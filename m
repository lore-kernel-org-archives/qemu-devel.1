Received: from eggs.gnu.org ([2001:4830:134:3::10]:40863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAayI-0006zr-LY
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAayF-0005YV-I6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:53:30 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:44291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAayF-0005XV-8K
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:53:27 -0400
Received: by mail-wr0-x234.google.com with SMTP id o15-v6so40951253wro.11
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 05:53:26 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<ef2caf0d-4bd0-9383-5d2f-e1f0ba9f536b@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <ef2caf0d-4bd0-9383-5d2f-e1f0ba9f536b@linaro.org>
Date: Mon, 23 Apr 2018 13:53:24 +0100
Message-ID: <87sh7mkrsr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/19/2018 03:58 AM, Alex Benn=C3=A9e wrote:
>> What would be really
>> helpful is if the respective maintainers could encode their EXACT
>> STEPS for building their cross compilers into some docker recipes.
>
> I've just re-built my alphaev67 cross-environment and recorded everything.
>
> Since the script begins with rebuilding glibc, it assumes you *already* h=
ave a
> cross-compiler.  If you don't have that, then you start in the middle of =
the
> script with the GCC build.  But in that case you must have the sysroot.ta=
r.gz
> that the first half just created.

Could you send me the sysroot.tar.gz?

>
> Starting without that seed tarball is hard, as previously mentioned.  For
> better supported platforms than alpha you can typically pull the same fil=
es
> from e.g. debian packages or a gentoo stage3 tarball.

Hmm I was hoping I could use --without-sysroot to build a gcc just for
building glibc and then re-build gcc once glibc was boot-strapped. But
that doesn't seem to work...

Maybe for alpha we just have to accept there is a blob of sysroot to get
the build going? Of course we should probably host that blob on qemu's
servers somewhere...

> While I've used git gcc/binutils/glibc, because I had them handy, of cour=
se
> everything would work equally well using release tarballs for each projec=
t.
>
> Let me know if you have any questions re cross-tools.
>
>
> r~


--
Alex Benn=C3=A9e
