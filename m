Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BDAC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753E7208CD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N59gR7dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753E7208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4na7-0002Oe-Lg
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j4nYy-0001PP-45
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j4nYw-0004pm-NK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:16:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j4nYw-0004pR-K2
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582211786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSui4haKfS7pax/OWNsYuUFoY6/2KG25x9gUsk24h4w=;
 b=N59gR7dP6Tey8POehXBqskGePSPIOuMdXkrta0UxuUcywPGuhZqtIs6Vo9Zbr+CTYf0dlm
 QwPVFkBwi57m1dRCqiqwcKg1Ok8HPK5BTNfJgPYeInmkBMyL5JrmjTZkwb5+SB8au9TwlS
 pz4ugZiIcH8dTQXoQ7yaKESi3LDAh20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-P5-Wzp-oOgqNPkeL0cNgDA-1; Thu, 20 Feb 2020 10:16:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26EF6107ACCC;
 Thu, 20 Feb 2020 15:16:14 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E13C8681F;
 Thu, 20 Feb 2020 15:16:13 +0000 (UTC)
Subject: Re: [RFC PATCH v3 05/27] qcow2: Document the Extended L2 Entries
 feature
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
 <3a946970-5a26-6c40-a212-0aefdccef509@redhat.com>
 <w51mu9db9f3.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <567b92a4-7563-f75e-4f19-1abadd03e21c@redhat.com>
Date: Thu, 20 Feb 2020 09:16:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <w51mu9db9f3.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: P5-Wzp-oOgqNPkeL0cNgDA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 8:49 AM, Alberto Garcia wrote:
> On Thu 20 Feb 2020 03:28:17 PM CET, Eric Blake wrote:
>>> +An image uses Extended L2 Entries if bit 3 is set on the incompatible_features
>>> +field of the header.
>>> +
>>> +In these images standard data clusters are divided into 32 subclusters of the
>>> +same size. They are contiguous and start from the beginning of the cluster.
>>> +Subclusters can be allocated independently and the L2 entry contains information
>>> +indicating the status of each one of them. Compressed data clusters don't have
>>> +subclusters so they are treated like in images without this feature.
>>
>> Grammar; I'd suggest:
>>
>> ...don't have subclusters, so they are treated the same as in images
>> without this feature.
> 
> Ok
> 
>> Are they truly the same, or do you still need to document that the
>> extra 64 bits of the extended L2 entry are all zero?
> 
> It is documented later in the same patch ("Subcluster Allocation Bitmap
> for compressed clusters").

Yes, I saw the mention later.  I'm just wondering if we need to 
rearrange text to mention that the bits are reserved (set to 0, ignore 
on read) closer to the point where we document compressed clusters have 
no subclusters.

> 
> By the way, this series treats an L2 entry as invalid if any of those
> bits is not zero, but I think I'll change that. Conceivably those bits
> could be used for a future compatible feature, but it can only be
> compatible if the previous versions ignore those bits.
> 
>>> +        32 -  63    Subcluster reads as zeros (one bit per subcluster)
>>> +
>>> +                    1: the subcluster reads as zeros. In this case the
>>> +                       allocation status bit must be unset. The host
>>> +                       cluster offset field may or may not be set.
>>
>> Why must the allocation bit be unset?  When we preallocate, we want a
>> cluster to reserve space, but still read as zero, so the combination
>> of both bits set makes sense to me.
> 
> Since 00 means unallocated and 01 allocated, there are two options left
> to represent the "reads as zero" case: 10 and 11.
> 
> I think that one could argue for either one and there is no "right"
> choice. I chose the former because I understood the allocation bit as
> "the guest visible data is obtained from the raw data in that
> subcluster" but the other option also makes sense.

My argument is that BOTH bit settings make sense:

10 - reads as zero, but subcluster is not allocated
11 - reads as zero, and subcluster is allocated

Oh, I see.  I'm getting confused on the meanings of "allocated". 
Meaning 1: a host address is reserved for the guest address 
(pre-allocation sense).  Meaning 2: guest reads come from this layer 
rather than from the backing layer (COW/COR sense).

Pre-allocation is ALWAYS done a cluster at a time (you only have ONE 
host offset, shared among all 32 subclusters, per L2 entry), so either 
all 32 subclusters have a preallocated location, or none of them do. 
What is left, then, is a determination of whether to read locally or 
from the backing file, AND when reading locally, whether to read from 
the pre-allocated space or to just read zeroes.

We have 8 potential combinations (not all make sense):

host   zero alloc
   0      0    0     cluster unallocated, subcluster defers to backing
   0      0    1     error (except maybe for external data file)
   0      1    0     cluster unallocated, subcluster reads as zero
   0      1    1     error (except maybe for external data file)
  addr    0    0     cluster allocated, subcluster defers to backing
  addr    0    1     cluster allocated, subcluster reads from host
  addr    1    0     cluster allocated, subcluster reads as zero
  addr    1    1   error, or cluster allocated, subcluster reads as zero

Hmm - normally addr is non-zero (because the 0 addr is the metadata 
cluster of qcow2), but with external data file, host addr 0 is required 
for guest offset 0.  How do subclusters play with external data files? 
It makes sense to still have subclusters read as 0 or defer to backing 
with an external file (except maybe when raw external file is set).  But 
you did word it as if the alloc bit is set, the "host cluster offset 
field must contain a valid offset" which includes an offset of 0 for 
external data file.

If we mandate 10 for the reads-as-zero form, then whether addr is valid 
is irrelevant. If we mandate 11 for the reads-as-zero form, then addr 
must be valid even though we don't reference addr.  Having written all 
that, I agree that either form should work, but also that mandating one 
form leaves the door open for a future extension to define meaning to 
the form we did not permit (that is, either 10 or 11 becomes a reserved 
pattern that we can later give meaning to), vs. allowing both forms now 
and locking ourselves out of a future meaning.  And mandating addr to be 
valid even when reading zeroes doesn't use addr feels odd.

So, I'm okay with your choice of picking 00, 01, and 10 as the mandated 
forms, and declaring 11 as invalid for now (but a possible future 
extension).  Maybe I'll change my mind when seeing what complexity it 
adds to the qcow2 reference implementation, but hopefully not.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


