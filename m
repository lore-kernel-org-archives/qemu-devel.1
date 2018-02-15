Received: from eggs.gnu.org ([2001:4830:134:3::10]:40131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJRP-0008QR-VC
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emJRP-0002hB-2Z
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:19:11 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emJRO-0002gu-Tl
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:19:11 -0500
Received: by mail-ot0-x241.google.com with SMTP id w38so5276217ota.8
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:19:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a3f95aa2-3a13-8a67-4fe2-b7da6eace585@amsat.org>
References: <20180208055039.24666-1-penberg@iki.fi>
	<20180208055039.24666-4-penberg@iki.fi>
	<CAFEAcA_008TiXr0RYmPuhPcmSY9qx=Ju8CMAu_t-z+DBRruykA@mail.gmail.com>
	<9c52a265-6659-5c9c-27c7-eced8528fb63@amsat.org>
	<a3f95aa2-3a13-8a67-4fe2-b7da6eace585@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:18:49 +0000
Message-ID: <CAFEAcA8Zhih61YZNBEQQOFv_XKWknw7oN80pQbK+NgcB1mEsYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 3/3] raspi: Add "raspi3"
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Pekka Enberg <penberg@iki.fi>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 February 2018 at 13:14, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 02/15/2018 09:49 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 02/15/2018 09:39 AM, Peter Maydell wrote:
>>> On 8 February 2018 at 05:50, Pekka Enberg <penberg@iki.fi> wrote:
>
> Now I remember why I hesitated with this patch,
>
> This part {
>
>>>> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
>>>> +    mc->max_cpus =3D BCM2836_NCPUS;
>>>> +    mc->min_cpus =3D BCM2836_NCPUS;
>>>> +    mc->default_cpus =3D BCM2836_NCPUS;
>
> } is the BCM2837 SoC, very similar to the BCM2836.

Yeah, we had a whole go-around about whether we should have a
BCM2837 object or just make the BCM2836 object have a configurable
CPU type. You could argue either way...

thanks
-- PMM
