Received: from eggs.gnu.org ([2001:4830:134:3::10]:45370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOXT-0000Ua-Ga
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOXO-0003OE-Ja
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:45:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dGOXO-0003Nn-90
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:45:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51BhtdR137055
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:45:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2at85r40ht-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:45:08 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 1 Jun 2017 12:45:06 +0100
Date: Thu, 1 Jun 2017 13:45:01 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170529135520.101429-6-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-6-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170601134501.02ba4484.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/7] s390x/css: add ORB to SubchDev
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

On Mon, 29 May 2017 15:55:18 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Since we are going to need a migration compatibility breaking change to
> activate ChannelSubSys migration let us use the opportunity to introduce
> ORB to the SubchDev before that (otherwise we would need separate
> handling e.g. a compat property).
> 
> The ORB will be useful for implementing IDA, or async handling of
> subchannel work.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 35 +++++++++++++++++++++++++++++++++++
>  include/hw/s390x/css.h |  1 +
>  2 files changed, 36 insertions(+)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
