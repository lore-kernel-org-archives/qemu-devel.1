Received: from eggs.gnu.org ([2001:4830:134:3::10]:37879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gPQ8r-00065L-Qf
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gPQ8o-0002P7-MM
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:53:57 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:37868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gPQ8o-0002Ol-IE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:53:54 -0500
Received: by mail-it1-x141.google.com with SMTP id b5so8199245iti.2
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 02:53:54 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Wed, 21 Nov 2018 05:53:50 -0500
References: <mailman.23054.1542721275.1282.qemu-devel@nongnu.org>
In-Reply-To: <mailman.23054.1542721275.1282.qemu-devel@nongnu.org>
Message-Id: <36E62A3F-7402-418F-AB88-9B597E437C69@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Fix for crashes and non-responsive UI on
 macOS Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


> On 13 November 2018 at 12:12, Programmingkid =
<programmingkidx@gmail.com> wrote:
>>> On Nov 11, 2018, at 4:35 PM, Berkus Decker wrote:
>>> These changes are ought to work on OSX 10.6, although I don?t have a =
machine handy to test it.
>>=20
>> I have Mac OS 10.6 available for testing.
>=20
> This is perhaps a good point to ask the question: is retaining
> support for 10.6 still worth the effort ? It was released 9
> years ago and has been unsupported by Apple for nearly 5 years.
>=20
> qemu-doc.texi's "Supported build platforms" section says:
> # The project supports building with the two most recent versions
> # of macOS, with the current homebrew package set available.
>=20
> which would be High Sierra (10.13) and Mojave (10.14) only. If you
> widened that to "all versions still supported by Apple" it would add
> Sierra (10.13) to the list.
>=20
> Given how few upstream developers we have who care about OSX,
> I think it is not very useful to spend that effort on trying
> to retain support for ancient versions of it.
>=20
> thanks
> -- PMM

Mac OS 10.6 is a very good operating system. I much rather we simplify =
the patch rather than drop support for this excellent operation system =
just because it is a few years old. I suspect rewriting the the patch to =
use performSelectorOnMainThread:withObject:waitUntilDone: would be a =
simpler and better patch.

I have tried the patch out already on Mac OS 10.12 and it did not work. =
The firmware never runs and the Machine menu does not populate. I do not =
believe this patch is worth dropping the support of many versions of Mac =
OS X.=
