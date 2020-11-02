Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF027C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEF020678
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEF020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZgbB-00087y-U2
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kZga2-0007GE-Mj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:37:31 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:40700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1kZga0-0007Z9-Qv
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:37:30 -0500
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 0CE1EB6F;
 Mon,  2 Nov 2020 21:37:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XK8-eOh2zJvA; Mon,  2 Nov 2020 21:37:24 +0100 (CET)
Received: from function (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr
 [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 403535AB;
 Mon,  2 Nov 2020 21:37:24 +0100 (CET)
Received: from samy by function with local (Exim 4.94)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1kZgZv-00EGma-Cn; Mon, 02 Nov 2020 21:37:23 +0100
Date: Mon, 2 Nov 2020 21:37:23 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Does QEMU's coverity-scan run need to track coverity issues in
 dtb or slirp ?
Message-ID: <20201102203723.t7p4ildto3xbbdsx@function>
References: <CAFEAcA93d5VKj+jbJQcyxsG+54G32r1k53DPT8rGRqZcROU2hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA93d5VKj+jbJQcyxsG+54G32r1k53DPT8rGRqZcROU2hA@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Received-SPF: softfail client-ip=185.233.100.1;
 envelope-from=samuel.thibault@gnu.org; helo=hera.aquilenet.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 15:37:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: marcandre.lureau@gmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Peter Maydell, le lun. 02 nov. 2020 19:54:14 +0000, a ecrit:
> Do dtc and slirp as upstream projects already track Coverity issues

We started tracking them yes.

Samuel

