Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddZZ-0001Rz-9Y
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eddZY-0007hf-Gz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:59:45 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eddZY-0007hO-CV
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:59:44 -0500
Received: by mail-ot0-x233.google.com with SMTP id f100so7682958otf.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 06:59:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHXHxSH4LxSu0Jjug5hy1FhMYF-O2FtYbjpnm68VjTDpA@mail.gmail.com>
References: <20180113113445.2705-1-jcd@tribudubois.net>
	<CAFEAcA_epX=BOj5sxNVB2z-k3wQ+RRAry=OQi2b=i0d9pJaSeA@mail.gmail.com>
	<CAHQ1cqHXHxSH4LxSu0Jjug5hy1FhMYF-O2FtYbjpnm68VjTDpA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 14:59:23 +0000
Message-ID: <CAFEAcA-XKE=KkOdT62i3VdU=pfQZq7D9KRHNQFjn4Ei_EdpPoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] i.MX: Fix FEC/ENET receive funtions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, fyleo45@gmail.com, qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>

On 22 January 2018 at 14:54, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Mon, Jan 22, 2018 at 3:48 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 13 January 2018 at 11:34, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>>> The actual imx_eth_enable_rx() function is buggy.
>>>
>>> It updates s->regs[ENET_RDAR] after calling qemu_flush_queued_packets().
>>>
>>> qemu_flush_queued_packets() is going to call imx_XXX_receive() which itself
>>> is going to call imx_eth_enable_rx().
>>>
>>> By updating s->regs[ENET_RDAR] after calling qemu_flush_queued_packets()
>>> we end up updating the register with an outdated value which might
>>> lead to disabling the receive function in the i.MX FEC/ENET device.
>>>
>>> This patch change the place where the register update is done so that the
>>> register value stays up to date and the receive function can keep
>>> running.
>>>
>>> Reported-by: Fyleo <fyleo45@gmail.com>
>>> Tested-by: Fyleo  <fyleo45@gmail.com>
>>> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
>>> ---
>>
>> Andrey, do you have an opinion on this patch, since you've been
>> looking at i.MX code recently?
>>
>
> The rationale makes sense to me and patch looks like a good cleanup in
> general, so FWIW:
>
> Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>
> I also gave it a spin against my i.MX7 changes with doing basic things
> like ping and scp of 1GB file, so I can give my:
>
> Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Thanks; I've applied the patch to target-arm.next.

-- PMM
