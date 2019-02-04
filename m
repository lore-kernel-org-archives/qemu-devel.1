Received: from eggs.gnu.org ([209.51.188.92]:42038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gqi3p-0000IG-Nm
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gqi3l-0006GA-Rn
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gqi3i-0006CY-7T
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:29:27 -0500
References: <20190204160325.4914-1-lersek@redhat.com>
	<20190204160325.4914-2-lersek@redhat.com>
	<87310497-8360-f6ab-8671-c20ac14242c1@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <02f79867-b567-b410-6eb6-6c6bd4ae2c82@redhat.com>
Date: Mon, 4 Feb 2019 18:29:05 +0100
MIME-Version: 1.0
In-Reply-To: <87310497-8360-f6ab-8671-c20ac14242c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] roms: add the edk2 project as a git
 submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 02/04/19 17:50, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/4/19 5:03 PM, Laszlo Ersek wrote:
>> The roms/edk2 submodule can help with three goals:
>> - build the OVMF and ArmVirtQemu virtual UEFI firmware platforms (to b=
e
>>   implemented later),
>> - build the EfiRom tool on the fly, which is used in roms/Makefile, fo=
r
>>   building the "efirom" target,
>> - build UEFI test applications (to be run in guests), for qtest suppor=
t.
>>
>> Edk2 commit 85588389222a3636baf0f9ed8227f2434af4c3f9 stands for the la=
test
>> "stable tag", namely "edk2-stable201811".
>>
>> The edk2 repository tracks some binary files that should not be remove=
d by
>> QEMU's top-level "make clean"; exempt the full pathnames from the "fin=
d"
>> command.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Already reviewed v2 ;)
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg592311.html
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Ugh, my bad, for not picking up those. I was so relieved Friday (?)
night about the "+" that I failed to focus on anything else. My apologies=
.

Thank you!
Laszlo
