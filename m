Received: from eggs.gnu.org ([2001:4830:134:3::10]:53220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgYgm-00069F-AR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgYgl-0004zk-GL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:18:44 -0500
Date: Wed, 22 Feb 2017 16:18:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170222151833.GM4112@noname.str.redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170221115512.21918-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Am 21.02.2017 um 12:54 hat Daniel P. Berrange geschrieben:
> When integrating the crypto support with qcow/qcow2, we don't
> want to use the bare LUKS option names "hash-alg", "key-secret",
> etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
> so that they don't clash with any general qcow options at a later
> date.

Or maybe "luks.key-secret", i.e. actually embed the LUKS options QAPI
type into the qcow2 one? In that case, maybe qdict_extract_subqdict()
can even be used before calling into this, so that we don't have to
write a QemuOpts version of the function.

However, the only option I can see at the end of this series in
BlockdevOptionsQcow2 is luks-key-secret, so what happened with this
plan?

And if we really have only luks-key-secret (and that not in a separate
sub-dict), I don't really see the need to have separate aes-key-secret
and luks-key-secret options.

> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Having said all that, while I'm not sure if the goal of the patch is
completely right, it does seem to correctly implement what it promises.

Kevin
