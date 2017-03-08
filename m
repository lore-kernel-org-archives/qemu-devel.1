Received: from eggs.gnu.org ([2001:4830:134:3::10]:57442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clYcs-0005uU-7R
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1clYcp-0001Gq-3A
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:15:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1clYco-0001GA-RT
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 05:15:19 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v28A5lZG001880
	for <qemu-devel@nongnu.org>; Wed, 8 Mar 2017 05:15:17 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292e5q4qgq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 05:15:17 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 8 Mar 2017 10:15:14 -0000
Date: Wed, 8 Mar 2017 11:15:08 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <31903f0c-a3e7-6acc-5e31-84d08507c513@redhat.com>
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<313e32c5-140d-ec13-6b10-98043756f2e6@redhat.com>
	<f3e9db7e-f3ab-1ae5-4da6-05dbd8d0206f@redhat.com>
	<61938aa1-2698-f55e-ea1c-e7d96da0b5d7@redhat.com>
	<20170308103023.5e0d9d81.cornelia.huck@de.ibm.com>
	<31903f0c-a3e7-6acc-5e31-84d08507c513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170308111508.79811f7e.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

On Wed, 8 Mar 2017 17:53:23 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 17:30, Cornelia Huck wrote:
> > On Wed, 8 Mar 2017 14:22:06 +0800
> > Jason Wang <jasowang@redhat.com> wrote:

> >> there may be even more. So you want to fix them all?
> > Obviously not speaking for Paolo, but I think the virtio core should
> > have be audited for missing guards.
> >
>=20
> Probably, otherwise we need a careful auditing of all callers of caches.

Yes, especially as all direct calls to the caches are localized in the
core anyway.
