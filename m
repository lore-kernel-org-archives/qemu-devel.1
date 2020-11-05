Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7553CC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12BB2080D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9V8Akxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12BB2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaSoJ-0003Uz-Eo
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 19:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kaSnk-000346-4P
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kaSng-0008EP-N0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604534806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQyIO+g9BoYfRhzoHUqPPvjbo4v0eX+WS5RhTeVZr6Y=;
 b=i9V8AkxqcZI0wucPzdo869QZNeZAMkEkSet0euE7APzUVkNXESHZfmMl8CysYz9hRnKdyV
 xR+R0y6JreqHADCK1QUdy8y9XQQFgIY5PMRJ86JipCSSTE9Vr7qF8eH7gWi9s+yJdNtmG9
 waGOAbnWjm37t/17qmQWxnb79SD4PFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-mD7K1TlsN6e2lbxIW8T9bg-1; Wed, 04 Nov 2020 19:06:43 -0500
X-MC-Unique: mD7K1TlsN6e2lbxIW8T9bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A843C8030B0;
 Thu,  5 Nov 2020 00:06:41 +0000 (UTC)
Received: from [10.10.113.61] (ovpn-113-61.rdu2.redhat.com [10.10.113.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69B8619D61;
 Thu,  5 Nov 2020 00:06:39 +0000 (UTC)
Subject: Re: Migrating to the gitlab issue tracker
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
Date: Wed, 4 Nov 2020 19:06:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 6:57 AM, Peter Maydell wrote:
> On Fri, 30 Oct 2020 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> This
>> makes it more appealing to leave existing bugs in the LP tracker until
>> they are resolved, auto-closed, or there is a compelling reason to move
>> to gitlab.
> 
> The compelling reason is that there is no way that I want to
> have to consult two entirely separate bug tracking systems
> to see what our reported bugs are. We must have an entry
> in the new BTS for every 'live' bug, whether it was originally
> reported to LP or to gitlab.
> 

OK. I will try to investigate using the Launchpad API to pull our 
existing information, and then using the Gitlab API to re-create them. 
We will lose things like the list of subscribers and account 
information. Tags, Priority and Status can be preserved as labels. I'm 
not sure what the fate of attachments and other things are yet, I will see.


Current status, as of the start of this email:

New: 751 items
Opinion: 10 items
Invalid: 373 items
Won't Fix: 88 items
Expired: 438 items
Confirmed: 56 items
Triaged: 21 items
In Progress: 21 items
Fix Committed: 10 items
Fix Released: 1034 items
Incomplete (with response): 1 item
Incomplete (without response): 17 items


I think these things we do not have to migrate at all:

- Invalid
- Won't Fix
- Expired
- Fix Committed (Let's just graduate them to Released on LP.)
- Fix Released (Already done)


The Incomplete bugs we can likely avoid migrating; we can just let them 
expire as they are quite likely to do. This might leave us open to a 
situation where we might need to manually migrate or handle a bug or two 
that revives itself from the Incomplete tag, but it should be 
exceedingly few cases.

The Opinion tag is for, by description, "Doesn't fit with the project, 
but can be discussed." They don't have to be migrated, but sometimes 
this status was used "accidentally" by the reporter; so we can switch 
those back to Incomplete, Wontfix, or Released as appropriate.


That leaves these:

- New (755)
- Confirmed (59)
- Triaged (21)
- In Progress (6)


Likely we can migrate everything in the New/Confirmed/Triaged categories 
all as "new" bugs to Gitlab.

We could keep the "Confirmed" stage as a label as a hint for us on which 
ones to re-triage first, it should go quickly. We could also make a 
temporary "formerly-triaged" label for the "Triaged" state to give us a 
hint for a small handful of bugs to re-triage first.

That leaves "In Progress", which is a pretty small list now:

https://bugs.launchpad.net/qemu/+bugs?search=Search&field.status=In+Progress

Perhaps small enough to not worry about migrating these and just 
special-casing working through them for the migration, either:

1. Getting the attention of the contributor and getting them hooked into 
gitlab to own the new bug as a manual migration
2. Marking the bug as Fix Committed if it's done, or
3. Kicking the bug back to New if nobody is working on it.


Thanks,
--js


