Received: from eggs.gnu.org ([208.118.235.92]:46820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gexHy-0007aO-T3
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 02:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gexHu-0008GN-42
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 02:19:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gexHl-0008Aw-4Z
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 02:19:25 -0500
References: <1546443980-26779-1-git-send-email-thuth@redhat.com>
	<c2648f00-c44f-7f8e-8673-501b88f1e125@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <17ed4887-1784-960e-d82e-ec90d98efc82@redhat.com>
Date: Thu, 3 Jan 2019 08:19:10 +0100
MIME-Version: 1.0
In-Reply-To: <c2648f00-c44f-7f8e-8673-501b88f1e125@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add some missing
 SPARC-related files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 2019-01-02 20:34, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 1/2/19 4:46 PM, Thomas Huth wrote:
>> These files / devices are only used by SPARC machines, so we can sort
>> them into the corresponding categories in the MAINTAINERS file.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  MAINTAINERS | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b6c2645..e897963 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1069,9 +1069,11 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co=
.uk>
>>  S: Maintained
>>  F: hw/sparc/sun4m.c
>>  F: hw/sparc/sun4m_iommu.c
>> +F: hw/display/cg3.c
>> +F: hw/display/tcx.c
>>  F: hw/dma/sparc32_dma.c
>>  F: hw/misc/eccmemctl.c
>> -F: hw/misc/slavio_misc.c
>> +F: hw/*/slavio_*.c
>>  F: include/hw/sparc/sparc32_dma.h
>>  F: pc-bios/openbios-sparc32
>>  F: include/hw/sparc/sun4m_iommu.h
>> @@ -1083,6 +1085,8 @@ F: hw/sparc64/sun4u.c
>>  F: pc-bios/openbios-sparc64
>>  F: hw/pci-host/sabre.c
>>  F: include/hw/pci-host/sabre.h
>> +F: include/hw/sparc/sun4u_iommu.h
>=20
> I sent a patch to trivial@ with other sun4u changes, reviewed by Mark:
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04467.html

Oh, right, sorry!

> Neither mine nor your are complete :)
> Can I include your patch when respining the series? (Not sure I need to
> respin although).

Sure!

>> +F: include/hw/nvram/sun_nvram.h
>=20
> sun_nvram.h is also used by sun4m (the previous section this patch upda=
tes).

Right. So it should maybe be listed twice... (but since the maintainer
of sun4u and sun4m is the same, it likely does not really matter)

 Thomas
