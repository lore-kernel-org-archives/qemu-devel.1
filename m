Received: from eggs.gnu.org ([2001:4830:134:3::10]:55126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpu4-0004xT-A8
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpu2-0007uO-SL
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebpu2-0007rH-8U
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:26 -0500
References: <20180117131821.18700-1-f4bug@amsat.org>
	<f580124e-75a7-749b-da1c-da4993d583da@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01640495-199c-e1d6-51c4-6df2610d5270@redhat.com>
Date: Wed, 17 Jan 2018 09:45:12 -0600
MIME-Version: 1.0
In-Reply-To: <f580124e-75a7-749b-da1c-da4993d583da@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2saEGVyBOva0fPIpXGsmVctCMxbm7E7Nk"
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] add QEMU_WARN_NONNULL_ARGS() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2saEGVyBOva0fPIpXGsmVctCMxbm7E7Nk
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01640495-199c-e1d6-51c4-6df2610d5270@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] add QEMU_WARN_NONNULL_ARGS() macro
References: <20180117131821.18700-1-f4bug@amsat.org>
 <f580124e-75a7-749b-da1c-da4993d583da@linaro.org>
In-Reply-To: <f580124e-75a7-749b-da1c-da4993d583da@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 09:36 AM, Richard Henderson wrote:
> On 01/17/2018 05:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> BTW another useful macro for the static analizer I used is:
>>
>>     #define QEMU_FALLTHROUGH __attribute__((fallthrough))
>>
>> It replaces the /* fall through */ comment, i.e.:
>=20
> That's unfortunate.  Does it help if you use the actual lint spelling o=
f /*
> FALLTHRU */?

New gcc has this:

'-Wimplicit-fallthrough=3DN'
     Warn when a switch case falls through.  For example:
=2E..

     Since there are occasions where a switch case fall through is
     desirable, GCC provides an attribute, '__attribute__
     ((fallthrough))', that is to be used along with a null statement to
     suppress this warning that would normally occur:

          switch (cond)
            {
            case 1:
              bar (0);
              __attribute__ ((fallthrough));
            default:
              ...
            }

     C++17 provides a standard way to suppress the
     '-Wimplicit-fallthrough' warning using '[[fallthrough]];' instead
     of the GNU attribute.  In C++11 or C++14 users can use
     '[[gnu::fallthrough]];', which is a GNU extension.  Instead of the
     these attributes, it is also possible to add a fallthrough comment
     to silence the warning.  The whole body of the C or C++ style
     comment should match the given regular expressions listed below.

     The option argument N specifies what kind of comments are accepted:

        * '-Wimplicit-fallthrough=3D0' disables the warning altogether.

        * '-Wimplicit-fallthrough=3D1' matches '.*' regular expression,
          any comment is used as fallthrough comment.

        * '-Wimplicit-fallthrough=3D2' case insensitively matches
          '.*falls?[ \t-]*thr(ough|u).*' regular expression.

        * '-Wimplicit-fallthrough=3D3' case sensitively matches one of th=
e
          following regular expressions:

             * '-fallthrough'

             * '@fallthrough@'

             * 'lint -fallthrough[ \t]*'

             * '[ \t.!]*(ELSE,? |INTENTIONAL(LY)? )?
               FALL(S | |-)?THR(OUGH|U)[ \t.!]*(-[^\n\r]*)?'

             * '[ \t.!]*(Else,? |Intentional(ly)? )?
               Fall((s | |-)[Tt]|t)hr(ough|u)[ \t.!]*(-[^\n\r]*)?'

             * '[ \t.!]*([Ee]lse,? |[Ii]ntentional(ly)? )?
               fall(s | |-)?thr(ough|u)[ \t.!]*(-[^\n\r]*)?'

        * '-Wimplicit-fallthrough=3D4' case sensitively matches one of th=
e
          following regular expressions:

             * '-fallthrough'

             * '@fallthrough@'

             * 'lint -fallthrough[ \t]*'

             * '[ \t]*FALLTHR(OUGH|U)[ \t]*'

        * '-Wimplicit-fallthrough=3D5' doesn't recognize any comments as
          fallthrough comments, only attributes disable the warning.

     The comment needs to be followed after optional whitespace and
     other comments by 'case' or 'default' keywords or by a user label
     that precedes some 'case' or 'default' label.

          switch (cond)
            {
            case 1:
              bar (0);
              /* FALLTHRU */
            default:
              ...
            }

     The '-Wimplicit-fallthrough=3D3' warning is enabled by '-Wextra'.


No thanks to level 5, these days, you HAVE to use a macro that expands
to the attribute and/or C17 spelling, rather than relying on the lint
spelling, if you cannot control what level a user will request; although
with level 3, the lint spelling of a comment still works.  I'm not sure
which static analyzers recognize which other spellings; which is why a
macro that consistently expands to the same string known to work, rather
than 20 different ad hoc comments (many of which work, but auditing that
all of them work is a bigger task), may be worthwhile.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2saEGVyBOva0fPIpXGsmVctCMxbm7E7Nk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfb4gACgkQp6FrSiUn
Q2qiUwf/ShGWd96OhvHA5i0SS2ogiF8aPFEvDffpIv8WgKOErK3hDwliXCfkAy6+
EAdeN1irpNsTjLI+XoubbuVePJL/O0ZBCcqWX2CFbRkyKQWz18NHX6b2QGIZiUFQ
Ro/dZn2Ly0TRZwPhKW6dRCOppqUK/eOURIeaCEUj1edAw1v7zUwylLKpJ5cBtG2H
voE71r3CG+u9x5QQ0mhhMJRqyaoF6m/yf2wwwpo9Zpbnv7SF9MIz6GZKs9uLE9AB
SiR/edqdgx/lgtlSE1/2WHlUT8Rw+lyzvES2lZdNxxtXCx0tmKKGzvH1vQeHiegP
sMmayyVu6fAZ7/Q9tq+azvYKP6Gfog==
=CWQ+
-----END PGP SIGNATURE-----

--2saEGVyBOva0fPIpXGsmVctCMxbm7E7Nk--
