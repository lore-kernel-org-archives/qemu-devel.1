Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A709C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4F621479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4F621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3sx-0000k6-OU
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:40:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP3rx-0008HJ-U3
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP3rx-0006jR-2r
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:39:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hP3ru-0006fR-JW; Fri, 10 May 2019 07:39:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B354C0568FE;
	Fri, 10 May 2019 11:39:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E6F3646B1;
	Fri, 10 May 2019 11:39:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A88A81132B35; Fri, 10 May 2019 13:38:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-7-thuth@redhat.com>
	<87ef5acsce.fsf@dusky.pond.sub.org>
	<b53b7591-44fa-2982-6674-91137f69be63@redhat.com>
	<3741b9b6-632a-b517-7533-818727ef75a7@redhat.com>
	<44a3ebee-c717-d953-8e89-c24da99209a6@redhat.com>
	<f39169a4-3916-9d1a-b3a5-b667e8775217@redhat.com>
Date: Fri, 10 May 2019 13:38:59 +0200
In-Reply-To: <f39169a4-3916-9d1a-b3a5-b667e8775217@redhat.com> (Thomas Huth's
	message of "Fri, 10 May 2019 10:55:27 +0200")
Message-ID: <87a7fusfn0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 10 May 2019 11:39:08 +0000 (UTC)
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
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> Thinking about this again, "make check" now runs quite a bit longer
> indeed. So I now rather tend to remove the tests that run longer than 5s
> from the auto group instead... I think I'll send a v4 of this patch
> where I'll remove them from the auto group.

Appreciated!

I'm all for automated testing, but "make check" is already slow enough
to make certain kinds of work painful.  Not quite slow enough to make me
renege on commitments and go on a quest to speed it up.

