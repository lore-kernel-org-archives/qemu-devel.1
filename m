Received: from eggs.gnu.org ([2001:4830:134:3::10]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOcM-0002YZ-JV
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOcI-0004tQ-GE
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:50:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dGOcI-0004tJ-64
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:50:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51BnIRL005441
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:50:12 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at85r47ut-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:50:12 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 1 Jun 2017 12:50:10 +0100
Date: Thu, 1 Jun 2017 13:50:06 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170529135520.101429-8-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-8-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170601135006.5a33a20c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] s390x/css: use SubchDev.orb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Mon, 29 May 2017 15:55:20 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Instead of passing around a pointer to ORB let us simplify some
> functions signatures by using the previously introduced ORB saved at the

Either "function signatures" or "functions' signatures" :)

> subchannel (SubchDev).
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

This is a nice rework.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
