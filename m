Received: from eggs.gnu.org ([2001:4830:134:3::10]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyEBw-00087q-Hv
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyEBr-0005iG-Mn
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:03:56 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:44822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cyEBr-0005hx-HN
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:03:51 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 16C3F2F5F8
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 11:03:49 +0200 (CEST)
References: <1491984907-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
	<9e992fd5-8f42-5ec6-2a77-f6d9ce088226@kaod.org>
	<20170412085300.GB1429@in.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ab619b56-35ba-80f8-7647-06666673b7bb@kaod.org>
Date: Wed, 12 Apr 2017 11:03:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170412085300.GB1429@in.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr-cpu-core: Release ICPState object
 during CPU unrealization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bharata@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 04/12/2017 10:53 AM, Bharata B Rao wrote:
> On Wed, Apr 12, 2017 at 10:47:39AM +0200, C=E9dric Le Goater wrote:
>> On 04/12/2017 10:15 AM, Bharata B Rao wrote:
>>> Recent commits that re-organized ICPState object missed to destroy
>>> the object when CPU is unrealized. Fix this so that CPU unplug
>>> doesn't abort QEMU.
>>
>> Indeed.
>>
>>> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>>
>> I am wondering if we should not be doing the unparent under=20
>> spapr_cpu_destroy() or even xics_cpu_destroy(). Apart from
>> that,=20
>=20
> Thought so, but since object is created in realize routinte itself
> (and not in any of its callers), did the object destruction in
> unrealize to be symmetrical :)

yes. I think it is a good pratice to unparent/free the object=20
in the same file it was allocated.

Thanks,

C.
