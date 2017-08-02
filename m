Received: from eggs.gnu.org ([2001:4830:134:3::10]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcqbB-0008AZ-Ds
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcqbA-0003lW-MN
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:09:53 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcqbA-0003hw-EW
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:09:52 -0400
Received: by mail-wm0-x232.google.com with SMTP id t201so37068726wmt.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 03:09:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Aug 2017 11:09:29 +0100
Message-ID: <CAFEAcA-DTfWsTZVPTceqWTxup=J7ab+=rZ7=KvzJm8LvFQd8Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] pc, acpi, virtio: fixes,
 test speedup for rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 August 2017 at 22:37, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 7d48cf8102a10e4a54333811bafb5eb566509268:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-08-01 14:33:56 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 3a3fcc75f92ab0d71ba0e7511af7dc575c4b4f6c:
>
>   pc: acpi: force FADT rev1 for 440fx based machine types (2017-08-02 00:13:26 +0300)
>
> ----------------------------------------------------------------
> pc, acpi, virtio: fixes, test speedup for rc1
>
> Some fixes all over the place. Notably vhost-user gained a new message
> to set endian-ness. Borderline for 2.10 but seems to be the only way to
> fix legacy guests.  Also pc tests are run on kvm now. Not a fix at all
> but doesn't touch qemu itself, so I merged it since I had to run these a
> lot and I just got tired of waiting for these to finish.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks.

-- PMM
