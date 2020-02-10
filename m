Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A56C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D59020733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 22:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrYtQpmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D59020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Hac-0002fk-8F
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 17:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1HZc-000233-9f
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1HZZ-0004C0-4z
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:30:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1HZX-00045e-GU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 17:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581373828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndWJYrJDqYVWn5Nd+TybwT3Eg8HqEeF8V1B3jDFRXaA=;
 b=QrYtQpmrfCoeICgjTyueHQ1+6iULIA3wNuWf7ECdMC7UltxHC3l9bgBj2J3tP6imj5hhfg
 ksi/xVLRCu0/EGq4HAPF2PeTFjxZJibilX0ou0VVwCj//k2/8RrpMInu4m8thTJzQ1zKa9
 42mZThuCEUGWkZNASqAZ3tegnlylB6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-shvBQj_jMsGEgMCNZpUZsQ-1; Mon, 10 Feb 2020 17:29:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D286F800D5B;
 Mon, 10 Feb 2020 22:29:57 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59BDE5C1D4;
 Mon, 10 Feb 2020 22:29:54 +0000 (UTC)
Subject: Re: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <20200210221234.GH3888@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cc6e1e2e-d3a9-c498-354b-d382b5623ca0@redhat.com>
Date: Mon, 10 Feb 2020 16:29:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210221234.GH3888@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: shvBQj_jMsGEgMCNZpUZsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "nbd@other.debian.org" <nbd@other.debian.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 4:12 PM, Richard W.M. Jones wrote:
> On Mon, Feb 10, 2020 at 03:37:20PM -0600, Eric Blake wrote:
>> For now, only 2 of those 16 bits are defined: NBD_INIT_SPARSE (the
>> image has at least one hole) and NBD_INIT_ZERO (the image reads
>> completely as zero); the two bits are orthogonal and can be set
>> independently, although it is easy enough to see completely sparse
>> files with both bits set.
> 
> I think I'm confused about the exact meaning of NBD_INIT_SPARSE.  Do
> you really mean the whole image is sparse; or (as you seem to have
> said above) that there exists a hole somewhere in the image but we're
> not saying where it is and there can be non-sparse parts of the image?

As implemented:

NBD_INIT_SPARSE - there is at least one hole somewhere (allocation would 
be required to write to that part of the file), but there may b 
allocated data elsewhere in the image.  Most disk images will fit this 
definition (for example, it is very common to have a hole between the 
MBR or GPT and the first partition containing a file system, or for file 
systems themselves to be sparse within the larger block device).

NBD_INIT_ZERO - all bytes read as zero.

The combination NBD_INIT_SPARSE|NBD_INIT_ZERO is common (generally, if 
you use lseek(SEEK_DATA) to prove the entire image reads as zeroes, you 
also know the entire image is sparse), but NBD_INIT_ZERO in isolation is 
also possible (especially with the qcow2 proposal of a persistent 
autoclear bit, where even with a fully preallocated qcow2 image you 
still know it reads as zeroes but there are no holes).  But you are also 
right that for servers that can advertise both bits efficiently, 
NBD_INIT_SPARSE in isolation may be more common than 
NBD_INIT_SPARSE|NBD_INIT_ZERO (the former for most disk images, the 
latter only for a freshly-created image that happens to create with zero 
initialization).

What's more, in my patches, I did NOT patch qemu to set or consume 
INIT_SPARSE; so far, it only sets/consumes INIT_ZERO.  Of course, if we 
can find a reason WHY qemu should track whether a qcow2 image is 
fully-allocated, by demonstrating a qemu-img algorithm that becomes 
easier for knowing if an image is sparse (even if our justification is: 
"when copying an image, I want to know if the _source_ is sparse, to 
know whether I have to bend over backwards to preallocate the 
destination"), then using that in qemu makes sense for my v2 patches. 
But for v1, my only justification was "when copying an image, I can skip 
holes in the source if I know the _destination_ already reads as 
zeroes", which only needed INIT_ZERO.

Some of the nbdkit patches demonstrate the some-vs.-all nature of the 
two bits; for example, in the split plugin, I initialize h->init_sparse 
= false; h->init_zero = true; then in a loop over each file change 
h->init_sparse to true if at least one file was sparse, and change 
h->init_zero to false if at least one file had non-zero contents.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


