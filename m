Received: from eggs.gnu.org ([209.51.188.92]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1TyX-0000sA-Cd
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1TyW-00017J-1N
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:40:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1TyV-0000zh-NJ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:40:35 -0500
Date: Wed, 6 Mar 2019 10:40:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190306104027.GB2727@work-vm>
References: <20190305181602.9051-1-dgilbert@redhat.com>
	<20190305181602.9051-11-dgilbert@redhat.com>
	<84195982-1d8f-0bae-5136-6443a1f63c2a@redhat.com>
	<87tvgg1ssw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvgg1ssw.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PULL 10/21] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

* Markus Armbruster (armbru@redhat.com) wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 3/5/19 12:15 PM, Dr. David Alan Gilbert (git) wrote:
> >> From: Juan Quintela <quintela@redhat.com>
> >>
> >> It will be used to store the uri parameters. We want this only for
> >> tcp, so we don't set it for other uris.  We need it to know what port
> >> is migration running.
> >>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >>
> >> --
> >>
> >
> > This was not the usual '---' divider, and hence:
> >
> >> This used to be uri parameter, but it has so many troubles to
> >> reproduce that it don't just make sense.
> >>
> >> This used to be a port parameter.  I was asked to move to
> >> SocketAddress, done.
> >> I also merged the setting of the migration tcp port in this one
> >> because now I need to free the address, and this makes it easier.
> >> This used to be x-socket-address with a single direction, now it is a
> >> list of addresses.
> >> Move SocketAddress_to_str here.  I used to try to generalize the one
> >> in chardev/char-socket.c, but it is not worth it.
> >>
> >> Free string (eric)
> >> Handle VSOCK address nicely (not that migration can use them yet).
> >> Remove useless breaks (dave)
> >> rename socket_address to socket_address_list to avoid confusion
> >> Update to 4.0 (eric)
> >> Put a comment indicating that there is a problem on the qapi
> >> generator (markus).
> >
> > ...all this got included, even if it was perhaps not intended.
> >
> >> Message-Id: <20190227105128.1655-3-quintela@redhat.com>
> >>
> >> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > At any rate, it certainly looks odd to split *-by: tags by so much text.
> >
> >> +++ b/qapi/sockets.json
> >> @@ -152,3 +152,21 @@
> >>               'unix': 'UnixSocketAddress',
> >>               'vsock': 'VsockSocketAddress',
> >>               'fd': 'String' } }
> >> +
> >> +##
> >> +# @DummyStruct:
> >> +#
> >> +# Both block-core and migration needs SocketAddressList
> >> +# I am open to comments about how to share it
> >> +#
> >> +# @dummy-list: A dummy list
> >> +#
> >> +# FIXME: This shouldn't be needed, but this struct has two users, and
> >> +# current qapi generator generates it on the 1st place that uses it,
> >> +# so the second user don't see it.  Putting it here it is seen in both
> >> +# sides.
> >
> > If Markus' pull request lands first, we don't need this.
> > https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg01185.html
> 
> It did: merge commit a3e3b0a7bd5.  Please drop this hunk, either in a
> respin or in a follow-up patch.
> 
> A respin would give you a chance to clean up the commit message.

OK, respin coming up.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
