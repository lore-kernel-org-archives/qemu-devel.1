Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607CCC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF302084F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 00:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF302084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJovC-0002nw-Dc
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 20:40:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJotu-0001qT-OE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJots-0000yc-2g
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:39:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:1806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJotn-0000oX-JU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 20:39:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 17:39:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,395,1549958400"; d="scan'208";a="340872403"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2019 17:39:28 -0700
Date: Fri, 26 Apr 2019 08:39:01 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20190426003901.GA25513@richard>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-2-richardw.yang@linux.intel.com>
	<e9cd3438-345f-2a68-daec-1ce4cba37ef1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <e9cd3438-345f-2a68-daec-1ce4cba37ef1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH 1/4] migration/savevm: remove duplicate
 check of migration_is_blocked
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426003901.AhGBkU8QUxcqYI872g3yjsWYVTtL0--eSUOz6d4Ick4@z>

On Thu, Apr 25, 2019 at 04:20:57PM -0300, Daniel Henrique Barboza wrote:
>
>
>On 4/23/19 9:46 PM, Wei Yang wrote:
>> Current call flow of save_snapshot is:
>> 
>>    save_snapshot
>>      migration_is_blocked
>>        qemu_savevm_state
>>          migration_is_blocked
>> 
>> Since qemu_savevm_state is only called in save_snapshot, this means
>> migration_is_blocked has been already checked.
>
>I think it would be a nice touch to add a comment in qemu_savevm_state,
>saying that the function must be called with migration_is_blocked()
>context. Just in case someone else in the future ends up re-using the
>function.
>

That's reasonable, let me add a comment for qemu_savevm_state().

>
>Other than that, +1 for less code duplication.
>
>
>Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>
>
>
>
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>   migration/savevm.c | 4 ----
>>   1 file changed, 4 deletions(-)
>> 
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 92af2471cd..2eea604624 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1412,10 +1412,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>>           return -EINVAL;
>>       }
>> -    if (migration_is_blocked(errp)) {
>> -        return -EINVAL;
>> -    }
>> -
>>       if (migrate_use_block()) {
>>           error_setg(errp, "Block migration and snapshots are incompatible");
>>           return -EINVAL;

-- 
Wei Yang
Help you, Help me

