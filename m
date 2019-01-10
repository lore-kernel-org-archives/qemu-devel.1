Received: from eggs.gnu.org ([209.51.188.92]:44717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghh3A-0001da-7p
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghh39-000520-AQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:35:36 -0500
References: <1547111736-3962-1-git-send-email-thuth@redhat.com>
	<1547111736-3962-3-git-send-email-thuth@redhat.com>
	<20190110132838.31365c55@bahia.lan>
	<8947b77e-41c7-5c1d-465f-a9bf1dd7d103@redhat.com>
	<20190110170054.232da6a0@bahia.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <120f1d93-7085-e5ee-18ee-e7b7b1a218ef@redhat.com>
Date: Thu, 10 Jan 2019 21:35:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190110170054.232da6a0@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/3] ppc: Drop duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On 10/01/19 17:00, Greg Kurz wrote:
>>> Hmm... so the choice here is to simply ignore the official coding
>>> style ? =20
>>
>> Are typedefs really our "official coding style"? It's mentioned in
>> HACKING, not in CODING_STYLE, so I rather see this as a recommendation
>=20
> Indeed.
>=20
>> only. (Otherwise, all the forward struct definitions at the beginning =
of
>> spapr.h are a plain violation of the coding style, too...)
>>
>=20
> Yeah.
>=20
>> IMHO we should rather adopt the coding style of the kernel which rathe=
r
>> tries to avoid to typedef each and every struct.
>>
>=20
> From https://www.kernel.org/doc/html/latest/process/coding-style.html#t=
ypedefs :
>=20
> "In general, a pointer, or a struct that has elements that can reasonab=
ly be
>  directly accessed should never be a typedef."
>=20
> So if we were to adopt the coding style of the kernel, we'd have to fac=
e a
> lot more violations with the current QEMU code base :)

Yes, that's just not going to happen.  QEMU has a different coding
style; it's used consistently(*) and we'll live with it. I do like the
kernel style too as well, but it's just too different for a transition
to make sense and it may make even less sense if QEMU ever becomes
multi-language.  To put it clearly, this is not multiline comments.

It's a different thing to allow struct in prototypes, that's a special
case that already exists and can be adopted only if necessary.

Paolo

    (*) camel-case type identifiers are also shared with GLib and many
        other libraries we use, and they are pretty much a universal
        convention in every language but C and C++.
