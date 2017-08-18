Received: from eggs.gnu.org ([2001:4830:134:3::10]:46683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1difQ3-0003pr-KM
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1difPy-000653-Ma
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:26:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1difPy-00064d-GN
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:26:22 -0400
References: <20170818110015.25310-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4b80d965-d162-84eb-c6c6-0adb86d83ce8@redhat.com>
Date: Fri, 18 Aug 2017 13:26:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170818110015.25310-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: specification exception for
 unknown diag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com

On 18.08.2017 13:00, Cornelia Huck wrote:
> While the PoP is silent on the issue, z/VM documentation states
> that unknown diagnose codes trigger a specification exception.
> We already do that when running with kvm, so change tcg to do so
> as well.

I just tried on a z/VM guest what happens if I call diag with an
unsupported code, and the Linux kernel then crashes with a specification
exception, indeed. So this sounds like the right thing to do!

> This is on top of "s390x: wire up diag288 in tcg".

May I suggest to order the patches the other way round? ... that's less
code churn that way.

 Thomas
