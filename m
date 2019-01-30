Received: from eggs.gnu.org ([209.51.188.92]:51993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomrH-0003A9-6Y
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomrG-0002nw-DQ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:12:39 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-7-philmd@redhat.com>
	<f2462ab2-4579-aad1-99e8-a474587ec409@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <450d58b6-f6af-4714-6b47-832d7a7564b2@redhat.com>
Date: Wed, 30 Jan 2019 11:11:59 +0100
MIME-Version: 1.0
In-Reply-To: <f2462ab2-4579-aad1-99e8-a474587ec409@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OUvCPsnW4dVK22evODaN67tLPftANjm65"
Subject: Re: [Qemu-devel] [PATCH v2 06/18] qemu-iotests: Improve portability
 by searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OUvCPsnW4dVK22evODaN67tLPftANjm65
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <450d58b6-f6af-4714-6b47-832d7a7564b2@redhat.com>
Subject: Re: [PATCH v2 06/18] qemu-iotests: Improve portability by searching
 bash in the $PATH
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-7-philmd@redhat.com>
 <f2462ab2-4579-aad1-99e8-a474587ec409@redhat.com>
In-Reply-To: <f2462ab2-4579-aad1-99e8-a474587ec409@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2019-01-29 23:15, Eric Blake wrote:
[...]
> Why a space between #! and /usr/bin/env? That's not our prevailing styl=
e
There is an urban legend that this was required on certain old Unix
systems, but as far as I know, it's only wrong information:

 https://www.in-ulm.de/~mascheck/various/shebang/#blankrequired

Anyway, the blank is certainly not required anymore in the 21st century,
so I'd also suggest to remove it in these patches here.

 Thomas


--OUvCPsnW4dVK22evODaN67tLPftANjm65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcUXh1AAoJEC7Z13T+cC21K3UQAIfpXIDPD0FVDYorAgSMrrub
iWvwqaTHSAiDaVI5S5nxIRukC5k6/kHWbCxJgb2E5M6gTjUi2j+xQS2FeMr96JI3
XhNo/sYl7/mhvjnpl7uQJec6RiUoyXC+TAmCbREONmDAFyD2WQVJLhLLIlqUY3LW
eoJ1x/fULLSsakmk8RNmEYv2UDE2YS47DtNSuMEu94nH8LLQj5QB4tytcjOWhKmp
XsP1L9ZESViZOIdK9woKGEg8vB0WT8k4e8OX/sBkAs582VJ3jTYq5d7B3CYYD4eb
wkai63/n/D3O69blWS735mLsj4Hv8WLh2Icvxeg6VX8fgJFmD7j6MC4o0tKSzXuw
bRNf9Sm4UBY2WY95eSGvjkD99uQfw6ryY5mNB2584x+oCcWCFR/i5h5rYdalDvV3
m2dpXJTq343hsmlqRVLFLIBxw5Y3fdg47XnbiFQqvSo3si5ScdP7HeP+vc5cu5ti
Kcy0TZT3mOCpPTn4Nlb5M0/wFpv07ky47SqACh5DN12jtB8uT2u/j6AocjgvQzzw
eLjTYRT84e/W+niFFcXTnvwKDCB1ZBHoZ5Z5B9pnUSqVKJ0KH8iT/4CGSdATJxzZ
dL0XQ7LdCKHU8/ogxsCjgg6hcuaY8EYLN4JArO1YIus7xbH37ebgXRFhJC/q7Bix
B5OoxIsBZLeZS0vXg75O
=Wsqr
-----END PGP SIGNATURE-----

--OUvCPsnW4dVK22evODaN67tLPftANjm65--
