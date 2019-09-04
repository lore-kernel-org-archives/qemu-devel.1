Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB963C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C021D2339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C021D2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Vbw-0003H0-Lr
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i5VaD-0001ax-07
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i5VaC-0002gZ-3i
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i5Va8-0002dd-Ec; Wed, 04 Sep 2019 09:44:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B30CD7F767;
 Wed,  4 Sep 2019 13:44:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-221.ams2.redhat.com
 [10.36.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B631A19C4F;
 Wed,  4 Sep 2019 13:44:14 +0000 (UTC)
Date: Wed, 4 Sep 2019 15:44:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190904134413.GB21246@localhost.localdomain>
References: <1567588284-975381-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567588284-975381-1-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 04 Sep 2019 13:44:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 0/6] Allow Valgrind checking all QEMU
 processes
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
Cc: vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.09.2019 um 11:11 hat Andrey Shinkevich geschrieben:
> In the current implementation of the QEMU bash iotests, only qemu-io
> processes may be run under the Valgrind with the switch '-valgrind'.
> Let's allow the common.rc bash script running all other QEMU processes,
> such as qemu-kvm, qemu-img, qemu-ndb and qemu-vxhs, under the Valgrind.
> 
> v8:
>   01: Fix for the optimization made in v7 where the iotests 039 and 051
>       did not pass being run under the Valgrind. NO_VALGRIND variable
>       has been introduced to complete the optimization logic (patch 2/6).

Thanks, applied to the block branch.

Kevin

