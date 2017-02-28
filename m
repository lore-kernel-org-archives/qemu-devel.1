Received: from eggs.gnu.org ([2001:4830:134:3::10]:34335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cieqA-0001Ge-7I
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cieq6-0002Zm-7c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:17:06 -0500
Date: Tue, 28 Feb 2017 10:16:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170228101651.GE2762@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1488220970.git.jcody@redhat.com>
	<12a16b28300f871052a49897ec7875a082fc63e3.1488220970.git.jcody@redhat.com>
	<c5869fe5-fa51-3f2f-26d6-26a733c15493@redhat.com>
	<20170228035744.GO25637@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170228035744.GO25637@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] block/rbd: add support for
 'mon_host', 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On Mon, Feb 27, 2017 at 10:57:44PM -0500, Jeff Cody wrote:
> On Mon, Feb 27, 2017 at 04:47:54PM -0600, Eric Blake wrote:
> > On 02/27/2017 12:58 PM, Jeff Cody wrote:
> > > @@ -604,6 +620,29 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> > >          goto failed_shutdown;
> > >      }
> > >  
> > > +    /* if mon_host was specified */
> > > +    if (host) {
> > > +        const char *hostname = host;
> > > +        char *mon_host = NULL;
> > > +
> > > +        if (port) {
> > > +            mon_host = g_strdup_printf("%s:%s", host, port);
> > 
> > Does Ceph care about IPv6 (in which case you may need [host]:port when
> > host itself includes ':')?
> >
> 
> Some quick sanity testing seems to show that it does not need [] for ipv6
> addresses, which is nice.

Hmm, that is very odd to me, as that means parsing is ambiguous. The
ceph 'mon_host' option allows the port to be omitted, so given a
string  2001:242:24:23   there's no way of knowing whether it is
a IPv6 addr 2001:242:24:23, with no port, or an addr 2001:242:24 with
port of 23


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
