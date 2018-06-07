Received: from eggs.gnu.org ([2001:4830:134:3::10]:47912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQqWy-0004cw-OD
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQqWx-0007N8-Um
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:44:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQqWx-0007Mu-Pz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:44:27 -0400
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <183c8b5c-a76c-ce69-4999-19203a1cc0cf@redhat.com>
Date: Thu, 7 Jun 2018 10:44:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180606173233.28080-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util: remove redundant include of
 glib.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 06.06.2018 19:32, Daniel P. Berrang=C3=A9 wrote:
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

In case you respin this series, should the order of patch 2 and 3 be
swapped? ... so that we keep the tree bisectable?

 Thomas
