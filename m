Received: from eggs.gnu.org ([2001:4830:134:3::10]:38419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fuDtb-0007jz-AR
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fuDn0-0007KY-3s
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:26:29 -0400
References: <20180824133757.1cbdba75.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a29f4cdd-8012-d46e-8984-b4e223f1957f@redhat.com>
Date: Mon, 27 Aug 2018 11:26:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180824133757.1cbdba75.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFD] [s390x] Tweaking the s390x maintainership
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 24.08.2018 13:37, Cornelia Huck wrote:
> Hi all,
>=20
> while I think the current s390x maintainership setup is working quite
> well, there's probably still room for improvement. In particular, I'd
> like to spread out the work a bit more and make it easy to test things
> pre-integration in an automated way.
>=20
> As a recap, how it works today:
>=20
> - We have designated maintainers for some major areas:
>   * tcg
>   * KVM
>   * s390 virtio-ccw machine
>   * s390 bios
>   * vfio-ccw
>   * virtio-ccw
>=20
> - I'm acting as overall s390x maintainer, queuing patches onto my
>   s390-next branch (s390-fixes for fixes during freeze) and sometimes
>   pulling s390 bios updates (if I don't apply them myself). I'm
>   generally the only person that sends pull requests for master.
>=20
> Some problems I've noted:
>=20
> * The bus factor -- or, put in a less dramatic way, what happens when
>   I'm sick or on vacation? For fixes during freeze, there's no problem
>   if the other maintainers submit them directly, but I really don't wan=
t
>   to be the single point of failure (plus, I'm the only person listed
>   as vfio-ccw maintainer).
> * The IBM folks can't do tcg.
> * Conversely, the non-IBM folks cannot review things that don't have
>   public documentation (yet), other than in a very general way.
> * I don't want to pick everything myself :) Especially when I basically
>   rely on other people noticing problems in the first place (like with
>   the non-public things or code areas I'm not so familiar with).
> * Testing seems to be a bit ad hoc. It would be nice to have a branch
>   that (semi) automated tests can be run on before things hit upstream,
>   and that is also created on top of current master. (I usually only
>   rebase the pushed-out s390-next branch when I apply new patches, and
>   sometimes not even then.) Oh, and other people testing things,
>   especially on different hardware.
>=20
> So, here are some ideas I had on how to improve things:
>=20
> * Split up maintainership a bit more. For example, split out areas like
>   pci for which no public documentation is available; these need to
>   have at least one IBM maintainer. Another candidate would maybe be
>   the cpu model.

I could take care of the latter. But it usually goes hand in hand with
KVM changes (or core s390x changes for migration), so I am not sure if
splitting the cpu model out makes that much sense after all. To me, it
somehow feels "s390x core".

> * On a related note, more maintainers from IBM would be nice :) For
>   example, for vfio-ccw, where I'm the only maintainer... Some R:
>   entries would not hurt, either.
> * More trees to pull from. Of course, not every area needs a dedicated
>   tree (that would become silly pretty quickly), but for example a tcg
>   tree would be nice. I can still pick individual patches if a pull
>   request would be overkill.

I can take care of that for TCG (including picking + sending pull request=
s).

> * I'd also like to have a designated backup for the overall
>   maintainership, especially for when I'm on vacation (like the first
>   two weeks of September, just to let you know :) or otherwise
>   unavailable, but also for sanity. Likely needs to be a non-IBMer due
>   to the tcg problem.

Either Thomas or I could do that. I will be on vacation the first two
weeks of September, too ;) Thomas, interested?

> * A more predictable s390-next would be nice. Maybe have it
>   (semi-)automatically created out of the different trees, on top of
>   current master? I would start to apply patches on a new branch that
>   feeds into s390-next rather than on s390-next directly, then.

Is there any fancy mechanism out there with which we can easily build
something like that (automatic merging like e.g. linux-next does)?

> * Do something about (semi-)consolidated, (semi-)automatic testing.
>   Like hooking into Travis (or something similar), sharing test setups,
>   and enabling tests to be run on a range of platforms (including very
>   recent ones). Testing is probably a large topic on its own, though.

Sounds interesting to me. Especially building all different kinds of
combinations + e.g. running kvm-unit-tests / booting a simple distro.

>=20
> Thoughts?
>=20


--=20

Thanks,

David / dhildenb
