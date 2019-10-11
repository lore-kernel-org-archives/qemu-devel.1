Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8B9ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432442196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432442196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpL2-0006vA-9l
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iIpJo-0006S5-Mn
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iIpJn-0004da-9Y
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iIpJn-0004dN-1K
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:26:31 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EED4289AC4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 07:26:29 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id p6so2247012wmc.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 00:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=An+Xw9UfvUhIk/kOagdDxjmvY77oHZp8b3iPBc8TVRo=;
 b=H/938Cykup6+pY691BQ789dh2YD4pnGhxjwpFrH56unsi/aYt6OFkgN4V+oizWIllh
 XwixFIrl3ts2MJIF8mYOpEuoHblgRxGDt60Qfn8Gr9J6dpWu6JyqNmF027hwda+ob2aM
 qUkN6aDz2yLdmDHEsSnQBsq1z+EGYDh0dVPITMI6FBWGwgm4yfL2lBnp8yi9NBOS4OsE
 kBWW4jxVPoFlInh9SZn/HH8JDBXN2d3T/vfT0GhcnpRXfiKVpK97e8ReZV6JkFnatc8l
 nsViB6F685lbLL/hAB56sZ0e5f+DtwWd1yFArrXukjliCJJyD5aPWzsmiBQ6Cr6+Wn7Y
 23kg==
X-Gm-Message-State: APjAAAU+b3EajiqofseYc4yOjvw2ifpxWQc8/jY7yjOcHkMuyvmGrHgE
 HD6UI4xgwkOwgSmdi8A+/1Qphqv13MujQyGiK64NU7nBsFu0ZXmCUZ7zed0qfYjCmXvtUXeo9LO
 U0ogU+jFwAsHg6xA=
X-Received: by 2002:adf:f0c3:: with SMTP id x3mr1496941wro.389.1570778788746; 
 Fri, 11 Oct 2019 00:26:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz2ekderyPFHmZUOuAA69ES4tbwxnemkhZ6UKgm+rnJbsdPuOSA4zTSbJZjNpZNYqG90Tyd7w==
X-Received: by 2002:adf:f0c3:: with SMTP id x3mr1496920wro.389.1570778788533; 
 Fri, 11 Oct 2019 00:26:28 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id 90sm10932121wrr.1.2019.10.11.00.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 00:26:27 -0700 (PDT)
References: <20191010143125.67246-1-slp@redhat.com>
 <20191010143125.67246-5-slp@redhat.com>
 <f147fefc-1bec-2ac1-b5d6-35bcfdddf2fc@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v8 04/15] hw/i386/pc: replace use of strtol with
 qemu_strtol in x86_load_linux()
In-reply-to: <f147fefc-1bec-2ac1-b5d6-35bcfdddf2fc@redhat.com>
Date: Fri, 11 Oct 2019 09:26:25 +0200
Message-ID: <871rvj4uam.fsf@redhat.com>
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

> Hi Sergio,
>
> On 10/10/19 4:31 PM, Sergio Lopez wrote:
>> Follow checkpatch.pl recommendation and replace the use of strtol with
>> qemu_strtol in x86_load_linux().
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>   hw/i386/pc.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 77e86bfc3d..e6bcc3ff42 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -68,6 +68,7 @@
>>   #include "qemu/config-file.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/option.h"
>> +#include "qemu/cutils.h"
>>   #include "hw/acpi/acpi.h"
>>   #include "hw/acpi/cpu_hotplug.h"
>>   #include "hw/boards.h"
>> @@ -1201,7 +1202,8 @@ static void x86_load_linux(PCMachineState *pcms,
>>       /* handle vga=3D parameter */
>>       vmode =3D strstr(kernel_cmdline, "vga=3D");
>>       if (vmode) {
>> -        unsigned int video_mode;
>> +        long video_mode;
>
> Why do you change 'video_mode' to a signed type?

qemu_strtol fourth argument is a pointer to long int. According to
"linux/Documentation/admin-guide/svga.rst", valid video modes are in the
in the range of 0x0 to 0xffff (matching the stw_p below), so this change
shouldn't be a problem.

>> +        int ret;
>>           /* skip "vga=3D" */
>>           vmode +=3D 4;
>>           if (!strncmp(vmode, "normal", 6)) {
>> @@ -1211,7 +1213,12 @@ static void x86_load_linux(PCMachineState *pcms,
>>           } else if (!strncmp(vmode, "ask", 3)) {
>>               video_mode =3D 0xfffd;
>>           } else {
>> -            video_mode =3D strtol(vmode, NULL, 0);
>> +            ret =3D qemu_strtol(vmode, NULL, 0, &video_mode);
>> +            if (ret !=3D 0) {
>> +                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\=
n",
>> +                        strerror(-ret));
>> +                exit(1);
>> +            }
>>           }
>>           stw_p(header + 0x1fa, video_mode);
>>       }
>>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2gLqEACgkQ9GknjS8M
AjUc7Q/8CnWTRMR6gzrhCRxWAfEMSOp4MoDoYhYGvgl70r1qydi6dGcXJKV5zncV
0kG/0DDofIqYjfrWiEe1nwIWr/cCpqeB7vIrL+RbSYZLeycDLfY79AoDSuynLd73
ff8apDmIR/ev+m0WEQsL1iFvFzzxcQZ+Z2e5t2cp8VRU9NXJUlI2+k/hBr15Nes1
xPw+15k6t70qCrwFMzdjCHiCDKgfwhCd51s+DgTDMXYSlG1yYcgvD7tEn8WyqFLc
JoLDXEjnYm+947TKsNjQfF+IPBBNHR/vPgFVELABNL79f/QZb2ydQ8rTZtwzr1cr
FK3T/rjIz4fL+zGDUGqCb3SIqGzkuVQdktC7lsDX15gAlqBLS957wTIRRwG1Eyz1
a0KukdQU8UypgyeymEzaUpljHgT3uyN7nFqBf1KyRZ+TvW9MlCtAC/h9F9QouitE
456MlskiTakgwWq/03hBgNa9zA7EuWpmRAgCiaC9i3hsuRrbedfG6GVWqLhSN68o
MxrlsUCc/J2vRm1UTTzieKS2wt1QPk8Phda1dv4zr7h3QNk9LkOH+Jj2Aua9L5R8
FkbGJ/ajw8R9xeh/Gj4AAkczzXSYuIBXO/aNg5otwbW2hCg2lm7B0gB04d9IXbc3
7X/NUgHL5tGaJFtGUqs7JDHW+QsGN3A4YqfblpV7EvkBhkXqHNw=
=wyHc
-----END PGP SIGNATURE-----
--=-=-=--

