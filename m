Received: from eggs.gnu.org ([2001:4830:134:3::10]:45857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2wP4-0004kp-4D
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2wP3-00018m-0W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2wP2-000184-QX
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 05:37:12 -0400
Date: Fri, 13 Oct 2017 11:37:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171013113708.2dd02a17.cohuck@redhat.com>
In-Reply-To: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
References: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] German BSI analysed security of KVM / QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>

On Fri, 13 Oct 2017 11:10:05 +0200
Stefan Weil <sw@weilnetz.de> wrote:

> Hi,
>=20
> the German Bundesamt f=C3=BCr Sicherheit in der Informationstechnik
> (Federal Office for Information Security) published a study on
> the security of KVM and QEMU:
>=20
> https://www.bsi.bund.de/DE/Publikationen/Studien/Sicherheitsanalyse_KVM/s=
icherheitsanalyse_kvm.html
>=20
> (article only available in German)

Thanks for posting this!

I only looked at the conclusion for now. Some interesting points:

- They state that QEMU's source code is well structured, readable and
  maintainable. I wonder what kind of source code they usually deal
  with ;)
- Most problems noted seemed to be related to signed<->unsigned
  conversions, but none were found to be exploitable.
- They liked hardening via stack protection, NX, and ASLR, as well as
  the mechanisms used by libvirt.
- They generally seemed to be happy with QEMU being deployed via
  libvirt.
- Restrictions imposed via KVM (guest access to some CPU registers)
  scored positive points. They did not like that Hyper-V and PMU were
  not deconfigurable.
- Lack of support for encryption/signing of network-based images was
  criticized. They ended up using Ceph and GlusterFS, which they were
  reasonably happy with.

That's just from a quick browse.
