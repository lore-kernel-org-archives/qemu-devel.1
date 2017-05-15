Received: from eggs.gnu.org ([2001:4830:134:3::10]:54498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAGiH-0000bd-5D
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAGiD-0006PY-K1
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dAGiD-0006PF-6K
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:11:01 -0400
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-2-f4bug@amsat.org>
	<b5660d99-c854-1930-8806-5989c69f90d1@redhat.com>
	<27c7761e-48c8-9398-ea89-b1fb67602cef@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <19ed7405-d072-de74-867b-c353e59bee48@redhat.com>
Date: Mon, 15 May 2017 16:10:54 +0200
MIME-Version: 1.0
In-Reply-To: <27c7761e-48c8-9398-ea89-b1fb67602cef@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v4 1/6] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>, Julia Lawall <julia.lawall@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>

On 15/05/2017 16:06, Paolo Bonzini wrote:
>=20
>=20
> On 15/05/2017 16:04, Eric Blake wrote:
>> On 05/12/2017 06:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> If you have coccinelle installed you can apply this script using:
>>>
>>>     $ spatch \
>>>         --macro-file scripts/cocci-macro-file.h \
>>>         --dir target --in-place
>>>
>>> You can also use directly Peter Senna Tschudin docker image (easier):
>>>
>>>     $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
>>>         --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
>>>         --macro-file scripts/cocci-macro-file.h \
>>>         --dir target --in-place
>>>
>>> Then verified that no manual touchups are required.
>>>
>>> The following thread was helpful while writing this script:
>>>
>>>     https://github.com/coccinelle/coccinelle/issues/86
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  scripts/coccinelle/tcg_gen_extract.cocci | 103 +++++++++++++++++++++=
++++++++++
>>>  1 file changed, 103 insertions(+)
>>>  create mode 100644 scripts/coccinelle/tcg_gen_extract.cocci
>>
>> It's still not obvious to me whether we want this script in the tree (=
as
>> something we plan to rerun regularly to check for regressions), or jus=
t
>> in the commit message (useful for the one-time location of spots to
>> optimize, but something we don't anticipate repeating).
>=20
> I think it's useful.  New backends can have this issue, plus it shows
> some advanced Coccinelle techniques.
>=20

I agree: I think it's a good idea to have a place in QEMU directory with
all past coccinelle scripts to help to write the new ones.

Laurent
