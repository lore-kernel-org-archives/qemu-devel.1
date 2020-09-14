Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24A0C2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92387206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92387206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpsN-0005c1-HI
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kHpnt-0003BC-H8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:50:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:52034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kHpnr-00056G-SG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:50:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 86D93B454;
 Mon, 14 Sep 2020 14:50:12 +0000 (UTC)
Subject: Re: [RFC v3] checkpatch: detect missing changes to trace-events
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200811081158.4893-1-cfontana@suse.de>
 <20200914134442.GN579094@stefanha-x1.localdomain>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <cf51a4d1-f760-dd83-fde8-9e9121daae50@suse.de>
Date: Mon, 14 Sep 2020 16:49:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914134442.GN579094@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:18:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 3:44 PM, Stefan Hajnoczi wrote:
> On Tue, Aug 11, 2020 at 10:11:58AM +0200, Claudio Fontana wrote:
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>>  scripts/checkpatch.pl | 48 ++++++++++++++++++++++++++++++++++++------------
>>  1 file changed, 36 insertions(+), 12 deletions(-)
>>
>> v2 -> v3 :
>>
>> * move the check for missing changes to MAINTAINERS and trace-events
>>   later on, as otherwise the check for in_commit_log will not be done
>>   on an up to date value, causing fromfile and realfile to not be set,
>>   and matching unwanted strings inside the commit log.
>>
>> * Ensure that at least one file name is passed to grep.
>>
>>
>> ----
>>
>> v1 -> v2 :
>>
>> * track the "from" file in addition to the "to" file,
>>   and grep into both (if they exist), looking for trace.h, trace-root.h
>>
>>   If files are reachable and readable, emit a warning if there is no
>>   update to trace-events.
> 
> This patch still has an RFC tag. Is it ready to be merged?
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

Hi Stefan, I think it's actually not, I would like to have more testing on it, checking all false positive/false negative cases.
I found some issues with it, with false negatives, that I still do not understand.

If anybody wants to rework this taking this as starting point, that's good, otherwise I will get back to it when I can..

I am not sure about the "move the check" part in v2 -> v3, and if anybody has more input and can help to understand this aspect, welcome to collaborate on this.

Ciao,

CLaudio

