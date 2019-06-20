Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE84FC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8706B20B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8706B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdq2N-0003D0-QL
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 01:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56700)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hdpyE-0007pv-Vx
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hdpyD-00047g-1F
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:50:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1hdpy8-00043F-UA; Thu, 20 Jun 2019 01:50:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F4D175724;
 Thu, 20 Jun 2019 05:50:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com
 [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7E9B19C6F;
 Thu, 20 Jun 2019 05:50:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9D48316E19; Thu, 20 Jun 2019 07:50:38 +0200 (CEST)
Date: Thu, 20 Jun 2019 07:50:38 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190620055038.w7zwwxviqfp4vxvr@sirius.home.kraxel.org>
References: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
 <156093697557.22612.8821990862661724517@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156093697557.22612.8821990862661724517@ce79690b2cb9>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 05:50:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [SeaBIOS] [QEMU] [PATCH v4 0/8] Add Qemu to
 SeaBIOS LCHS interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, mreitz@redhat.com, kevin@koconnor.net,
 shmuel.eiderman@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> === OUTPUT BEGIN ===
> 1/8 Checking commit cf2168a66dbd (block: Refactor macros - fix tabbing)
> ERROR: Macros with complex values should be enclosed in parenthesis
> #55: FILE: include/hw/block/block.h:65:
> +#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                      \
> +    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                  \
> +    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),                \
>      DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)

False positive.

> 8/8 Checking commit 6664d7d898d5 (hd-geo-test: Add tests for lchs override)
> WARNING: line over 80 characters
> #242: FILE: tests/hd-geo-test.c:579:
> +                     (char *)r->dev_path, &(r->chs.c), &(r->chs.h), &(r->chs.s));

Should be fixed.

> WARNING: Block comments use a leading /* on a separate line
> #640: FILE: tests/hd-geo-test.c:995:
> +                       "skipping hd-geo/override/* tests");

False positive too.

cheers,
  Gerd


