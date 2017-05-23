Received: from eggs.gnu.org ([2001:4830:134:3::10]:36239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dD7JR-00006K-FM
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dD7JM-0006Uz-Kz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:45:13 -0400
From: Diana Madalina Craciun <diana.craciun@nxp.com>
Date: Tue, 23 May 2017 10:45:03 +0000
Message-ID: <AM3PR04MB0616065849157F3DC9EA8E19FFF90@AM3PR04MB0616.eurprd04.prod.outlook.com>
References: <1490276212-32008-1-git-send-email-diana.craciun@nxp.com>
	<1490276212-32008-2-git-send-email-diana.craciun@nxp.com>
	<CAFEAcA8s9aR4rbJzd=9-oRashOGvUtSL4xxqbu2M1Cv2YFND7Q@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] Increased the size of requester_id
 field from MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Mike Caraman <mike.caraman@nxp.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Christoffer Dall <christoffer.dall@linaro.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>

On 04/04/2017 03:27 PM, Peter Maydell wrote:=0A=
> On 23 March 2017 at 13:36, Diana Craciun <diana.craciun@nxp.com> wrote:=
=0A=
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
> This name change would be reverting the name change in=0A=
> commit a05f686ff3, which says:=0A=
>     MemTxAttrs.stream_id also renamed to requester_id in order to better=
=0A=
>     reflect semantics of the field.=0A=
>=0A=
> I don't have a strong opinion about the name myself, but flipping=0A=
> backwards and forwards doesn't seem like a great plan :-)=0A=
=0A=
The reason I have changed the name is that the requester_id is a PCI=0A=
related terminology and this patch is extending the usage of that field=0A=
to other devices also. Naming it requester_id might be confusing.=0A=
=0A=
I will shortly send a v2 for the patches, I didn't change the name in=0A=
the v2, but if there are strong opinions regarding this naming, I will=0A=
change it.=0A=
=0A=
Thanks,=0A=
=0A=
Diana=0A=
