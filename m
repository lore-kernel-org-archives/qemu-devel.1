Received: from eggs.gnu.org ([2001:4830:134:3::10]:46705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxZxc-0006S9-EC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxZxX-0005uu-G7
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:06:28 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:35697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1cxZxX-0005fC-43
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 10:06:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170405151148.16363-5-stefanha@redhat.com>
References: <20170405151148.16363-1-stefanha@redhat.com>
	<20170405151148.16363-5-stefanha@redhat.com>
Date: Mon, 10 Apr 2017 16:05:42 +0200
Message-ID: <w51k26se4sp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 4/9] qcow2: make refcount size
 calculation conservative
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Wed 05 Apr 2017 05:11:43 PM CEST, Stefan Hajnoczi wrote:
> The refcount metadata size calculation is inaccurate and can produce
> numbers that are too small.  This is bad because we should calculate a
> conservative number - one that is guaranteed to be large enough.
>
> This patch switches the approach to a fixed point calculation because
> the existing equation is hard to solve when inaccuracies are taken care
> of.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
