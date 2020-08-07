Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A41FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604672177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604672177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Ea-000878-IJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k40E0-0007VJ-4p
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:07:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:42178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1k40Dy-00060X-3y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:07:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4FDAAABE2;
 Fri,  7 Aug 2020 11:08:02 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC] checkpatch: detect missing changes to trace-events
To: Markus Armbruster <armbru@redhat.com>
References: <20200806153331.23907-1-cfontana@suse.de>
 <87imdv0ye0.fsf@dusky.pond.sub.org>
Message-ID: <9734b0bd-b7ce-9453-8364-ab2d9db331c9@suse.de>
Date: Fri, 7 Aug 2020 13:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87imdv0ye0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 23:38:33
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 8:21 AM, Markus Armbruster wrote:
> Claudio Fontana <cfontana@suse.de> writes:
> 
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  scripts/checkpatch.pl | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> We could do something similar to MAINTAINERS for trace-events,
>> ie warning about files added, moved, deleted if we don't see
>> an update to a trace-events file.
> 
> I like the idea, but...
> 
>> To make it more solid it would be better to check the
>> actual file contents for #include "trace.h" or "trace-root.h",
>> but I guess this is not possible/practice from checkpatch?
> 
> ... I'm also concerned about false positives.
> 
>> If we could only warn for files moved that actually include
>> trace.h or trace-root.h, we could avoid a lot of false positives.
> 
> The existing MAINTAINERS check warns even when an existing pattern
> covers the new file, e.g. when I create or rename a file scripts/qapi/*
> or qapi/*.json.  The former is definitely a false positive, and mildly
> annoying.  The latter, however, could be a true positive: even though
> the new file is covered by the "QAPI Schema" section, *additional*
> coverage by some other section may be called for, just like
> qapi/machine.json is additionally covered by "Machine core".  So, even
> if checkpatch.pl looked at more than just the patch, suppressing false
> positives would involve guesswork.
> 
> The new trace-events check is simpler: it's *always* a false positive
> when the file doesn't include trace.h or trace-root.h.
> 
> Complication: it could include via some header.  I figure that's rare
> enough to be ignored.


Agreed with all the above. I think something like this would be useful (and not annoying)
only if we could at least limit the false positives by checking that the file effectively includes trace.h or trace-root.h .

> 
> Howver, checkpatch.pl checks *patches* by design[*].  It doesn't read
> the patched files to get more context, or additional files.


Right - if we do end up checking the patched files for this feature though (thus breaking this design rule),
would this have any other consequence beyond providing this feature?

We need to call checkpatch.pl from the top srcdir anyway,
and if we don't find the patched file or we don't match trace.h or trace-root.h in there, well we just don't emit the warning...

> 
> Perhaps it's simply the wrong place both for the MAINTAINERS check and
> the trace-events check.  We put the MAINTAINERS check there, because it
> exists and developers run it.  "make check-source" would be another
> option, except it doesn't exist.  CI would be yet another option, but we
> should be careful about what to check only in CI.
> 
> 
> [*] There's -f to check a source file, which checks "diff -u /dev/null
> $filename".
> 

Won't insist, would just have found it useful to avoid forgetting that piece when moving stuff around.

Just for kicks I will send an RFC v2 to see what it could look like attempting to look for trace.h and trace-root.h,
probably it's something I would personally use.

Ciao, thanks!

Claudio





