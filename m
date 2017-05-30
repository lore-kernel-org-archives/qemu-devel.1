Received: from eggs.gnu.org ([2001:4830:134:3::10]:47932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFdl1-0004nX-Ba
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFdl0-0003nc-Bx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:48:07 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFdl0-0003nR-4f
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:48:06 -0400
Received: by mail-wm0-x232.google.com with SMTP id b84so84885164wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:48:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ce532829-b11b-7992-3fc4-3e21210c66f0@amsat.org>
References: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
	<1493226792-3237-3-git-send-email-peter.maydell@linaro.org>
	<ce532829-b11b-7992-3fc4-3e21210c66f0@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 10:47:44 +0100
Message-ID: <CAFEAcA-d1oZazep6-HbKDJ7dY-gAZYf+MXghDPcKSHGKWLTnEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/intc/arm_gicv3_cpuif: Don't let BPR
 be set below its minimum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 14 May 2017 at 06:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> On 04/26/2017 02:13 PM, Peter Maydell wrote:
>> +    minval =3D (grp =3D=3D GICV3_G1NS) ? GIC_MIN_BPR_NS : GIC_MIN_BPR;
>> +    if (value < minval) {
>> +        value =3D minval;
>> +    }
>> +
>
>
> which is:
>
>     if (grp =3D=3D GICV3_G1NS) {
>         value =3D MAX(value, GIC_MIN_BPR_NS);
>     }

Only if you assume GIC_MIN_BPR must always be 0, which isn't
necessarily the case. (One day we might need to update it to
be a per-device configurable parameter, like the VBPR min.)

thanks
-- PMM
