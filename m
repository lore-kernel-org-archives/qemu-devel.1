Received: from eggs.gnu.org ([2001:4830:134:3::10]:41580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esqBK-0007hI-1c
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esqBI-0008WG-UD
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:29:34 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esqBI-0008Vo-P3
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:29:32 -0500
Received: by mail-oi0-x22f.google.com with SMTP id j79so11987477oib.12
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 05:29:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520004397-28521-1-git-send-email-minyard@acm.org>
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 13:29:11 +0000
Message-ID: <CAFEAcA8WZVHJ-uBowS3V2gpuiO8Fwg2rZLpb3WT2dMLTD2Crzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] ipmi: Fix vmstate transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 2 March 2018 at 15:26,  <minyard@acm.org> wrote:
> I apologize for the resend, I left the list off the previous post.
>
> This is unchanged since the previous post, two weeks ago.  I received
> no comments, so I guess it's ok.  It's fairly broken now, so I would
> like this fixed.
>
> Changes from v1:
>   * Validate the data values in pre_load functions.
>   * For KCS, instead of an old function, create a separate vmstate
>     structure for the new version.  The name on the old vmstate
>     structure wasn't specific enough, so a new name was needed,
>     The old structure is set up to never be sent, but it can be
>     received.
>
> The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)
>
> are available in the git repository at:
>
>   https://github.com/cminyard/qemu.git tags/ipmi-vmstate-fixes
>
> for you to fetch changes up to 90797371d9a3138657e7b1f7ab4425eb67d6fd0a:
>
>   ipmi: Use proper struct reference for BT vmstate (2018-03-02 07:48:39 -0600)
>

If you could avoid sending pull request emails for patchsets, I'd
appreciate it -- they automatically go into my queue of
things-to-process-for-master, and if I'm not paying enough attention
they might actually get applied...

thanks
-- PMM
