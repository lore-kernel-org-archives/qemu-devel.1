Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323EC4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9150521556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HHpfrQpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9150521556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j701D-00062Z-O3
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j700X-0005ZE-5z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:58:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j700V-00035G-IM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 11:58:00 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:56278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j700U-0002eS-W3; Wed, 26 Feb 2020 11:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=sJaYeACQgsWE/oqGZjFILef+4a0cXUlXMnmvBKXW9IA=; 
 b=HHpfrQpMNxjrV2sWQ+smFSt61j4mczkqhTXJxGfjfYB3fJQXA0USCEaS5+pgipI1frOo4C9aaIeee66Ykw3GB7Duaun5l+bYty4UoIsBZofOmZ4vT7IQ7hFnJrimTyxR8pL1Mcr+HT/RIPwTLg9ndhL6j+2FNc4UPoMk5URi+VdlICHmp4Vi9rilu37cm8+4ev2+XUShrzoYRdvQ04Z2Lh8bFdvbvLcPQHSj+lzM79f6Xr/1vPReBP327XfYOc8r0zV76RxZnENN26opwYgfPUR+sGMVOstG1Ihr4LsplBC8E9DI0mHVUFyvB7a26xQRHlFQPFb/rI+J2ejiOysCbA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j700A-0006ER-Lu; Wed, 26 Feb 2020 17:57:38 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j700A-0005RM-Bz; Wed, 26 Feb 2020 17:57:38 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 05/27] qcow2: Document the Extended L2 Entries
 feature
In-Reply-To: <567b92a4-7563-f75e-4f19-1abadd03e21c@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
 <3a946970-5a26-6c40-a212-0aefdccef509@redhat.com>
 <w51mu9db9f3.fsf@maestria.local.igalia.com>
 <567b92a4-7563-f75e-4f19-1abadd03e21c@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 26 Feb 2020 17:57:38 +0100
Message-ID: <w51mu95p9q5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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

On Thu 20 Feb 2020 04:16:12 PM CET, Eric Blake wrote:

>>>> +In these images standard data clusters are divided into 32 subclusters of the
>>>> +same size. They are contiguous and start from the beginning of the cluster.
>>>> +Subclusters can be allocated independently and the L2 entry contains information
>>>> +indicating the status of each one of them. Compressed data clusters don't have
>>>> +subclusters so they are treated like in images without this feature.
>>>
>>> Grammar; I'd suggest:
>>>
>>> ...don't have subclusters, so they are treated the same as in images
>>> without this feature.
>> 
>> Ok
>> 
>>> Are they truly the same, or do you still need to document that the
>>> extra 64 bits of the extended L2 entry are all zero?
>> 
>> It is documented later in the same patch ("Subcluster Allocation
>> Bitmap for compressed clusters").
>
> Yes, I saw the mention later.  I'm just wondering if we need to
> rearrange text to mention that the bits are reserved (set to 0, ignore
> on read) closer to the point where we document compressed clusters
> have no subclusters.

When I say that "compressed data clusters are treated the same as in
images without this feature" I mean that there are no semantic
changes. I don't think it's necessary to add anything else considering
that the sentence immediately after that one says that the L2 entry size
is now 128 bits, so it's not hard to guess that compressed cluster
descriptors must somehow be affected by this.

> We have 8 potential combinations (not all make sense):
>
> host   zero alloc
>    0      0    0     cluster unallocated, subcluster defers to backing
>    0      0    1     error (except maybe for external data file)

Correct (without the 'maybe')

>    0      1    0     cluster unallocated, subcluster reads as zero
>    0      1    1     error (except maybe for external data file)

This is an error in all cases.

>   addr    0    0     cluster allocated, subcluster defers to backing
>   addr    0    1     cluster allocated, subcluster reads from host
>   addr    1    0     cluster allocated, subcluster reads as zero
>   addr    1    1   error, or cluster allocated, subcluster reads as zero

The last one is also an error.

> Hmm - normally addr is non-zero (because the 0 addr is the metadata 
> cluster of qcow2), but with external data file, host addr 0 is required 
> for guest offset 0. How do subclusters play with external data files?

No difference:

    /* ... */ if (!(l2_entry & L2E_OFFSET_MASK)) {
        /* Offset 0 generally means unallocated, but it is ambiguous with
         * external data files because 0 is a valid offset there. However, all
         * clusters in external data files always have refcount 1, so we can
         * rely on QCOW_OFLAG_COPIED to disambiguate. */
        if (has_data_file(bs) && (l2_entry & QCOW_OFLAG_COPIED)) {
            return QCOW2_CLUSTER_NORMAL;
        } else {
            return QCOW2_CLUSTER_UNALLOCATED;
        }
    } /* ... */

This code doesn't change if there are subclusters, and is still used to
determine whether a cluster is allocated or not, and therefore whether
the subcluster allocation bits need to be checked or not.

> It makes sense to still have subclusters read as 0 or defer to backing
> with an external file (except maybe when raw external file is set).
> But you did word it as if the alloc bit is set, the "host cluster
> offset field must contain a valid offset" which includes an offset of
> 0 for external data file.

Yes, that is possible with subclusters (unless there's a bug).

> If we mandate 10 for the reads-as-zero form, then whether addr is
> valid is irrelevant. If we mandate 11 for the reads-as-zero form, then
> addr must be valid even though we don't reference addr.  Having
> written all that, I agree that either form should work, but also that
> mandating one form leaves the door open for a future extension to
> define meaning to the form we did not permit (that is, either 10 or 11
> becomes a reserved pattern that we can later give meaning to),
> vs. allowing both forms now and locking ourselves out of a future
> meaning.  And mandating addr to be valid even when reading zeroes
> doesn't use addr feels odd.

Yes, we definitely don't want to make 10 and 11 synonymous. One of them
should return an error and maybe in the future we can think of a new
meaning.

> So, I'm okay with your choice of picking 00, 01, and 10 as the
> mandated forms, and declaring 11 as invalid for now (but a possible
> future extension).  Maybe I'll change my mind when seeing what
> complexity it adds to the qcow2 reference implementation, but
> hopefully not.

From the implementation point of view there's no difference in
complexity.

Berto

