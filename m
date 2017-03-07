Received: from eggs.gnu.org ([2001:4830:134:3::10]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clCLz-0006Vc-R7
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clCLw-0003xJ-IU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:28:27 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:41745 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1clCLw-0003fa-Av
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:28:24 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170303135150.12145-2-stefanha@redhat.com>
References: <20170303135150.12145-1-stefanha@redhat.com>
	<20170303135150.12145-2-stefanha@redhat.com>
Date: Tue, 07 Mar 2017 11:27:46 +0100
Message-ID: <w51mvcx2xgd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 1/4] block: add bdrv_max_size() API
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

On Fri 03 Mar 2017 02:51:47 PM CET, Stefan Hajnoczi wrote:
> bdrv_max_size() provides a conservative maximum for the size of a new
> image.  This information is handy if storage needs to be allocated (e.g.
> a SAN or an LVM volume) ahead of time.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
