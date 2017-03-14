Received: from eggs.gnu.org ([2001:4830:134:3::10]:50504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cnpom-00052n-5l
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cnpoj-0004L6-4U
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:01:04 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:59128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cnpoi-0004FT-RY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:01:00 -0400
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 0CDF430FC6
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 18:00:47 +0100 (CET)
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-2-git-send-email-clg@kaod.org>
	<20170314053856.GH12564@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3136fbfa-938a-679e-0bf6-c1dab315d425@kaod.org>
Date: Tue, 14 Mar 2017 18:00:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170314053856.GH12564@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/8] ppc/xics: add a
 xics_get_cpu_index_by_pir() helper
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

On 03/14/2017 06:38 AM, David Gibson wrote:
> On Wed, Mar 08, 2017 at 11:52:44AM +0100, C=E9dric Le Goater wrote:
>> This helper will be used to translate the server number of the XIVE
>> (which is a PIR) into an ICPState index number (which is a cpu index).
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> This seems a slightly roundabout way of doing things.  Why not just
> have the vcpu_by_pir() interface, then have the XICSFabric implementor
> go directly from PIR to xics server state.

So what you are saying is that we should try to move the "nature"
of the 'server' parameter of the xics framework in the icp_get()=20
handler of the XICSFabric. Correct ? Because at the end, it all=20
boils down to use a 'server' to look for an ICPState.

Each machine would do its conversion :=20

	xics_get_cpu_index_by_dt_id() for spapr
	xics_get_cpu_index_by_pir() for powernv

C.
