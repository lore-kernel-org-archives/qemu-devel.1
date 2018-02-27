Received: from eggs.gnu.org ([2001:4830:134:3::10]:56554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqgRU-0005pe-Sy
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqgRQ-0000hd-3P
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:41:20 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9264d585-dc54-b116-b96c-190ec1bf2562@redhat.com>
References: <20180222155922.9833-1-eblake@redhat.com>
	<20180222155922.9833-3-eblake@redhat.com>
	<20180227114702.GA5269@localhost.localdomain>
	<9264d585-dc54-b116-b96c-190ec1bf2562@redhat.com>
Date: Tue, 27 Feb 2018 15:41:13 +0100
Message-ID: <w51zi3u337a.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/4] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

> Note that L1 and L2 fields both stop at bit 55 currently, but do have
> room for expansion up to bit 61; so all three limits (if we include
> refcount table in the set capped at bit 55 for now) could be raised
> simultaneously if we find 64P too small in the future.

64 petabytes ought to be enough for anybody :-)

Berto
