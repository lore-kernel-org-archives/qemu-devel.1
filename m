Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5A8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A0D2084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A0D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDnDR-00027D-Uy
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:38:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDnCR-0001eq-5m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDnCP-0005Hg-L1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:37:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDnCP-0005G1-92
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:37:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so19955034wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 02:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qvADDrWX5bZugPG44iMbzSoIiAOjPAdyGGl39TnlEXg=;
	b=Dm6CzOZxs9uCWjOgsBU/54/LLIAww7xGVTz+uUNb7Fr9w4vnCPxrGD73Ow2pGRHShG
	C21v+bfFzlCRr78A6RiBQexeV6m69auOiuoBj4pYixqVuSgs7o9XAMwZPriUTvQAcym4
	XaHbjAH9Lqoaxg8lsFw8VhrjvC8zNTr3BidwFYKWXBQQldUYzS4+RX4SXROeP+PHUpA1
	11zYxB1T5NeUoqmK8uUEjPsJALeZ4Z/+dnIVp1e6UvyqXyP6c5R5oyie+KNaluzLv1YS
	97lBcMzuvLD6trZ+ZoIo3D7Q2BPx9+gQtzXWkYMTrR92l9ed0OuJmp2BBDBZVn1tX455
	e4PQ==
X-Gm-Message-State: APjAAAV4ryoczZYDPYMRwB3lVBJ6hyoQhHqgEpEy6IMyjQY8y3FZQQOE
	nI3n83sOzUqgUSZwyuC9aB/ExA==
X-Google-Smtp-Source: APXvYqxCxz9nGMbTRYYPGfTUOra6sw7/al6n5QUbg8mnWwXGGezoM67+CBFd/nkTe47spPJf+TqPpA==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr2167527wrw.167.1554802667013; 
	Tue, 09 Apr 2019 02:37:47 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	x14sm16034905wmj.3.2019.04.09.02.37.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 02:37:46 -0700 (PDT)
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>, Lidong Chen <lidong.chen@oracle.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
	<BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cd833acf-4643-0d3c-78f5-7677d224954e@redhat.com>
Date: Tue, 9 Apr 2019 11:37:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"f4bug@amsat.org" <f4bug@amsat.org>,
	"darren.kenny@oracle.com" <darren.kenny@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409093744.XFepMXHxskgbr3LlDPQulCPeEH9QLp_aCJ_-7FCDPa4@z>

On 4/9/19 10:59 AM, Aleksandar Markovic wrote:
>>
>> Lidong Chen <lidong.chen@oracle.com> writes:
>>
>>> Due to an off-by-one error, the assert statements allow an
>>> out-of-bounds array access.
>>>
>>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>>> ---
>>>  hw/sd/sd.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index aaab15f..818f86c 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>>>      if (state == sd_inactive_state) {
>>>          return "inactive";
>>>      }
>>> -    assert(state <= ARRAY_SIZE(state_name));
>>> +    assert(state < ARRAY_SIZE(state_name));
>>>      return state_name[state];
>>>  }
>>>
>>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>>>      if (rsp == sd_r1b) {
>>>          rsp = sd_r1;
>>>      }
>>> -    assert(rsp <= ARRAY_SIZE(response_name));
>>> +    assert(rsp < ARRAY_SIZE(response_name));
>>>      return response_name[rsp];
>>>  }
>>
>> This is the second fix for this bug pattern in a fortnight.  Where's
>> one, there are more:
>>
>> $ git-grep '<= ARRAY_SIZE'
>> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
>> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
>> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {
>> hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
>> hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
>> hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);
>> hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
>> hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));
>> hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));
> 
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> 
> The last four items are OK as they are. The variable multiple_regs is, in fact,
> an array of 9 int constants:
> 
> static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
> 
> ARRAY_SIZE (multiple_regs) will always be equal to 9.
> 
> The variable base_reglist (that is checked to be > 0 and <=9) is used
> in succeeding lines like this:
> 
>         for (i = 0; i < base_reglist; i++) {
>             do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
>                   GETPC());
>             addr += 4;
>         }
> 
> Therefore, the array multiple_regs will always be accessed within its bounds.
> 
>> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
>> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
>> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));
>> tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
>> util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
>> util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));
>>
>> Lidong Chen, would you like to have a look at these?
>>
>> Cc'ing maintainers to help with further investigation.
>>
> 
> Thank you for bringing this to our attention, Markus. And thanks to Lidong too.
> 
> Aleksandar
> 
> P. S. Shouldn't perhaps our macro ARRAY_SIZE() be renamed to
> NUMBER_OF_ELEMENTS()?

I remember this post from Daniel where he suggests sticking to GLib
G_N_ELEMENTS() (which looks similar to your suggestion):
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02676.html

$ git grep G_N_ELEMENTS|wc -l
125
$ git grep ARRAY_SIZE|wc -l
939

Now it is not obvious to me to understand which GLib API we are
encouraged to use and which ones we shouldn't.

> ________________________________________
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Tuesday, April 9, 2019 7:51:51 AM
> To: Lidong Chen
> Cc: qemu-devel@nongnu.org; darren.kenny@oracle.com; f4bug@amsat.org; Peter Maydell; Jason Wang; Andrzej Zaborowski; Gerd Hoffmann; Aurelien Jarno; Aleksandar Markovic; Aleksandar Rikalo; David Gibson; Richard Henderson; Paolo Bonzini
> Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
> 
> Lidong Chen <lidong.chen@oracle.com> writes:
> 
>> Due to an off-by-one error, the assert statements allow an
>> out-of-bounds array access.
>>
>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>> ---
>>  hw/sd/sd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index aaab15f..818f86c 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>>      if (state == sd_inactive_state) {
>>          return "inactive";
>>      }
>> -    assert(state <= ARRAY_SIZE(state_name));
>> +    assert(state < ARRAY_SIZE(state_name));
>>      return state_name[state];
>>  }
>>
>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>>      if (rsp == sd_r1b) {
>>          rsp = sd_r1;
>>      }
>> -    assert(rsp <= ARRAY_SIZE(response_name));
>> +    assert(rsp < ARRAY_SIZE(response_name));
>>      return response_name[rsp];
>>  }
> 
> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:
> 
> $ git-grep '<= ARRAY_SIZE'
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {
> hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);
> hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));
> hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));
> 
> Lidong Chen, would you like to have a look at these?
> 
> Cc'ing maintainers to help with further investigation.
> 

