Received: from eggs.gnu.org ([2001:4830:134:3::10]:60343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT7Yr-00086D-Df
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fT7Yn-0003XN-Sp
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:19:49 -0400
Date: Wed, 13 Jun 2018 16:19:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180613151942.GC19901@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-5-git-send-email-thuth@redhat.com>
	<20180613133840.GK24528@stefanha-x1.localdomain>
	<20180613134452.GU19901@redhat.com>
	<b0ebd968-797f-48e0-32c1-869c452feca9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0ebd968-797f-48e0-32c1-869c452feca9@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jun 13, 2018 at 05:11:51PM +0200, Thomas Huth wrote:
> On 13.06.2018 15:44, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jun 13, 2018 at 02:38:40PM +0100, Stefan Hajnoczi wrote:
> >> On Wed, Jun 13, 2018 at 07:05:21AM +0200, Thomas Huth wrote:
> >>> We've got three ways of enabling an accelerator: -machine accel=3Dx=
yz,
> >>> -accel xyz and -enable-xyz. For new QEMU users, this must be very
> >>> confusing ("Which one do I have to use? Is there a difference betwe=
en
> >>> the options?"). While -enable-kvm was useful in the past, there is =
no
> >>> real good reason for using it anymore today ("-accel kvm" is even l=
ess
> >>> to type than "-enable-kvm"), so let's decrease the confusing amount=
 of
> >>> options in our documenation a little bit by removing the -enable-xy=
z
> >>> here. Note that the option itself is neither removed nor marked as
> >>> deprecated - since -enable-kvm is likely used in a lot of scripts a=
nd
> >>> since its code is easy to maintain, we should keep it around to avo=
id
> >>> to break old setups.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>  PS: I guess Paolo won't like this patch ... let's try it anyway ;-=
)
> >>
> >> It's widely used and we're removing the documentation for it?!  That=
 is
> >> likely to cause issues for new users who refer to the man page to
> >> understand the QEMU command-lines they see online, in scripts, etc.
> >=20
> > Agreed, this is a very bad idea. Any option that is accepted by QEMU,
> > but not documented is a bug that must be fixed. IOW removing docs
> > is creating bugs.
>=20
> Not documenting unliked options that are still kept for compatibility
> was at least a common practice in the past (see -no-kvm for example, or
> many of those deprecated options like -net channel that have been
> removed in the past year).

If we're planning to deprecate & then delete an option, then I
don't mind if docs are dropped, but IIUC, in this case we're
not doing that - the option will essentially exist forever.

> > If we want to help users understand why we have -enable-kvm, just
> > make the docs say that it is syntactic for '-machine accel=3Dkvm'.
> > Users can decide for themselves whether they want to switch to
> > the more verbose way or not
>=20
> Uh, well, in this case "-enable-kvm" is already the more verbose way:
> "-accel kvm" is shorter :-)

If I'm a user looking for how to enable KVM, then -enable-kvm is the
one I'll pick because of the obvious name.

> It's just a big mess: We've got -enable-kvm, -enable-hax, but there is
> no -enable-hvf, -enable-whpx or -enable-xen option. And to force TCG
> mode, you've got to use -no-kvm ... honestly, if I were a new user, I'd
> simply say: WTF!?!

Personally I'd just clean that up by just adding the missing
-enable-xxx options for consistency :-)

> But ok, since -enable-kvm has such a big tradition and is used in a lot
> of examples out there, it's likely really better if we keep it in the
> documentation. But we should either move it to a "obsolete option"
> chapter, or update the current documentation with some words like
> "obsolete" or "legacy" (to make it clear that nobody gets the idea of
> introducing -enable-hvf or other similar options in the future).
>=20
> And what about -enable-hax? That hardly has any tradtion. Should we
> maybe even deprecate it?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
