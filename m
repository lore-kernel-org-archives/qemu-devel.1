Received: from eggs.gnu.org ([2001:4830:134:3::10]:46020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZK7h-0002XE-FM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZK7g-0005bZ-Hi
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 13:29:41 -0500
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-2-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7ebdd16-17d2-676d-d444-78eb85627e5d@redhat.com>
Date: Tue, 18 Dec 2018 12:29:01 -0600
MIME-Version: 1.0
In-Reply-To: <20181218175122.3229-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qemu/compiler: Define QEMU_NONSTRING
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On 12/18/18 11:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> GCC 8 introduced the -Wstringop-truncation checker to detect truncation=
 by
> the strncat and strncpy functions (closely related to -Wstringop-overfl=
ow,
> which detect buffer overflow by string-modifying functions declared in
> <string.h>).

This paragraph talks about a new warning checker, but makes no mention=20
of an attribute.

>=20
> Add the QEMU_NONSTRING macro which checks if the compiler supports this
> attribute.

Thus, "this attribute" has no antecedent; did you forget to add a=20
sentence to the previous paragraph, or maybe put the mention of adding=20
QEMU_NONSTRING after...

>=20
>>From the GCC manual [*]:
>=20
>    The nonstring variable attribute specifies that an object or member
>    declaration with type array of char, signed char, or unsigned char,
>    or pointer to such a type is intended to store character arrays that
>    do not necessarily contain a terminating NUL. This is useful in dete=
cting
>    uses of such arrays or pointers with functions that expect NUL-termi=
nated
>    strings, and to avoid warnings when such an array or pointer is used=
 as
>    an argument to a bounded string manipulation function such as strncp=
y.

...the explanation of how the attribute was added in tandem with the new=20
warning checker for silencing specific instances of the warning?

>=20
> [*] https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#=
index-nonstring-variable-attribute
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   include/qemu/compiler.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
