Received: from eggs.gnu.org ([2001:4830:134:3::10]:38652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMvUq-0004Ov-WC
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMvUq-0003kd-AR
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:37:17 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:34812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cMvUq-0003kT-6e
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 06:37:16 -0500
Received: by mail-vk0-x233.google.com with SMTP id x186so241431914vkd.1
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 03:37:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
References: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Dec 2016 11:36:55 +0000
Message-ID: <CAFEAcA8Ys-TcdJyaNLY0PzB-Mp0QEKJ-xYk54iL_KRs=_NzviA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 29 December 2016 at 17:24, Programmingkid <programmingkidx@gmail.com> wrote:
> Programs running inside of QEMU can sometimes use more CPU time than is really
> needed. To solve this problem, we just need to throttle the virtual CPU. This
> feature will stop laptops from burning up.
>
> This patch adds a menu called Speed that has menu items from 10 to 1. They
> represent the speed options. 10 is full speed and 1 is slowest.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>

I don't want to take new features into the Cocoa UI that don't
already exist in any of QEMU's other UI frontends, I'm afraid.

thanks
-- PMM
