Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A72E207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aZO64TQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A72E207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Jmx-0004sA-OA
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8JmO-0004Mh-L0; Wed, 19 Aug 2020 04:49:08 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:44386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1k8JmM-0004Pq-Bi; Wed, 19 Aug 2020 04:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=5hYuOriTErHucTv7XkAWQPSMAW3y9nFBqTnFDzQye/U=; 
 b=aZO64TQ7W2/IHCO1OeMvAuAov8oOpOwpfowJQUrGSaQuscTkWlqlvccbl2A16Sz/rdhc0OCbm4jyN6i9lYUrg7BlC9FWX3D1/JsLITjiQOlQbDSukSuKmB0Jomc9WoCst1VAd4Tz/1oTwUpuqlZ+DueBtLR0iL7Vrb9yuDumySZLXPA8RBdoz7g0H7UmMNw1+FMkNJr5jU/Cj95N+imV2eEsmtQJtVdJhE+depoD/204yoGBW7GkKS6eMMBreaE7FEqYuo7n0xQzgpPrqdwPccShjOQE9NI9knsPNKR3txgIpLuJAqVnsG0cp/Lbr0KNYkgi0J1vp2zqGkFmvysLEQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1k8Jlw-00044u-EH; Wed, 19 Aug 2020 10:48:40 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1k8Jlw-0001Ie-4u; Wed, 19 Aug 2020 10:48:40 +0200
From: Alberto Garcia <berto@igalia.com>
To: Yi Li <yili@winhong.com>, qemu-block@nongnu.org, mreitz@redhat.com,
 sgarzare@redhat.com
Subject: Re: [PATCH v2] qemu-img: Explicit number replaced by a constant
In-Reply-To: <20200819013607.32280-1-yili@winhong.com>
References: <0107e40a-1d96-fa3d-bd15-019c004d0353@redhat.com>
 <20200819013607.32280-1-yili@winhong.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Wed, 19 Aug 2020 10:48:40 +0200
Message-ID: <w51y2mbdnrr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:48:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, yilikernel@gmail.com, qemu-devel@nongnu.org,
 yili@winhong.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 19 Aug 2020 03:36:07 AM CEST, Yi Li wrote:
> Signed-off-by: Yi Li <yili@winhong.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

