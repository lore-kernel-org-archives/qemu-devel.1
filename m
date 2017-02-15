Received: from eggs.gnu.org ([2001:4830:134:3::10]:43849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce1MF-0002YU-Up
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce1MC-0000oL-Oy
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:19:03 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170210170910.8867-13-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-13-berrange@redhat.com>
Date: Wed, 15 Feb 2017 16:18:37 +0100
Message-ID: <w51d1ejqy7m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 12/18] qcow2: extend specification to
 cover LUKS encryption
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

On Fri 10 Feb 2017 06:09:04 PM CET, Daniel P. Berrange wrote:
> Update the qcow2 specification to describe how the LUKS header is
> placed inside a qcow2 file, when using LUKS encryption for the
> qcow2 payload instead of the legacy AES-CBC encryption
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

> +    Byte  0 -  7:   Offset into the image file at which the encryption
> +                    header starts in bytes. Must be aligned to a cluster
> +		    boundary.
> +    Byte  8 - 15:   Length of the written encryption header in bytes.
> +                    Note actual space allocated in the qcow2 file may
> +		    be larger than this value, since it will be rounded
> +		    to the nearest multiple of the cluster size. Any
> +		    unused bytes in the allocated space will be initialized
> +		    to 0.

You are using tabs instead of spaces in these paragraphs. Those are the
only tabs in the whole file so you probably want to change them.

> +In the LUKS partition header, the "payload-offset" field will be
> +calculated as normal for the LUKS spec. ie the size of the LUKS
> +header, plus key material regions, plus padding. Its value is not
> +used, however, since the qcow2 file format itself defines where
> +the real payload offset is.

If I understand this, the value of payload-offset is not used but it
must be correct.

Is payload-offset also relative to the start of the LUKS header? I
assume that it is, but maybe it can be clarified like you did with
key-material-offset.

> +In the LUKS key slots header, the "key-material-offset" is relative
> +to the start of the LUKS header clusters in the qcow2 container,
> +not the start of the qcow2 file.

Berto
