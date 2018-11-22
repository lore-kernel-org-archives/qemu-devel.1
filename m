Received: from eggs.gnu.org ([2001:4830:134:3::10]:48285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPlH7-000443-Iv
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPlBC-0003yB-A5
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:21:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPlBC-0003xz-4r
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:21:46 -0500
Date: Thu, 22 Nov 2018 10:21:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181122092138.oytqi4skcm546z6q@sirius.home.kraxel.org>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-3.2 v2 00/30] slirp: make it again a
 standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

> There has been some attempts to make slirp a seperate project in the past.
> (https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01092.html)
> Unfortunately, they forked from QEMU and didn't provide enough
> compatibility for QEMU to make use of it (in particular, vmstate
> handling was removed, they lost git history etc). Furthermore, they
> are not maintained as far as I can see.
> 
> I would propose to make slirp a seperate project, that can initially
> be used by QEMU as a submodule, keeping Makefile.objs until a proper
> shared library with stability guarantees etc is ready..

Hmm, I'd skip the submodule step if the long-term plan is to use slirp
as pkg-config detectable dependency (like most other libs).

cheers,
  Gerd
