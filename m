Received: from eggs.gnu.org ([2001:4830:134:3::10]:45567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZHa2-00075g-1E
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gZHZv-0002sb-FZ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:46:45 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gZHZu-0002rc-Nu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:46:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so16399457wra.6
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:46:38 -0800 (PST)
References: <20181214201855.14476-1-richard.henderson@linaro.org>
	<87k1k8gic7.fsf@linaro.org>
	<32f6ded3-4dc8-7d3f-b68b-741528433380@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <32f6ded3-4dc8-7d3f-b68b-741528433380@linaro.org>
Date: Tue, 18 Dec 2018 15:46:35 +0000
Message-ID: <87r2eeald0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/arm: Convert ARM_TBFLAG_* to FIELDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/17/18 9:43 AM, Alex Benn=C3=A9e wrote:
>>> Use "register" TBFLAG_ANY to indicate shared state between
>>> A32 and A64, and "registers" TBFLAG_A32 & TBFLAG_A64 for
>>> fields that are specific to the given cpu state.
>>>
>>> Move ARM_TBFLAG_BE to shared state, instead of its current
>>> placement within "Bit usage when in AArch32 state".
>>
>> This looks like a worthwhile clean-up but really we need to defer this
>> calculation. It's in the top 2 hot functions on my build load stressor:
>>
>>    5.74%  qemu-system-aarch64      [.] helper_lookup_tb_ptr
>>    5.05%  qemu-system-aarch64      [.] get_phys_addr_lpae
>>    4.39%  qemu-system-aarch64      [.] cpu_get_tb_cpu_state
>>    3.73%  qemu-system-aarch64      [.] tcg_gen_code
>>    3.65%  qemu-system-aarch64      [.] qht_lookup_custom
>
> Yes, I know.  We need to put on our thinking caps and come up with a sche=
me
> that minimizes the chances of missing an update to any (partially) pre-co=
mputed
> value.
>
> That has been Peter's (legitimate) resistance to such a scheme so far.  T=
here
> are a *lot* of variables that go into computing tb->flags.
>
> In the meantime this patch just makes the task of adding bits less
> ugly.

I'm having all sorts of trouble applying this patch - have you got a
commit I can reference?

--
Alex Benn=C3=A9e
