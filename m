Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcqkR-0002TB-Vs
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcqkR-0005k1-0C
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:23:59 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:32949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcqkQ-0005jp-PR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 07:23:58 -0400
Received: by mail-oi0-x244.google.com with SMTP id c6-v6so41915968oiy.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 04:23:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7fafbf1c-9af1-cfb9-24c7-ee9a00ef9d4e@linaro.org>
References: <20180709124535.1116-1-peter.maydell@linaro.org>
	<7fafbf1c-9af1-cfb9-24c7-ee9a00ef9d4e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 12:23:37 +0100
Message-ID: <CAFEAcA_F03w0REiTrT-Xi5cGcBtnv5m3RK4f6QvU+bufSEhb7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] target/arm: Use correct mmu_idx
 for exception-return unstacking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Adithya Baglody <adithya.nagaraj.baglody@intel.com>, "patches@linaro.org" <patches@linaro.org>

On 9 July 2018 at 15:30, Richard Henderson <richard.henderson@linaro.org> wrote:
> On 07/09/2018 05:45 AM, Peter Maydell wrote:
>> For M-profile exception returns, the mmu index to use for exception
>> return unstacking is supposed to be that of wherever we are returning to:
>>  * if returning to handler mode, privileged
>>  * if returning to thread mode, privileged or unprivileged depending on
>>    CONTROL.nPRIV for the destination security state
>>
>> We were passing the wrong thing as the 'priv' argument to
>> arm_v7m_mmu_idx_for_secstate_and_priv(). The effect was that guests
>> which programmed the MPU to behave differently for privileged and
>> unprivileged code could get spurious MemManage Unstack exceptions.
>>
>> Reported-by: Adithya Baglody <adithya.nagaraj.baglody@intel.com>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/helper.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; applied to master for 3.0-rc0.

-- PMM
