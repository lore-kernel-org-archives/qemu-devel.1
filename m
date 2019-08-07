Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD546C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CF22238C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CF22238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHaO-0003rX-25
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47684)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hvHZl-0003QX-Jo
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hvHZk-0002Pc-Lj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:45:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hvHZk-0002P5-H2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 074F5FA8C4;
 Wed,  7 Aug 2019 08:45:39 +0000 (UTC)
Received: from redhat.com (ovpn-116-161.ams2.redhat.com [10.36.116.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 758405D717;
 Wed,  7 Aug 2019 08:45:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Ivan Ren <renyime@gmail.com>
In-Reply-To: <1564464816-21804-2-git-send-email-ivanren@tencent.com> (Ivan
 Ren's message of "Tue, 30 Jul 2019 13:33:34 +0800")
References: <1564464816-21804-1-git-send-email-ivanren@tencent.com>
 <1564464816-21804-2-git-send-email-ivanren@tencent.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 07 Aug 2019 10:45:35 +0200
Message-ID: <8736id4b4g.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 07 Aug 2019 08:45:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/3] migration: add
 qemu_file_update_transfer interface
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, richardw.yang@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ivan Ren <renyime@gmail.com> wrote:
> From: Ivan Ren <ivanren@tencent.com>
>
> Add qemu_file_update_transfer for just update bytes_xfer for speed
> limitation. This will be used for further migration feature such as
> multifd migration.
>
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com> 

Reviewed-by: Juan Quintela <quintela@redhat.com>

