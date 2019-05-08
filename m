Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D75C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD7820644
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD7820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOM0Z-0003AC-E5
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:49:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOLxz-0000yO-68
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOLxv-0002oe-PO
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:46:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hOLxo-0002gK-6I; Wed, 08 May 2019 08:46:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39D5CC0586D8;
	Wed,  8 May 2019 12:46:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F04F5D717;
	Wed,  8 May 2019 12:46:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 60DF01132B35; Wed,  8 May 2019 14:46:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-7-thuth@redhat.com>
	<87ef5acsce.fsf@dusky.pond.sub.org>
	<b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
	<3741b9b6-632a-b517-7533-818727ef75a7@redhat.com>
Date: Wed, 08 May 2019 14:46:15 +0200
In-Reply-To: <3741b9b6-632a-b517-7533-818727ef75a7@redhat.com> (Eric Blake's
	message of "Tue, 7 May 2019 10:50:22 -0500")
Message-ID: <87y33h2jxk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 08 May 2019 12:46:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/7] tests/qemu-iotests/group: Re-use
 the "auto" group for tests that can always run
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
	qemu-block@nongnu.org,
	Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?=
	<philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 5/7/19 10:22 AM, Thomas Huth wrote:
>> On 07/05/2019 15.22, Markus Armbruster wrote:
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> Currently, all tests are in the "auto" group. This is a little bit pointless.
>>>> OTOH, we need a group for the tests that we can automatically run during
>>>> "make check" each time, too. Tests in this new group are supposed to run
>>>> with every possible QEMU configuration, for example they must run with every
>>>> QEMU binary (also non-x86), without failing when an optional features is
>>>> missing (but reporting "skip" is ok), and be able to run on all kind of host
>>>> filesystems and users (i.e. also as "nobody" or "root").
>>>> So let's use the "auto" group for this class of tests now. The initial
>>>> list has been determined by running the iotests with non-x86 QEMU targets
>>>> and with our CI pipelines on Gitlab, Cirrus-CI and Travis (i.e. including
>>>> macOS and FreeBSD).
>>>
>>> I wonder whether we should additionally limit "make check" to "quick"
>>> tests.  How slow are the non-quick auto tests for you?
>> 
>> I already sorted out some of the tests that run veeeery long, since the
>> run time on gitlab, cirrus-ci and travis is limited. "make check-block"
>> currently takes 3 minutes on my laptop, I think that's still ok?
>> 
>> When I run the tests from the auto group that are not in the quick
>> group, I currently get:
>> 
>
> My personal threshold is about 5 seconds for quick, so:
>
>> 003 1s ...
>> 007 2s ...
>
> Should these be moved to quick?
>
>> 013 5s ...
>
> this one is borderline
>
>> 014 15s ...
>> 015 9s ...
>
> Definitely not quick, but if you think they are still okay for auto, I
> can live with that.
>
>> 022 1s ...
>
> Another candidate for quick?
>
>> 023 18s ...
>
> Even longer than 14. Okay for auto?
>
> etc.

Kevin, Max?

