Received: from eggs.gnu.org ([2001:4830:134:3::10]:49045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHw4-0005KY-5t
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHw3-0002JH-E6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:03:32 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHw3-0002J0-8a
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:03:31 -0400
Received: by mail-oi0-x242.google.com with SMTP id w126-v6so7828201oie.7
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 06:03:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534420566-15799-1-git-send-email-thuth@redhat.com>
References: <1534420566-15799-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:03:10 +0100
Message-ID: <CAFEAcA_pdycNxCqxKArO-PV6O9WBLob5f8iry_iJ4g-yP-MQYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/mps2-tz: Replace
 init_sysbus_child() with sysbus_init_child_obj()
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

On 16 August 2018 at 12:56, Thomas Huth <thuth@redhat.com> wrote:
> Now that we've got the common sysbus_init_child_obj() function, we do
> not need the local init_sysbus_child() anymore.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to target-arm.next, thanks. (Might end up with some
textual conflicts with the various not-yet-reviewed MPS2
patches I have on-list, but I'll fix those up as I apply those.)

thanks
-- PMM
