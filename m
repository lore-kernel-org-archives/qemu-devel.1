Received: from eggs.gnu.org ([2001:4830:134:3::10]:43083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNfmH-0005wb-0f
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 09:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNfmD-0001DY-1D
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 09:06:53 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:40916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNfmC-0001DB-QH
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 09:06:48 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C1AD6126B9A
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 15:06:46 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a33e3f91-e1e4-07c2-5976-bf9371c26b66@kaod.org>
Date: Sat, 9 Dec 2017 15:06:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171209084338.29395-3-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>

> +static const VMStateDescription vmstate_spapr_xive = {
> +    .name = TYPE_SPAPR_XIVE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_spapr_xive_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
> +        VMSTATE_STRUCT_VARRAY_UINT32(ivt, sPAPRXive, nr_irqs, 1,
> +                                     vmstate_spapr_xive_ive, XiveIVE),

I got it wrong again. This should be :

        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ivt, sPAPRXive, nr_irqs,
                                     vmstate_spapr_xive_ive, XiveIVE),

for migration to work.

Cheers,

C. 
