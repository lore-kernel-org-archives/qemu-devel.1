Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B320C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534ED208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRhgKw64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534ED208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUns-0002Dg-CI
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUmF-00016k-TN
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUk4-00031h-KF
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:28:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUUk4-00030w-5j
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588335967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzkwToGvfXyCj6Tqr04iN3hRDRWmyErm6JKbFu5VCfk=;
 b=BRhgKw64t4hXXPlv7AE+gV0lK6As8skebCGWs5fvkoBxVaEEowS8x8E63mBNLwCPs9apkZ
 iJ6U48ckcQiYUFQXsf9MF+SxEhIAKFYEzJ1XMGzftoHbdE+wlWU5cm32Boabb4Yv8KMOD3
 QHxPUqAnnkAA5ZDCWr0kVYyy5JEx7dM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-QJwV2JLLMz-P-gxN4EghGw-1; Fri, 01 May 2020 08:25:58 -0400
X-MC-Unique: QJwV2JLLMz-P-gxN4EghGw-1
Received: by mail-wr1-f72.google.com with SMTP id y12so3010022wrl.14
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 05:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rOlLXYBe4j/M3YHe+bNwWfYpLF02yzA2GIi4LVSgniM=;
 b=TK3IJt4L/dsJ/2WkY8sPfKP/SacspVnhWSVSyUbyJlsceE54zRqwyviIldVn/wPBA7
 doId/qlVuYFzJUIc27AS8GDWP19CNklQPIe8BSyxFjSWY1LQHXkOdefXiPLMLOuoRS4I
 YfCGpbzLKNj3jjmyrDinrVPHhdm3BMJPt/M77Cm1bmSv2oLXxSg/avqNjMSxB7a3O7UC
 CyqH6hbagp2aS4syboCMcVdaN3rwKSSaKNpdDZLY9KYUhCouKoCtxeU/cf0RRrsFVOn9
 LRfZTic76L6HhgP+26QeNC2aB7bm/q2xPa9n1WzF0NRiUah580aIZ7/V9guJazSt2ErZ
 SziQ==
X-Gm-Message-State: AGi0Pub1Ra+Tz47CuQAaeQK+0Y4pRRVNdcZvyFSD45T7LXE87xHycENR
 TPxThHN6ffXomn9kNh1u51qPQg3aKBzyj90imw8kXxstGktJ+jLribQE43TlTJpLSMNTt5QtKQi
 yRGrmXpQFT8kzQtI=
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr2528013wrq.211.1588335957191; 
 Fri, 01 May 2020 05:25:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTaXdLdsLnKjLOKZm8T8+II1ihBrrNQel6b0vLmyRWXnoWCPcXifApNXVOUMHygRdTUdJMTQ==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr2528002wrq.211.1588335957041; 
 Fri, 01 May 2020 05:25:57 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id l5sm3609159wmi.22.2020.05.01.05.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 05:25:56 -0700 (PDT)
Subject: Re: [PATCH v1 1/9] configure: favour gdb-multiarch if we have it
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200430190122.4592-1-alex.bennee@linaro.org>
 <20200430190122.4592-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c69bbcae-1450-d75b-c05e-e9ee49bb53d5@redhat.com>
Date: Fri, 1 May 2020 14:25:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430190122.4592-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

On 4/30/20 9:01 PM, Alex Benn=C3=A9e wrote:
> As gdb will generally be talking to "foreign" guests lets use that if
> we can. Otherwise the chances of gdb barfing are considerably higher.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 23b5e93752..c58787100f 100755
> --- a/configure
> +++ b/configure
> @@ -303,7 +303,7 @@ libs_qga=3D""
>   debug_info=3D"yes"
>   stack_protector=3D""
>   use_containers=3D"yes"
> -gdb_bin=3D$(command -v "gdb")
> +gdb_bin=3D$(command -v "gdb-multiarch" || command -v "gdb")
>  =20
>   if test -e "$source_path/.git"
>   then
>=20

This was also already reviewed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg697748.html

There seem to be a problem in your workflow.

Again:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


