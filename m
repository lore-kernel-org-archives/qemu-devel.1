Received: from eggs.gnu.org ([2001:4830:134:3::10]:33991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLtRn-0008AN-2x
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cLtRm-0007AV-9w
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:13:51 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:34918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cLtRm-0007AL-1z
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:13:50 -0500
Received: by mail-vk0-x22c.google.com with SMTP id y197so62220731vky.2
	for <qemu-devel@nongnu.org>; Tue, 27 Dec 2016 07:13:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161220153103.mkhz74wlkr3dfrxt@kamzik.brq.redhat.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-2-git-send-email-peter.maydell@linaro.org>
	<20161220153103.mkhz74wlkr3dfrxt@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:13:28 +0000
Message-ID: <CAFEAcA_jCajsMbkjZe6WO2-x+TpOJxpPBDYt3kaZR3+MTZKDug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 01/23] target-arm: Log AArch64 exception
 returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Christoffer Dall <christoffer.dall@linaro.org>, "patches@linaro.org" <patches@linaro.org>

On 20 December 2016 at 15:31, Andrew Jones <drjones@redhat.com> wrote:
> Should we output both the destination PC (ELR) and the source PC (where
> the eret was)? Otherwise if there are many erets to the same entry point,
> then the logs won't fully enlighten us.

We don't really conveniently have the source PC, because it isn't
written out to env->pc at the point when this helper function
is called (the calling code in translate-a64.c doesn't call
gen_a64_set_pc(), because it knows the helper doesn't need to
care about the PC value).

thanks
-- PMM
