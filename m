Received: from eggs.gnu.org ([2001:4830:134:3::10]:37268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUiG-0001t8-Sm
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHUiF-0002pS-WB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:09:44 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:43208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHUiF-0002eq-D3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:09:43 -0400
Received: by mail-ot1-x332.google.com with SMTP id k9so11165107otl.10
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:09:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181029200250.24029-1-kraxel@redhat.com>
References: <20181029200250.24029-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 14:09:07 +0000
Message-ID: <CAFEAcA9mgLPs1F9WB0iZgXdDfFqVhVWoTREGqhweLtDQY5EA7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20181029 patches
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

On 29 October 2018 at 20:02, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20181029-pull-request
>
> for you to fetch changes up to 7dea29e4af17fc1d27478de9f8ea38144deac54a:
>
>   hw: ccid-card-emulated: cleanup resource when realize in error path (2018-10-29 10:46:07 +0100)
>
> ----------------------------------------------------------------
> usb: fixes for ohci and smart card emulation.
>
> ----------------------------------------------------------------
>
> Li Qiang (3):
>   usb: ohci: make num_ports to an unsinged integer
>   hw: ccid-card-emulated: introduce clean_event_notifier
>   hw: ccid-card-emulated: cleanup resource when realize in error path
>
>  hw/usb/ccid-card-emulated.c | 27 +++++++++++++++++++++------
>  hw/usb/hcd-ohci.c           |  6 +++---
>  2 files changed, 24 insertions(+), 9 deletions(-)

Applied, thanks.

-- PMM
