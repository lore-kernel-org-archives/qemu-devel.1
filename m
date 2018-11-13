Received: from eggs.gnu.org ([2001:4830:134:3::10]:49916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMOB7-0002U1-Fy
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 21:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMOB4-0004dx-Bo
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 21:11:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMOB4-0004do-5b
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 21:11:42 -0500
Date: Tue, 13 Nov 2018 00:11:34 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181113021134.GB12503@habkost.net>
References: <20181109182153.5390-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181109182153.5390-1-wainersm@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org, crosa@redhat.com, philmd@redhat.com, lizhijian@cn.fujitsu.com, ccarrara@redhat.com

On Fri, Nov 09, 2018 at 01:21:53PM -0500, Wainer dos Santos Moschetta wro=
te:
> QEMU used to exits with a not accurate error message when
> an initrd > 2GiB was passed. That was fixed on patch:
>=20
> 	commit f3839fda5771596152b75dd1e1a6d050e6e6e380
> 	Author: Li Zhijian <lizhijian@cn.fujitsu.com>
> 	Date:   Thu Sep 13 18:07:13 2018 +0800
>=20
>     	change get_image_size return type to int64_t
>=20
> This change adds a regression test for that fix. It starts
> QEMU with a 2GiB dummy initrd, and check it evaluates the file
> size correctly and prints accurate message.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Queued for 4.0, thanks!

--=20
Eduardo
