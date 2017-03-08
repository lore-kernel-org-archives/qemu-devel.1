Received: from eggs.gnu.org ([2001:4830:134:3::10]:44599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1clXwC-00084z-Pt
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1clXw9-0006TC-Il
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:31:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1clXw9-0006So-Bm
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:31:13 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v289TN7l027282
	for <qemu-devel@nongnu.org>; Wed, 8 Mar 2017 04:31:12 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292dgdcefq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 04:31:12 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 8 Mar 2017 04:31:10 -0500
Date: Wed, 8 Mar 2017 17:31:05 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170308021533.78292-1-bjsdjshi@linux.vnet.ibm.com>
	<20170308021533.78292-2-bjsdjshi@linux.vnet.ibm.com>
	<20170308091346.GB5211@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308091346.GB5211@noname.redhat.com>
Message-Id: <20170308093105.GC7563@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block: Handle NULL options
 correctly in raw_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com

* Kevin Wolf <kwolf@redhat.com> [2017-03-08 10:13:46 +0100]:

> Am 08.03.2017 um 03:15 hat Dong Jia Shi geschrieben:
> > A normal call for raw_open should always pass in a non-NULL @options,
> > but for some certain cases (e.g. trying to applying snapshot on a RBD
> > image), they call raw_open with a NULL @options right after the calling
> > for raw_close.
> > 
> > Let's take the NULL @options as a sign of trying to do raw_open again,
> > and just simply return a success code.
> > 
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> I think we rather need to fix bdrv_snapshot_goto() so that it doesn't
> pass NULL, but the actual options that were given for the node (i.e.
> bs->options).
I've tried that before the current try. bs->options does not have the
"file" key-value pair, so that leads to a fail too. Should we put "file"
in to the options manually? I noticed that it was removed from
bs->options during the calling of bdrv_open_inherit.

> 
> Kevin
> 

-- 
Dong Jia
