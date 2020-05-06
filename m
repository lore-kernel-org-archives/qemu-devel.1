Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254CFC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98D620746
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RC7DDxtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98D620746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLaN-0007f2-Vp
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWLZa-0006oW-FK; Wed, 06 May 2020 11:02:58 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:49505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jWLZY-0006ZY-4s; Wed, 06 May 2020 11:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=sHIl9q4uSH0GC4zmVXN3kQnxRlJqRsrYbNBGHJkk3Tw=; 
 b=RC7DDxtgEE01UUC2CowBApCH8aHpga3py+1zxJe+CryOANa1jYw11aXDz3HQ9WQDGEWon60r1nxTAD6llOrpA2WPbSKqXP4D9HjN5cLjjfqb3ttBrOjlEN+LWa+xd4c2AMAqKkT6QC7CRvGfDm1J9U6qMz65F3vN3PuSwuzIC3Yc8b4iiqn9AX/on79+mcxVKeNgaTByuqKj0DXoZNvGXOGJo1VcSMEbCsnEjH9l/Q4ujutj7ZiLXzNDGdww+L7Qicj3xvJSVUT7vRBWc+6NoDBUjlU0scgE2c+3oomAf+VYAOv+6X96qM3+G3+JfHha1QBsnzTThJCC1FVZtRpYGQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jWLZU-0004SR-EH; Wed, 06 May 2020 17:02:52 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jWLZU-0001NW-3a; Wed, 06 May 2020 17:02:52 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 07/31] qcow2: Document the Extended L2 Entries feature
In-Reply-To: <52c059ee-8a80-89af-dbab-ffea3976421e@redhat.com>
References: <cover.1588699789.git.berto@igalia.com>
 <ad59735f252161ec7ed2f08b30cd517cbfb1d360.1588699789.git.berto@igalia.com>
 <52c059ee-8a80-89af-dbab-ffea3976421e@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 06 May 2020 17:02:52 +0200
Message-ID: <w51d07h9kdf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 11:02:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue 05 May 2020 09:35:06 PM CEST, Eric Blake wrote:
> On 5/5/20 12:38 PM, Alberto Garcia wrote:
>> Subcluster allocation in qcow2 is implemented by extending the
>> existing L2 table entries and adding additional information to
>> indicate the allocation status of each subcluster.
>> 
>> This patch documents the changes to the qcow2 format and how they
>> affect the calculation of the L2 cache size.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   docs/interop/qcow2.txt | 68 ++++++++++++++++++++++++++++++++++++++++--
>>   docs/qcow2-cache.txt   | 19 +++++++++++-
>>   2 files changed, 83 insertions(+), 4 deletions(-)
>> 
>
>> @@ -547,7 +557,8 @@ Standard Cluster Descriptor:
>>                       nor is data read from the backing file if the cluster is
>>                       unallocated.
>>   
>> -                    With version 2, this is always 0.
>> +                    With version 2 or with extended L2 entries (see the next
>> +                    section), this is always 0.
>
> In your cover letter, you said you changed things to tolerate this bit
> being set even with extended L2 entries.  Does this sentence need a
> tweak?

Not a bad idea.


>> +The last 64 bits contain a subcluster allocation bitmap with this format:
>> +
>> +Subcluster Allocation Bitmap (for standard clusters):
>> +
>> +    Bit  0 -  31:   Allocation status (one bit per subcluster)
>
> Why two spaces after '-'?

No reason, I guess I just didn't notice. I'll fix it.

Berto

