Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895DFC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555682070D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555682070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmTh-0003e5-L5
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:51:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmSo-0003ES-KX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDmSn-0001st-NJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDmSl-0001qD-Fz; Tue, 09 Apr 2019 04:50:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52F09D571A;
	Tue,  9 Apr 2019 08:50:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EB0C569181;
	Tue,  9 Apr 2019 08:50:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5A1EA1138648; Tue,  9 Apr 2019 10:50:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
	<87mukzei52.fsf@dusky.pond.sub.org>
	<b294fe82-69e8-e4a3-9491-11445cdca15f@redhat.com>
	<87tvf7d1a6.fsf@dusky.pond.sub.org>
	<17e16697-2f36-cdf3-4067-a04f5de6b66c@redhat.com>
Date: Tue, 09 Apr 2019 10:50:36 +0200
In-Reply-To: <17e16697-2f36-cdf3-4067-a04f5de6b66c@redhat.com> (Thomas Huth's
	message of "Tue, 9 Apr 2019 10:40:14 +0200")
Message-ID: <87zhozbm03.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 09 Apr 2019 08:50:38 +0000 (UTC)
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
Message-ID: <20190409085036.TOGwudfb6PX0Rfsorf0b_kL3k8Mla9OpoP1bZ-21T6Q@z>

Thomas Huth <thuth@redhat.com> writes:

> On 09/04/2019 10.35, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> On 09/04/2019 09.45, Markus Armbruster wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> We'd like to get rid of global_qtest in the long run (since it is
>>>>> causing trouble for tests that run multiple instances of QEMU in
>>>>> parallel, e.g. migration tests)... so if it is feasible, please don't
>>>>> use it in new code anymore. Try to use a local variable in the function
>>>>> that call qtest_initf() and pass the test state around via a parameter
>>>>> to the functions that need it.
>>>>
>>>> Twenty tests still use @global_qtest
>>>>
>>>> Either we're serious about getting rid of @global_qtest.  Then we should
>>>> just do it.
>>>
>>> Ha ha, "just do it" ... that's quite a bit of work, actually. It's not
>>> just about grep'ing for global_qtest, you also have to replace all the
>>> writel(), readl() etc. functions with qtest_writel(), qtest_readl() etc.
>> 
>> And that's precisely why I'm reluctant to demand this work from
>> contributors.  Asking nicely is of course fair.
>
> That's what I did, didn't I? I said "... so if it is feasible, please
> don't use it in new code anymore". I did not say "you must not use this
> in new code anymore". So where's your problem here, Markus?

You did, I don't have a problem, I just wanted to make quite sure your
asking nicely wasn't misunderstood as a polite way to demand.

[...]

