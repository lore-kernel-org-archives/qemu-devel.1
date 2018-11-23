Received: from eggs.gnu.org ([2001:4830:134:3::10]:59594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gQ98M-0004YR-Qv
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gQ98I-0002lv-Oc
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:56:26 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:60557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gQ98I-0002jP-Gz
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 05:56:22 -0500
Date: Fri, 23 Nov 2018 11:56:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <30197297-c327-36a9-89f6-6a27eaef4cdf@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1811231151490.10585@zero.eik.bme.hu>
References: <87mw8rumhb.fsf@blackfin.pond.sub.org>
	<87y4s8h5rh.fsf@blackfin.pond.sub.org>
	<876132olyi.fsf@blackfin.pond.sub.org>
	<87a8fucx33.fsf@dusky.pond.sub.org>
	<87muq2fgbw.fsf@dusky.pond.sub.org>
	<a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com>
	<alpine.BSF.2.21.9999.1811222249030.51852@zero.eik.bme.hu>
	<30197297-c327-36a9-89f6-6a27eaef4cdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MAINTAINERS leaves too many files uncovered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Fri, 23 Nov 2018, Philippe Mathieu-Daud=C3=A9 wrote:
> On 22/11/18 22:56, BALATON Zoltan wrote:
>> While we're there, should I also add pc-bios/canyonlands.dts which is
>> the device tree for sam460ex?
>
> Yes, I suggest this set:
>
> pc-bios/canyonlands.dt?
> pc-bios/u-boot-sam460*
> roms/u-boot-sam460ex

Well, canyonlands.dtb and u-boot-sam460-*.bin are binaries built from=20
canyonlands.dts and roms/u-boot-sam460ex respectively and=20
roms/u-boot-sam460ex is mirrored from my git repo. So should these be=20
added despite of this or is it enough to add canyonlands.dts? I thought=20
only sources are listed in MAINTAINERS not binaries or external sources.

Regards,
BALATON Zoltan
