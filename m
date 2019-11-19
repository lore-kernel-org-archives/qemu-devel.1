Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EC8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6EF20679
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpWVJC0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6EF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5IY-00023r-L9
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX5HY-0001Gh-Uu
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX5HX-0004Bp-Rv
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:19:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX5HX-0004BS-OP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574176747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDxxXJyj6rv/EUbK/TQibRsbv1HRbazP4LVXKEgvjFg=;
 b=dpWVJC0oVJkm3a+BAX9ZkS713FRoumhlh1U+oiXrm3GxJiJDkZknZYypUWGsOx13K9WkdG
 rQd009jW13yTC8Rk5bL69/xoiWvirfJQcZ6Dy5aqUgUwAyK3vLoESqBshLXnHDa/zErZ6S
 V7r/eT4XjFc4MX5M8wA6MK+cnWbXVh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-MueLxhOHPteePDv0npPn-g-1; Tue, 19 Nov 2019 10:19:05 -0500
Received: by mail-wm1-f69.google.com with SMTP id 2so2592628wmd.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 07:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=79AgK9/lpV/yZyJuFW87CORvAnJvY83C0dNVHRhQ78U=;
 b=GsePqDkAdFdHccU0NM7EMVQCE3lLqMR4+fbKanb06nUwuGImfiDu/a+U4kSc8mnvxi
 Q+mv5FqzykBUEBox84fNTlnJkR2G5fw56+0AGdQKKaK6fpOJiCFQGQzVlyvfMyxcbXRz
 qVUCBAqfs27LgTg+V9jqk4OFIakw3Xa3/zwXxcp+kIq/dRi6AHf0bzH4trNkLlplLlS4
 XWuDH2BZ91g1G0uTgAmrtefpQ+JfTY+U8uthneK24kkA5ZWERNS9+SuJ2PMM9BByBG7t
 DKNuMre/WflohOG70ECPTWcRtk2bM9NSDm5SU7z+13ly25sthwFNznfZsHlTNIDLUSt/
 nrrg==
X-Gm-Message-State: APjAAAWKszCzk1WkFn6GkZDbNL8fhuaIv0TUdp8dwUXpZu0JXdvk/l0U
 GAiol5GSgZJwfVYS6f2vv4ptSKvdGeW81s+pI5G4M4a3CRjFbtULx3jh9YiBObRJrV08khTdqdb
 rCQcErk483x/HVls=
X-Received: by 2002:a1c:4946:: with SMTP id w67mr6662644wma.16.1574176743674; 
 Tue, 19 Nov 2019 07:19:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkW9C0B4LWz/2TiP96diNrd0fjk8H7TMYsx95vvOqjTSHc1B9JNv21AAgVv3Cp6G7O4xutUA==
X-Received: by 2002:a1c:4946:: with SMTP id w67mr6662619wma.16.1574176743477; 
 Tue, 19 Nov 2019 07:19:03 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id p9sm17694662wrs.55.2019.11.19.07.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 07:19:02 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>, laurent@vivier.eu,
 riku.voipio@iki.fi, qemu-devel@nongnu.org
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
Date: Tue, 19 Nov 2019 16:19:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: MueLxhOHPteePDv0npPn-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 12:58 AM, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
[...]
>   target/hexagon/imported/global_types.h      |  25 +++
>   target/hexagon/imported/iss_ver_registers.h | 183 +++++++++++++++
>   target/hexagon/imported/max.h               |  78 +++++++
>   target/hexagon/imported/regs.h              |  19 ++

Maybe you can rename this directory as:

target/hexagon/dsp-sdk/

and add a README "Files under this directory are imported from the SDK=20
available once registered on developer.qualcomm.com ..."


