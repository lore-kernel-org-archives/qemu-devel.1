Received: from eggs.gnu.org ([2001:4830:134:3::10]:38392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1dYXsK-0008Nu-3w
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1dYXsG-0003CG-Vn
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:21:48 -0400
Received: from mail.univention.de ([82.198.197.8]:10163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1dYXsG-0003A9-Ov
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:21:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by solig.knut.univention.de (Postfix) with ESMTP id 3CD9118001E0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 15:21:42 +0200 (CEST)
Received: from mail.univention.de ([127.0.0.1])
	by localhost (solig.knut.univention.de [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id NU4cw5WNoD4t for <qemu-devel@nongnu.org>;
	Fri, 21 Jul 2017 15:21:41 +0200 (CEST)
Received: from [172.16.1.200] (82-198-197-172.briteline.de [82.198.197.172])
	by solig.knut.univention.de (Postfix) with ESMTPSA id 0D59318001DC
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 15:21:40 +0200 (CEST)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-2-ldoktor@redhat.com>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <7170f089-8656-40de-5aef-b87d3c90e7e0@univention.de>
Date: Fri, 21 Jul 2017 07:28:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170720162815.19802-2-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/11] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Am 20.07.2017 um 18:28 schrieb Luk=C3=A1=C5=A1 Doktor:
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
...
> @@ -64,16 +79,16 @@ class QEMUMachine(object):
>          if self._socket_scm_helper is None:
>              print >>sys.stderr, "No path to socket_scm_helper set"
>              return -1
> -        if os.path.exists(self._socket_scm_helper) =3D=3D False:
> +        if os.path.exists(self._socket_scm_helper) is False:

if not os.path.exists(...):

Philipp
