Received: from eggs.gnu.org ([2001:4830:134:3::10]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cahhC-0005eD-7L
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cahh8-0007kR-RC
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:42:58 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:50087 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cahh8-0007aM-JY
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 06:42:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170206112953.16993-1-berrange@redhat.com>
References: <20170206112953.16993-1-berrange@redhat.com>
Date: Mon, 06 Feb 2017 12:42:16 +0100
Message-ID: <w51o9yfeeav.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] rules: don't try to create missing include
 dirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon 06 Feb 2017 12:29:53 PM CET, "Daniel P. Berrange" wrote:

> Rather than trying to workaround this, just revert the code that
> attempted to mkdir the missing include directories. Instead just turn
> off the compiler warning in question as the missing dir is expected &
> harmless in general.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Tested-by: Alberto Garcia <berto@igalia.com>

Berto
