Received: from eggs.gnu.org ([2001:4830:134:3::10]:34123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCN5b-00065Z-9D
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gCN5Y-0001SL-4E
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:00:39 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181016103105.30927-1-berrange@redhat.com>
References: <20181016103105.30927-1-berrange@redhat.com>
Date: Tue, 16 Oct 2018 12:59:58 +0200
Message-ID: <w51k1miyx5d.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] crypto: initialize sector size even when
 opening with no IO flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 16 Oct 2018 12:31:05 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> The qcow2 block driver expects to see a valid sector size even when it
> has opened the crypto layer with QCRYPTO_BLOCK_OPEN_NO_IO.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I was actually preparing a patch along these lines :-)

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
