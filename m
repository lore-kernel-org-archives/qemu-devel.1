Received: from eggs.gnu.org ([2001:4830:134:3::10]:45876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOZp-0001lO-0L
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOZl-0003sq-26
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:47:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40137
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dGOZk-0003sP-SD
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:47:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51Bi0Im005657
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:47:36 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atfv7qskm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:47:35 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 1 Jun 2017 12:47:34 +0100
Date: Thu, 1 Jun 2017 13:47:29 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170529135520.101429-7-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
	<20170529135520.101429-7-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170601134729.510fcc86.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] s390x/css: activate ChannelSubSys
 migration
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

On Mon, 29 May 2017 15:55:19 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Turn on migration for the channel subsystem for the next machine.  For
> legacy machines we still have to do things the old way.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c             | 5 +++++
>  hw/s390x/s390-virtio-ccw.c | 9 ++++-----
>  hw/s390x/virtio-ccw.c      | 1 -
>  include/hw/s390x/css.h     | 4 ++++
>  4 files changed, 13 insertions(+), 6 deletions(-)

=46rom your reply to Christian's mail, I presume you also tested the
result with some compat machines?

With the whitespace change removed,

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
