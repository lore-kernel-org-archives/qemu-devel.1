Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685ABC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C028208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Hy93AUR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C028208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrcV-0008NN-AL
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hgqn8-0005Je-MJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hgqn7-0007AY-KC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:19:50 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:38740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hgqn4-00076y-SR; Fri, 28 Jun 2019 09:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=ZkYE9z3rKFlAQb4M51jaBX8IgaX4czvu4ktWNBu3MBE=; 
 b=Hy93AUR/E/zIyCcBiaaEBuVPz8VsuQzalnzUu04kv56fnkxQpaBSCQxPJFsawYfdflIZGb93Ax6S+Qrv0KwKN66fXTMNC5NRDO/DhFLSrvaJMGZgwkITXXDvsD7IdxxexKl80tqwRbZjjUTayMdbn3AE0meFZBCxgWG8lAEPrq9ktUCbx3fQUoARDn5R9jpSxnJtzg+WCsC7Z4k901JwGNdUe5jJt7QOXkGHAsRbRt9kqyoKnVYXQvB5IDixxSPOntxS9poEUk+Tr/JwjIxZ0sm7Nc7PTwbMhcVA7KvbSD6PV37qk7BctlyTqW5ej4Bywcl5mkkScEYxVcjqmyFLXQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hgqmw-0007HM-Ko; Fri, 28 Jun 2019 15:19:38 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hgqmw-0005tC-Hy; Fri, 28 Jun 2019 15:19:38 +0200
From: Alberto Garcia <berto@igalia.com>
To: Kevin Wolf <kwolf@redhat.com>
In-Reply-To: <20190628100422.GE5179@dhcp-200-226.str.redhat.com>
References: <20190627135914.xlzohrdwr6mz2aq3@perseus.local>
 <4453cfc4-cff7-c004-1f4c-7cab462e4661@virtuozzo.com>
 <w51a7e3domn.fsf@maestria.local.igalia.com>
 <w517e97dogw.fsf@maestria.local.igalia.com>
 <20190628092057.GA5179@dhcp-200-226.str.redhat.com>
 <w515zoqjass.fsf@maestria.local.igalia.com>
 <20190628100422.GE5179@dhcp-200-226.str.redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 28 Jun 2019 15:19:38 +0200
Message-ID: <w51v9wpj191.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [RFC] Re-evaluating subcluster allocation for
 qcow2 images
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 28 Jun 2019 12:04:22 PM CEST, Kevin Wolf wrote:
> Am 28.06.2019 um 11:53 hat Alberto Garcia geschrieben:
>> On Fri 28 Jun 2019 11:20:57 AM CEST, Kevin Wolf wrote:
>> >> >> I would consider 64k cluster/8k subcluster as too extreme for me.
>> >> 
>> >> I forgot to add: this 64k/8k ratio is only with my current prototype.
>> >> 
>> >> In practice if we go with the 128-bit L2 entries we would have 64
>> >> subclusters per cluster, or 32 if we want to have a separate
>> >> QCOW_OFLAG_ZERO for each subcluster (would we need this?).
>> >
>> > Yes, I think we'd want to have a separate zero flag for each
>> > subcluster.  Otherwise, when writing to a zero cluster, you'd have to
>> > COW the whole supercluster again.
>> 
>> Yes if the original cluster had the QCOW_OFLAG_ZERO bit, not if it
>> was simply unallocated.
>
> Right, but that leaving clusters simply unallocated doesn't quite cut
> it is something we already noticed before writing the spec for
> v3. Only really necessary when you have a backing file, of course, but
> that's one of the more interesting cases for subclusters anyway.

I wonder if it would be possible to have a hybrid solution:

With 64 bits to indicate the allocation status of each subcluster we
still have the original L2 entry with its QCOW_OFLAG_ZERO bit, so we
need to specify what happens if that bit is set and at the same time
some subclusters are marked as allocated.

One possibility is that allocated subclusters have actual data and the
rest are zero subclusters.

Berto

