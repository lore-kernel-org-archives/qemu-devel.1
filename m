Received: from eggs.gnu.org ([2001:4830:134:3::10]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5swr-0000gC-QJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5swn-0008Lt-RO
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:04:33 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:46983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5swn-0008Lj-MY
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:04:29 -0400
Received: by mail-ot0-x242.google.com with SMTP id v64-v6so12597202otb.13
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:04:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523331602-18781-1-git-send-email-jasowang@redhat.com>
References: <1523331602-18781-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 14:04:08 +0100
Message-ID: <CAFEAcA_a3fHAcMJfckd3GiTg+cvuosh1EDisqViFmRNBpWAS_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Net patches
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

On 10 April 2018 at 04:39, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 915d34c5f99b0ab91517c69f54272bfdb6ca2b32:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-04-09 17:29:10 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 5f523530915e57a14ffb8c00e22252bfa557441c:
>
>   e1000: Old machine types, turn new subsection off (2018-04-10 11:30:04 +0800)
>
> ----------------------------------------------------------------
>
> A series from David that switches to use subsection instead of version
> bumping for e1000 to keep migration compatibility for old
> versions. This will ease the downstream maintaining.
>
> Please merge.
>
> Thanks
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (6):
>       e1000: Convert v3 fields to subsection
>       e1000: Dupe offload data on reading old stream
>       e1000: wire new subsection to property
>       e1000: Migrate props via a temporary structure
>       e1000: Choose which set of props to migrate
>       e1000: Old machine types, turn new subsection off
>
>  hw/net/e1000.c      | 103 ++++++++++++++++++++++++++++++++++++++++------------
>  include/hw/compat.h |   4 ++
>  2 files changed, 84 insertions(+), 23 deletions(-)

Applied, thanks.

-- PMM
