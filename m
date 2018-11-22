Received: from eggs.gnu.org ([2001:4830:134:3::10]:39889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPjg3-0006WQ-TF
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPjg0-0006DV-M6
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:45:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPjg0-0006BF-EY
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:45:28 -0500
Date: Thu, 22 Nov 2018 08:45:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181122074522.hdf2zxa4g6z5rjo7@sirius.home.kraxel.org>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
	<20181121220647.18844-26-marcandre.lureau@redhat.com>
	<20181121230023.putxhpeinrop2dbk@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181121230023.putxhpeinrop2dbk@function>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-3.2 v2 25/30] slirp: replace trace
 functions with DEBUG calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

On Thu, Nov 22, 2018 at 12:00:23AM +0100, Samuel Thibault wrote:
> Hello,
>=20
>=20
> Marc-Andr=E9 Lureau, le jeu. 22 nov. 2018 02:06:42 +0400, a ecrit:
> > Remove a dependency on QEMU. Use the existing logging facilities.
> > Set SLIRP_DEBUG=3Dtftp to get tftp log.
>=20
> As mentioned before, I was hesitating to replace the tracing with a
> DEBUG call. Now that I have merged to my tree the DEBUG rework which
> allows to just set SLIRP_DEBUG=3Dtftp to get tftp log, Gerd, are you fi=
ne
> with this replacement?

Hmm, I'd prefer tracepoints, but I can see that this will be rather
tricky to do when transforming slirp into a standalone library ...

So, yes, ok, go ahead.

cheers,
  Gerd
