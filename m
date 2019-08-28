Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABC7C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7272070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 10:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7272070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2vTI-0006qX-9L
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 06:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i2vRg-00064f-Q0
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i2vRf-0004rP-LI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 06:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i2vRd-0004i7-GK; Wed, 28 Aug 2019 06:44:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C3BA3308FC22;
 Wed, 28 Aug 2019 10:44:51 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C24FB50;
 Wed, 28 Aug 2019 10:44:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <20190827185913.27427-3-nsoffer@redhat.com> (Nir Soffer's message
 of "Tue, 27 Aug 2019 21:59:13 +0300")
References: <20190827185913.27427-1-nsoffer@redhat.com>
 <20190827185913.27427-3-nsoffer@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 28 Aug 2019 12:44:45 +0200
Message-ID: <87h861muw2.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 28 Aug 2019 10:44:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block: Remove unused masks
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nir Soffer <nirsof@gmail.com> wrote:
> Replace confusing usage:
>
>     ~BDRV_SECTOR_MASK
>
> With more clear:
>
>     (BDRV_SECTOR_SIZE - 1)
>
> Remove BDRV_SECTOR_MASK and the unused BDRV_BLOCK_OFFSET_MASK which was
> it's last user.
>
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

