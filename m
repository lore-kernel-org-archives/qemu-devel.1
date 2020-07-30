Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95671C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D66320656
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D66320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshdubois.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1J6F-0002iY-Lt
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 20:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josh@joshdubois.com>)
 id 1k1HVZ-0008L9-KQ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:58:41 -0400
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:48100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josh@joshdubois.com>)
 id 1k1HVY-0006fU-3P
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 18:58:41 -0400
Received: from jax4mhob24.registeredsite.com (jax4mhob24.registeredsite.com
 [64.69.218.112])
 by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 06UMpGM7009682
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 18:51:16 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.113])
 by jax4mhob24.registeredsite.com (8.14.4/8.14.4) with ESMTP id 06UMoAAr185307
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 18:50:11 -0400
Received: (qmail 9079 invoked by uid 0); 30 Jul 2020 22:50:10 -0000
X-TCPREMOTEIP: 50.93.248.134
X-Authenticated-UID: josh@joshdubois.com
Received: from unknown (HELO ?192.168.1.105?)
 (josh@joshdubois.com@50.93.248.134)
 by 0 with ESMTPA; 30 Jul 2020 22:50:10 -0000
Subject: Re: [PATCH] trace/simple: Allow enabling simple traces from command
 line
To: Stefan Hajnoczi <stefanha@gmail.com>, Josh DuBois <duboisj@gmail.com>
References: <20200723053359.256928-1-josh@joshdubois.com>
 <20200729130535.GI37763@stefanha-x1.localdomain>
From: Josh DuBois <josh@joshdubois.com>
Message-ID: <e08651bd-f775-eb85-817c-44d27ff072dc@joshdubois.com>
Date: Thu, 30 Jul 2020 17:50:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200729130535.GI37763@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: neutral client-ip=209.17.115.120;
 envelope-from=josh@joshdubois.com; helo=atl4mhfb04.myregisteredsite.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 18:51:16
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Jul 2020 20:39:56 -0400
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Well, this is a bit embarrassing.  The patch below simply re-introduced 
the bug which the Fixes: line was trying to fix in the first place.

I.e, :

- with my patch (just committed as 
1b7157be3a8c4300fc8044d40f4b2e64a152a1b4) applied, a QEMU built with 
simple tracing will always produce a trace-<pid> file, regardless of 
whether traces were asked for.

- after db25d56c014aa1a96319c663e0a60346a223b31e, which my patch was 
supposed to "fix," QEMU will not produce a trace file unless asked, I 
believe, via the monitor.  Enabling traces is, near as I can tell, 
simply impossible via the command-line in that case.

- prior to db25d56c014aa1a96319c663e0a60346a223b31e, just like today, 
QEMU built with simple tracing will always produce a trace-<pid> file, 
regardless of whether the user asks for traces at runtime.

I'm sorry for the mess.  Having stepped in it already, I'm  open to 
trying to track it down and fix it properly.  I imagine perhaps few 
people truly care, since traces require a special build and are probably 
only being done by developers anyway.  (And the original message for 
db25d56c014aa1a96319c663e0a60346a223b31e said it had been "broken" for 
an unknown period of time).

I'm brand new around here so I'll leave it to others whether it's better 
to revert and have traces impossible to enable from the cli (as I say, I 
think they're only possible from the monitor prior to my "fix" ) or to 
leave it be.

If I resubmit, I'll try to test a little more next time.  I just wanted 
my traces to work. ;)

On 7/29/20 8:05 AM, Stefan Hajnoczi wrote:
> On Thu, Jul 23, 2020 at 12:33:59AM -0500, Josh DuBois wrote:
>> The simple trace backend is enabled / disabled with a call
>> to st_set_trace_file_enabled().  When initializing tracing
>> from the command-line, this must be enabled on startup.
>> (Prior to db25d56c014aa1a9, command-line initialization of
>> simple trace worked because every call to st_set_trace_file
>> enabled tracing.)
>>
>> Fixes: db25d56c014aa1a96319c663e0a60346a223b31e
>> Signed-off-by: Josh DuBois <josh@joshdubois.com>
>> ---
>>   trace/control.c | 1 +
>>   1 file changed, 1 insertion(+)
> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing
>
> Stefan

