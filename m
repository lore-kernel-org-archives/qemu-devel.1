Received: from eggs.gnu.org ([2001:4830:134:3::10]:56043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW3f3-0004e2-Pt
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW3f3-0006mO-2I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:41:49 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW3f2-0006mC-RP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:41:48 -0400
Received: by mail-wm0-x236.google.com with SMTP id 62so25308107wmw.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:41:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4B913392-333F-455D-817E-46A1DE88FC6B@skyportsystems.com>
References: <1500046217-24597-1-git-send-email-mst@redhat.com>
	<4B913392-333F-455D-817E-46A1DE88FC6B@skyportsystems.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 17:41:27 +0100
Message-ID: <CAFEAcA9+CMk_xL3iwmeKoyFqHepdr6=cSycV8zVkRX3v30vrBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] vmgenid-test: use boot-sector
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On 14 July 2017 at 16:49, Ben Warren <ben@skyportsystems.com> wrote:
> Hi Michael,
>
> Looks good.  Thanks for taking care of this.
>
> On Jul 14, 2017, at 8:30 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> There's no requirement for RSDP to be installed last
> by the firmware, so in rare cases vmgen id test hits
> a race: RSDP is there but VM GEN ID isn't.
>
> To fix, switch to common boot sector infrastructure.
>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Ben Warren <ben@skyportsystems.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> Reviewed-by: Ben Warren <ben@skyportsystems.com>

Thanks; applied to master as a buildfix.

-- PMM
