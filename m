Received: from eggs.gnu.org ([2001:4830:134:3::10]:36560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5dcz-0006di-RL
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d5dcz-0005P3-2s
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:38:29 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d5dcy-0005Oe-Sx
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:38:29 -0400
Date: Tue, 2 May 2017 21:38:26 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170502193826.vpgll3ruv3zwmsu4@aurel32.net>
References: <20170501221046.9369-1-aurelien@aurel32.net>
	<20170501221046.9369-2-aurelien@aurel32.net>
	<679953aa-5a89-1d48-b623-f0d17340c02d@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <679953aa-5a89-1d48-b623-f0d17340c02d@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 01/14] target/sh4: split ctx->flags into
 ctx->tbflags and ctx->envflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

On 2017-05-02 09:16, Philippe Mathieu-Daud=E9 wrote:
> Hi Aurelien,
>=20
> On 05/01/2017 07:10 PM, Aurelien Jarno wrote:
> > There is a confusion (and not only in the SH4 target) between tb->flags,
> > env->flags and ctx->flags. To avoid it, split ctx->flags into
> > ctx->tbflags and ctx->envflags. ctx->tbflags stays unchanged during the
> > whole TB translation, while ctx->envflags evolves and is kept in sync
> > with env->flags using TCG instructions. ctx->envflags now only contains
> > the part that of env->flags that is contained in the TB state, i.e. the
> > DELAY_SLOT* flags.
>=20
> I agree with your split, but I'd rather put the 2nd part of your commit
> description as comments in the struct DisasContext declaration, if you mi=
nd
> :)

Thanks for the review. I'll do that in the v2, although at some point it
should probably go to some higher level documentation, as it is often a
source of confusion.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
