Received: from eggs.gnu.org ([2001:4830:134:3::10]:58286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eYrsd-0006ld-Rj
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eYrsY-0006eF-SL
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:15:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eYrsY-0006c5-E2
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:15:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w09BEqge055321
	for <qemu-devel@nongnu.org>; Tue, 9 Jan 2018 06:15:37 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fcu1pw80f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:15:37 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Tue, 9 Jan 2018 06:15:35 -0500
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-3-sjitindarsingh@gmail.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>
Date: Tue, 9 Jan 2018 09:15:31 -0200
MIME-Version: 1.0
In-Reply-To: <20180109092103.18458-3-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1316befd-f593-8082-bec5-a1635e866f61@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [RFC 2/3]
 hw/spapr/spapr_caps: Add new caps safe_[cache/bounds_check/indirect_branch]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org
Cc: paulus@ozlabs.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 01/09/2018 07:21 AM, Suraj Jitindar Singh wrote:
> This patch adds three new capabilities:
> cap-cfpc -> safe_cache
> cap-sbbc -> safe_bounds_check
> cap-ibs  -> safe_indirect_branch

Hi, Suraj.

What about splitting this into smaller patches, one per capability?

> Each capability is tristate with the possible values "broken",
> "workaround" or "fixed". Add generic getter and setter functions for
> this new capability type. Add these new capabilities to the capabilities
> list. The maximum value for the capabilities is queried from kvm through
> new kvm capabilities. The requested values are considered to be
> compatible if kvm can support an equal or higher value for each
> capability.
> 
> Discussion:
> Currently these new capabilities default to broken to allow for
> backwards compatibility, is this the best option?

This could be placed in the cover letter, not in the commit message.

Cheers
Murilo
