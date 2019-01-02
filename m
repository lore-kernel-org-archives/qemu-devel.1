Received: from eggs.gnu.org ([208.118.235.92]:60594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gecAR-0006EJ-Kb
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 03:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gecAO-00014V-GG
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 03:46:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gecAO-00013y-9Q
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 03:46:20 -0500
References: <20181228173356.15359-1-philmd@redhat.com>
	<20181228173356.15359-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <35c6df81-c6b8-16cf-8d12-4e1e172e2973@redhat.com>
Date: Wed, 2 Jan 2019 09:46:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181228173356.15359-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/5] qemu/compiler: Define QEMU_NONSTRING
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2018-12-28 18:33, Philippe Mathieu-Daud=C3=A9 wrote:
> GCC 8 introduced the -Wstringop-truncation checker to detect truncation=
 by
> the strncat and strncpy functions (closely related to -Wstringop-overfl=
ow,
> which detect buffer overflow by string-modifying functions declared in
> <string.h>).
>=20
> In tandem of -Wstringop-truncation, the "nonstring" attribute was added=
:
>=20
>   The nonstring variable attribute specifies that an object or member
>   declaration with type array of char, signed char, or unsigned char,
>   or pointer to such a type is intended to store character arrays that
>   do not necessarily contain a terminating NUL. This is useful in detec=
ting
>   uses of such arrays or pointers with functions that expect NUL-termin=
ated
>   strings, and to avoid warnings when such an array or pointer is used =
as
>   an argument to a bounded string manipulation function such as strncpy=
.
>=20
>   From the GCC manual: https://gcc.gnu.org/onlinedocs/gcc/Common-Variab=
le-Attributes.html#index-nonstring-variable-attribute
>=20
> Add the QEMU_NONSTRING macro which checks if the compiler supports this
> attribute.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
