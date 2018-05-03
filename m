Received: from eggs.gnu.org ([2001:4830:134:3::10]:49650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDXh-0005fA-Dx
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDXg-00031X-Hb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:41:01 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:44882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEDXg-00031I-CY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:41:00 -0400
Received: by mail-oi0-x22d.google.com with SMTP id e80-v6so15893283oig.11
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 05:41:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180501184933.37609-1-mathew1800@gmail.com>
References: <20180501184933.37609-1-mathew1800@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 13:40:39 +0100
Message-ID: <CAFEAcA_cq+1YPWqJD3UmEk4OL8yn=eU7Eo2Ab3tNWiGRBoQ44w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1] target/arm: Correct MPUIR PL setting
 in register_cp_regs_for_features()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mathew Maidment <mathew1800@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 May 2018 at 19:49, Mathew Maidment <mathew1800@gmail.com> wrote:
> Hey there! This is my first time sending a patch via a mailing list so
> hopefully I didn't bungle this up *too* badly.
>
> Mat
>
> Mathew Maidment (1):
>   target/arm: Correct MPUIR privilege level in
>     register_cp_regs_for_features()
>
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi -- thanks for this patch! It all looks good and I have added
it to my target-arm.next queue. (I made a minor edit to
the commit message to note that this bug only affected
OMAP and StrongARM cores.)

-- PMM
