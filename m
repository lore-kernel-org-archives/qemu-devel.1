Received: from eggs.gnu.org ([2001:4830:134:3::10]:53589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEE1f-0004pE-Mn
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEE1a-0000KD-Vn
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:07:27 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170525163851.8047-12-berrange@redhat.com>
References: <20170525163851.8047-1-berrange@redhat.com>
	<20170525163851.8047-12-berrange@redhat.com>
Date: Fri, 26 May 2017 14:07:21 +0200
Message-ID: <w518tljlt3a.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 11/20] qcow2: convert QCow2 to use
 QCryptoBlock for encryption
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

On Thu 25 May 2017 06:38:42 PM CEST, Daniel P. Berrange wrote:
> This converts the qcow2 driver to make use of the QCryptoBlock
> APIs for encrypting image content, using the legacy QCow2 AES
> scheme.
>
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>
>   $QEMU \
>     -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
>     -drive file=/home/berrange/encrypted.qcow2,encrypt.key-secret=sec0
>
> The test 087 could be simplified since there is no longer a
> difference in behaviour when using blockdev_add with encrypted
> images for the running vs stopped CPU state.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
