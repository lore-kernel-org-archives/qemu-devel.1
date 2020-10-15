Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356CEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAC022248
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 12:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAC022248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT2TO-0004gc-EY
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 08:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kT2S5-0003bu-Fn
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:33:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kT2S3-0000D4-Rb
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 08:33:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 41ADFABD1;
 Thu, 15 Oct 2020 12:33:46 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] accel/tcg: split tcg_start_vcpu_thread
To: Richard Henderson <richard.henderson@linaro.org>
References: <20201014192324.6390-1-cfontana@suse.de>
 <20201014192324.6390-3-cfontana@suse.de>
 <a3c48dd0-643b-a433-08b7-cdd637f2752d@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <3e46ce6a-e2a9-87f8-d301-ec41ff320938@suse.de>
Date: Thu, 15 Oct 2020 14:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a3c48dd0-643b-a433-08b7-cdd637f2752d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.019,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 10:08 PM, Richard Henderson wrote:
> On 10/14/20 12:23 PM, Claudio Fontana wrote:
>> +++ b/accel/tcg/tcg-cpus-mttcg.h
>> @@ -10,14 +10,4 @@
>>  #ifndef TCG_CPUS_MTTCG_H
>>  #define TCG_CPUS_MTTCG_H
>>  
>> -/*
>> - * Multi-threaded TCG
>> - *
>> - * In the multi-threaded case each vCPU has its own thread. The TLS
>> - * variable current_cpu can be used deep in the code to find the
>> - * current CPUState for a given thread.
>> - */
>> -
>> -void *tcg_cpu_thread_fn(void *arg);
>> -
>>  #endif /* TCG_CPUS_MTTCG_H */
> 
> Hum.  Do we really need to create these headers in the previous patch?  Because
> now we have an empty one.
> 
> Why not just put all of tcg-cpus-*.h into tcg-cpus.h?
> 
> Otherwise this looks ok.
> 
> 
> r~
> 

There are some symbols required between -icount, -rr, and -mttcg, and in particular in the -mttcg case, this requirement goes away after start_vcpu is also refactored.

Will take a look again, at the very least the mttcg.h should be removed completely.

Ciao,

Claudio

