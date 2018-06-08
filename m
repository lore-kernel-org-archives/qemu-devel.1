Received: from eggs.gnu.org ([2001:4830:134:3::10]:43000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRLAB-0001dk-DR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRLA8-0000D9-9g
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:26:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fRLA8-0000Ci-3z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:26:56 -0400
References: <20180608131604.16826-1-berrange@redhat.com>
	<20180608131604.16826-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <16b1856d-78a5-7a23-ca56-de545f546dc9@redhat.com>
Date: Fri, 8 Jun 2018 19:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180608131604.16826-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] util: remove redundant include of
 glib.h and add osdep.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>

On 08.06.2018 15:16, Daniel P. Berrang=C3=A9 wrote:
> Code must only ever include glib.h indirectly via the glib-compat.h
> header file, because we will need some macros set before glib.h is
> pulled in. Adding extra includes of glib.h will (soon) cause compile
> failures such as:
>=20
> In file included from /home/berrange/src/virt/qemu/include/qemu/osdep.h=
:107,
>                  from /home/berrange/src/virt/qemu/include/qemu/iova-tr=
ee.h:26,
>                  from util/iova-tree.c:13:
> /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_VER=
SION_MIN_REQUIRED" redefined [-Werror]
>  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
>=20
> In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
>                  from /usr/include/glib-2.0/glib/galloca.h:32,
>                  from /usr/include/glib-2.0/glib.h:30,
>                  from util/iova-tree.c:12:
> /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the loca=
tion of the previous definition
>  # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
>=20
> Furthermore, the osdep.h include should always be done directly from th=
e
> .c file rather than indirectly via any .h file.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qemu/iova-tree.h | 1 -
>  util/iova-tree.c         | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
