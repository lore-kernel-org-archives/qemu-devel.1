Received: from eggs.gnu.org ([2001:4830:134:3::10]:34214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdEAs-0000qy-Ka
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cdEAp-0007TA-Hm
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:48:02 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170210170910.8867-9-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-9-berrange@redhat.com>
Date: Mon, 13 Feb 2017 11:47:56 +0100
Message-ID: <w51inoez7s3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 08/18] qcow: make encrypt_sectors
 encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 10 Feb 2017 06:09:00 PM CET, Daniel P. Berrange wrote:
> Instead of requiring separate input/output buffers for
> encrypting data, change encrypt_sectors() to assume
> use of a single buffer, encrypting in place. One current
> caller uses the same buffer for input/output already
> and the other two callers are easily converted to do so.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

I think I had already reviewed this one in v3 :)

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
