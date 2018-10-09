Received: from eggs.gnu.org ([2001:4830:134:3::10]:33153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9tb8-0004Od-G1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g9tb4-0002yV-4d
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1g9tb3-0002fz-PD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:06:53 -0400
Date: Tue, 9 Oct 2018 17:06:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181009170628.7d453d90.cohuck@redhat.com>
In-Reply-To: <CAFEAcA9AfhifaHzGfNPwU7TG-4KUz0aO32utp86XWjHoHn3kUw@mail.gmail.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	<875zybzdzm.fsf@dusky.pond.sub.org>
	<87zhvntg6k.fsf@dusky.pond.sub.org>
	<20181009154312.771c276a.cohuck@redhat.com>
	<CAFEAcA-EV4YO7TtTqC74LfeLnceM7nphxsYc7WT9nPWTdap22g@mail.gmail.com>
	<20181009142309.GH22838@redhat.com>
	<CAFEAcA9AfhifaHzGfNPwU7TG-4KUz0aO32utp86XWjHoHn3kUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 9 Oct 2018 15:34:22 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 9 October 2018 at 15:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> > On Tue, Oct 09, 2018 at 02:58:41PM +0100, Peter Maydell wrote: =20
> >> On 9 October 2018 at 14:43, Cornelia Huck <cohuck@redhat.com> wrote: =
=20
> >> > I'm not sure why a single accelerator (any of them) would be a good
> >> > default. A list (tcg:kvm:<whatever>) sounds much saner, as it would
> >> > continue to work even if some accelerators have been disabled (right=
?)
> >> >
> >> > (And I'd prefer kvm to be first in that list; anything that relies on
> >> > tcg being used should specify it explicitly... a normal user will
> >> > likely always want the fast variant.) =20
> >>
> >> tcg should be the default for binaries without KVM compiled in,
> >> of course... But as Thomas points out, the reason for our current
> >> default is the usual "because we tend not to change things that
> >> would break existing working command lines". =20
> >
> > Putting KVM first shouldn't break existing working command lines
> > in general. =20
>=20
> There are ARM QEMU command lines which will fail with KVM
> and work with TCG (eg ones which use -cpu something-other-than-host
> or which ask for a GICv3 when the host has only a GICv2).
> These are basically cases where KVM can't provide features
> that TCG can. I imagine other archs like power have similar.

Well, on s390x there are (newer) cpu models that we don't support with
tcg but that work fine with kvm on a new-enough host... so I'm not sure
whether we can assume that any given accelerator supports the same set
of cpu models.

It feels like we're doomed whatever we decide to do :/
