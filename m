Received: from eggs.gnu.org ([2001:4830:134:3::10]:40974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6vTR-0005oC-Hl
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6vTQ-0003KL-Md
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g6vTQ-0003Jw-B8
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:30:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id j9-v6so12536299otl.2
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 03:30:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180927025427.101853-1-eblake@redhat.com>
References: <20180927025427.101853-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Oct 2018 11:30:23 +0100
Message-ID: <CAFEAcA8DRPDXviCCQJdeU7j=5JrrnOqcuit66Abo55+PygCOHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] NBD patches through 2018-09-26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 September 2018 at 03:54, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit c5e4e49258e9b89cb34c085a419dd9f862935c=
48:
>
>   Merge remote-tracking branch 'remotes/xanclic/tags/pull-block-2018-09-2=
5' into staging (2018-09-25 16:47:35 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-09-26
>
> for you to fetch changes up to fb7afc797e071f2616e1ccc849b39fe43e7033bf:
>
>   nbd/server: send more than one extent of base:allocation context (2018-=
09-26 21:37:48 -0500)
>
> Intentionally not included but still probable 3.1 material:
> - John: dirty-bitmaps cleanups - while related to NBD fleecing, John's tr=
ee is better suited for that
> - Vladimir: v4 00/10 NBD reconnect - I still haven't had time for a prope=
r review
> - Eric: NBD fixes for unaligned images - I still have corner cases that r=
equire a v2
> - Vladimir: nbd oldstyle vs. newstyle negotiation - still need a patch wr=
itten to flip the default
> - Eric: qemu-img dd improvements - useful in testing nbd, but needs a v2 =
written that improves 'qemu-img convert' in general to do subrange work
> - Eric?: need a way to cause NBD to give EIO when reading outside dirty b=
itmap area of fleeced image, so that we can then avoid copy-on-write to the=
 fleeced image for portions that aren't dirty for less local storage pressu=
re. So far just an idea with no patches
>
> ----------------------------------------------------------------
> nbd patches for 2018-09-26
>
> Fixes for external clients; add reminder to revisit naming of x- command
>
> - Vladimir Sementsov-Ogievskiy: nbd/server: send more than one extent of =
base:allocation context
> - John Snow: qapi: bitmap-merge: document name change
> - Vladimir Sementsov-Ogievskiy: nbd/server: fix bitmap export
>

Applied, thanks.

-- PMM
