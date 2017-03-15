Received: from eggs.gnu.org ([2001:4830:134:3::10]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1co2uN-0003jo-Fz
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1co2uK-0002Ey-9W
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:59:43 -0400
Received: from mail-db5eur01on0099.outbound.protection.outlook.com
	([104.47.2.99]:57632
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1co2uJ-0002Ee-K9
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:59:40 -0400
Message-ID: <1489561105.24841.25.camel@nokia.com>
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Wed, 15 Mar 2017 08:58:25 +0200
In-Reply-To: <1489510640.8844.18.camel@redhat.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


> > =C2=A0 - Does this approach make sense? Any better ideas?
> =C2=A0
> What is the use case?

The short answer: emulating real hardware.

Since real HW has this capability, there exist certain
auxiliary systems that are built on it. Having similar
semantics available in QEMU allows me to build a virtual
machine that works with these systems without modifying
them in any way.

Also, the support I'm after already almost was in QEMU
('-boot once=3D'). It just didn't quite provide the
functionality I wanted i.e. the 'bootindex' like operation.
This patch series tries to bridge that gap. But hey, I
wasn't sure if this was useful for other people too, and
that's why the RFC.

In principle I agree with you that in some specific cases
QEMU has other means of doing things that necessarily don't
exist in real HW. Obviously systems that are built for real
HW don't use any such QEMU specific methods. Again, in some
specific cases it might be possible to get close enough
semantics without real "boot once" support and in others it
probably won't be. Note that part of the semantics I'm after
is that the "boot once" order can be set while the system is
up and running. It may or may not be strictly necessary
depending on the specific use case, but that's the way the
real HW works.
