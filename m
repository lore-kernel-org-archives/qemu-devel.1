Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C6DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3702064A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3702064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2jul-0008FU-S5
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 18:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2jtk-0007aH-Mk
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2jti-0004uM-Sh
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:25:07 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:34955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i2jti-0004qL-LS
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:25:06 -0400
IronPort-SDR: DelAkQqaDXpK27kokO0lEPtAonkWL3n6XCbrQdIotCk7imsrDdTlyb9YvoUgQXc1IGp2/3izDi
 J8Mhdw3Fkqq8S1aJRx3zBgWxaQY2rTgq+1FAgpuwokyoJZfgT1xWwDlKlkBUQ83r1pC+JpmzOq
 IXWCHI09g55UzVMKVm9V+wNaIFN3UnBcJ+/0L9+1iQ/kXw2larMC7cEIOtODsIuSSoGEfn9rEB
 H6xN9qxkcsnf8xIB2gDWSY8tbPlThXoF4G/LuPiSIbidc/Yr2WfGFnaJfuneIDLePNdwWI+Yx/
 FAc=
X-IronPort-AV: E=Sophos;i="5.64,438,1559548800"; d="scan'208";a="40824444"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 27 Aug 2019 14:25:02 -0800
IronPort-SDR: 9DvoSTF79NQfDUGtmUf7P8pcsdHL1sYf3kuYHVAM1y5fzMFKjAaBzhiq2PtRx16tTu/iVUufPS
 AY984tU+CWZmKfe22wsbqoAAVxBLY6D6/SaomsWuAorIlcpNRGvJ7P46TnV3fh9g6gB35CaO47
 FT3coSGNr6+ge4KwTjWUKxtd/rdwf/gO2PSsKeNqNSNomOWSpG35BtUMqQy/DG7tOTvKrIEMMI
 uBWpPRV/L3WwBQSgmIeWOKVxWTrD10m+kBB+6cq+iit9jf9MNQi5H8nBi97W7DnU0J8f/HKqFc
 bc0=
To: <qemu-devel@nongnu.org>
References: <156694141365.19632.5931521442866569939@5dec9699b7de>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <1c07bc63-8f55-3f4c-ab4b-c8256c00c0a6@codesourcery.com>
Date: Tue, 27 Aug 2019 16:24:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156694141365.19632.5931521442866569939@5dec9699b7de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.137.252
Subject: Re: [Qemu-devel] [PATCH V2] gdbstub: Fix handler for 'F' packet
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
Cc: alex.bennee@linaro.org, philmd@redhat.com, arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 3:30 PM, no-reply@patchew.org wrote:

> === OUTPUT BEGIN ===
> ERROR: space prohibited before that close parenthesis ')'
> #37: FILE: gdbstub.c:1827:
> +        if (gdb_ctx->num_params >= 2 ) {

Arggghh, I am sorry.  I fixed this and then screwed up and resent the 
old patch over again.  I'll try again.

-Sandra

