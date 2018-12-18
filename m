Received: from eggs.gnu.org ([2001:4830:134:3::10]:36265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZGOA-0001pe-ED
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZGO4-0001Ub-PJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:30:26 -0500
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-11-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20f62f62-f677-6d0f-09dc-3759cc813d8f@redhat.com>
Date: Tue, 18 Dec 2018 13:34:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181218115615.1499-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/12] MAINTAINERS: Orphanize the 'CPU
 (QOM)' subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Helge Deller <deller@gmx.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 18/12/18 12:56, Philippe Mathieu-Daud=C3=A9 wrote:
> Nobody is looking at those files, downgrade this subsystem as orphan.
>=20
> Remove the qemu-devel@nongnu.org entry because the list is always
> selected by the 'All patches CC here' section.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e50f8c6b97..e6a73820f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1745,8 +1745,7 @@ S: Supported
>  F: scripts/coverity-model.c
> =20
>  CPU
> -L: qemu-devel@nongnu.org
> -S: Supported
> +S: Orphan
>  F: qom/cpu.c
>  F: include/qom/cpu.h
> =20
>=20

I don't think that's accurate.  Simply there's not much going on.  If
patches are sent, get-maintainers's git fallback will do something
(probably sending the patch to Eduardo, Igor or me).

Paolo
