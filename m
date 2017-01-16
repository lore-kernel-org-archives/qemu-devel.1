Received: from eggs.gnu.org ([2001:4830:134:3::10]:46667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT9gY-00079A-Fa
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT9gU-0004yh-F3
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:59:06 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:36737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT9gU-0004yd-3O
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:59:02 -0500
Received: by mail-ua0-x235.google.com with SMTP id 96so83925745uaq.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 07:59:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484559200-2301-1-git-send-email-armbru@redhat.com>
References: <1484559200-2301-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 15:58:41 +0000
Message-ID: <CAFEAcA_BBbHeQhWYf_qrL+TwxGT8w34SvUNG_gcNfpNnyaGCzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 000/180] QAPI patches for 2017-01-16
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

On 16 January 2017 at 09:33, Markus Armbruster <armbru@redhat.com> wrote:
> This is Marc-Andr=C3=A9's "[PATCH v8 00/21] qapi doc generation (whole
> version, squashed)" with a few commit messages tweaked, and "[PATCH v8
> 14/21] (SQUASHED) move doc to schema" unsquashed into 161 patches.
>
> We did all the respins with in this squashed form to reduce noise.
> However, since the unsquashed form is better suited for review, and
> probably nicer if we have to revisit this part of the work down the
> road, I'm proposing to merge this unsquashed.
>
> If you want me to post the unsquashed patches, I'm happy to redo this
> pull request.
>
> If you'd rather pull the squashed version, likewise.
>
> I'm afraid this is a bit of a doc conflict magnet.  The sooner we can
> get it in, the easier for Marc-Andr=C3=A9 and me.
>
> v2:
> * Rebased (v1 conflicts with commit e1ff3c6)
> * test-qapi.py tweaked to avoid trailing empty lines in .out
>
> The following changes since commit b6af8ea60282df514f87d32e36afd1c9aeee28=
c8:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pul=
l-request' into staging (2017-01-13 14:38:21 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-01-16
>
> for you to fetch changes up to 56e8bdd46a8a42d89b0afea9da83ae7679cc0439:
>
>   build-sys: add qapi doc generation targets (2017-01-16 10:11:43 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-01-16

This seems to trigger some warnings from older makeinfo versions:

On the Fedora 20 ppc64be box and Ubuntu 14.04.5 LTS aarch64 box
(Ubuntu: makeinfo (GNU texinfo) 5.2;
 Fedora: makeinfo (GNU texinfo) 5.1)

/home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION
/home/pm215/qemu/docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION
/home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: VERSIO=
N
/home/pm215/qemu/docs/qemu-qmp-ref.texi:41: warning: undefined flag: VERSIO=
N

On OSX (makeinfo (GNU texinfo) 4.8):
./qemu-options.texi:60: warning: unlikely character [ in @var.
./qemu-options.texi:60: warning: unlikely character ] in @var.
./qemu-options.texi:61: warning: unlikely character [ in @var.
./qemu-options.texi:61: warning: unlikely character ] in @var.

(OSX also has the long standing warning
/Users/pm215/src/qemu-for-merges/qemu-doc.texi:7: warning:
unrecognized encoding name `UTF-8'.
but you can ignore that since it's been that way for years
and is because osx's makeinfo is ancient.)

thanks
-- PMM
