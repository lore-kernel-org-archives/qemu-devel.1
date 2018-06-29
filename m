Received: from eggs.gnu.org ([2001:4830:134:3::10]:34300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYrFI-0003ub-Ks
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYrFF-0006vp-G2
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:07:20 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:46901)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYrFF-0006uc-9I
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:07:17 -0400
Received: from player750.ha.ovh.net (unknown [10.109.108.58])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 56459B7332
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:07:15 +0200 (CEST)
Date: Fri, 29 Jun 2018 13:07:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180629130701.6ab5d88a@bahia.lan>
In-Reply-To: <65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 29 Jun 2018 12:40:40 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/06/2018 12:39, Daniel P. Berrang=C3=A9 wrote:
> >> Also asserting current_machine !=3D NULL is not necessary, since you're
> >> immediately dereferencing it. =20
> > Is there a practical way to simply initialize the accelerators earlier
> > in startup sequence, so we just remove or at least reduce, the liklihood
> > of accessing it too early ? =20
>=20
> We can try, though not for 3.0 of course.
>=20

FWIW, the motivation for this patch was kvm_enabled() being called under
the class_init function of the machine TypeInfo. This happens way earlier
than accelerator init. Not sure this is doable, but I can have a look.

> Paolo
