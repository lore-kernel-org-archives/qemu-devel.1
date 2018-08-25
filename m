Received: from eggs.gnu.org ([2001:4830:134:3::10]:56283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftVLW-0007dC-M6
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 05:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftVLU-0004CI-Si
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 05:59:06 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftVLT-0004BI-6h
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 05:59:04 -0400
Received: by mail-oi0-x241.google.com with SMTP id 13-v6so19480782ois.1
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 02:59:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Aug 2018 10:58:41 +0100
Message-ID: <CAFEAcA_u6rTWb31C8JCMP+CydwojSRCS+_dQX4cgNFiCKqh+ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/58] QObject patches for 2018-08-24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 August 2018 at 20:31, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 1dfb85a8755096beecf182a617493d539259cbea:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/check/20180822' into staging (2018-08-24 14:46:31 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qobject-2018-08-24
>
> for you to fetch changes up to 37aded92c27d0e56cd27f1c29494fc9f8c873cdd:
>
>   json: Update references to RFC 7159 to RFC 8259 (2018-08-24 20:27:14 +0200)
>
> ----------------------------------------------------------------
> QObject patches for 2018-08-24
>
> JSON is such a simple language, so writing a parser should be easy,
> shouldn't it?  Well, the evidence is in, and it's a lot of patches.
> Summary of fixes:
>
> * Reject ASCII control characters in strings as RFC 7159 specifies
>
> * Reject all invalid UTF-8 sequences, not just some
>
> * Reject invalid \uXXXX escapes
>
> * Implement \uXXXX surrogate pairs as specified by RFC 7159
>
> * Don't ignore \u0000 silently, map it to \xC0\80 (modified UTF-8)
>
> * qobject_from_json() is ridicilously broken for input containing more
>   than one value, fix
>
> * Don't ignore trailing unterminated structures
>
> * Less cavalierly cruel error reporting
>
> Topped off with tests and cleanups.

Applied, thanks.

-- PMM
