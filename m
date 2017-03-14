Received: from eggs.gnu.org ([2001:4830:134:3::10]:48065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnplH-0003kK-E7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnplE-00023X-D2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cnplE-00022V-7A
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:57:24 -0400
Message-ID: <1489510640.8844.18.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 14 Mar 2017 17:57:20 +0100
In-Reply-To: <cover.1489494746.git.janne.huttunen@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janne Huttunen <janne.huttunen@nokia.com>
Cc: qemu-devel@nongnu.org

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
