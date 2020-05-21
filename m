Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B045206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B045206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbaDg-0007Pw-Om
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 21:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jbaCq-0006zU-68
 for qemu-devel@nongnu.org; Wed, 20 May 2020 21:41:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:19324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.hu@linux.intel.com>)
 id 1jbaCm-0002mk-2t
 for qemu-devel@nongnu.org; Wed, 20 May 2020 21:41:07 -0400
IronPort-SDR: qfnxOiWMQSVYOSTS34HOVrSzzumm1ik36rgYL+EB6uaOiudrjlmOrk30C5AzlCnL+cYCljNdEY
 7ZmV7dHbYhlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 18:40:57 -0700
IronPort-SDR: SZaIfhaVw5No94L0mQ147aZz0kdN72VpdSLi8L3BM6K99i9kp9rXDOtwHmeHAiK/6htdvnbHvW
 5fQeuNwniPnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; d="scan'208";a="308893282"
Received: from sqa-gate.sh.intel.com (HELO robert-ivt.tsp.org)
 ([10.239.48.212])
 by FMSMGA003.fm.intel.com with ESMTP; 20 May 2020 18:40:55 -0700
Message-ID: <40954b28075efac72948a9fd43b59ff4e2e9f42a.camel@linux.intel.com>
Subject: Re: [PATCH v4 5/5] target/i386: remove Icelake-Client CPU model
From: Robert Hoo <robert.hu@linux.intel.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Chenyi
 Qiang <chenyi.qiang@intel.com>
Date: Thu, 21 May 2020 09:40:55 +0800
In-Reply-To: <20200520091734.GD2194189@redhat.com>
References: <20200520021007.30649-1-chenyi.qiang@intel.com>
 <20200520021007.30649-6-chenyi.qiang@intel.com>
 <20200520091734.GD2194189@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.43;
 envelope-from=robert.hu@linux.intel.com; helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 21:40:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-05-20 at 10:17 +0100, Daniel P. Berrangé wrote:
> On Wed, May 20, 2020 at 10:10:07AM +0800, Chenyi Qiang wrote:
> > There are no Icelake Desktop products in the market. Remove the
> > Icelake-Client CPU model.
> 
> QEMU has been shipping this CPU model for 2 years now. Regardless
> of what CPUs Intel are selling, it is possible for users to be
> running VMs with Icelake-Client CPU if their host satisfies the
> listed features. So I don't think it is valid to remove this.
> 
This 'Icelake-Client' actually doesn't exist. How do we define its
feature list? and who will be using it? If any special feature tailor
requirement, it can be simply achieved by '-cpu Icelake,+/-' features,
this is the correct way.

I think we should remove it. When we realize something's not correct,
we should fix it ASAP. Leaving it there will only cause more serious
issue in the future.

> Regards,
> Daniel


