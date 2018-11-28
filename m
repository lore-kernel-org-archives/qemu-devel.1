Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRvbP-0003ij-4C
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRvbM-0000To-GV
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:53:47 -0500
References: <20181119110757.2692-1-ppandit@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76e37406-4268-5f3e-2666-82eb5ef4dd45@redhat.com>
Date: Wed, 28 Nov 2018 09:53:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181119110757.2692-1-ppandit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] bt: use size_t type for length
 parameters instead of int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Arash TC <tohidi.arash@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-stable@nongnu.org

On 2018-11-19 12:07, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> The length parameter values are not negative, thus use an unsigned
> type 'size_t' for them. Many routines pass 'len' values to memcpy(3)
> calls. If it was negative, it could lead to memory corruption issues.
> Add check to avoid it.
> 
> Reported-by: Arash TC <tohidi.arash@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  bt-host.c              |  8 +++---
>  bt-vhci.c              |  7 +++---
>  hw/bt/core.c           |  2 +-
>  hw/bt/hci-csr.c        | 32 ++++++++++++------------
>  hw/bt/hci.c            | 38 ++++++++++++++--------------
>  hw/bt/hid.c            | 10 ++++----
>  hw/bt/l2cap.c          | 56 ++++++++++++++++++++++--------------------
>  hw/bt/sdp.c            |  6 ++---
>  hw/usb/dev-bluetooth.c | 12 ++++-----
>  include/hw/bt.h        |  8 +++---
>  include/sysemu/bt.h    | 10 ++++----
>  11 files changed, 96 insertions(+), 93 deletions(-)
> 
> Update v2: modify assert calls
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg01036.html

Reviewed-by: Thomas Huth <thuth@redhat.com>

Even though it's a rather big patch, I think the changes are trivial
enough so that it could go via qemu-trivial (now on CC:). If not, maybe
Paolo could take it through his "misc" tree?

 Thomas
