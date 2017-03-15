Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1co3Fe-0001E8-13
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1co3FZ-0003uW-36
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:21:42 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1co3FY-0003uH-JN
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:21:37 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u108so4854688wrb.3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 00:21:36 -0700 (PDT)
MIME-Version: 1.0
Sender: vase@selfip.ru
In-Reply-To: <CACaajQsrkuZeC6WYXdEBJY=FEkTQ9iY_i8E-d5j7JqK5DDUuOw@mail.gmail.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<CACaajQsrkuZeC6WYXdEBJY=FEkTQ9iY_i8E-d5j7JqK5DDUuOw@mail.gmail.com>
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Wed, 15 Mar 2017 10:21:34 +0300
Message-ID: <CACaajQtXWHJvDWmh5KdDu=0awQzX+PcjAEH6viWi5n=EVv6dTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-devel@nongnu.org, Janne Huttunen <janne.huttunen@nokia.com>

14 =D0=9C=D0=B0=D1=80 2017 =D0=B3. 19:58 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Gerd Hoffmann" <kraxel@redhat.com>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

  Hi,

>   - Does this approach make sense? Any better ideas?

What is the use case?

Sometimes I'm wondering why we actually need the "once" thing.  Looks
like people use it for installs, but I fail to see why.  I usually
configure my guests with hard disk as bootindex=3D1 and install media
(cdrom or net) as bootindex=3D2.  In case the hard disk is blank it
automatically falls back to the second and boots the installer, and when
the installer is finished the hard disk isn't blank any more and the
just installed system gets booted ...

cheers,
  Gerd

This is useful for reinstalls. In this case hard disk already have boot
data and it can be used as boot device.
