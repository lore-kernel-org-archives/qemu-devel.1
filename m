Received: from eggs.gnu.org ([2001:4830:134:3::10]:33464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiix6-0005iA-EW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiix0-0001J1-Da
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:45:04 -0500
Date: Mon, 5 Feb 2018 15:44:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180205154446.GI25338@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180205125023.12394-1-vsementsov@virtuozzo.com>
	<ce6a6439-2a00-57d2-8dea-8a1f03df87bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce6a6439-2a00-57d2-8dea-8a1f03df87bf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: 205: support only raw format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Mon, Feb 05, 2018 at 09:40:20AM -0600, Eric Blake wrote:
> On 02/05/2018 06:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> > The test is about qmp interface to NBD server, so there no reasons
> > to run it for various disk formats. Also it actually do not support
> > luks format, so, disable all format except raw.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  tests/qemu-iotests/205 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
> > index 10388920dc..a78ff37104 100644
> > --- a/tests/qemu-iotests/205
> > +++ b/tests/qemu-iotests/205
> > @@ -153,4 +153,4 @@ class TestNbdServerRemove(iotests.QMPTestCase):
> >  
> >  
> >  if __name__ == '__main__':
> > -    iotests.main()
> > +    iotests.main(supported_fmts=['raw'])
> 
> Isn't that stricter than necessary?  The test works with qcow2; it was
> just luks that was special (because we weren't passing in proper
> secrets).  At any rate, I'm adding Dan in case he has a quick idea of
> what it would take to get luks working, rather than just disabling it.

For shell based tests it is not too difficult as I've got much fo the
support work done. This is a python tests though, so would need some
prep work first. The key is that you need to be able to add extra
args to QEMU to define the secret with --object, and use the full
blockdev options based syntax for -drive.

I'm not expecting you todo that unless you're actively interested in
it, so no objection to just disabling it

I will point out though there is an 'unsupported_fmts' arg to the
python tests, so a flexible fix would be to invert your patch todo

  unsupported_fmts=['luks']

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
