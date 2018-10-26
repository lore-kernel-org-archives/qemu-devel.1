Received: from eggs.gnu.org ([2001:4830:134:3::10]:51928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG7Hw-00065x-NF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gG7Ht-000532-Fh
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:56:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gG7Ht-00052a-A3
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 14:56:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67935C04B2CC
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 18:56:48 +0000 (UTC)
Date: Sat, 27 Oct 2018 00:26:33 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181026141458.GA493@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810270008210.7551@xnncv>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<nycvar.YSQ.7.76.1810261213001.8270@xnncv>
	<20181026094208.GD31390@redhat.com>
	<20181026095943.GG31390@redhat.com>
	<4e377111-8b95-c65a-e456-a7a8a4580ecb@redhat.com>
	<20181026141458.GA493@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

+-- On Fri, 26 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
| ...=20
| One thing we should do, however, is to make it clear which of the
| device models we consider secure, and which we consider only usable
| in a friendly guest environment, as we have very different code
| maintainership & quality standards for different parts of QEMU.
|=20
| Essentially virtio devices, and then only a handful of the emulated
| devices are things we consider suitable for usage in secure envs.
| Likewise for machine types probably.

True, +1.

It did come up in another thread. It'll surely be helpful to list these=20
professional and friendly components. 'Professional' being production rea=
dy=20
and thus security relevant. And 'Friendly' being experimental or not suit=
able=20
for production usage. Maybe like staging drivers in the kernel tree. They=
 are=20
available for use but not considered production ready and thus are not=20
security relevant.

To be clear, irrespective of professional or friendly, we strive to fix e=
very=20
single issue that is found and/or reported. Only difference is, professio=
nal=20
ones are tracked by a CVE ID and friendly ones are fixed as bug fixes, no=
t=20
tracked by CVE ID.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
