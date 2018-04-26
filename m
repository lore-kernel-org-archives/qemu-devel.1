Received: from eggs.gnu.org ([2001:4830:134:3::10]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBbAn-0001vg-Up
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBbAi-0005OC-LU
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:18:33 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:36359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fBbAi-0005Nc-FI
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:18:28 -0400
Received: from player774.ha.ovh.net (unknown [10.109.108.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id A11C8135E5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 09:18:26 +0200 (CEST)
References: <20180425093424.18713-1-clg@kaod.org>
	<20180426011916.GB8800@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <33034bc0-c8ec-3b07-74aa-285daf8e6cdc@kaod.org>
Date: Thu, 26 Apr 2018 09:18:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180426011916.GB8800@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: fix entry point for secondary CPUs
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

On 04/26/2018 03:19 AM, David Gibson wrote:
> On Wed, Apr 25, 2018 at 11:34:24AM +0200, C=E9dric Le Goater wrote:
>> Secondary CPUs do not start at SPAPR_ENTRY_POINT but at an address
>> given by the guest OS.
>>
>> Fixes commit c79128c14c20 ("spapr: Make a helper to set up cpu entry
>> point state")
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Oops.  Since I haven't send that patch upstream yet, I've folded this
> fix in rather than including it as a separate patch.

OK.=20

> Note that ppc-for-<whatever> are rebasing trees, so commit ids in
> there aren't stable.

yes. I usually track these at the beginning of the dev cycle. So I=20
have rebased all my QEMU development trees on ppc-for-2.13 yesterday=20
and found a couple of issues in TCG hot(un)plug, the entry point and=20
the radix LPCR setting.

C.
=20
