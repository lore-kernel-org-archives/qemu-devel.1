Received: from eggs.gnu.org ([2001:4830:134:3::10]:56823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff3j6-0000OG-6U
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff3j5-0005Ue-BY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:39:44 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff3j5-0005Tm-4T
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:39:43 -0400
Received: by mail-oi0-x244.google.com with SMTP id r16-v6so74840640oie.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:39:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531415537-26037-1-git-send-email-thuth@redhat.com>
References: <1531415537-26037-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:39:22 +0100
Message-ID: <CAFEAcA9_TrSTrcHBGS1mAd0-w2VSQ0AP3z=EPM_U3dTF3k_R1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm2836: Mark the bcm2836 / bcm2837
 devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 July 2018 at 18:12, Thomas Huth <thuth@redhat.com> wrote:
> These devices are currently causing some problems when a user is trying
> to hot-plug or introspect them during runtime. Since these devices can
> not be instantiated by the user at all (they need to be wired up in code
> instead), we should mark them with user_creatable = false anyway, then we
> avoid at least the crashes with the hot-plugging. The introspection problem
> will be handled by a separate patch.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

I thought we'd changed things so all sysbus devices defaulted
to not-user-createable? Am I confusing that with something else?
(The set of user-creatable sysbus devices must be very small...)

thanks
-- PMM
