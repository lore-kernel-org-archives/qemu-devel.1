Received: from eggs.gnu.org ([2001:4830:134:3::10]:41827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linus971@gmail.com>) id 1fsBYY-0003YG-La
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linus971@gmail.com>) id 1fsBYW-0002YG-IM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:39:06 -0400
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:55813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <linus971@gmail.com>) id 1fsBYU-0002Vg-Fo
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 14:39:02 -0400
Received: by mail-it0-x22b.google.com with SMTP id d10-v6so5498674itj.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 11:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
	<1534870966-9287-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-28-git-send-email-pbonzini@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Aug 2018 11:38:48 -0700
Message-ID: <CA+55aFyG=iDf3r3nj5Wav4xnKs1D8tUM9iejJd4M0xb2q-tZoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 27/74] checkpatch: allow space in more
 places before a bracket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Morton <akpm@linux-foundation.org>

This is commit 38dca988bb20 ("checkpatch: allow space between colon
and bracket") upstream, why is that not mentioned anywhere?

*Please* mention the upstream commits when back-porting things.

                 Linus


On Tue, Aug 21, 2018 at 10:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Allow a space between a colon and subsequent opening bracket.  This
> sequence may occur in inline assembler statements like
