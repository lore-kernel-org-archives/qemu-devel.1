Received: from eggs.gnu.org ([2001:4830:134:3::10]:42485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZOTk-0002l4-Bo
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZOTj-0006nw-9e
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 18:08:44 -0500
Date: Tue, 18 Dec 2018 18:08:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218180813-mutt-send-email-mst@kernel.org>
References: <20181218175122.3229-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181218175122.3229-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/5] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On Tue, Dec 18, 2018 at 06:51:17PM +0100, Philippe Mathieu-Daud=E9 wrote:
> GCC 8 new warning prevents builds to success since quite some time.
> First report on the mailing list is in July 2018:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03723.html
>=20
> Various intents has been sent to fix this:
> - Incorrectly using g_strlcpy()
>   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03705.html
>   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03706.html
> - Using assert() and strpadcpy()
>   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03938.html
> - Use #pragma GCC diagnostic ignored "-Wstringop-truncation"
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> - adding an inline wrapper with said pragma in there
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> - -Wno-stringop-truncation is the makefile
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> - Use the 'nonstring' attribute
>   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04493.html
>=20
> This series add the QEMU_NONSTRING definition and use it.
>=20
> Regards,
>=20
> Phil.


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Philippe Mathieu-Daud=E9 (5):
>   qemu/compiler: Define QEMU_NONSTRING
>   block/sheepdog: Use QEMU_NONSTRING for non NUL-terminated arrays
>   hw/acpi: Use QEMU_NONSTRING for non NUL-terminated arrays
>   migration: Use QEMU_NONSTRING for non NUL-terminated arrays
>   migration: Use strnlen() for fixed-size string
>=20
>  block/sheepdog.c            |  2 +-
>  hw/acpi/core.c              |  8 ++++----
>  include/hw/acpi/acpi-defs.h |  8 ++++----
>  include/qemu/compiler.h     | 15 +++++++++++++++
>  migration/global_state.c    |  4 ++--
>  5 files changed, 26 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.17.2
