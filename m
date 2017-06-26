Received: from eggs.gnu.org ([2001:4830:134:3::10]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPQwJ-0000Ex-4F
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPQwE-0007hD-BD
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:08:15 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170623162419.26068-10-berrange@redhat.com>
References: <20170623162419.26068-1-berrange@redhat.com>
	<20170623162419.26068-10-berrange@redhat.com>
Date: Mon, 26 Jun 2017 12:07:31 +0200
Message-ID: <w51r2y7cba4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 09/20] qcow: convert QCow to use
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

On Fri 23 Jun 2017 06:24:08 PM CEST, Daniel P. Berrange wrote:
> This converts the qcow driver to make use of the QCryptoBlock
> APIs for encrypting image content. This is only wired up to
> permit use of the legacy QCow encryption format. Users who wish
> to have the strong LUKS format should switch to qcow2 instead.
>
> With this change it is now required to use the QCryptoSecret
> object for providing passwords, instead of the current block
> password APIs / interactive prompting.
>
>   $QEMU \
>     -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
>     -drive file=/home/berrange/encrypted.qcow,encrypt.format=aes,\
>            encrypt.key-secret=sec0

I just realized that the property in the 'secret' object is called
'file', not 'filename'.

You can of course keep my R-b if you fix that.

Berto
