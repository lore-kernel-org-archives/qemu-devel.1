Received: from eggs.gnu.org ([2001:4830:134:3::10]:54650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eBjJc-0006aS-8a
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eBjJY-0008Bq-90
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:27:56 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171103143902.18039-1-berrange@redhat.com>
References: <20171103143902.18039-1-berrange@redhat.com>
Date: Mon, 06 Nov 2017 16:27:50 +0100
Message-ID: <w51r2tbjukp.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qcow2: don't permit changing
 encryption parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri 03 Nov 2017 03:39:02 PM CET, Daniel P. Berrange wrote:
> Currently if trying to change encryption parameters on a qcow2 image, qemu-img
> will abort. We already explicitly check for attempt to change encrypt.format
> but missed other parameters like encrypt.key-secret. Rather than list each
> parameter, just blacklist changing of all parameters with a 'encrypt.' prefix.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
