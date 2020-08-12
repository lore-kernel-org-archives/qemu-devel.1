Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058DBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2D12076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2D12076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tJt-0003yq-RG
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5tId-0002su-OK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:08:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:35776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k5tIb-000879-Sd
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:08:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B19D4B647;
 Wed, 12 Aug 2020 16:08:41 +0000 (UTC)
Subject: Re: [RFC v2] checkpatch: detect missing changes to trace-events
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200807111447.15599-1-cfontana@suse.de>
 <20200812155119.GC112330@stefanha-x1.localdomain>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <dcd14c2c-f7e9-8241-f938-79eea165c73b@suse.de>
Date: Wed, 12 Aug 2020 18:08:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200812155119.GC112330@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 23:47:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 5:51 PM, Stefan Hajnoczi wrote:
> On Fri, Aug 07, 2020 at 01:14:47PM +0200, Claudio Fontana wrote:
>>  # Check for added, moved or deleted files
>> -		if (!$reported_maintainer_file && !$in_commit_log &&
>> +		if (!$in_commit_log &&
>>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
>>  		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
>>  		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
>>  		      (defined($1) || defined($2))))) {
>> -			$reported_maintainer_file = 1;
>> -			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
>> +			if (!$reported_maintainer_file) {
>> +				$reported_maintainer_file = 1;
>> +				WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
>> +			}
>> +			if (!$reported_trace_events_file) {
>> +				if (`grep -F -s -e trace.h -e trace-root.h ${fromfile} ${realfile}` ne '') {
> 
> Are there false positives on non-C files (e.g. Makefiles)?
> 
> The search expressions can be tightened to avoid false positives (at the
> cost of possible false negatives): -e '#include "trace.h"' -e '#include
> "trace-root.h"'. This way a C file containing "strace.handler" will not
> cause a false positive.
> 

Yep good point.

> I wonder if there is a native Perl way to do this search instead of
> forking grep :). Nevermind though.
> 

If only all the speedups from GNU grep would be available as a libgrep..

I had to post an RFC v3 of this one, because there is an issue in the order in_commit_log is set and checked (in my understanding).

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01953.html

This is actually potentially an issue in upstream (kernel) checkpatch.pl as well, but it does not bite until you try to use
realfile variable (or in this case fromfile also).

Ciao,

Claudio






