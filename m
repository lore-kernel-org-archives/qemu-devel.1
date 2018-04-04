Received: from eggs.gnu.org ([2001:4830:134:3::10]:58171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3jfr-0000yJ-Vh
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f3jfo-0005NW-SW
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:46:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f3jfo-0005NE-N5
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:46:04 -0400
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
Date: Wed, 4 Apr 2018 16:45:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180404143859.GI3186@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Programmingkid <programmingkidx@gmail.com>
Cc: Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On 04/04/2018 16:38, Daniel P. Berrang=C3=A9 wrote:
>>> Actually I believe we should remove those links.  I don't think hosti=
ng
>>> QEMU binaries on mediafire is a good idea.
>>>
>>> Paolo
>> Why not?
> The source/quality of those binaries is completely opaque. We've no ide=
a who
> built them, nor what build options were used, nor what/where the corres=
ponding
> source is (required for GPL compliance), nor any checksum / signature t=
o
> validate the binary isn't compromised since build, etc, etc.
>=20
> Pointing users to those binaries makes it appear QEMU project is blessi=
ng
> them, and so any issues with them directly reflect on QEMU's reputation=
.
>=20
> If we're going to link to binaries telling users to download them, we n=
eed
> to be hosting them on qemu.org and have a clearly documented formal pro=
cess
> around building & distributing them.
>=20
> Since both Homebrew & Macports are providing formal bulds though, it lo=
oks
> simpler to just entirely delegate the problem to them, as we do for Lin=
ux
> where we delegate to distro vendors to build & distribute binaries.

Note that, to some extent, the same issues do apply to Win32 binaries
(in particular, they are distributed under http and there are no
signatures).  However, the situation is better in that they are hosted
on an identifiable person's website, and of course Windows doesn't have
something akin to Homebrew and Macports so there is no alternative to
volunteers building and hosting the binaries.

Paolo
