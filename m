Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05990C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64E920883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 18:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64E920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40934 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgz9-0005Uu-4m
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 14:38:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVgyM-0005CE-5G
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVgyK-0002HI-9H
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVgyI-0002G5-Jo
	for qemu-devel@nongnu.org; Tue, 28 May 2019 14:37:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D807BC05D419
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 18:37:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 54D7E5D6A9;
	Tue, 28 May 2019 18:37:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C2C4E1138648; Tue, 28 May 2019 20:37:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <87a7f7ov6q.fsf@dusky.pond.sub.org>
	<18bac6f1-3bd8-f4c1-3f19-34084cc9553b@redhat.com>
Date: Tue, 28 May 2019 20:37:01 +0200
In-Reply-To: <18bac6f1-3bd8-f4c1-3f19-34084cc9553b@redhat.com> (Paolo
	Bonzini's message of "Tue, 28 May 2019 19:46:18 +0200")
Message-ID: <87muj6juia.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 28 May 2019 18:37:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Make target check-report.tap is broken
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/05/19 10:11, Markus Armbruster wrote:
>> Commit 9df43317b82 "test: replace gtester with a TAP driver" replaced
>> targets check-report.xml and check-report.html by
>> 
>> check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
>> 	$(call quiet-command,./scripts/tap-merge.py $^ > $@,"GEN","$@")
>> 
>> This never worked: scripts/tap-merge.py does not exist.
>> 
>> Perhaps it accidentally wasn't committed.
>> 
>> Perhaps it's just a typoed tap-merge.pl.  But that one reads its intput
>> from stdin.  Possible fix appended.
>
> Indeed that's the right one.

Then I'll post it as a proper patch.  Thanks!

