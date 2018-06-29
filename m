Received: from eggs.gnu.org ([2001:4830:134:3::10]:44290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrsl-0001iZ-FE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrsi-0003K8-CP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:48:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYrsi-0003IZ-6E
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:48:04 -0400
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
	<29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
	<20180629111405.GG27016@redhat.com>
	<fe804632-393f-3499-10c2-425a3bf51485@kaod.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f82f360a-045d-099e-c2ae-b5d6507a20a0@redhat.com>
Date: Fri, 29 Jun 2018 13:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <fe804632-393f-3499-10c2-425a3bf51485@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29/06/2018 13:42, C=C3=A9dric Le Goater wrote:
>> Yeah, doing anything non-trivial in class_init is just asking for trou=
ble,
>> as conceivably nothing is initialized at that point.=20
>
> May be we should consider having a set of binaries for each accelerator=
,
> KVM, TCG, etc. That would simplify a lot of the init path of the machin=
es
> and also of some of the models which are trying to initialize in one mo=
de=20
> or the other.

That would prevent things like "-machine accel=3Dkvm:tcg", which try KVM
and fall back to TCG if it is not available.

Paolo

> Hybrid machines would still be possible, like using KVM for the CPUs an=
d
> an emulated model for some device. But the definitions would be static,=
=20
> not guessed from what is available or not.=20
