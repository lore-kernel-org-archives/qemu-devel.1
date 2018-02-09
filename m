Received: from eggs.gnu.org ([2001:4830:134:3::10]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek5aC-0005AY-NN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:07:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek5aB-0003EP-S4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:07:04 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ek5aB-0003E8-Lw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 05:07:03 -0500
Received: by mail-oi0-x241.google.com with SMTP id j15so5739698oii.5
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 02:07:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2018 10:06:42 +0000
Message-ID: <CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
 fixes and cleanups
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

On 8 February 2018 at 19:08, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c96:
>
>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-02-08 14:31:51 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to f4ac9b2e04e8d98854a97bc473353207765aa9e7:
>
>   virtio-balloon: include statistics of disk/file caches (2018-02-08 21:06:42 +0200)
>
> ----------------------------------------------------------------
> virtio,vhost,pci,pc: features, fixes and cleanups
>
> - a new vhost crypto device
> - new stats in virtio balloon
> - virtio eventfd rework for boot speedup
> - vhost memory rework for boot speedup
> - fixes and cleanups all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Hi. This has some format-string issues:

/home/peter.maydell/qemu/backends/cryptodev-vhost-user.c: In function
'cryptodev_vhost_user_start':
/home/peter.maydell/qemu/backends/cryptodev-vhost-user.c:112:26:
error: format '%lu' expects argument of type 'long unsigned int', but
argument 2 has type 'size_t {aka unsigned int}' [-Werror=format=]
             error_report("failed to init vhost_crypto for queue %lu", i);
                          ^
/home/peter.maydell/qemu/backends/cryptodev-vhost-user.c: In function
'cryptodev_vhost_user_init':
/home/peter.maydell/qemu/backends/cryptodev-vhost-user.c:205:40:
error: format '%lu' expects argument of type 'long unsigned int', but
argument 2 has type 'size_t {aka unsigned int}' [-Werror=format=]
         cc->info_str = g_strdup_printf("cryptodev-vhost-user%lu to %s ",
                                        ^

thanks
-- PMM
