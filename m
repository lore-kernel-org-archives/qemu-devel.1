Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71BCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2B5206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9500zZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2B5206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpeW-0007o7-5s
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYpTk-0005HE-Hy
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:23:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jYpTj-0006cd-PL
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589368990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7kHMfacoIFVM069h+B2k6eoQbprIkQzen9v4EN7ZPY8=;
 b=a9500zZSOJ4IfNO4i+BsxWIfc6B81Su9mSoWSOP+r7bAgLEkI48VMzn5RI3jiMOrDvweTc
 DpPDXME9pXEJpW9iWiMGxRNsocMYi43D3XA95uLR8iLDc1imvjTana6nk2aG9/GYea01+9
 /vAfx1ATJmHksIFZkOxAQgioUf6yaK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-xx-l3ce4OZG-4gE6jr1wXw-1; Wed, 13 May 2020 07:23:09 -0400
X-MC-Unique: xx-l3ce4OZG-4gE6jr1wXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9E5881E22C;
 Wed, 13 May 2020 11:23:07 +0000 (UTC)
Received: from kaapi (unknown [10.74.9.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D4B6619AC;
 Wed, 13 May 2020 11:23:03 +0000 (UTC)
Date: Wed, 13 May 2020 16:52:58 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] megasas: use unsigned type for positive numeric fields
In-Reply-To: <CAFEAcA_01feEPG-PbQ9Msy3MNV4qSb2zVJyLAMGcOwfrhezkfQ@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.2005131651260.1451610@xnncv>
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <20200507105718.1319187-3-ppandit@redhat.com>
 <CAFEAcA_01feEPG-PbQ9Msy3MNV4qSb2zVJyLAMGcOwfrhezkfQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 12 May 2020, Peter Maydell wrote --+
| Does an INT32->UINT32 change in vmstate break migration compat? I forget, 
| but this is the kind of detail it's worth calling out in the commit message 
| if you've checked and it really is still compatible.

No, not sure.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


