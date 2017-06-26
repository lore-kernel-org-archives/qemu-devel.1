Received: from eggs.gnu.org ([2001:4830:134:3::10]:52727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPTuF-0001KE-BC
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPTuA-0001Ec-9M
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:18:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170623162419.26068-8-berrange@redhat.com>
References: <20170623162419.26068-1-berrange@redhat.com>
	<20170623162419.26068-8-berrange@redhat.com>
Date: Mon, 26 Jun 2017 15:18:11 +0200
Message-ID: <w51mv8udh0s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 07/20] block: deprecate "encryption=on"
 in favor of "encrypt.format=aes"
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

On Fri 23 Jun 2017 06:24:06 PM CEST, Daniel P. Berrange wrote:
> Historically the qcow & qcow2 image formats supported a property
> "encryption=on" to enable their built-in AES encryption. We'll
> soon be supporting LUKS for qcow2, so need a more general purpose
> way to enable encryption, with a choice of formats.
>
> This introduces an "encrypt.format" option, which will later be
> joined by a number of other "encrypt.XXX" options. The use of
> a "encrypt." prefix instead of "encrypt-" is done to facilitate
> mapping to a nested QAPI schema at later date.
>
> e.g. the preferred syntax is now
>
>   qemu-img create -f qcow2 -o encrypt.format=aes demo.qcow2
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
