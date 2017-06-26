Received: from eggs.gnu.org ([2001:4830:134:3::10]:53891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPU0M-00032z-TB
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPU0H-0003IJ-T3
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:24:38 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170623162419.26068-11-berrange@redhat.com>
References: <20170623162419.26068-1-berrange@redhat.com>
	<20170623162419.26068-11-berrange@redhat.com>
Date: Mon, 26 Jun 2017 15:24:32 +0200
Message-ID: <w51k23ydgq7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 10/20] qcow2: make
 qcow2_encrypt_sectors encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 23 Jun 2017 06:24:09 PM CEST, Daniel P. Berrange wrote:
> Instead of requiring separate input/output buffers for
> encrypting data, change qcow2_encrypt_sectors() to assume
> use of a single buffer, encrypting in place. The current
> callers all used the same buffer for input/output already.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
