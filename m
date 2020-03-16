Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59711C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2152F20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDVyblEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2152F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlUC-0003VG-QI
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDlNH-0001ey-Ph
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDlNG-0006Wx-Iq
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:45:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDlNG-0006Sg-BO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584348326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AMQ0GpiVc2TjYc/UD0hxWGBZTAgb2SSPbJXlELU65cs=;
 b=DDVyblEXRad9wN+r0g86meRimqOcN/XW2fh4PB3TwHcypKPm3UiklA0JNl00nY7rBqj/5l
 DyKAaqH1wvgbcL1RKGl/aOs8vN2x7btfexNlzftGUBWKrUL7D8JRTwuHSkv3DZI5wkXECd
 bUJcTt37/dorIrOuhhc/AzzQMNBVmHw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-RQn_lAz8MqiVsreEUTwSZw-1; Mon, 16 Mar 2020 04:45:22 -0400
X-MC-Unique: RQn_lAz8MqiVsreEUTwSZw-1
Received: by mail-wr1-f69.google.com with SMTP id w11so8676267wrp.20
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AMQ0GpiVc2TjYc/UD0hxWGBZTAgb2SSPbJXlELU65cs=;
 b=Ia7TOgGJrK/FMMv57oIUdrMCzI5Z6GXHkp+v0sWgln1nQalyogtccQS7CiN7foBJv2
 FxfRwxmRjCZ/hJ8CChBLWBXj/D9qjJ3YtUxLuSHK3QacFX5uovJ+0f9FofAuMiCxJylx
 N4uaWnftLM5dvLyEkTcxbp7whp8Qg+1DRSSinJosR9XA9H+gpJaSEvA3wNT25IStp+fm
 rFN3ZMooZIkbDsZR3ii+o/9tpAB+e69Y8VLvAVs10EMUBWRwE09bGDpjpBPRgWUNtHLG
 TDPCZ5N014hJylo3fXxGRM+Pq+LqbhhwRfSHxnwz05i50eAZYD7Jr1P2sG8o4DTtF1/s
 EoaA==
X-Gm-Message-State: ANhLgQ0j1+c/R7fsv7dp+OvdCIOTz8NN+0dUDr4ITQTlPS4nL3Hrt+ln
 3HAKaQKxZnXUxWv+EVJAfDeAFOxxPdManuDAH2ZsFPSnxTRwwX8rW1Lj7ZKS+FpJRbytUGZaGC9
 UhHHHTE0gQJ7rSCI=
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr21899635wmk.79.1584348320982; 
 Mon, 16 Mar 2020 01:45:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsEex+1++UbzA17s6B2qTGo5gt7DEcOHSQmtKdRxhNFyN4LGBLzsK/XYm/EajmkdgkA5pmasA==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr21899608wmk.79.1584348320783; 
 Mon, 16 Mar 2020 01:45:20 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.82.39])
 by smtp.gmail.com with ESMTPSA id l8sm29803697wmj.2.2020.03.16.01.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:45:20 -0700 (PDT)
Subject: Re: [PATCH] cpus: avoid stucking in pause_all_vcpus due to race
To: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org
References: <20200316083732.2010-1-longpeng2@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ce34c43-b8ea-d34a-60fe-ba72f0b0172b@redhat.com>
Date: Mon, 16 Mar 2020 09:45:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316083732.2010-1-longpeng2@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: arei.gonglei@huawei.com, huangzhichao@huawei.com,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 09:37, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> We found an issue when repeat reboot in guest during migration, it cause the
> migration thread never be waken up again.
> 
> <main loop>                        |<migration_thread>
>                                    |
> LOCK BQL                           |
> ...                                |
> main_loop_should_exit              |
>  pause_all_vcpus                   |
>   1. set all cpus ->stop=true      |
>      and then kick                 |
>   2. return if all cpus is paused  |
>      (by '->stopped == true'), else|
>   3. qemu_cond_wait [BQL UNLOCK]   |
>                                    |LOCK BQL
>                                    |...
>                                    |do_vm_stop
>                                    | pause_all_vcpus
>                                    |  (A)set all cpus ->stop=true
>                                    |     and then kick
>                                    |  (B)return if all cpus is paused
>                                    |     (by '->stopped == true'), else
>                                    |  (C)qemu_cond_wait [BQL UNLOCK]
>   4. be waken up and LOCK BQL      |  (D)be waken up BUT wait for  BQL
>   5. goto 2.                       |
>  (BQL is still LOCKed)             |
>  resume_all_vcpus                  |
>   1. set all cpus ->stop=false     |
>      and ->stopped=false           |
> ...                                |
> BQL UNLOCK                         |  (E)LOCK BQL
>                                    |  (F)goto B. [but stopped is false now!]
>                                    |Finally, sleep at step 3 forever.
> 
> As suggested by Paolo, resume_all_vcpus should notice this race, so we need
> to move the change of runstate before pause_all_vcpus in do_vm_stop() and
> ignore the resume request if runstate is not running.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Dr . David Alan Gilbert <dgilbert@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Queued, thanks!

Paolo

> ---
>  cpus.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/cpus.c b/cpus.c
> index b4f8b84..ef441bd 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1026,9 +1026,9 @@ static int do_vm_stop(RunState state, bool send_stop)
>      int ret = 0;
>  
>      if (runstate_is_running()) {
> +        runstate_set(state);
>          cpu_disable_ticks();
>          pause_all_vcpus();
> -        runstate_set(state);
>          vm_state_notify(0, state);
>          if (send_stop) {
>              qapi_event_send_stop();
> @@ -1899,6 +1899,10 @@ void resume_all_vcpus(void)
>  {
>      CPUState *cpu;
>  
> +    if (!runstate_is_running()) {
> +        return;
> +    }
> +
>      qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
>      CPU_FOREACH(cpu) {
>          cpu_resume(cpu);
> 


