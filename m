Received: from eggs.gnu.org ([2001:4830:134:3::10]:60536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFL1V-0005m4-Au
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFL1Q-0002rM-F4
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:47:53 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170525163851.8047-18-berrange@redhat.com>
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-18-berrange@redhat.com>
Date: Mon, 29 May 2017 15:47:08 +0200
Message-ID: <w51fufn4vxf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 17/20] block: remove all encryption
 handling APIs
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

On Thu 25 May 2017 06:38:48 PM CEST, "Daniel P. Berrange" <berrange@redhat.com> wrote:
> Now that all encryption keys must be provided upfront via
> the QCryptoSecret API and associated block driver properties
> there is no need for any explicit encryption handling APIs
> in the block layer. Encryption can be handled transparently
> within the block driver. We only retain an API for querying
> whether an image is encrypted or not, since that is a
> potentially useful piece of metadata to report to the user.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
