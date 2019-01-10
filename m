Received: from eggs.gnu.org ([209.51.188.92]:41515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghd8I-0005Eb-6m
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghd8H-0005aM-GU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:24:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghd8H-0005U5-7W
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:24:37 -0500
References: <20190109220942.23822-1-pbonzini@redhat.com>
	<CAFEAcA9v3v3k_cFZCwvD5WD4FmiuFT=0UAjCBHEwpO+LuQWjAw@mail.gmail.com>
	<CAAdtpL5cuJdVgfgoo1oNfEpTZFkybLRn5MWqLna7osTUT=MCbg@mail.gmail.com>
	<CAFEAcA9huyGyKeOfwX7ZKPc7620DaA6ZP7cUvNFmbxe4AB72fg@mail.gmail.com>
	<CAAdtpL6VsQn1WKo9=a-UaRD_acn8a_XVA1R46YX+MCx9-89hHg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e25cfc5d-64d6-e742-b46a-73ab257a4ae5@redhat.com>
Date: Thu, 10 Jan 2019 17:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL6VsQn1WKo9=a-UaRD_acn8a_XVA1R46YX+MCx9-89hHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v6 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 10/01/19 17:12, Philippe Mathieu-Daud=C3=A9 wrote:
>> I'm not using travis, this is a local run of the test.
>> But perhaps my system has a cached image. It seems a bit
>> odd that it uses that cached image when testing master
>> but not when testing Paolo's merge, though.
> The patch "test: replace gtester with a TAP driver" contains docker
> changes (adding libtest-harness-perl) which trigger a rebuild, your
> builds using /master should use the cache.
>=20
> This might be a problem with this new package (if so, Fam's PR isn't
> going to help here).

Yes, in some versions of Debian it's a virtual package.  I should just
install perl instead.

Paolo
