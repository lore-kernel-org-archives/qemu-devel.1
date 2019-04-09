Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC03C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D307720883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D307720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmFa-0007pc-By
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:37:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmEm-0007OQ-HE
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmEi-00032V-K8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDmDs-0002Sn-Ub; Tue, 09 Apr 2019 04:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2ACC7DCE1;
	Tue,  9 Apr 2019 08:35:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BD86600D4;
	Tue,  9 Apr 2019 08:35:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9E2A41138648; Tue,  9 Apr 2019 10:35:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
	<87mukzei52.fsf@dusky.pond.sub.org>
	<b294fe82-69e8-e4a3-9491-11445cdca15f@redhat.com>
Date: Tue, 09 Apr 2019 10:35:13 +0200
In-Reply-To: <b294fe82-69e8-e4a3-9491-11445cdca15f@redhat.com> (Thomas Huth's
	message of "Tue, 9 Apr 2019 10:16:33 +0200")
Message-ID: <87tvf7d1a6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 09 Apr 2019 08:35:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 01/10] block/pflash_cfi02: Add test for
 supported commands
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stephen Checkoway <s@pahtak.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409083513.UFTpCMnHouxPwH5ziRwWWkW2KymHMyZ1CWSIFzlwXBg@z>

Thomas Huth <thuth@redhat.com> writes:

> On 09/04/2019 09.45, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> We'd like to get rid of global_qtest in the long run (since it is
>>> causing trouble for tests that run multiple instances of QEMU in
>>> parallel, e.g. migration tests)... so if it is feasible, please don't
>>> use it in new code anymore. Try to use a local variable in the function
>>> that call qtest_initf() and pass the test state around via a parameter
>>> to the functions that need it.
>> 
>> Twenty tests still use @global_qtest
>> 
>> Either we're serious about getting rid of @global_qtest.  Then we should
>> just do it.
>
> Ha ha, "just do it" ... that's quite a bit of work, actually. It's not
> just about grep'ing for global_qtest, you also have to replace all the
> writel(), readl() etc. functions with qtest_writel(), qtest_readl() etc.

And that's precisely why I'm reluctant to demand this work from
contributors.  Asking nicely is of course fair.

> If you feel like this is a "just do it" quick task, you're welcome to help!
>
>> Or we're not.  Then we shouldn't ask contributors to do extra work.
>
> We are:
>
>  git log --oneline -- tests | grep global_qtest
>
> ... it just takes time.
>
>  Thomas

