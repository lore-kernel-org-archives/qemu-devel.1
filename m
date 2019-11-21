Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2467C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD89D20692
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaB1sj2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD89D20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpEj-00074m-M6
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXpDR-0006OU-U8
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXpDQ-0006EK-FW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:21:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXpDQ-0006Df-Ad
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574353314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scMVOKhhnarm2rX1omDGXP2fWXr4AuzuqRDPv4KsTMM=;
 b=aaB1sj2OglupSxHAvQDjUYMZAA6HwoqNT7jdFm2XNLOA5ikWLZtnPSRS+deuB60YX9exTx
 JIuehayqjSwYH4/VuuExTc4U9FKflvLKkc5sCRzy/46h41xGRS/vNgNCaOvkM0lB+8uAcF
 of3hf49npNHsW+HFgbEctkqSKdcnP5w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-owjkyZ1jPQCO3QShPZekqQ-1; Thu, 21 Nov 2019 11:21:52 -0500
Received: by mail-wm1-f71.google.com with SMTP id t203so1769476wmt.7
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UvgkVKx6y7zbjfT0M18/Aez5VyDE64BT7zXNYYM1x2c=;
 b=mnh3lOedHLz8vGkYkSEa5/NnKOulZ53cVMFWnuli9+BnlIgRbPJiYxciIM6V6RgEEc
 IG+vuwIBGKmnU0t0ZiCeVMHEo+tcTRSClJ0Vxpz0arGbgEaTYzEOXzX6y6Nd9u3ThlHW
 zlJeXMwmKBZJHRWilEz5wx024XfbIfmriSdJi4s3Simjf7kN+WDgls0E17Jt4jJQVWXS
 NQcm/AgRxhYLGcxOBT9XOCwrFOnbrExgUhiiKAVZ1W2uzlVailpB3vFlnRkxoDeKMgNj
 2iiQt1BSbUX7uOSiwlhxMSdIgh3y0NqsJERSfmNR/sBZlvl8gjAV3y9rhcK+xjR3m02a
 aHkw==
X-Gm-Message-State: APjAAAWcIzhUR5OV8sGogfRX38mYsig6ZJ999UWzUp6ZMuqNwYzBlUMf
 VUv0fjILwFhLtFXwr7naMsGMmPxGg63XvSz5p9B6tUrlNhY+JGwWRnmgTorvILhD6tfDsAFS+R4
 HD1U2o35BEwwx4GU=
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr12412997wrn.235.1574353310999; 
 Thu, 21 Nov 2019 08:21:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1n2eMfsl4b+hzdMl8YJ9Rsg6m/UiZol5dO05bLRMb/+kOgc+3RXXKm+jF80xL6puxjQ4S7g==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr12412956wrn.235.1574353310694; 
 Thu, 21 Nov 2019 08:21:50 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id c144sm179727wmd.1.2019.11.21.08.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 08:21:50 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 0/2] hw/timer/m48t59: Convert to trace events
To: Markus Armbruster <armbru@redhat.com>
References: <20190626122042.7656-1-philmd@redhat.com>
 <dfa56995-6a66-1aeb-4461-fb2919e8b699@redhat.com>
 <87r2219rk7.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d3151eb-841d-0e03-46d5-c48107ce821c@redhat.com>
Date: Thu, 21 Nov 2019 17:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87r2219rk7.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: owjkyZ1jPQCO3QShPZekqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 4:28 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> ping?
>=20
> Did this fall through the cracks?

Certainly =3D) Thanks for noticing.
This now need a (trivial) rebase.
I'll respin for 5.0.

>> On 6/26/19 2:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Another trivial cleanup series.
>>>
>>> Philippe Mathieu-Daud=C3=A9 (2):
>>>    MAINTAINERS: Add missing m48t59 files to the PReP section
>>>    hw/timer/m48t59: Convert debug printf()s to trace events
>>>
>>>   MAINTAINERS                |  2 ++
>>>   hw/timer/m48t59-internal.h |  5 -----
>>>   hw/timer/m48t59.c          | 11 +++++------
>>>   hw/timer/trace-events      |  6 ++++++
>>>   4 files changed, 13 insertions(+), 11 deletions(-)
>>>


