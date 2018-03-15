Received: from eggs.gnu.org ([2001:4830:134:3::10]:58025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewYcZ-0007wH-Nd
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewYcY-0005ZO-WB
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:33:03 -0400
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-2-git-send-email-thuth@redhat.com>
	<cd0806bc-6503-6cab-5f23-a92128ad0af3@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8f02c51b-3311-465c-84a1-aacafc6c485e@redhat.com>
Date: Thu, 15 Mar 2018 20:32:47 +0100
MIME-Version: 1.0
In-Reply-To: <cd0806bc-6503-6cab-5f23-a92128ad0af3@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] tests/boot-sector: Add magic bytes to
 s390x boot code header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 15.03.2018 12:47, Philippe Mathieu-Daud=C3=A9 wrote:
> On 03/15/2018 08:49 AM, Thomas Huth wrote:
>> We're going to use the s390x boot code for testing CD-ROM booting.
>> But the ISO loader of the s390-ccw bios is a little bit more picky
>> than the network loader and expects some magic bytes in the header
>> of the file (see linux_s390_magic in pc-bios/s390-ccw/bootmap.c), so
>> we've got to add them in our boot code here, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/boot-sector.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
>> index c373f0e..04721c9 100644
>> --- a/tests/boot-sector.c
>> +++ b/tests/boot-sector.c
>> @@ -68,8 +68,11 @@ static uint8_t x86_boot_sector[512] =3D {
>>  };
>> =20
>>  /* For s390x, use a mini "kernel" with the appropriate signature */
>> -static const uint8_t s390x_psw[] =3D {
>> -    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
>> +static const uint8_t s390x_psw_and_magic[] =3D {
>=20
> Can you add a comment such "see linux_s390_magic in
> pc-bios/s390-ccw/bootmap.c"?

Sure, I'll add a comment.

 Thomas
