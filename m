Received: from eggs.gnu.org ([2001:4830:134:3::10]:42123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS334-0006d8-Ur
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gS333-0005Nr-MG
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:50:50 -0500
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
	<20181128160525.GP24355@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3d95da16-5f2a-2ec8-a674-189b44eab222@redhat.com>
Date: Wed, 28 Nov 2018 17:50:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181128160525.GP24355@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1?] target/arm/sve_helper: Fix
 compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2018-11-28 17:05, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Nov 28, 2018 at 10:58:14AM +0100, Thomas Huth wrote:
>> Clang 3.4 does not know the "flatten" attribute yet. We've already
>> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2,
>> so use this macro now here, too, to fix this issue.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Although we currently only aim to support CLang and GCC, we don't have
> any checks for a minimum version of these two tools in configure.
>=20
> So I was wondering if we actually still need to support CLang 3.4 at al=
l
> in QEMU, given our targetted build platforms.
>=20
> Unfortunately repology.org is failing me in reporting clang versions
> for most distros, so I don't have an answer yet. I do see that Debian
> Jessie however ships clang =3D=3D 3.5 and that's usually the oldest dis=
tro
> if RHEL hasn't got something older.

I'm using RHEL7 and the clang that I get "for free" is 3.4.2 via EPEL.

> If we did explicitly check min gcc + clang versions, we could sanitize
> stuff such as hacks for ancient clang 3.2 which lacks int128 support.

I guess we could try to force the minimum version to 3.4 and see whether
somebody complains afterwards...

 Thomas


PS: That reminds me that I also wanted to send a patch for compiler.h to
properly fail there if the minimum version of GCC is not met (v4.1)...
