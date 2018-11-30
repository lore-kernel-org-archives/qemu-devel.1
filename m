Received: from eggs.gnu.org ([2001:4830:134:3::10]:59642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gSeoJ-0004wQ-BI
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gSeoE-00008h-T7
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:10:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gSeoE-00008U-Km
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:10:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAU93UIG098742
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 04:10:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p30mrvh4n-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 04:10:01 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 30 Nov 2018 09:09:58 -0000
Reply-To: pmorel@linux.ibm.com
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-2-git-send-email-pmorel@linux.ibm.com>
	<91b8a21b-5dea-f944-1200-4491ad1d69f2@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 30 Nov 2018 10:09:52 +0100
MIME-Version: 1.0
In-Reply-To: <91b8a21b-5dea-f944-1200-4491ad1d69f2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <07fbdb99-be94-1bf0-3ee8-769e49a61aff@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] s390x/vfio: ap: Finding the AP
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 29/11/2018 21:30, Tony Krowiak wrote:
> On 11/22/18 11:35 AM, Pierre Morel wrote:
>> In the case we will enter QEMU through interception of instructions,
>> we will need to retrieve the AP devices.
>> The base device is the AP bridge.
>>
>> Let us implement a way to retrieve the AP Bridge from qtree.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>> =C2=A0 hw/s390x/ap-bridge.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 12 ++++++++++++
>> =C2=A0 include/hw/s390x/ap-bridge.h |=C2=A0 1 +
>> =C2=A0 2 files changed, 13 insertions(+)
>>
>> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
>> index 3795d30..831ad5d 100644
>> --- a/hw/s390x/ap-bridge.c
>> +++ b/hw/s390x/ap-bridge.c
>> @@ -14,6 +14,18 @@
>> =C2=A0 #include "hw/s390x/ap-bridge.h"
>> =C2=A0 #include "cpu.h"
>> +DeviceState *s390_get_ap_bridge(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 static DeviceState *apb;
>=20
> Since you are caching a reference to the bridge after
> retrieving it, why not make apb a global scope variable
> and initialize it in s390_init_ap() when the bridge is
> created. You can then declare it as an extern in the
> ap-bridge.h header file and you eliminate the need for
> this function. If you do make it a global var, I would
> name it ap_bridge;

We already had this discussion when implementing zPCI.
I use a similar solution as it was decided at that time.


Regards,
Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
