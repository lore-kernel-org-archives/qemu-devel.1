Received: from eggs.gnu.org ([2001:4830:134:3::10]:46788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ebTEm-0001Tn-88
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ebTEg-0007Ep-Mq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:33:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ebTEg-00078d-Gb
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:33:14 -0500
Date: Tue, 16 Jan 2018 16:33:00 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180116153300.ahsce4wkxq3mzh7o@eukaryote>
References: <20180109070112.30806-1-vincent@bernat.im>
	<20180112184727.GJ6646@localhost.localdomain>
	<87zi5ite88.fsf@luffy.cx>
	<20180116124111.GC627@localhost.localdomain>
	<87efmqx8sl.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87efmqx8sl.fsf@luffy.cx>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH x86-next v2] target-i386: add PCID flag to
 Westmere, Sandy Bridge and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Bernat <vincent@bernat.im>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>

On Tue, Jan 16, 2018 at 01:55:22PM +0100, Vincent Bernat wrote:
>  =E2=9D=A6 16 janvier 2018 10:41 -0200, Eduardo Habkost <ehabkost@redha=
t.com>=C2=A0:
>=20
> >> > Adding Westmere-PCID would require adding a Westmere-PCID-IBRS
> >> > CPU model too, so this is starting to look a bit ridiculous.
> >> > Sane VM management systems would know how to use
> >> > "-cpu Westmere,+pcid" without requiring new CPU model entries in
> >> > QEMU.  What's missing in existing management stacks to allow that
> >> > to happen?
> >>=20
> >> That's what I actually do. So, I am fine with the solution of doing
> >> nothing. However, it would be nice for unaware people to get the spe=
edup
> >> of pcid without knowing about it. Maybe we can just forget about
> >> Westmere and still apply it to Sandy Bridge and Ivy Bridge.
> >
> > If management stacks today don't let the user choose
> > "Westmere,+pcid", we probably have no other choice than adding a
> > Westmere-PCID CPU model.  But our management stacks need to be
> > fixed so we won't need similar hacks in the future.

True;  I'm aware of the limitation here in Nova.

> With libvirt:
>=20
>   <cpu mode=3D'custom' match=3D'exact'>
>     <model>Westmere</model>
>     <feature policy=3D'require' name=3D'pcid'/>
>   </cpu>

Yep, libvirt upstream allows it.

> We are using CloudStack on top of that and it's also an available
> option. However, looking at OpenStack, it doesn't seem possible:
>  https://github.com/openstack/nova/blob/6b248518da794a4c82665c22abf7bee=
5aa527a47/nova/conf/libvirt.py#L506

That's correct, upstream OpenStack Nova doesn't yet have facility to
specify granular CPU feature names.  Nova just ought to wire up the
facility libvirt already provides.

--=20
/kashyap
