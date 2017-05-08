Received: from eggs.gnu.org ([2001:4830:134:3::10]:41614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7iWT-0005e8-Lb
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7iWQ-0001Il-Hz
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:21 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:40991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1d7iWQ-0001Cz-4r
	for qemu-devel@nongnu.org; Mon, 08 May 2017 09:16:18 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170418135726.28022-5-stefanha@redhat.com>
References: <20170418135726.28022-1-stefanha@redhat.com>
	<20170418135726.28022-5-stefanha@redhat.com>
Date: Mon, 08 May 2017 15:15:40 +0200
Message-ID: <w51efvz32wz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 4/9] qcow2: make refcount size
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
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nir Soffer <nsoffer@redhat.com>, John Snow <jsnow@redhat.com>

On Tue 18 Apr 2017 03:57:21 PM CEST, Stefan Hajnoczi wrote:
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

(I think I had already reviewed this in v4? I haven't seen any further
changes)

Berto
