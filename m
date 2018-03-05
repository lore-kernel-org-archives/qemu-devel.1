Received: from eggs.gnu.org ([2001:4830:134:3::10]:38653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esrr0-0006tf-1w
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esrqz-0000zg-4y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:16:42 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:40534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esrqy-0000zJ-Vr
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:16:41 -0500
Received: by mail-ot0-x22b.google.com with SMTP id l12so15210643otj.7
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 07:16:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
References: <1520219524-17160-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 15:16:20 +0000
Message-ID: <CAFEAcA8t9Ne7MdQ6ROY+nH-ObfGWmO16+70gZ6nN_JOozN9GtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Net patches
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

On 5 March 2018 at 03:11, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:
>
>   Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 46d4d36d0bf2b24b205f2f604f0905db80264eef:
>
>   tap: setting error appropriately when calling net_init_tap_one() (2018-03-05 10:30:16 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Jay Zhou (1):
>       tap: setting error appropriately when calling net_init_tap_one()
>
> Thomas Huth (8):
>       net: Move error reporting from net_init_client/netdev to the calling site
>       net: List available netdevs with "-netdev help"
>       net: Only show vhost-user in the help text if CONFIG_POSIX is defined
>       net: Make net_client_init() static
>       net: Remove the deprecated way of dumping network packets
>       net: Remove the deprecated 'host_net_add' and 'host_net_remove' HMP commands
>       net: Add a new convenience option "--nic" to configure default/on-board NICs
>       hw/net: Remove unnecessary header includes
>

Applied, thanks.

-- PMM
