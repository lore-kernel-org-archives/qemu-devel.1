Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8925C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511EB20830
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511EB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEHwj-00028T-9p
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 14:27:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEHvj-0001fK-9a
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEHvh-0005oj-2C
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:26:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1hEHvd-0005U9-Dg
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:26:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1BF6C049598
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 18:26:17 +0000 (UTC)
Received: from [10.10.123.233] (ovpn-123-233.rdu2.redhat.com [10.10.123.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 670C426E40;
	Wed, 10 Apr 2019 18:26:16 +0000 (UTC)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
References: <20181119182330.17147-1-pbonzini@redhat.com>
	<20181120114422.GA5072@work-vm>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <f6c43c98-1319-85bb-c379-72d8caacf68d@redhat.com>
Date: Wed, 10 Apr 2019 14:26:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20181120114422.GA5072@work-vm>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 10 Apr 2019 18:26:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: kvm: add VMX migration
 blocker
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410182615.Cw3VRcWmYg-J-cKPcet405l3hzS95kT7jvUmzZ5kZdY@z>

On 11/20/18 6:44 AM, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>> Nested VMX does not support live migration yet.  Add a blocker
>> until that is worked out.
>>
>> Nested SVM only does not support it, but unfortunately it is
>> enabled by default for -cpu host so we cannot really disable it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> So I'm OK with this, but it does need a release note warning whenever it
> goes in, because it'll surprise those who've already enabled nesting
> but don't use it on all their VMs.
> 

We are hitting this in Fedora 30. Now that nested VMX is enabled by
default at the kernel level, and virt-manager/boxes will use the
equivalent of -cpu host by default, libvirt managedsave (migrate to
file) and virt-manager snapshots (savevm) are rejected for default
created VMs on intel. That's quite unfortunate.

Any ideas on how to resolve this?

FYI it's the root of this bug though there's libvirt issues mixed in:
https://bugzilla.redhat.com/show_bug.cgi?id=1697997

Thanks,
Cole

