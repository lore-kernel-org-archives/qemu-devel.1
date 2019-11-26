Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB9C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D7FE20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AWSoa5+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D7FE20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZblv-0000Ax-5I
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iZbj1-0005MG-N1
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iZbiz-00028H-FN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:21:55 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:46400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>) id 1iZbiu-00023s-8V
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=vbZ9Vj/DV7mXa4BJmld8xJR8zzhx0WBQ1ygQ2O3z2Ko=; 
 b=AWSoa5+RVBU0OsY4D0s2ClhFRtrSoqjFEh14jKhgiuKXM2nrK8vLd5mxmWufH1jQEdelMa3wf+F3CR08FUyAfSNJAvYthVwqLv1tYQqk1h0gWrnJfBq0E7WogVCa6uPI8USahH14mOmOfhzFAzx836dSOS9Vj1yvm/nUMh3Gfdm5ke9WPsbp3QqJu5q7s7Cjjt/BBmXyZCMabW8IRLgML6PLkweAlIb3gNgB8nua4dc0F6lhdkd0ANTYUMIPdKHobMHXiKGa4I8vGU+BvP+PjHaFd0g4SVzUlgxwLqKBq4rLoZn89X4JbQTYu6hlQpXYs6eqt6pIrsMH2R+7lSrQZQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1iZbij-0000dV-61; Tue, 26 Nov 2019 15:21:37 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1iZbij-0007Gd-3O; Tue, 26 Nov 2019 15:21:37 +0100
From: Alberto Garcia <berto@igalia.com>
To: Lukas Straub <lukasstraub2@web.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] block/quorum.c: stable children names
In-Reply-To: <20191121193445.2361b846@luklap>
References: <cover.1574356137.git.lukasstraub2@web.de>
 <ce10f8cf2bb9ae8a1505b59bbc2199f7b4966990.1574356137.git.lukasstraub2@web.de>
 <2ce1be55-010b-d3c3-9df4-e8e02eb522f9@redhat.com>
 <20191121193445.2361b846@luklap>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 26 Nov 2019 15:21:37 +0100
Message-ID: <w51imn667m6.fsf@maestria.local.igalia.com>
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 21 Nov 2019 07:34:45 PM CET, Lukas Straub wrote:
>> > diff --git a/block/quorum.c b/block/quorum.c
>> > index df68adcfaa..6100d4108a 100644
>> > --- a/block/quorum.c
>> > +++ b/block/quorum.c
>> > @@ -1054,6 +1054,12 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
>> >       /* We know now that num_children > threshold, so blkverify must be false */
>> >       assert(!s->is_blkverify);
>> >
>> > +    unsigned child_id;
>> > +    sscanf(child->name, "children.%u", &child_id);
>>
>> sscanf() cannot detect overflow. Do we trust our input enough to
>> ignore this shortfall in the interface, or should we be using saner
>> interfaces like qemu_strtoul()?  For that matter, why do we have to
>> reparse something; is it not already available somewhere in numerical
>> form?
>
> Yes, I wondered about that too, but found no other way. But the input
> is trusted, AFAIK the only way to add child nodes is trough
> quorum_add_child above and quorum_open and there already are adequate
> checks there.

I also don't see any other way to get that value, unless we change
BDRVQuorumState to store that information (e.g. instead of children
being a list of pointers BdrvChild ** it could be a list of {pointer,
index}, or something like that).

There's another (more convoluted) alternative if we don't want to parse
child->name. Since we only want to know if the child number equals
s->next_child_index - 1, we can do it the other way around:

   snprintf(str, 32, "children.%u", s->next_child_index - 1);

and then compare str and child->name.

Berto

