Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F16BC282DA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532B9206C0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532B9206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRc6-0001sb-Hg
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:22:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCRZe-000052-D1
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hCRZc-0004hE-6M
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hCRZI-000425-Pr; Fri, 05 Apr 2019 12:20:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E61A73087931;
	Fri,  5 Apr 2019 16:12:02 +0000 (UTC)
Received: from work-vm (ovpn-117-242.ams2.redhat.com [10.36.117.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9968960C7A;
	Fri,  5 Apr 2019 16:12:01 +0000 (UTC)
Date: Fri, 5 Apr 2019 17:11:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190405161158.GA3275@work-vm>
References: <20190405114513.3141-1-armbru@redhat.com>
	<20190405125140.GB4597@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405125140.GB4597@linux.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 05 Apr 2019 16:12:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0] hmp: Fix drive_add ... format=help
 crash
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com,
	Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405161159.eDIPnNjrHoBQHo6ou5GIA3_wiLvFwKyTeF5_Kxy9bGc@z>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 05.04.2019 um 13:45 hat Markus Armbruster geschrieben:
> > drive_new() returns null without setting an error when it provided
> > help.  add_init_drive() assumes null means failure, and crashes trying
> > to report a null error.
> > 
> > Fixes: c4f26c9f37ce511e5fe629c21c180dc6eb7c5a25
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> We should probably have a test case for this.

Perhaps just adding:

drive_add 0 format=help

to the hmp_cmds list in tests/test-hmp.c  ?

Dave

> Kevin
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

