Received: from eggs.gnu.org ([2001:4830:134:3::10]:46935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etMVa-0003Kt-5o
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 19:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etMVZ-0002nZ-2k
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 19:00:38 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:43471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etMVY-0002nJ-Rn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 19:00:37 -0500
Received: by mail-ot0-x231.google.com with SMTP id m22so426436otf.10
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 16:00:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306234742.GA26112@flamenco>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<CAHNT7NsqMQr9hmFN2wBo+CevLjD=X-9UTeDCoEfg_GVEvtJ1pw@mail.gmail.com>
	<20180306234742.GA26112@flamenco>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 13:00:35 +1300
Message-ID: <CAHNT7NtRmkPWKN-0pEzX4JWSppOS_=oB6Ha7C-U3oqg0EKAWWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 00/22] Spec conformance bug fixes and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Wed, Mar 7, 2018 at 12:47 PM, Emilio G. Cota <cota@braap.org> wrote:

> On Wed, Mar 07, 2018 at 12:07:18 +1300, Michael Clark wrote:
> > BTW Apologies for the duplicate emails. I'm still getting to grips with
> the
> > git-sendemail workflow and was using a sed script to Add Cc's which
> munged
> > the headers as it didn't take into account Subject lines flowing to two
> > lines. I guess I can just include Cc: in the commit message? and
> > git-format-patch will handle it for me? or I just should how to use
> > git-publish...
>
> I don't have experience with git-publish. The following two suggestions
> might help though:
>
> - Yes, add Cc's to individual patches -- those are picked up by send-email.
>   That also applies to the cover letter, although note that if
>   you use --compose then Cc's won't be picked up. Instead, just write
>   the cover letter into a 0000-$cover.patch (with Cc's in there)
>   and do not use --compose.
>
> - Use send-email's --dry-run option to make sure everything looks good
>   without actually sending any emails.


I'll use dry run next time and reword the patches to add 'Cc. The previous
patch series all had subject lines that didn't flow to the next line and I
had script automation to carve up the port. I'm trying to get into a new
habit of making the first line of the patch (Subject) as short as
reasonably possible and instead putting a longer description in the body.
Short subjects and short first lines of commits are better.


> > I still have to work on Igor's requested change to CPU initializer
> > declarations, and i'd also like to get the patch in that fixes fmin/fmax
> > test failures using the riscv-tests testsuite by implementing IEEE-754
> > minimumNumber/maximumNumber. I'll try to get a patch onto the list before
> > soft-freeze. I dropped the patch which was in an earlier version of our
> > port patch series due to a conflict with changes in softfloat (conversion
> > of minmax from a macro to a static function iirc).
>
> Note that if you're fixing a bug (and the fmin/fmax patch qualifies),
> you can definitely get it merged post-soft-freeze.


 Okay. good.
