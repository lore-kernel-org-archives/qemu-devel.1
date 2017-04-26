Received: from eggs.gnu.org ([2001:4830:134:3::10]:56986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3NhW-0001gp-HC
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3NhS-0004i0-Ey
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:13:50 -0400
Date: Wed, 26 Apr 2017 15:13:29 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426141329.GA18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-3-berrange@redhat.com>
	<48ac644a-441b-134a-7d4c-fb3239fb5e0f@redhat.com>
	<20170426135051.GY18933@redhat.com>
	<c9ba2963-41f6-3207-d4d4-c5a8f4171f77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9ba2963-41f6-3207-d4d4-c5a8f4171f77@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On Wed, Apr 26, 2017 at 09:12:06AM -0500, Eric Blake wrote:
> On 04/26/2017 08:50 AM, Daniel P. Berrange wrote:
> > On Wed, Apr 26, 2017 at 08:28:04AM -0500, Eric Blake wrote:
> >> On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> >>> When integrating the crypto support with qcow/qcow2, we don't
> >>> want to use the bare LUKS option names "hash-alg", "key-secret",
> >>> etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
> >>> so that they don't clash with any general qcow options at a later
> >>> date.
> 
> >> Is this still needed, given your cover letter said you reworked things
> >> to use a nested struct?  I'm still not convinced we need the complexity
> >> of two different prefixes if we can instead reuse a common structure.
> > 
> > Yes, we still need this at the QemuOpts level.  We have the general
> > purpose luks driver that has opts directly in the top level QAPI block
> > driver options, vs the qcow2 integration, which now has the encryption
> > options in a nested struct/union, rather than having an option prefix
> > in the QAPI member names.
> 
> Fair enough.
> 
> > 
> > At the QemuOpts level, this mean that the option names have changed
> > from being 'luks-key-secret', 'aes-key-secret', to be "encrypt.key-secret"
> 
> But you'll want to update the commit message to match your new planned
> names ;)

Hah, opps :-)


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
