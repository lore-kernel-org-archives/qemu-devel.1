Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C59ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2DF20640
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2DF20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIwfz-00043n-Mz
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 11:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iIweq-0003ZF-E4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iIweo-0002Dr-WB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:16:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iIweo-0002De-NU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:16:42 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A43310B78
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 15:16:41 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id l3so4246275wmf.8
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=2RV97ty4invITlJLyLAWAbITLL3EwB8bbkieQCerYUI=;
 b=VruXrGZstROROI6fMMlz5KdZAMgejfGkXqwuRstli4XQGlTNyMP+PyF7Oh3Zb0beTV
 Nk8IquGm1lZHt35+9c9/hp61ed2u5g9iysxAdQ5Zr8NWk1UuYE/j5bspI2zUhNeuufsz
 Xk5U6f5nFIlw273r/9+NikJkEo/hCRYkxZukqAI7JBy5HAF0OgipmEGudnolWMd0XYGe
 9YZABOCaWKeAgvMfI3tQLsJCiHp1RX9rRm1gBALgDEwLQyQGRTzMR9YgRJI2LsieErN8
 pX9hnp+9V2OAD0O0a31MNkafUExdlm5ykfrGB11HKtH8u8z+mDPrQpn+LWbEqsVESeBP
 1Juw==
X-Gm-Message-State: APjAAAUa+fhHCqC0ZdhvjJ6OnrnClsNsmnvcZuJbc/2Gzwpv9+VNNvZA
 oAls8TrUhsxeOp5O+e+lL6FhGLXtM+VV/skxNikmmpNE/oVg7yy98qNOFh/c/sgAA5+qD150HUJ
 1VcNVSVu4fpjWcZM=
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr13120110wrt.36.1570807000313; 
 Fri, 11 Oct 2019 08:16:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVQXwqtblUl19OEmAddeT317H2FX2jGS9nsKw31I0xDShi8EwpLPsi9zrWZ9Pzsq744uPVqA==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr13120074wrt.36.1570806999908; 
 Fri, 11 Oct 2019 08:16:39 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id h14sm12671256wro.44.2019.10.11.08.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:16:38 -0700 (PDT)
References: <20191010143125.67246-1-slp@redhat.com>
 <20191010143125.67246-5-slp@redhat.com>
 <f147fefc-1bec-2ac1-b5d6-35bcfdddf2fc@redhat.com> <871rvj4uam.fsf@redhat.com>
 <e9033f53-df3a-ac77-ffd2-e50bcf034ca7@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 04/15] hw/i386/pc: replace use of strtol with
 qemu_strtol in x86_load_linux()
In-reply-to: <e9033f53-df3a-ac77-ffd2-e50bcf034ca7@redhat.com>
Date: Fri, 11 Oct 2019 17:16:35 +0200
Message-ID: <87v9svb9d8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 10/11/19 9:26 AM, Sergio Lopez wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> Hi Sergio,
>>>
>>> On 10/10/19 4:31 PM, Sergio Lopez wrote:
>>>> Follow checkpatch.pl recommendation and replace the use of strtol with
>>>> qemu_strtol in x86_load_linux().
>>>>
>>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>>> ---
>>>>    hw/i386/pc.c | 11 +++++++++--
>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index 77e86bfc3d..e6bcc3ff42 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -68,6 +68,7 @@
>>>>    #include "qemu/config-file.h"
>>>>    #include "qemu/error-report.h"
>>>>    #include "qemu/option.h"
>>>> +#include "qemu/cutils.h"
>>>>    #include "hw/acpi/acpi.h"
>>>>    #include "hw/acpi/cpu_hotplug.h"
>>>>    #include "hw/boards.h"
>>>> @@ -1201,7 +1202,8 @@ static void x86_load_linux(PCMachineState *pcms,
>>>>        /* handle vga=3D parameter */
>>>>        vmode =3D strstr(kernel_cmdline, "vga=3D");
>>>>        if (vmode) {
>>>> -        unsigned int video_mode;
>>>> +        long video_mode;
>>>
>>> Why do you change 'video_mode' to a signed type?
>>
>> qemu_strtol fourth argument is a pointer to long int. According to
>> "linux/Documentation/admin-guide/svga.rst", valid video modes are in the
>> in the range of 0x0 to 0xffff (matching the stw_p below), so this change
>> shouldn't be a problem.
>
> Why not simply use qemu_strtoui() then? Later stw_p() implicitly cast
> this to uint16_t anyway.

I don't think there's a significant difference in functionality, but
that would probably look better. I'll prepare a v9.

Thanks!
Sergio.

> Any thought from other reviewers? Do we care? I'm feeling being a pain
> with Sergio :/
>
>>>> +        int ret;
>>>>            /* skip "vga=3D" */
>>>>            vmode +=3D 4;
>>>>            if (!strncmp(vmode, "normal", 6)) {
>>>> @@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
>>>>            } else if (!strncmp(vmode, "ask", 3)) {
>>>>                video_mode =3D 0xfffd;
>>>>            } else {
>>>> -            video_mode =3D strtol(vmode, NULL, 0);
>>>> +            ret =3D qemu_strtol(vmode, NULL, 0, &video_mode);
>>>> +            if (ret !=3D 0) {
>>>> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: %=
s\n",
>>>> +                        strerror(-ret));
>>>> +                exit(1);
>>>> +            }
>>>>            }
>>>>            stw_p(header + 0x1fa, video_mode);
>>>>        }
>>>>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gnNMACgkQ9GknjS8M
AjVk3RAAuOPjLr8LitUxPXVSjElRYgxcMAa/GigAP4ou+JxYoP5jztz5m/wRL+St
e4tydftDYtfAUPhg0rVGcksvrfOw/RcrjRAZ5EJEw9K8CThIkU1T6Qi2jK7b/OHu
kbLXjeFcqeNIaoHThw4/LlyCRyWAGHFF0wTUVhtkoBR6JjoRUQ8IHRSXC1iSmZCW
fwxiNC9b4mfrsQAsvanrnB1oxhRPRlKxH8ObAB5R/yNuExzcGgHSA3Yb072yE2uZ
xV1kMJpM+nXjd3RT1L7Tb1LeuG30+ZDjSL9D0sNXP6hAstKqCIws/iy3e2CGGSJr
pm/qwcVxo12XwHXG1aoyRMdINdydn5ZO3a9hfa5ANywFlQp3z2nudGjlflhq18Mf
W6aTKMH3LbB+8tY+pP1tEviGdgf8dimOIWSUKHLaKze/JhBDI3mn0KgeyHtRaubS
P7mNqzydLxjAd96ues6bVUJQ1wkT8U7y+vmd3wRnTQR+7oUMbAVxZIgJuntpInYa
zevMnzxTL2m6U41dE8TxwY7Xn1u/odx6hN2QmSVW4EyyInD4a5g2acUIeTsc+lrg
FCAMvAf1DQNeKu+J11XROsfGObXIfeZDZeHoi7c/xA57DTTBrgxGC8HmFlG1J+yY
kWgIFgepKqwIfLy2sUwPuCRwpA/r2d55dRU/mnKyo5u/mYdnk4w=
=LnBB
-----END PGP SIGNATURE-----
--=-=-=--

