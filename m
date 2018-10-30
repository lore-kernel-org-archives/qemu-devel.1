Received: from eggs.gnu.org ([2001:4830:134:3::10]:59538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHY9J-0005FU-9p
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHY9B-0001tc-Lx
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:49:51 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHY97-0001cJ-TX
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:49:43 -0400
Received: by mail-wm1-f47.google.com with SMTP id p2-v6so12154147wmc.2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:49:29 -0700 (PDT)
References: <1540920498-5133-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f1b976d-e1ce-44bc-2810-ff7a3275d6ac@redhat.com>
Date: Tue, 30 Oct 2018 18:49:26 +0100
MIME-Version: 1.0
In-Reply-To: <1540920498-5133-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/5] MIPS queue for October 2018, part 5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

Hi Aleksandar,

On 30/10/18 18:28, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> The following changes since commit 3f3285491dd52014852a56135c90e428c8b507ea:
> 
>    Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-10-30 14:09:25 +0000)
> 
> are available in the git repository at:
> 
>    https://github.com/AMarkovic/qemu tags/mips-queue-october-2018-part-5
> 
> for you to fetch changes up to 12ccc41b192a0a65e9379bafa947d1ed7de79750:
> 
>    target/mips: Enable only tested modes for R5900 (2018-10-30 18:17:17 +0100)

1h44min between a series posted and the same series sent as pull request 
is quite fast for qemu-devel@.

I'm sorry to complain about this, but this is not the first time I 
review your patches and make comment, and see the previous series in PR 
and my comment ignored.

There are (paid) reviewers working in about every timezones, also note 
that some hobbyist might only have time during week-ends.

I don't know if they are guidelines for that. 24h could work.

Maybe you can answer 'Applied' to the series you take, so people 
interested won't spend time reviewing.

Regards,

Phil.

> 
> ----------------------------------------------------------------
> MIPS queue for October 2018, part 5
> 
>    - some cleanup of R5900 support
> ----------------------------------------------------------------
> Aleksandar Markovic (5):
>    target/mips: Rename MMI-related masks
>    target/mips: Rename MMI-related opcodes
>    target/mips: Rename MMI-related functions
>    target/mips: Remove some spurious R5900-related comments
>    target/mips: Enable only tested modes for R5900
> 
>   target/mips/translate.c          | 533 ++++++++++++++++++++-------------------
>   target/mips/translate_init.inc.c |  16 +-
>   2 files changed, 271 insertions(+), 278 deletions(-)
> 
