Received: from eggs.gnu.org ([2001:4830:134:3::10]:53353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOLUd-0005ff-A3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOLUc-00075i-8C
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:07:11 -0400
Date: Fri, 23 Jun 2017 11:06:59 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170623100659.GE28635@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170619173455.18805-1-berrange@redhat.com>
	<20170619173455.18805-10-berrange@redhat.com>
	<0456194f-d8c0-3542-2a8a-6a952b4c8b58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0456194f-d8c0-3542-2a8a-6a952b4c8b58@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 09/20] qcow: convert QCow to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On Wed, Jun 21, 2017 at 04:29:02PM +0200, Max Reitz wrote:
> On 2017-06-19 19:34, Daniel P. Berrange wrote:
> > This converts the qcow driver to make use of the QCryptoBlock
> > APIs for encrypting image content. This is only wired up to
> > permit use of the legacy QCow encryption format. Users who wish
> > to have the strong LUKS format should switch to qcow2 instead.
> > 
> > With this change it is now required to use the QCryptoSecret
> > object for providing passwords, instead of the current block
> > password APIs / interactive prompting.
> > 
> >   $QEMU \
> >     -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
> >     -drive file=/home/berrange/encrypted.qcow,encrypt.format=qcow,\
> 
> Still should be encrypt.format=aes, but, well... Let's just give it a

Opps, yes. Fixed that now for real.

> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
