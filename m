Received: from eggs.gnu.org ([2001:4830:134:3::10]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1ebQm3-0003Rs-Ey
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincent@bernat.im>) id 1ebQlz-0007gc-E3
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:55:31 -0500
Received: from bart.luffy.cx ([78.47.78.131]:49723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vincent@bernat.im>) id 1ebQlz-0007f5-2M
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:55:27 -0500
From: Vincent Bernat <vincent@bernat.im>
References: <20180109070112.30806-1-vincent@bernat.im>
	<20180112184727.GJ6646@localhost.localdomain>
	<87zi5ite88.fsf@luffy.cx> <20180116124111.GC627@localhost.localdomain>
Date: Tue, 16 Jan 2018 13:55:22 +0100
In-Reply-To: <20180116124111.GC627@localhost.localdomain> (Eduardo Habkost's
	message of "Tue, 16 Jan 2018 10:41:11 -0200")
Message-ID: <87efmqx8sl.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>

 =E2=9D=A6 16 janvier 2018 10:41 -0200, Eduardo Habkost <ehabkost@redhat.co=
m>=C2=A0:

>> > Adding Westmere-PCID would require adding a Westmere-PCID-IBRS
>> > CPU model too, so this is starting to look a bit ridiculous.
>> > Sane VM management systems would know how to use
>> > "-cpu Westmere,+pcid" without requiring new CPU model entries in
>> > QEMU.  What's missing in existing management stacks to allow that
>> > to happen?
>>=20
>> That's what I actually do. So, I am fine with the solution of doing
>> nothing. However, it would be nice for unaware people to get the speedup
>> of pcid without knowing about it. Maybe we can just forget about
>> Westmere and still apply it to Sandy Bridge and Ivy Bridge.
>
> If management stacks today don't let the user choose
> "Westmere,+pcid", we probably have no other choice than adding a
> Westmere-PCID CPU model.  But our management stacks need to be
> fixed so we won't need similar hacks in the future.

With libvirt:

  <cpu mode=3D'custom' match=3D'exact'>
    <model>Westmere</model>
    <feature policy=3D'require' name=3D'pcid'/>
  </cpu>

We are using CloudStack on top of that and it's also an available
option. However, looking at OpenStack, it doesn't seem possible:
 https://github.com/openstack/nova/blob/6b248518da794a4c82665c22abf7bee5aa5=
27a47/nova/conf/libvirt.py#L506
--=20
A banker is a fellow who lends you his umbrella when the sun is shining
and wants it back the minute it begins to rain.
		-- Mark Twain
