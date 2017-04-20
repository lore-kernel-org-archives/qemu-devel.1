Received: from eggs.gnu.org ([2001:4830:134:3::10]:55332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d18XC-0000xk-4g
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d18XB-0000vh-5W
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:37:54 -0400
Date: Thu, 20 Apr 2017 17:37:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420093742.GH24486@lemon.lan>
References: <20170420075237.18219-1-famz@redhat.com>
	<149267756074.42.11256185359141373584@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149267756074.42.11256185359141373584@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PATCH v13 00/20] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Thu, 04/20 01:39, no-reply@patchew.org wrote:
> test-replication: /tmp/qemu-test/src/block/file-posix.c:1168: raw_init_lock_update: Assertion `!s->lock_update' failed.
> GTester: last random seed: R02Scba16429ff5a192bda9c88444de57b96
> test-replication: /tmp/qemu-test/src/block/file-posix.c:1168: raw_init_lock_update: Assertion `!s->lock_update' failed.
> GTester: last random seed: R02S71ef34cf124dcfa2d2816a5a05a83ee9
> test-replication: /tmp/qemu-test/src/block/file-posix.c:1168: raw_init_lock_update: Assertion `!s->lock_update' failed.
> GTester: last random seed: R02S6296241250c2052edfd7157c5417b65f
> test-replication: /tmp/qemu-test/src/block/file-posix.c:1168: raw_init_lock_update: Assertion `!s->lock_update' failed.
> GTester: last random seed: R02Sd7e01803d3bd42deab2a0a3015bcc52f

Good catch. Centos 6 doesn't have the OFD lock, and the code path missed a
cleanup. Will fix this.

Fam
