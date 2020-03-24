Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329FEC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F070A2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/M9Q1B8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F070A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGj9U-0003wu-5s
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGj8k-0002YD-OI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGj8j-0000YJ-Mj
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:58:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGj8j-0000Xw-J2
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585054721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bUjgqZwds+shXYY1dqN1cr/B125IREerhlgPNMcEq0=;
 b=C/M9Q1B8IjcMakImM7YvJ48QYnvvlUYGLjx/1+5wZ5diQx0lIOd4fV79LVH/a1W3nJMkaf
 nIgSKhI5gY5o2/U2wmk0kgpShvrvJDBixau1MTOD8kb8/ngTX+aNP51PYebn+3/87M5XkH
 oLHygp4Kxs+mHye8Ja3GVbzB2AhM9Cw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Q6Q9b_tDNLKB6nT0ZTh7sQ-1; Tue, 24 Mar 2020 08:58:39 -0400
X-MC-Unique: Q6Q9b_tDNLKB6nT0ZTh7sQ-1
Received: by mail-ed1-f69.google.com with SMTP id a14so6021631edx.22
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EfOS4opR0h/3sgxqoPZz4d5TqMMAbLhQTkdJB8j8NDA=;
 b=sLqO6gBvBXiGVPqgV1s9NiJAPgrud353CnngGDNwgxwQ6f2tGDMfnU0RmejDdKwVfa
 4xLBkDrhaybVDxLcZGzJndFcVpglM6IF/Y3Hn9XotGvsUagh8EbZNIKS7Zjro8LE6HGQ
 SosuJvw90cC1ut7i16DC/pnfl5GI7BV0ISZCoS2kGzDS1ny5eNuNe7B2PqtrsULEbMp0
 U8NUbSWtB9WCQm4bdTBGsAfMZ2NZj4YVw/7U7MavEw4WyaTi51r1aFE5HBESJf5g/6Y4
 NdNNycU8Ayur7a+BwEO05/MgigZawImrGKPQhMqSiuPcbLnjaQZ3HUdPNI+y4MBnhh/G
 0+sQ==
X-Gm-Message-State: ANhLgQ1jf303ant68u2qLckgl/7HXPWJW+VlOFdIKCkUKLVr4RfITSc4
 PxQznJedqTvKToamXGr08NpcVMIhKUz1Map1b8xdpi9fQeYgLs1pQ/zfOVPmb13SWXvtsxVoYRA
 RJjbpoIHN38aCG0I=
X-Received: by 2002:aa7:d291:: with SMTP id w17mr25297435edq.266.1585054718564; 
 Tue, 24 Mar 2020 05:58:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuAsmC7K/NUc+clKf088yCdajRhQ2ZGFRpoPhIgTPvA+gIOuA/p7fG1L/KesbZjVpF08kguyQ==
X-Received: by 2002:aa7:d291:: with SMTP id w17mr25297421edq.266.1585054718393; 
 Tue, 24 Mar 2020 05:58:38 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e4sm1012931eje.45.2020.03.24.05.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 05:58:37 -0700 (PDT)
Subject: Re: [PATCH for-5.0] hw/ppc/e500.c: Handle qemu_find_file() failure
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200324121216.23899-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bdfedb84-a6fa-907b-8e88-d22626124fc4@redhat.com>
Date: Tue, 24 Mar 2020 13:58:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324121216.23899-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 1:12 PM, Peter Maydell wrote:
> If qemu_find_file() doesn't find the BIOS it returns NULL; we were
> passing that unchecked through to load_elf(), which assumes a non-NULL
> pointer and may misbehave. In practice it fails with a weird message:
>=20
>    $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
>    Bad address
>    qemu-system-ppc: could not load firmware '(null)'
>=20
> Handle the failure case better:
>=20
>    $ qemu-system-ppc -M ppce500 -display none -kernel nonesuch
>    qemu-system-ppc: could not find firmware/kernel file 'nonesuch'
>=20
> Spotted by Coverity (CID 1238954).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/ppc/e500.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 854cd3ac465..0d1f41197cf 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1047,6 +1047,10 @@ void ppce500_init(MachineState *machine)
>       }
>  =20
>       filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
> +    if (!filename) {
> +        error_report("could not find firmware/kernel file '%s'", payload=
_name);
> +        exit(1);
> +    }
>  =20
>       payload_size =3D load_elf(filename, NULL, NULL, NULL,
>                               &bios_entry, &loadaddr, NULL, NULL,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


