Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F9ECE599
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 20:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17FA207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 20:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17FA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKpkh-0002QU-9o
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 16:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jae.hyun.yoo@linux.intel.com>) id 1iKoZW-0002N8-PM
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jae.hyun.yoo@linux.intel.com>) id 1iKoZV-0006qz-6L
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:02:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:17053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jae.hyun.yoo@linux.intel.com>)
 id 1iKoZU-0006o2-Us; Wed, 16 Oct 2019 15:02:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Oct 2019 12:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; d="scan'208";a="186243015"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143])
 ([10.7.153.143])
 by orsmga007.jf.intel.com with ESMTP; 16 Oct 2019 12:02:49 -0700
Subject: Re: [PATCH 1/5] aspeed/i2c: Add support for pool buffer transfers
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191016085035.12136-1-clg@kaod.org>
 <20191016085035.12136-2-clg@kaod.org>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <03475e1b-84c3-f5d1-ac23-81365ea150b9@linux.intel.com>
Date: Wed, 16 Oct 2019 12:02:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016085035.12136-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
X-Mailman-Approved-At: Wed, 16 Oct 2019 16:16:12 -0400
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.vnet.ibm.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/2019 1:50 AM, Cédric Le Goater wrote:
> The Aspeed I2C controller can operate in different transfer modes :
> 
>    - Byte Buffer mode, using a dedicated register to transfer a
>      byte. This is what the model supports today.
> 
>    - Pool Buffer mode, using an internal SRAM to transfer multiple
>      bytes in the same command sequence.
> 
> Each SoC has different SRAM characteristics. On the AST2400, 2048
> bytes of SRAM are available at offset 0x800 of the controller AHB
> window. The pool buffer can be configured from 1 to 256 bytes per bus.
> 
> On the AST2500, the SRAM is at offset 0x200 and the pool buffer is of
> 16 bytes per bus.
> 
> On the AST2600, the SRAM is at offset 0xC00 and the pool buffer is of
> 32 bytes per bus. It can be splitted in two for TX and RX but the
> current model does not add support for it as it it unused by known
> drivers.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

