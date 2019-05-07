Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA80C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4738620825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 18:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4738620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51099 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO4cs-0007qA-JI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 14:15:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hO4c8-0007TU-V7
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hO4c8-0000Ic-1h
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:14:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hO4c7-0000HV-SC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 14:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3247C46289;
	Tue,  7 May 2019 18:14:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28694173BB;
	Tue,  7 May 2019 18:14:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9C0761132B35; Tue,  7 May 2019 20:14:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
	<004401d503db$9e66b530$db341f90$@ru>
Date: Tue, 07 May 2019 20:14:43 +0200
In-Reply-To: <004401d503db$9e66b530$db341f90$@ru> (Pavel Dovgalyuk's message
	of "Mon, 6 May 2019 10:16:26 +0300")
Message-ID: <874l669lnw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 07 May 2019 18:14:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 00/24] Fix record/replay and add
 reverse debugging
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
Cc: peter.maydell@linaro.org, war2jordan@live.com, pavel.dovgaluk@ispras.ru,
	mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
	kraxel@redhat.com, thomas.dullien@googlemail.com,
	artem.k.pisarenko@gmail.com, quintela@redhat.com,
	ciro.santilli@gmail.com, armbru@redhat.com, dgilbert@redhat.com,
	boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net,
	kwolf@redhat.com, crosthwaite.peter@gmail.com, mreitz@redhat.com,
	'Pavel Dovgalyuk' <pavel.dovgaluk@gmail.com>,
	maria.klimushenkova@ispras.ru, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Pavel Dovgalyuk" <dovgaluk@ispras.ru> writes:

> Ping.
> Can anyone PULL these patches?

Paolo?

