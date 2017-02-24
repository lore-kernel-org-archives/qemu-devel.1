Received: from eggs.gnu.org ([2001:4830:134:3::10]:43564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDp6-0000fB-GN
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chDp1-0008Uc-UY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:14:04 -0500
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:51395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chDp1-0008TE-O9
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:59 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 37EF3DB84A
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 12:13:58 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-10-git-send-email-clg@kaod.org>
	<20170223023145.GX12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <07e35e98-3090-793e-16aa-90b0b913fcaa@kaod.org>
Date: Fri, 24 Feb 2017 12:13:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170223023145.GX12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 09/22] ppc/xics: remove
 xics_find_source()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/23/2017 03:31 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 02:47:32PM +0100, C=E9dric Le Goater wrote:
>> It is not used anymore now that we have the QOM interface for XICS.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Several of these patches are small enough that I wonder if they could
> be merged, though.

yes I could probably keep all the removal at the end. I will take
a look at that.

Thanks,

C.=20

=20
>=20
>> ---
>>  hw/intc/xics.c        | 12 ------------
>>  include/hw/ppc/xics.h |  1 -
>>  2 files changed, 13 deletions(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index 2decb921e4e3..bfd3a539561a 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -737,18 +737,6 @@ static const TypeInfo xics_interface_info =3D {
>>  /*
>>   * Exported functions
>>   */
>> -ICSState *xics_find_source(XICSState *xics, int irq)
>> -{
>> -    ICSState *ics;
>> -
>> -    QLIST_FOREACH(ics, &xics->ics, list) {
>> -        if (ics_valid_irq(ics, irq)) {
>> -            return ics;
>> -        }
>> -    }
>> -    return NULL;
>> -}
>> -
>>  qemu_irq xics_get_qirq(XICSInterface *xi, int irq)
>>  {
>>      XICSInterfaceClass *xic =3D XICS_INTERFACE_GET_CLASS(xi);
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 896fa5d87c1c..e10426e98e31 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -222,7 +222,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, =
int server,
>> =20
>>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>> =20
>> -ICSState *xics_find_source(XICSState *icp, int irq);
>>  void ics_resend(ICSState *ics);
>> =20
>>  #endif /* XICS_H */
>=20
