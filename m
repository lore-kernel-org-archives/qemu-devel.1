Received: from eggs.gnu.org ([2001:4830:134:3::10]:33632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVC7m-0006Nz-RY
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gVC7j-00043n-Fz
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:08:42 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:48037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gVC7j-0003wv-8M
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:08:39 -0500
Received: from player793.ha.ovh.net (unknown [10.109.143.246])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5ED2C19C86F
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 10:08:37 +0100 (CET)
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-4-clg@kaod.org>
	<20181206032535.GL768@umbus.fritz.box>
	<aa579a81-aeec-4197-1ea9-c6a7f995949f@kaod.org>
	<20181207020735.GY768@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c74c6541-a20d-4cab-9f8d-81854800afd7@kaod.org>
Date: Fri, 7 Dec 2018 10:08:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181207020735.GY768@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/37] ppc/xive: introduce the
 XiveNotifier interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 12/7/18 3:07 AM, David Gibson wrote:
> On Thu, Dec 06, 2018 at 07:17:47AM +0100, C=E9dric Le Goater wrote:
>> On 12/6/18 4:25 AM, David Gibson wrote:
>>> On Thu, Dec 06, 2018 at 12:22:17AM +0100, C=E9dric Le Goater wrote:
>>>> The XiveNotifier offers a simple interface, between the XiveSource
>>>> object and the main interrupt controller of the machine. It will
>>>> forward event notifications to the XIVE Interrupt Virtualization
>>>> Routing Engine (IVRE).
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  include/hw/ppc/xive.h | 23 +++++++++++++++++++++++
>>>>  hw/intc/xive.c        | 25 +++++++++++++++++++++++++
>>>>  2 files changed, 48 insertions(+)
>>>>
>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>> index 7cebc32eba4c..6770cffec67d 100644
>>>> --- a/include/hw/ppc/xive.h
>>>> +++ b/include/hw/ppc/xive.h
>>>> @@ -142,6 +142,27 @@
>>>> =20
>>>>  #include "hw/qdev-core.h"
>>>> =20
>>>> +/*
>>>> + * XIVE Fabric (Interface between Source and Router)
>>>> + */
>>>> +
>>>> +typedef struct XiveNotifier {
>>>> +    Object parent;
>>>> +} XiveNotifier;
>>>> +
>>>> +#define TYPE_XIVE_NOTIFIER "xive-fabric"
>>>
>>> I'm applying this, but changing the string here from "xive-fabric" to
>>> "xive-notifier".
>>
>> Ah yes. My sed command missed that.
>=20
> So, I've now applied patches 1-5.  I think we've agreed to a change in
> patch 6 which will require tweaks to a bunch further down the series,

yes.

> so I think the rest will need a v7.

Yes.

Here's my TODO list :=20

- some asserts and comments
- introduce a helper to get the CAM line of a ring
- rework the physical CAM line setting.
- introduce a "block" property in XiveENDSource
- remove chip_id id from XiveRouter
- may be modify XiveRouter to be a QOM interface


The hcalls are the big remaining part to review before adding the=20
XIVE-only machine.

I think I will move up in the patchset the TCG "dual" machine because=20
it does not need much more changes and the XICS machine is not impacted.

KVM will come after.
=20

Thanks,

C.=20
