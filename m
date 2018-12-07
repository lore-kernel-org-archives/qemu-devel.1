Received: from eggs.gnu.org ([2001:4830:134:3::10]:48667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gV5th-0004n5-Fj
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gV5tg-0006L0-RL
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 21:29:45 -0500
References: <20181206151401.13455-1-peter.maydell@linaro.org>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <4c74e17a-840b-e1d9-6dac-71f64a190945@huawei.com>
Date: Fri, 7 Dec 2018 10:29:24 +0800
MIME-Version: 1.0
In-Reply-To: <20181206151401.13455-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] arm: Allow system registers for KVM guests
 to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2018/12/6 23:14, Peter Maydell wrote:
> ---
> I think this patch:
>  * should be necessary for the current KVM debug code to be able
>    to actually set the ESR_EL1 for the guest when it wants to
>    deliver a breakpoint exception to it
>  * will also be necessary for Dongjiu's patchset to inject
>    external aborts on memory errors
> 
> I have tagged it "RFC" because I don't have a setup to test
> that; I've just given it a quick smoke test that it runs a
> VM OK. Please test this and check whether it really does
> fix the bugs I think it does :-)

Great! thanks Peter follow up this issue and patch to fix it.
I will test it and give response.

> 
> Opinions welcome on whether the "try the write-and-read-back"
> approach in write_cpustate_to_list() is too hacky and it
> would be better to actually record whether write_list_to_cpustate()
> succeeded for each register. (That would require another array.)
