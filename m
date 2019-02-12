Received: from eggs.gnu.org ([209.51.188.92]:35516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gte53-00041P-JO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gte3Q-0000cr-De
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:49:17 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:54382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gte3O-0000Oj-23
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:49:15 -0500
Date: Tue, 12 Feb 2019 20:49:08 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190212194908.svejwyknxdenpaif@function>
References: <20190212160953.29051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212160953.29051-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix slirp regression on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>, hsp.cat7@gmail.com

Marc-Andr=C3=A9 Lureau, le mar. 12 f=C3=A9vr. 2019 17:09:51 +0100, a ecri=
t:
> QEMU wraps the socket functions in os-win32.h, but in commit
> a9d8b3ec4385793815d71217857304, the header inclusion was dropped,
> breaking slirp on Windows. Fix the regression by wrapping all the
> socket functions.

Applied to my tree, thanks!

Samuel
