Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD89C74A54
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C98E2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C98E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXJg-0000B5-K8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlXJ2-00089S-4v
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlXJ1-0000a9-80
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:32:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlXJ1-0000YP-25
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:32:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2A9D3082132;
 Thu, 11 Jul 2019 11:32:05 +0000 (UTC)
Received: from redhat.com (ovpn-117-151.ams2.redhat.com [10.36.117.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A3A9194B3;
 Thu, 11 Jul 2019 11:32:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <c2bfa537-8a5a-86a1-495c-a6c1d0f85dc5@redhat.com> (Paolo
 Bonzini's message of "Thu, 11 Jul 2019 13:19:44 +0200")
References: <20190711104412.31233-1-quintela@redhat.com>
 <c2bfa537-8a5a-86a1-495c-a6c1d0f85dc5@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Thu, 11 Jul 2019 13:32:02 +0200
Message-ID: <87ftncvmbx.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 11 Jul 2019 11:32:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 11/07/19 12:43, Juan Quintela wrote:
>> The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fdfa:
>> 
>>   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
>> 
>> are available in the Git repository at:
>> 
>>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>> 
>> for you to fetch changes up to 0b47e79b3d04f500b6f3490628905ec5884133df:
>> 
>>   migration: allow private destination ram with x-ignore-shared
>> (2019-07-11 12:30:40 +0200)
>
> Aren't we in hard freeze already?

They were sent bedfore the hard freeze, no?

Later, Juan.

