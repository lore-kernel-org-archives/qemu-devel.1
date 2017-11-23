Received: from eggs.gnu.org ([2001:4830:134:3::10]:51978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHoxp-0002yP-Kj
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHoxj-0006Md-VU
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:42:37 -0500
References: <1511364808-30171-1-git-send-email-deepa.srinivasan@oracle.com>
	<20171122170607.GA8217@stefanha-x1.localdomain>
	<20171122180426.GC10954@localhost.localdomain>
	<20171123102325.GA26022@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2735b9a3-7f03-d82b-fe88-b189f1989abf@redhat.com>
Date: Thu, 23 Nov 2017 11:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <20171123102325.GA26022@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block: Fix qemu crash when using scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Deepa Srinivasan <deepa.srinivasan@oracle.com>, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mark.kanda@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On 23/11/2017 11:23, Stefan Hajnoczi wrote:
> You are right.  I audited the blk_aio_preadv() callers and they all kee=
p
> qiov around until the request is complete.
>=20
> Actually this makes sense because even in the simple non-coroutine case
> with aio=3Dthreads the qiov hasn't necessarily been read yet when the
> function returns.  The aio_worker() function executes later and only
> then is qiov handed to the host kernel.
>=20
> So this is a one-off bug in blk_aio_ioctl() callers.

Only in blk_aio_ioctl, not in the callers.

Paolo
