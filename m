Received: from eggs.gnu.org ([2001:4830:134:3::10]:34325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1de2J0-0007Tw-HG
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 12:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1de2Iz-0005GV-5m
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 12:52:02 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:38016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1de2Iy-0005Ez-Ug
	for qemu-devel@nongnu.org; Sat, 05 Aug 2017 12:52:01 -0400
Received: by mail-wr0-x233.google.com with SMTP id f21so26083603wrf.5
	for <qemu-devel@nongnu.org>; Sat, 05 Aug 2017 09:52:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170805010622.GZ4859@toto>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-3-git-send-email-peter.maydell@linaro.org>
	<20170805010622.GZ4859@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 5 Aug 2017 17:51:38 +0100
Message-ID: <CAFEAcA-nx-zUa8zJv3dz9UiYg9oUQQpg8gSCYLahnY4xT_9Vpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/8] cpu: Define new
 cpu_transaction_failed() hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 5 August 2017 at 02:06, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Fri, Aug 04, 2017 at 06:20:43PM +0100, Peter Maydell wrote:
>> @@ -85,8 +85,10 @@ struct TranslationBlock;
>>   * @has_work: Callback for checking if there is work to do.
>>   * @do_interrupt: Callback for interrupt handling.
>>   * @do_unassigned_access: Callback for unassigned access handling.
>> + * (this is deprecated: new targets should use do_transaction_failed instead)
>>   * @do_unaligned_access: Callback for unaligned access handling, if
>>   * the target defines #ALIGNED_ONLY.
>> + * @do_transaction_failed: Callback for handling failed memory transactions
>
> Looks OK but I wonder if there you might want to clarify that this is a
> bus/slave failure and not a failure within the CPU (e.g not an MMU fault).

Yes, we could add
"(ie bus faults or external aborts; not MMU faults)"
just to clarify.

thanks
-- PMM
