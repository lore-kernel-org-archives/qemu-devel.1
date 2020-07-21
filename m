Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 05:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3A6207DD
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 05:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViwSUv2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3A6207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxktZ-0001oO-SF
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 01:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxksv-00016h-3g
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 01:32:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxkst-0003cO-4o
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 01:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595309529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=6bwESLpt/VaLPQMjG1MhfEvuJQcehymjuTut7CkNq/o=;
 b=ViwSUv2ZkdHy2O6w+Lc3TRYlWHMKzz/MaZisqKgD4gmL8EEVj/KqsYxC1mL7RwWGfRBAeG
 dpBnzPokMjItZNVhtZYxvRVfmw1gmN/W3g2B5y0Ih7++fKD911ITDiwAToOjq5nYd2eHG8
 e0M4iPhVpGD9pCQnYNy7tfRaSjAFRGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-qQPz0SFwNoWQGyoU0WueLg-1; Tue, 21 Jul 2020 01:32:06 -0400
X-MC-Unique: qQPz0SFwNoWQGyoU0WueLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DA5A18C63C0;
 Tue, 21 Jul 2020 05:32:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06E741002397;
 Tue, 21 Jul 2020 05:31:57 +0000 (UTC)
Subject: Re: [PATCH 4/4] docs/fuzz: add instructions for generating a coverage
 report
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200706195534.14962-1-alxndr@bu.edu>
 <20200706195534.14962-5-alxndr@bu.edu>
 <20200707044124.d4f2em2cdfivdrcq@mozz.bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <33421314-aca3-7d59-f712-1763d6848c5e@redhat.com>
Date: Tue, 21 Jul 2020 07:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200707044124.d4f2em2cdfivdrcq@mozz.bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:32:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: bsd@redhat.com, philmd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/2020 06.41, Alexander Bulekov wrote:
> On 200706 1555, Alexander Bulekov wrote:
>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> ---
>>  docs/devel/fuzzing.txt | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
>> index 284d57f8fd..a9816ffce9 100644
>> --- a/docs/devel/fuzzing.txt
>> +++ b/docs/devel/fuzzing.txt
>> @@ -85,6 +85,25 @@ better coverage performance, depending on the target.
>>  Note that libFuzzer's exact behavior will depend on the version of
>>  clang and libFuzzer used to build the device fuzzers.
>>  
>> +== Generating Coverage Reports ==
>> +Code coverage is a crucial metric for evaluating a fuzzer's performance.
>> +libFuzzer's output provides a "cov: " column that provides a total number of
>> +unique blocks/edges covered. To examine coverage on a line-by-line basis we
>> +can use Clang coverage:
>> +
>> + 1. Configure libFuzzer to store a corpus of all interesting inputs (see
>> +    CORPUS_DIR above)
>> + 2. ./configure the QEMU build with:
>> +    --enable-sanitizers \
> Oops... that should be --enable-fuzzing \

I've pushed it with the fix applied to my qtest-next branch:

 https://gitlab.com/huth/qemu/-/commits/qtest-next/

  Thomas


