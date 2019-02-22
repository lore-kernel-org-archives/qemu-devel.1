Received: from eggs.gnu.org ([209.51.188.92]:49649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gxCjM-0007Je-9M
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gxCjK-0002xF-S6
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:27:16 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:22156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gxCjK-0002He-EN
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:27:14 -0500
Date: Fri, 22 Feb 2019 16:26:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <BN6PR2201MB1251CE53F93F35FFA399FABEC67F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.BSF.2.21.9999.1902221621440.73795@zero.eik.bme.hu>
References: <20190218121322.DAB0474569F@zero.eik.bme.hu>
	<BN6PR2201MB1251CE53F93F35FFA399FABEC67F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] mips_fulong2e: Add on-board graphics
 chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <zltjiangshi@gmail.com>, "philmd@redhat.com" <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, 22 Feb 2019, Aleksandar Markovic wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>> Subject: [PATCH v2] mips_fulong2e: Add on-board graphics chip
>>
>> Add (partial) emulation of the on-board GPU of the machine. This
>> allows the PMON2000 firmware to run and should also work with Linux
>> console but probably not with X yet.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Based-on: 20190218030257.624A7745694@zero.eik.bme.hu
>> ---
>> hw/mips/mips_fulong2e.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Zoltan, perhaps you ought to create a mini series consisting of the pat=
ch
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02471.html
>
> and this patch.
>
> I would like to apply this patch independently to MIPS queue, but I can=
't,
> because of interdependencies og the two patches.
>
> I would feel comfortable with both patches going through graphics pull
> request.

OK, I'll resubmit this together with the next version of the prerequisite=
=20
ATI patch cc-ing Gerd so he can take them together. Thanks for review.=20
(The ATI VGA patch is still under review so maybe we will have a few more=
=20
versions before it will be merged.)

Regards,
BALATON Zoltan
