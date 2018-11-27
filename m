Received: from eggs.gnu.org ([2001:4830:134:3::10]:51424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRccT-0005wi-9i
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gRccQ-0007Sj-Fp
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gRccQ-0007Rm-AS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:34 -0500
Date: Tue, 27 Nov 2018 13:37:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181127123729.m2vwgr2o5o3422ky@sirius.home.kraxel.org>
References: <CGME20181127111109eucas1p2b1eae35e38e46c3f76c86a350ed41926@eucas1p2.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-2-i.maximets@samsung.com>
	<CAMxuvay-6X2g1k8TbJR1NAW=Gb_tARb-wbr7H2RRoF9x+-F+aw@mail.gmail.com>
	<78f31962-8d54-19c1-e8fb-c21f95a491f0@samsung.com>
	<CAJ+F1C+XFs++Q044Y8CvVYFhtNpaEDS8qjx0BjsJN1yukZURkA@mail.gmail.com>
	<2edee79d-4d23-913a-3536-a8794ee16528@samsung.com>
	<CAJ+F1CK_WtcLCg+hi76J6x85zTvYkF1YN7b8hgP4-p-M_4-cag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK_WtcLCg+hi76J6x85zTvYkF1YN7b8hgP4-p-M_4-cag@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] hostmem-memfd: enable seals only if
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Ilya Maximets <i.maximets@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

  Hi,

> > > which system supports memfd without sealing?
> >
> > RHEL 7.2. kernel version 3.10.0-327.el7.x86_64
> 
> Correct, it was backported without sealing for some reason.
> 
> I would rather have an explicit seal=off argument on such system
> (because sealing is expected to be available with memfd in general)

Or just drop support for memfd without sealing.

cheers,
  Gerd
