Received: from eggs.gnu.org ([2001:4830:134:3::10]:33530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ9FU-0007ld-91
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:03:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQ9FO-0004wl-LX
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:03:48 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQ9FO-0004w4-G1
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:03:42 -0500
Received: by mail-wr1-f46.google.com with SMTP id z5so7624110wrt.11
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 03:03:42 -0800 (PST)
References: <87mw8rumhb.fsf@blackfin.pond.sub.org>
	<87y4s8h5rh.fsf@blackfin.pond.sub.org>
	<876132olyi.fsf@blackfin.pond.sub.org>
	<87a8fucx33.fsf@dusky.pond.sub.org> <87muq2fgbw.fsf@dusky.pond.sub.org>
	<a7902403-7572-9b64-235e-cb6f9e0efbae@redhat.com>
	<alpine.BSF.2.21.9999.1811222249030.51852@zero.eik.bme.hu>
	<30197297-c327-36a9-89f6-6a27eaef4cdf@redhat.com>
	<alpine.BSF.2.21.9999.1811231151490.10585@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a3f005e-44fb-5fe7-55b0-c2bf23c67220@redhat.com>
Date: Fri, 23 Nov 2018 12:03:39 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1811231151490.10585@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] MAINTAINERS leaves too many files uncovered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 23/11/18 11:56, BALATON Zoltan wrote:
> On Fri, 23 Nov 2018, Philippe Mathieu-Daudé wrote:
>> On 22/11/18 22:56, BALATON Zoltan wrote:
>>> While we're there, should I also add pc-bios/canyonlands.dts which is
>>> the device tree for sam460ex?
>>
>> Yes, I suggest this set:
>>
>> pc-bios/canyonlands.dt?
>> pc-bios/u-boot-sam460*
>> roms/u-boot-sam460ex
> 
> Well, canyonlands.dtb and u-boot-sam460-*.bin are binaries built from
> canyonlands.dts and roms/u-boot-sam460ex respectively and
> roms/u-boot-sam460ex is mirrored from my git repo. So should these be
> added despite of this or is it enough to add canyonlands.dts? I thought
> only sources are listed in MAINTAINERS not binaries or external sources.

Hmm I see various binaries, i.e.:

$ file pc-bios/s390-ccw.img
pc-bios/s390-ccw.img: ELF 64-bit MSB shared object, IBM S/390, version 1
(SYSV), dynamically linked, interpreter /lib/ld64.so.1,
BuildID[sha1]=5bf569bf2205ea94a015c1fe2702d7efb446a8c5, stripped
$ ./scripts/get_maintainer.pl -f pc-bios/s390-ccw.img
Christian Borntraeger <borntraeger@de.ibm.com> (supporter:S390-ccw boot)
Thomas Huth <thuth@redhat.com> (supporter:S390-ccw boot)
Cornelia Huck <cohuck@redhat.com> (supporter:S390)
qemu-s390x@nongnu.org (open list:S390-ccw boot)

$ file pc-bios/u-boot.e500
pc-bios/u-boot.e500: ELF 32-bit MSB executable, PowerPC or cisco 4500,
version 1 (SYSV), statically linked, stripped
$ ./scripts/get_maintainer.pl -f pc-bios/u-boot.e500
David Gibson <david@gibson.dropbear.id.au> (odd fixer:e500)
qemu-ppc@nongnu.org (open list:e500)

If I have issues with a binary like 'canyonlands.dtb' I'd like to be
able to contact the maintainer. Maybe this is not the best example since
the 'canyonlands.dts' is there too ;)

Regards,

Phil.
