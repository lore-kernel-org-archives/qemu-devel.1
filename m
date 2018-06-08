Received: from eggs.gnu.org ([2001:4830:134:3::10]:58554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRIh8-0003k0-0N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRIh3-0001i5-OZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:48:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fRIh3-0001hb-KH
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:48:45 -0400
References: <20180608131604.16826-1-berrange@redhat.com>
	<20180608131604.16826-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8c705c77-ca6a-7cbe-07b3-537f6ae20ee0@redhat.com>
Date: Fri, 8 Jun 2018 09:48:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180608131604.16826-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Olaf Hering <olaf@aepfle.de>

On 06/08/2018 08:16 AM, Daniel P. Berrang=C3=A9 wrote:
> Code must only ever include glib.h indirectly via the glib-compat.h
> header file, because we will need some macros set before glib.h is
> pulled in. Adding extra includes of glib.h will (soon) cause compile
> failures such as:
>=20
> In file included from /home/berrange/src/virt/qemu/include/qemu/osdep.h=
:107,
>                   from /home/berrange/src/virt/qemu/include/qemu/iova-t=
ree.h:26,
>                   from util/iova-tree.c:13:
> /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_VER=
SION_MIN_REQUIRED" redefined [-Werror]
>   #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
>=20
> In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
>                   from /usr/include/glib-2.0/glib/galloca.h:32,
>                   from /usr/include/glib-2.0/glib.h:30,
>                   from util/iova-tree.c:12:
> /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the loca=
tion of the previous definition
>   # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
>=20
> Furthermore, the osdep.h include should always be done directly from th=
e
> .c file rather than indirectly via any .h file.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
