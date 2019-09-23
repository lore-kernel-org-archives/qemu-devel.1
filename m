Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F3C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDAD21907
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDAD21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKM3-0007g8-OW
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCJwE-0003Si-8n
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:43:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCJwC-0006hf-W4
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:43:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCJwC-0006hX-OK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:43:16 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDE4388307
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:43:15 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id t185so4671435wmg.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RZ8TfihFLFp9ogn/VN3z57FhE0lipjbfgVMgo4BXLqI=;
 b=lbUQElNpYJiTAxV77snefj8QDg92DIvXfO8ziTMDdJjdXCHlV22Yv76hK7JNrUgIel
 DMQpIEGjbZrGHqnb5Y2/3E3971wtxMwcIfFxGV0GWpmvHkNlEZW0r2brhrASh/39pnaS
 IKM3eAMxIdT8zizSpLjo3aFWKA1LCqJF8ZICWMWS5D9DVX9kOFCsxP8PBZrtpt9InmVR
 TX6OOcrDsL9gs0MrvjoyeTVaeB436dPDxLk5DduOBr6DecHYdXiBd0qhzlQJVbXqVobF
 cO/JqPzo3EQOgafq0jgO8nN+kim73qxOtGFUcX8KD/yACE8i3JCscDWjEl0357epy3Aq
 46kA==
X-Gm-Message-State: APjAAAUIVvaCpiIepvlGF7oVA4Ltt7FfRGPIwB44D1KGcAhqZCQCuBKs
 NZXbT+zeRoq7IErvShUueQWgB7SiggmuoiVk7UsX8yziHPVcCctTcDmndU2rfTtbQxegwKtIkDw
 xoHNj9Nzqod6wVEU=
X-Received: by 2002:a05:600c:2412:: with SMTP id
 18mr12278162wmp.128.1569228194529; 
 Mon, 23 Sep 2019 01:43:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzh5Dsh7lCmgMElQwKIcdcTwg3vHI378RhNCjA7e+DgtswSSab7CCNH19LkCShVhCZox92edw==
X-Received: by 2002:a05:600c:2412:: with SMTP id
 18mr12278143wmp.128.1569228194240; 
 Mon, 23 Sep 2019 01:43:14 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c18sm8776662wrv.10.2019.09.23.01.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 01:43:13 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/boot: Use the IEC binary prefix definitions
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190921103405.19623-1-philmd@redhat.com>
 <20190923082919.y2fjn2y6t7lire3z@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <75b5eaec-5e00-6dd0-1a67-b0dafd2d5622@redhat.com>
Date: Mon, 23 Sep 2019 10:43:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190923082919.y2fjn2y6t7lire3z@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 10:29 AM, Stefano Garzarella wrote:
> On Sat, Sep 21, 2019 at 12:34:04PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> IEC binary prefixes ease code review: the unit is explicit.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  hw/arm/boot.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index bf97ef3e33..59bb2fa0d3 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>=20
> Very appreciated!
>=20
> What about fixing also this other line?
>=20
> @@ -575,7 +575,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>          goto fail;
>      }
> =20
> -    if (scells < 2 && binfo->ram_size >=3D (1ULL << 32)) {
> +    if (scells < 2 && binfo->ram_size >=3D 4 * GiB) {

Good idea!

>          /* This is user error so deserves a friendlier error message
>           * than the failure of setprop_sized_cells would provide
>=20
>=20
>> @@ -1095,7 +1095,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU =
*cpu,
>>       * we might still make a bad choice here.
>>       */
>>      info->initrd_start =3D info->loader_start +
>> -        MIN(info->ram_size / 2, 128 * 1024 * 1024);
>> +        MIN(info->ram_size / 2, 128 * MiB);
>>      if (image_high_addr) {
>>          info->initrd_start =3D MAX(info->initrd_start, image_high_add=
r);
>>      }
>> @@ -1155,13 +1155,13 @@ static void arm_setup_direct_kernel_boot(ARMCP=
U *cpu,
>>                   *
>>                   * Let's play safe and prealign it to 2MB to give us =
some space.
>>                   */
>> -                align =3D 2 * 1024 * 1024;
>> +                align =3D 2 * MiB;
>>              } else {
>>                  /*
>>                   * Some 32bit kernels will trash anything in the 4K p=
age the
>>                   * initrd ends in, so make sure the DTB isn't caught =
up in that.
>>                   */
>> -                align =3D 4096;
>> +                align =3D 4 * KiB;
>>              }
>> =20
>>              /* Place the DTB after the initrd in memory with alignmen=
t. */
>> @@ -1178,7 +1178,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU =
*cpu,
>>                  info->loader_start + KERNEL_ARGS_ADDR;
>>              fixupcontext[FIXUP_ARGPTR_HI] =3D
>>                  (info->loader_start + KERNEL_ARGS_ADDR) >> 32;
>> -            if (info->ram_size >=3D (1ULL << 32)) {
>> +            if (info->ram_size >=3D 4 * GiB) {
>>                  error_report("RAM size must be less than 4GB to boot"
>>                               " Linux kernel using ATAGS (try passing =
a device tree"
>>                               " using -dtb)");
>=20
> With or without the new line fix:
>=20
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Did you mean Reviewed-by?

Regards,

Phil.

