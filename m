Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZG5h-0002kc-9H
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZG5V-0003I8-JE
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:11:19 -0500
Date: Tue, 18 Dec 2018 13:51:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181218135131.3f5cd35a.cohuck@redhat.com>
In-Reply-To: <20181218115615.1499-9-philmd@redhat.com>
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-9-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/12] MAINTAINERS: Add maintainers to
 the Linux subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On Tue, 18 Dec 2018 12:56:11 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Add Michael, Cornelia and Paolo as maintainers of the Linux subsystem.
>=20
> Remove the qemu-devel@nongnu.org entry because the list is always
> selected by the 'All patches CC here' section.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0fb2c74d7..5f39fa4b80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -420,9 +420,10 @@ Hosts:
>  ------
> =20
>  LINUX
> -L: qemu-devel@nongnu.org
> +M: Michael S. Tsirkin <mst@redhat.com>
> +M: Cornelia Huck <cohuck@redhat.com>
> +M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: linux-*
>  F: linux-headers/
> =20
>  POSIX

As this now basically an entry for linux-headers, should this now also
include the headers update script?

Acked-by: Cornelia Huck <cohuck@redhat.com>
