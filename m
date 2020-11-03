Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2294C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2099522226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2099522226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZqlf-00046W-1V
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 02:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kZqka-0003d1-IC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:29:04 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kZqkY-0001Ld-Kp
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 02:29:04 -0500
Received: from [192.168.100.1] ([82.252.154.198]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYNS0-1kniWV14Uc-00VSeV; Tue, 03 Nov 2020 08:28:53 +0100
Subject: Re: [PULL 1/1] linux-user: Support futex_time64
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200330102945.2388294-1-laurent@vivier.eu>
 <20200330102945.2388294-2-laurent@vivier.eu>
 <CAFEAcA97s+jiZxH+ObdFeFgs7-Wub6XjZvJFmL2s4voRrny38Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a1fd7792-b7fa-6e86-4a24-b53fb7ecac0f@vivier.eu>
Date: Tue, 3 Nov 2020 08:28:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA97s+jiZxH+ObdFeFgs7-Wub6XjZvJFmL2s4voRrny38Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YYJAZyr4FVkxIYNyjJTNvFfSlSOqYRBmT9wRJBr0+JIKwzKCu+w
 ni9HKEeQ4cte3We891xs2Mo2U+wRiQO1trlIvBOaU2tQwIg0XLSv6HunaXI9QPBTx3KmM5R
 U0cEahsQG4licIrlwkvZWJV+lpgV0nPNowKGyzZQEIsIDx+ux3UWUPKWPe/D/jsGiDgOMIO
 u2RDZ0mjW9QuQ4ZdL4t7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OWw9Yr/Xd/A=:wQF52cZByB20pzo4Sa/s/j
 XGmeTKWPSx22pyVjlFeO7e34FdRFHTI2I6WpmRXMN5DTBM76yxzPYGdfQ89jNrfl0Q5t6mAv6
 boZfYzp6kkImVYVu1LGevg2qGKnM/v9Gc1Wy1hVG2HQUSTXQxi8zBuIDMyY/ofMO0R/ZcXP8j
 Rw8SQm2ONxKpWW56qpaKE3dMODr13wtqdT9E2HBgMSOJ+TeUSFOjdo1LHwvJ0eplZxEN/m/dW
 JO8QVGgZDj8qQOU3/xqRsiQj9YeNhqpCgVBkTK4D50tnb5v8UHEa8Kpp/5v60G/dK6BijLJ6S
 mKK5QkN8uHXwUS5cFVQVUkiyxtVroA2cVbbUjP1OFHS2+zRVMcW1umJQJfLMWCtfaOPz+jBEI
 rCcZrqzVabsNKfyd6Z5+Ajdc3IjsTstNYIad2/v1M62UgocWTbdqsknbJqleo/22tVNpEI7NB
 MEL4zyB4Ow==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 02:28:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/11/2020 à 19:15, Peter Maydell a écrit :
> On Mon, 30 Mar 2020 at 11:31, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> From: Alistair Francis <alistair.francis@wdc.com>
>>
>> Add support for host and target futex_time64. If futex_time64 exists on
>> the host we try that first before falling back to the standard futex
>> syscall.
> 
> Hi; I dunno why Coverity's only just noticed this, but in
> CID 1432339 it points out:
> 
>> +#if defined(TARGET_NR_futex_time64)
>> +static int do_futex_time64(target_ulong uaddr, int op, int val, target_ulong timeout,
>> +                           target_ulong uaddr2, int val3)
>> +{
>> +    struct timespec ts, *pts;
>> +    int base_op;
>> +
>> +    /* ??? We assume FUTEX_* constants are the same on both host
>> +       and target.  */
>> +#ifdef FUTEX_CMD_MASK
>> +    base_op = op & FUTEX_CMD_MASK;
>> +#else
>> +    base_op = op;
>> +#endif
>> +    switch (base_op) {
>> +    case FUTEX_WAIT:
>> +    case FUTEX_WAIT_BITSET:
>> +        if (timeout) {
>> +            pts = &ts;
>> +            target_to_host_timespec64(pts, timeout);
> 
> ...that here we call target_to_host_timespec64(), which can
> fail with -TARGET_EFAULT, but (unlike all the other times we call
> the function) we aren't checking its return value.
> Is there missing error handling code here ?
> 

I think the code is like that because this is a cut&paste of function
do_futex() witl "s/timespec/timespec64/".

And yes I think we should check for the return value.
I'm going to fix that.

Thanks,
Laurent

