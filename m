Received: from eggs.gnu.org ([2001:4830:134:3::10]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoFtI-0000hs-Mm
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoFtF-00064X-B0
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:56:00 -0500
Date: Tue, 20 Feb 2018 22:55:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180220183022.GQ6021@redhat.com>
Message-ID: <alpine.BSF.2.21.1802202243460.89213@zero.eik.bme.hu>
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<7fa4ce574074b3baf702b628a7e1fce647305ce1.1519150239.git.balaton@eik.bme.hu>
	<20180220183022.GQ6021@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] pc-bios: Added u-boot-sam460 firmware
 binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 20 Feb 2018, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Feb 20, 2018 at 06:57:43PM +0100, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  Makefile                           |   2 +-
>>  pc-bios/u-boot-sam460-20100605.bin | Bin 0 -> 524288 bytes
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>  create mode 100755 pc-bios/u-boot-sam460-20100605.bin
>>
>> diff --git a/Makefile b/Makefile
>> index 6434d6c..b0c16b3 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -661,7 +661,7 @@ multiboot.bin linuxboot.bin linuxboot_dma.bin kvmv=
apic.bin \
>>  s390-ccw.img s390-netboot.img \
>>  spapr-rtas.bin slof.bin skiboot.lid \
>>  palcode-clipper \
>> -u-boot.e500 \
>> +u-boot.e500 u-boot-sam460-20100605.bin \
>>  qemu_vga.ndrv \
>>  hppa-firmware.img
>>  else
>> diff --git a/pc-bios/u-boot-sam460-20100605.bin b/pc-bios/u-boot-sam46=
0-20100605.bin
>> new file mode 100755
>
> IIUC, you also need to provide glue in roms/Makefile to build the
> u-boot-sam460-20100605.bin from the submodule content. Presumably
> you can largely copy what's done for u-boot.e500 there.

Yes, it seems we can do the same (except stripping the result) and build=20
the Sam460ex_config from the appropriate source that should generate the=20
binary (but I'm not sure about the cross compiler setup in that Makefile,=
=20
my cross compiler is called powerpc-elf-gcc and after briefly looking at=20
it I'm not sure it will be found by that make magic).

Once the patch to add the sources is cleared I can send a v2 of this with=
=20
the roms/Makefile changes to also add a new target for this binary.

Regards,
BALATON Zoltan
