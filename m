Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481C7C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2A82054F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rXzVIvXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2A82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiI4l-00067h-7d
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berto@igalia.com>) id 1hiI2X-000499-S7
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1hiI2W-0000zo-Vs
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:37:41 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:32782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1hiI2Q-0000Tk-W7; Tue, 02 Jul 2019 08:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=0u1tsK7A42zMIAwbirT2Br0EYed33d2mFT9q2BRfJe0=; 
 b=rXzVIvXaknHVgzosEWImykPWDUh8DWuQOuWz3TIgyBftxf6eBfu3yT290tFY0umy1qH6DFGluO+oWg/7PzNAykr05b5lqy2phoK/jHLAVKeayNr5DiHuw/n5WFOvjajuospRxlsZUhdT9PWnEJmiUVWzmWs3BuXoetCUcEuI5hAijebTYFuZSs6aUaupezOhy5rtfuo/C9iJDKXr4ulAVpF5fWjNx0/0wjYnmcvwsV0HBw9mg7lJANEFf/fUKESZf/vRINvqf3HAPLK0HsBn5znBnyXN3shPu9SMxsw2FEjjASOw75BbycQSLuxa85p/G0EsV8DacMnwIut1Ic3wqg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1hiI27-0001t7-0e; Tue, 02 Jul 2019 14:37:15 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1hiI26-0000Zj-Tt; Tue, 02 Jul 2019 14:37:14 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
In-Reply-To: <20190627223255.3789-4-mreitz@redhat.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-4-mreitz@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Tue, 02 Jul 2019 14:37:14 +0200
Message-ID: <w511rz87gud.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH 3/5] iotests: Compare error messages in 030
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 28 Jun 2019 12:32:53 AM CEST, Max Reitz wrote:
> Currently, 030 just compares the error class, which does not say
> anything.
>
> Before HEAD^ added throttling to test_overlapping_4, that test actually
> usually failed because node2 was already gone, not because it was the
> commit and stream job were not allowed to overlap.
>
> Prevent such problems in the future by comparing the error description
> instead.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

