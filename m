Received: from eggs.gnu.org ([2001:4830:134:3::10]:36700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dgAzF-0008Jb-48
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dgAzB-0006N7-13
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:32:29 -0400
From: Diana Madalina Craciun <diana.craciun@nxp.com>
Date: Fri, 11 Aug 2017 14:32:21 +0000
Message-ID: <AM3PR04MB0616F921434F49926CA6213DFF890@AM3PR04MB0616.eurprd04.prod.outlook.com>
References: <1495537965-4187-1-git-send-email-diana.craciun@nxp.com>
	<1495537965-4187-2-git-send-email-diana.craciun@nxp.com>
	<17ae81be-a86e-d0ab-de93-046846e0b7d2@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Increased the size of requester_id
 field from MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, Mike Caraman <mike.caraman@nxp.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>

Hi Eric,=0A=
=0A=
On 07/26/2017 03:23 PM, Auger Eric wrote:=0A=
> Hi Diana,=0A=
> On 23/05/2017 13:12, Diana Craciun wrote:=0A=
>> The PCI requester ID field is 16 bits. The requester_id field=0A=
>> from MemTxAttrs is used for MSIs to specify the device ID for=0A=
>> the platforms where this device ID is needed (e.g virt machine + GICv3=
=0A=
>> ITS). However, if more entities that uses MSIs in the system are used,=
=0A=
>> 16 bit is no longer enough to represent the device ID. Increased the siz=
e=0A=
>> of this field to 24 bits in order to accomodate 256 entities.=0A=
>> Also the name requester_id does no longer reflect the content, so=0A=
>> the name was changed to stream_id.=0A=
> I think both deviceid and streamid can be up to 32 bits in theory.=0A=
=0A=
Yes, both of them can be up to 32 bit. I can extend the field to 32 bit.=0A=
=0A=
>=0A=
> With respect to the renaming, stream_id really is ARM specific and=0A=
> corresponds to the ID space before the SMMU while you mostly address=0A=
> device id problematics here (ie. space id input to the interrupt=0A=
> controller). Maybe a more generic terminology such as originator id=0A=
> could be used or source id (I think this is Intel terminology though).=0A=
=0A=
I agree, originator id sounds good and so far it doesn't seem to overlap=0A=
to other specific terminology.=0A=
=0A=
>=0A=
> Maybe the changes in semantics of the field should be=0A=
> associated/combined with its new computation found in next patch? see=0A=
> comments in subsequent patch.=0A=
=0A=
I agree.=0A=
=0A=
Thanks,=0A=
=0A=
Diana=0A=
=0A=
=0A=
