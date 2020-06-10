Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C8FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB032070B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0mQRB34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB032070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3Vq-0008BK-I9
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj3UN-0007Ja-Fl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:22:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jj3U1-00045E-In
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591806098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mx4J1/Bw9Gd75e2h1XvvYZswudEJ8kDP8b03hgPw2us=;
 b=Q0mQRB34Cnvcpd/yqMQF3lvkJ6pIHqyYSr69NaqqkdqbgTsCdoDYcflOqGs8FXEByPZ7m2
 xPjYK1c9hTCHLb7aHCseHRvMEzx8Fahc/zEz20FnlecUemFh9wL5AYgQEXELzU76Z5Cdx/
 bb/CdMapAoDKOLKdvEPjDtuXXWFPOBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-3YMjXHSpNVi8FXmW5iPUqg-1; Wed, 10 Jun 2020 12:21:30 -0400
X-MC-Unique: 3YMjXHSpNVi8FXmW5iPUqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F667835B45;
 Wed, 10 Jun 2020 16:21:29 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5041F6EDBE;
 Wed, 10 Jun 2020 16:21:28 +0000 (UTC)
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: David Edmondson <dme@dme.org>, Sam Eiderman <sameid@google.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
 <20200610140620.GE6947@linux.fritz.box>
 <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
 <CAFr6bUksp1Nm4nL69na5WDj6A5iXzwcc4K3=JNnyP4xZ+HKJHA@mail.gmail.com>
 <m2bllr7wrg.fsf@dme.org> <999a1a74-d082-bcdb-e3f9-6c44b2526433@redhat.com>
 <m28sgu9ame.fsf@dme.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <03718921-c988-98e2-3a72-3f10b9f14fcd@redhat.com>
Date: Wed, 10 Jun 2020 11:21:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <m28sgu9ame.fsf@dme.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Tony Zhang <tzz@google.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 10:57 AM, David Edmondson wrote:
> On Wednesday, 2020-06-10 at 10:48:52 -05, Eric Blake wrote:
> 
>> On 6/10/20 10:42 AM, David Edmondson wrote:
>>> On Wednesday, 2020-06-10 at 18:29:33 +03, Sam Eiderman wrote:
>>>
>>>> Excuse me,
>>>>
>>>> Vladimir already pointed out in the first comment that it will skip
>>>> writing real zeroes later.
>>>
>>> Right. That's why you want something like "--no-need-to-zero-initialise"
>>> (the name keeps getting longer!), which would still write zeroes to the
>>> blocks that should contain zeroes, as opposed to writing zeroes to
>>> prepare the device.
>>
>> Or maybe something like:
>>
>> qemu-img convert --skip-unallocated
> 
> This seems fine.
> 
>> which says that a pre-zeroing pass may be attempted, but it if fails,
> 
> This bit puzzles me. In what circumstances might we attempt but fail?
> Does it really mean "if it can be done instantly, it will be done, but
> not if it costs something"?

A fast pre-zeroing pass is faster than writing explicit zeroes.  If such 
a fast pass works, then you can avoid further I/O for all subsequent 
zero sections; the unallocated sections will now happen to read as zero, 
but that is not a problem since the content of unallocated portions is 
not guaranteed.

But if pre-zeroing is not fast, then you have to spend the extra I/O to 
explicitly zero the portions that are allocated but read as zero, while 
still skipping the unallocated portions.

> 
> I'd be more inclined to go for "unallocated blocks will not be written",
> without any attempts to pre-zero.

But that can be slower, when pre-zeroing is fast.  "Unallocated blocks 
need not be written" allows for optimizations, "unallocated blocks must 
not be touched" does not.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


