Received: from eggs.gnu.org ([2001:4830:134:3::10]:43855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVFqH-00013q-SQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVFqD-0001Kd-U0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:30:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42624
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVFqD-0001KI-Nm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:30:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CBTfET067698
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:30:01 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj5eh93-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:30:00 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 07:30:00 -0400
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 13:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <5d0d881a-28ae-0c77-81ed-60c2a680a47d@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] migration: s390x css migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 07/11/2017 04:54 PM, Halil Pasic wrote:
> Like for v2 the scope of this patch series is now limited to decoupling
> channel subsystem migration from the migration of virtio-ccw proxies.
> 
> There wasn't a whole lot of criticism regarding v2, so very little
> changed since then. All issues identified in the previous round were
> addressed as agreed upon. I hope this series is now good for 2.10.
> 
> @Dave You helped me quite a lot with these, thanks a lot! I could not
> find any r-b's or similar form you so if you would like to take the
> well deserved credit for your work...
> 
> v2 --> v3:
> * rebased onto current master, since 's390x: vmstatify config migration
>   for virtio-ccw' is already there we don't need it here any more
> * added ack's and r-b'
> * got rid of loads of nits (thanks Connie and Thomas)
> * added explanation why certain members are not migrated
> 
> v1 --> v2:
> * Split out the vmystatify virtio-ccw part, reorganize
> * Use WITH_TMP instead of one-shot VMStateInfo's
> 
> Halil Pasic (6):
>   s390x: add helper get_machine_class
>   s390x: add css_migration_enabled to machine class
>   s390x/css: add missing css state conditionally
>   s390x/css: add ORB to SubchDev
>   s390x/css: activate ChannelSubSys migration
>   s390x/css: use SubchDev.orb
> 
>  hw/intc/s390_flic.c                |  20 ++++++
>  hw/s390x/css.c                     | 144 +++++++++++++++++++++++++++++++++----
>  hw/s390x/s390-virtio-ccw.c         |  58 +++++++++------
>  include/hw/s390x/css.h             |  11 ++-
>  include/hw/s390x/s390-virtio-ccw.h |   7 ++
>  5 files changed, 199 insertions(+), 41 deletions(-)
> 

applied to s390-next. Thanks
