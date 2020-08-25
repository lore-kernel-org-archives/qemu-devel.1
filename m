Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A1CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDEE20706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 06:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDEE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAS2r-0004oC-M9
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 02:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1kARzL-0002dL-23; Tue, 25 Aug 2020 01:59:19 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3]:58420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1kARzJ-0000QT-Du; Tue, 25 Aug 2020 01:59:18 -0400
Received: from blackfin.pond.sub.org
 (p200300d36f1be000dacb8afffee0c842.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f1b:e000:dacb:8aff:fee0:c842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 23C812191B;
 Tue, 25 Aug 2020 07:59:10 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE32E112D737; Tue, 25 Aug 2020 07:59:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] tests: fix a memory in test_socket_unix_abstract_good
In-Reply-To: <CAKXe6SJ0+qvRQaKxirq=j9jAaKAdjXZzxVoMTbcQg_W=RcGz8g@mail.gmail.com>
 (Li Qiang's message of "Fri, 14 Aug 2020 00:32:30 +0800")
References: <20200603161409.54682-1-liq3ea@163.com>
 <CAKXe6SJ-HNK-ZKYcGCGsiUmYi_MVGrVmSvric2OjK5m2q=TBjg@mail.gmail.com>
 <20200624105644.GG774096@redhat.com>
 <CAKXe6SJ0+qvRQaKxirq=j9jAaKAdjXZzxVoMTbcQg_W=RcGz8g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 25 Aug 2020 07:59:07 +0200
Message-ID: <87v9h7jmfo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 zxq_yx_007@163.com, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org,
 marcandre lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Li Qiang <liq3ea@gmail.com> writes:

> Hi Daniel,
> It seems this patch still not in the upstream.

Cc: qemu-trivial, hope this helps.

