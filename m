Received: from eggs.gnu.org ([2001:4830:134:3::10]:51002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYIDx-00081U-FZ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYIDu-0002Ve-A7
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:06:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYIDu-0002Va-3k
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:06:46 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5361080476
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 20:06:46 +0000 (UTC)
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-20-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68c0ebae-7559-80eb-23fc-f8acc218a6d3@redhat.com>
Date: Mon, 30 Jan 2017 15:06:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170130133954.31353-20-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 19/41] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 30/01/2017 08:39, Marc-Andr=C3=A9 Lureau wrote:
> The class kind is necessary to lookup the chardev name in
> qmp_chardev_add() after calling qemu_chr_new_from_opts() and to set
> the appropriate ChardevBackend (mainly to free the right
> fields).
>=20
> qemu_chr_new_from_opts() can be changed to use a non-qmp function
> using the chardev class typename. Introduce qemu_chardev_add() to be
> called from qemu_chr_new_from_opts() and remove the class chardev kind
> field. Set the backend->type in the parse callback (when non-common
> fields are added).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  1 -
>  backends/baum.c       |  1 -
>  backends/msmouse.c    |  1 -
>  backends/testdev.c    |  1 -
>  qemu-char.c           | 99 +++++++++++++++++++++++++------------------=
--------
>  spice-qemu-char.c     |  4 +--
>  ui/console.c          |  2 +-
>  ui/gtk.c              |  1 -
>  8 files changed, 51 insertions(+), 59 deletions(-)

I am not sure about this patch.  Why not remove backend->type
altogether, and instead look at ChardevClass with object_dynamic_cast?

Paolo
