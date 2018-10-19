Received: from eggs.gnu.org ([2001:4830:134:3::10]:40284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDWX2-0003Ro-De
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDWWz-0000Q3-RM
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:17:44 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:40477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDWWz-0000MD-L6
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:17:41 -0400
Received: by mail-ot1-x32f.google.com with SMTP id w67so33507219ota.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:17:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
References: <1539919345-10703-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 16:17:18 +0100
Message-ID: <CAFEAcA85Lruwc8gbX6vVbzMwci-p5-o1=b9B-WRaGs2N7AqC8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL V2 00/26] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2018 at 04:21, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 37a4442a76d010f5d957e3ee09dfb23364281b37:
>
>   qemu-options: Fix bad "macaddr" property in the documentation (2018-10-19 11:15:04 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Jason Wang (5):
>       ne2000: fix possible out of bound access in ne2000_receive
>       rtl8139: fix possible out of bound access
>       pcnet: fix possible buffer overflow
>       net: ignore packet size greater than INT_MAX
>       e1000: indicate dropped packets in HW counters
>
> Thomas Huth (1):
>       qemu-options: Fix bad "macaddr" property in the documentation
>
> Zhang Chen (15):
>       filter-rewriter: Add TCP state machine and fix memory leak in connection_track_table
>       colo-compare: implement the process of checkpoint
>       colo-compare: use notifier to notify packets comparing result
>       COLO: integrate colo compare with colo frame
>       COLO: Add block replication into colo process
>       COLO: Remove colo_state migration struct
>       COLO: Load dirty pages into SVM's RAM cache firstly
>       ram/COLO: Record the dirty pages that SVM received
>       COLO: Flush memory data from ram cache
>       qapi/migration.json: Rename COLO unknown mode to none mode.
>       qapi: Add new command to query colo status
>       savevm: split the process of different stages for loadvm/savevm
>       filter: Add handle_event method for NetFilterClass
>       filter-rewriter: handle checkpoint and failover event
>       docs: Add COLO status diagram to COLO-FT.txt
>
> liujunjie (1):
>       clean up callback when del virtqueue
>
> zhanghailiang (4):
>       qmp event: Add COLO_EXIT event to notify users while exited COLO
>       COLO: flush host dirty ram from cache
>       COLO: notify net filters about checkpoint/failover event
>       COLO: quick failover process by kick COLO thread
>

Applied, thanks.

-- PMM
