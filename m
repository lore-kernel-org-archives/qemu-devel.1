Received: from eggs.gnu.org ([2001:4830:134:3::10]:48077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYziV-0007sV-WA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYziR-0006dS-0m
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:10:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYziQ-0006b1-PF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:09:58 -0400
Date: Fri, 29 Jun 2018 17:09:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629200955.GZ7451@localhost.localdomain>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
	<29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
	<20180629111405.GG27016@redhat.com>
	<fe804632-393f-3499-10c2-425a3bf51485@kaod.org>
	<f82f360a-045d-099e-c2ae-b5d6507a20a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f82f360a-045d-099e-c2ae-b5d6507a20a0@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 29, 2018 at 01:47:59PM +0200, Paolo Bonzini wrote:
> On 29/06/2018 13:42, C=E9dric Le Goater wrote:
> >> Yeah, doing anything non-trivial in class_init is just asking for tr=
ouble,
> >> as conceivably nothing is initialized at that point.=20
> >
> > May be we should consider having a set of binaries for each accelerat=
or,
> > KVM, TCG, etc. That would simplify a lot of the init path of the mach=
ines
> > and also of some of the models which are trying to initialize in one =
mode=20
> > or the other.
>=20
> That would prevent things like "-machine accel=3Dkvm:tcg", which try KV=
M
> and fall back to TCG if it is not available.

We could at least make it easier for packagers to choose the
features available on the binaries they build (including
accelerators, machine-types and device models).

As we already have distributions that build a "qemu-kvm" binary
that uses KVM by default, we could make this a supported feature
of the build system instead of requiring downstream
makefile/configure hacks.

--=20
Eduardo
