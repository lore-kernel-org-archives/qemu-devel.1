Received: from eggs.gnu.org ([2001:4830:134:3::10]:55012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXOuN-0008Tf-Td
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXOuM-0007XJ-Qq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:11 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXOuM-0007Vv-Kb
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:35:10 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 12so20576499wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 02:35:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 10:34:47 +0100
Message-ID: <CAFEAcA9PXMb2yDfwS_w62Am0OrHBg6qbqjFTNU=5x_ajagTx-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Net patches
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

On 17 July 2017 at 13:21, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 6632f6ff96f0537fc34cdc00c760656fc62e23c5:
>
>   Merge remote-tracking branch 'remotes/famz/tags/block-and-testing-pull-request' into staging (2017-07-17 11:46:36 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 189ae6bb5ce1f5a322f8691d00fe942ba43dd601:
>
>   virtio-net: fix offload ctrl endian (2017-07-17 20:13:56 +0800)
>
> ----------------------------------------------------------------
>
> - fix virtio-net ctrl offload endian
> - vnet header support for variou COLO netfilters and compare thread
>
> ----------------------------------------------------------------
> Jason Wang (1):
>       virtio-net: fix offload ctrl endian
>
> Michal Privoznik (1):
>       virtion-net: Prefer is_power_of_2()
>
> Zhang Chen (12):
>       net: Add vnet_hdr_len arguments in NetClientState
>       net/net.c: Add vnet_hdr support in SocketReadState
>       net/filter-mirror.c: Introduce parameter for filter_send()
>       net/filter-mirror.c: Make filter mirror support vnet support.
>       net/filter-mirror.c: Add new option to enable vnet support for filter-redirector
>       net/colo.c: Make vnet_hdr_len as packet property
>       net/colo-compare.c: Introduce parameter for compare_chr_send()
>       net/colo-compare.c: Make colo-compare support vnet_hdr_len
>       net/colo.c: Add vnet packet parse feature in colo-proxy
>       net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
>       net/filter-rewriter.c: Make filter-rewriter support vnet_hdr_len
>       docs/colo-proxy.txt: Update colo-proxy usage of net driver with vnet_header

Applied, thanks.

-- PMM
