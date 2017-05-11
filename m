Received: from eggs.gnu.org ([2001:4830:134:3::10]:45851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8pPJ-00087G-FA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d8pPG-0008Rn-BW
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:49:33 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170425153858.25660-18-berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-18-berrange@redhat.com>
Date: Thu, 11 May 2017 16:49:28 +0200
Message-ID: <w511srvtpmv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 17/18] block: remove all encryption
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

On Tue 25 Apr 2017 05:38:57 PM CEST, Daniel P. Berrange wrote:
> @@ -220,7 +220,12 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>              goto fail;
>          }
>          bs->encrypted = true;
> -        bs->valid_key = true;
> +    } else {
> +        if (encryptfmt) {
> +            error_setg(errp, "No encryption in image header, but options "
> +                       "specified format '%s'", encryptfmt);
> +            goto fail;
> +        }

You need to set a return value here, else it's undefined.

Berto
