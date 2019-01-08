Received: from eggs.gnu.org ([209.51.188.92]:58399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggqki-0004RI-4x
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggqkh-00035U-Ek
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:45:04 -0500
Date: Tue, 8 Jan 2019 13:44:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108134440.0d52f2c7.cohuck@redhat.com>
In-Reply-To: <20190104181208.7809-2-philmd@redhat.com>
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] util/cutils: Move size_to_str()
 from "qemu-common.h" to "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Stefano Garzarella <sgarzare@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri,  4 Jan 2019 19:12:06 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The size_to_str() function doesn't need to be in a generic header.
>=20
> It makes also sens to find this function in the same header than
> the opposite string to size functions: qemu_strtosz*().
> Note than this function is already implemented in util/cutils.c.
>=20
> Since we introduce a new function in a header, we document it,
> using the previous comment from the source file.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu-common.h        |  1 -
>  include/qemu/cutils.h        | 13 +++++++++++++
>  qapi/string-output-visitor.c |  2 +-
>  util/cutils.c                |  6 ------
>  4 files changed, 14 insertions(+), 8 deletions(-)

With the patch description fixed (as noted by Eric):

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
