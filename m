Received: from eggs.gnu.org ([209.51.188.92]:37115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBwMF-0001j7-Oo
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBwMD-00068Q-VH
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:00:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBwMB-00064d-T5
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 03:00:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id 103so1363635otd.9
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 00:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
	<1554321185-2825-3-git-send-email-sandra@codesourcery.com>
	<CAFEAcA_ENtYbEcxqH7LFDXS53-v3QiEYcn3aQ+Wh0MRGBcugDw@mail.gmail.com>
	<88a32d60-aaf5-0625-a798-24ebf3b288a6@codesourcery.com>
In-Reply-To: <88a32d60-aaf5-0625-a798-24ebf3b288a6@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2019 14:00:01 +0700
Message-ID: <CAFEAcA8YU+zC-2JKUyF6+v6zZUtYqDDqfcKtz6wX3mu5MFJFjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

On Thu, 4 Apr 2019 at 13:44, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> On 4/3/19 11:59 PM, Peter Maydell wrote:
> > On Thu, 4 Apr 2019 at 02:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
> >>
> >> This patch adds support for libgloss semihosting to Nios II bare-metal
> >> emulation.  The specification for the protocol can be found in the
> >> libgloss sources.
> >>
> >> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> >> Signed-off-by: Julian Brown <julian@codesourcery.com>
> >
> > I gave a reviewed-by tag for this patch in v6 -- has something changed
> > in v7 that made that no longer able to carry across?
>
> I fixed the formatting problems you asked me to address.  What else am I
> supposed to do?  I don't understand what you mean about the tag.

If somebody provides you with a Reviewed-by tag and you submit
a fresh version of the patchset then you should include that tag in
your commit message; that records that the patch has been reviewed
so that people know it doesn't need to be looked at again.
https://wiki.qemu.org/Contribute/SubmitAPatch#Proper_use_of_Reviewed-by:_tags_can_aid_review

thanks
-- PMM
