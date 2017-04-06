Received: from eggs.gnu.org ([2001:4830:134:3::10]:52753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw7Gv-0003Rq-Jj
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw7Gr-0003EL-LH
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:16:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53936
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw7Gr-0003E7-CS
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:16:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36DDop2047228
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 09:16:15 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29nkydr07t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 09:16:15 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 14:16:13 +0100
Date: Thu, 6 Apr 2017 15:16:10 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <5e9b4ef5-f737-bc26-433d-f111e44e294a@redhat.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
	<20170406111646.12624-6-cornelia.huck@de.ibm.com>
	<5e9b4ef5-f737-bc26-433d-f111e44e294a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170406151610.0f8c867e.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/10] s390x/css: provide
 introspection for virtual subchannel and device busid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, agraf@suse.de

On Thu, 6 Apr 2017 14:19:10 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 06.04.2017 13:16, Cornelia Huck wrote:

> > +out_err:
> > +    error_propagate(errp, err);
> > +    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
> > +    ccw_dev->sch = NULL;
> > +    g_free(sch);
> > +    return;
> >  }
> 
> Cosmetic nit: Remove the unnecessary "return;" statement right before
> the closing curly bracket.

Yup, will merge in.
