Received: from eggs.gnu.org ([2001:4830:134:3::10]:52705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euITO-0004W8-G5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euITN-00016V-Nt
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:54:14 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:46022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euITN-00016I-If
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:54:13 -0500
Received: by mail-oi0-x236.google.com with SMTP id j79so6991494oib.12
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:54:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871sgtl5o0.fsf@linaro.org>
References: <20180308130626.12393-1-peter.maydell@linaro.org>
	<20180308130626.12393-7-peter.maydell@linaro.org>
	<871sgtl5o0.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 13:53:52 +0000
Message-ID: <CAFEAcA-JDyRPy1MiCf49+0W3VVgn3O6wWN=8v22Kpc+e7bRN9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/6] hw/arm/virt: Support -machine
 gic-version=max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 9 March 2018 at 13:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>> @@ -1480,9 +1487,11 @@ static void virt_set_gic_version(Object *obj, con=
st char *value, Error **errp)
>>          vms->gic_version =3D 2;
>>      } else if (!strcmp(value, "host")) {
>>          vms->gic_version =3D 0; /* Will probe later */
>> +    } else if (!strcmp(value, "max")) {
>> +        vms->gic_version =3D -1; /* Will probe later */
>>      } else {
>>          error_setg(errp, "Invalid gic-version value");
>> -        error_append_hint(errp, "Valid values are 3, 2, host.\n");
>> +        error_append_hint(errp, "Valid values are 3, 2, host,
>> max.\n");
>
> nit: host is only valid on aarch64 host. However it will fail later on
> with:
>
>   qemu-system-aarch64: gic-version=3Dhost requires KVM

'host' was already in this string. It's valid in the sense that
it's not a syntax error, though it won't work in all situations.
(Similarly, if you try '3' and you have KVM enabled and a gicv2
host system you'll get an error.)

thanks
-- PMM
