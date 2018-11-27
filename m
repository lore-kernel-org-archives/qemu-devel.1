Received: from eggs.gnu.org ([2001:4830:134:3::10]:33858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRkSg-0008MA-1J
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:00:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRkSf-0007Mz-3L
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:00:01 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRkSe-0007Mh-U8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:00:01 -0500
Received: by mail-ot1-x342.google.com with SMTP id 32so21440633ota.12
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20181127084143.1113-1-armbru@redhat.com>
In-Reply-To: <20181127084143.1113-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 20:59:48 +0000
Message-ID: <CAFEAcA8unXASA_hqZpqT12Ruv31ySnXakuBSVrEc7GTLFcPLYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] vfio-helpers: Fix
 qemu_vfio_open_pci() crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, Paolo Bonzini <pbonzini@redhat.com>, coli@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 27 Nov 2018 at 08:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> qemu_vfio_open_common() initializes s->lock only after passing s to
> qemu_vfio_dma_map() via qemu_vfio_init_ramblock().
> qemu_vfio_dma_map() tries to lock the uninitialized lock and crashes.
>
> Fix by initializing s->lock first.
>
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1645840
> Fixes: 418026ca43bc2626db092d7558258f9594366f28
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> Compile-tested only, as I lack suitable hardware.  Cong Li (cc'ed) is
> going to test it for real.  It looks obvious enough to me to put it
> into -rc3 without waiting for the test results.  We can also wait and
> put it into -rc4.
>
>  util/vfio-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks (for rc3).

-- PMM
