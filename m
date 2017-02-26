Received: from eggs.gnu.org ([2001:4830:134:3::10]:50411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1chnuj-0001yV-QH
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 20:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1chnug-0002Ma-ND
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 20:46:17 -0500
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <87efynl9k1.fsf@linaro.org>
Date: Sat, 25 Feb 2017 20:46:08 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EE0E791-D80F-416B-B145-5D423310B65C@gmail.com>
References: <mailman.54661.1487925109.22739.qemu-devel@nongnu.org>
	<D18A2230-B3C1-46E9-A43E-291E5F672CBB@gmail.com>
	<87efynl9k1.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v14 00/24] MTTCG Base enabling patches with
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>


On Feb 24, 2017, at 1:37 PM, Alex Benn=E9e wrote:

>=20
> G 3 <programmingkidx@gmail.com> writes:
>=20
>> Hi I was wondering if your MTTCG patches have been tested with a
>> PowerPC guest yet.
>=20
> You would have to talk to PPC guys about the current status of MTTCG =
for
> the PowerPC architecture. You can force it to run with -accel
> tcg,thread=3Dmulti but it will likely behave weirdly if the =
atomic/barrier
> updates haven't been made to the front end.
>=20
>> Also do you have a repo someone could clone to test
>> out all your patches?
>=20
> Sure:
>=20
>  https://github.com/stsquad/qemu/tree/mttcg/base-patches-v14
>=20
> Hopefully it will get merged in the next couple of days ;-)
>=20
> --
> Alex Benn=E9e


Ok I have tried out the PowerPC target with "-accel tcg,thread=3Dmulti".
What I saw while booting was this message:

kernel[0]: USBF:	235.754	AppleUSBOHCI[0x1151000] Watchdog =
detected
dead controller (hcca #: 0, hc #: 836)


The maximum host cpu usgae for QEMU went up, but only by 2 percent. =
Before
qemu-system-ppc would use at most 101% of the host CPU. With the accel =
option, it went
up to 104%.

My Mac OS X guest was able to boot up and shutdown correctly with your =
patches.

With the i386 target, I did see host CPU usage go up to 120%. That was =
nice
to see. Windows XP and Windows 2000 would not boot to the desktop for =
some
reason.

Your patches can be a real game changer for emulation. Please let me =
know
if there is anything else I could do.=
