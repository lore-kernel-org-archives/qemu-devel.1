Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC0BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFDC207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZX87Ud0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFDC207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nAP-0003HO-U1
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j4n9J-00029I-KE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j4n9I-0000h3-8j
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:49:57 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:48095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j4n9H-0000fc-Vn; Thu, 20 Feb 2020 09:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=fQkzJIea36FdyDd6mr4Bb/OS+w3aVY+XM89Gc7SHzgg=; 
 b=ZX87Ud0YVJFeOX2XlcHJxtdPWlobJ9tQu10xvXjabsbKT4qFNYEMHQYHgPaHmVaaGOXzPNhvQYuYJ91QfLWdUdffOkF2FN0nrga0XlSpAMcKNNBjKuO4LykzH6Q6Qizr/NmXUdFPk/lsvo0ZKScsoi/olN5mYE4Ri9pSGlgNjhkDv93A1kbUn8/Q/m4EgCHB5hgyELUc8SDD4ueIa9/hq6xpbZg4F080ozgNdaFNbl1y2rIHA4Qwr8JBHD7ul+qsHhO/XbFHm5VQqavNylKNEVIEzC1AzHgZDVIRWfnQpS+UIHrb2vW/CftBxkalacvF6uR8BKnww3dyrtBJHedejg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1j4n9E-0006IK-Gq; Thu, 20 Feb 2020 15:49:52 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1j4n9E-0000Hy-7R; Thu, 20 Feb 2020 15:49:52 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v3 05/27] qcow2: Document the Extended L2 Entries
 feature
In-Reply-To: <3a946970-5a26-6c40-a212-0aefdccef509@redhat.com>
References: <cover.1577014346.git.berto@igalia.com>
 <0b884ddcd0ac3a3c0b8cdd9d09c74566ac107c9a.1577014346.git.berto@igalia.com>
 <3a946970-5a26-6c40-a212-0aefdccef509@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 20 Feb 2020 15:49:52 +0100
Message-ID: <w51mu9db9f3.fsf@maestria.local.igalia.com>
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

On Thu 20 Feb 2020 03:28:17 PM CET, Eric Blake wrote:
>> +An image uses Extended L2 Entries if bit 3 is set on the incompatible_features
>> +field of the header.
>> +
>> +In these images standard data clusters are divided into 32 subclusters of the
>> +same size. They are contiguous and start from the beginning of the cluster.
>> +Subclusters can be allocated independently and the L2 entry contains information
>> +indicating the status of each one of them. Compressed data clusters don't have
>> +subclusters so they are treated like in images without this feature.
>
> Grammar; I'd suggest:
>
> ...don't have subclusters, so they are treated the same as in images 
> without this feature.

Ok

> Are they truly the same, or do you still need to document that the
> extra 64 bits of the extended L2 entry are all zero?

It is documented later in the same patch ("Subcluster Allocation Bitmap
for compressed clusters").

By the way, this series treats an L2 entry as invalid if any of those
bits is not zero, but I think I'll change that. Conceivably those bits
could be used for a future compatible feature, but it can only be
compatible if the previous versions ignore those bits.

>> +        32 -  63    Subcluster reads as zeros (one bit per subcluster)
>> +
>> +                    1: the subcluster reads as zeros. In this case the
>> +                       allocation status bit must be unset. The host
>> +                       cluster offset field may or may not be set.
>
> Why must the allocation bit be unset?  When we preallocate, we want a
> cluster to reserve space, but still read as zero, so the combination
> of both bits set makes sense to me.

Since 00 means unallocated and 01 allocated, there are two options left
to represent the "reads as zero" case: 10 and 11.

I think that one could argue for either one and there is no "right"
choice. I chose the former because I understood the allocation bit as
"the guest visible data is obtained from the raw data in that
subcluster" but the other option also makes sense.

Berto

