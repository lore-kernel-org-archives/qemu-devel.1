Received: from eggs.gnu.org ([2001:4830:134:3::10]:35396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIaSy-0007RG-4Q
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIaSx-0001Zu-D0
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:58:12 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIaSx-0001ZX-8U
	for qemu-devel@nongnu.org; Tue, 15 May 2018 09:58:11 -0400
Received: by mail-ot0-x244.google.com with SMTP id l22-v6so293088otj.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 06:58:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515094332.4907-1-kraxel@redhat.com>
References: <20180515094332.4907-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 14:57:49 +0100
Message-ID: <CAFEAcA-g9DprkBb74Ppt3=E_qxJiZKnZWJoFRJm8_74oAVGvTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Input 20180515 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 May 2018 at 10:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit fbd3a489df9953e2a5d017c922f3c103b2426952:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180514' into staging (2018-05-14 18:53:42 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20180515-pull-request
>
> for you to fetch changes up to 7abe7eb29494b4e4a11ec99ae5623083409a2f1e:
>
>   ps2: Fix mouse stream corruption due to lost data (2018-05-15 11:31:33 +0200)
>
> ----------------------------------------------------------------
> input: ps2 fixes.
>
> ----------------------------------------------------------------
>
> Geoffrey McRae (2):
>   ps2: Clear the PS/2 queue and obey disable
>   ps2: Fix mouse stream corruption due to lost data
>
>  include/hw/input/ps2.h |   5 ++
>  hw/input/ps2.c         | 135 ++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 111 insertions(+), 29 deletions(-)
>

Applied, thanks.

-- PMM
