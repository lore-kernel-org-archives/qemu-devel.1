Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67207C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3978A206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3978A206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7HQA-00052Y-38
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 07:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1i7HOi-0004Re-W8
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1i7HOi-0005mw-4J
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:59:52 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:58715)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1i7HOh-0005mD-Sm
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:59:52 -0400
X-IronPort-AV: E=Sophos;i="5.64,484,1559512800"; d="scan'208";a="400860917"
Received: from nat-inria-bordeaux-52-gw-01-bso.bordeaux.inria.fr (HELO
 function) ([194.199.1.52])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384;
 09 Sep 2019 12:59:49 +0200
Received: from samy by function with local (Exim 4.92.1)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1i7HOf-0005Bi-KK; Mon, 09 Sep 2019 12:59:49 +0200
Date: Mon, 9 Sep 2019 12:59:49 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190909105949.45jdxvzwusonn327@function>
References: <0115e29c-2254-09c3-13d5-6dfb5307d968@precibake.com>
 <20190907232924.a2maha6jyf7u6xbb@function>
 <47bad7a1-8fae-b464-7c74-b458d02a6174@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47bad7a1-8fae-b464-7c74-b458d02a6174@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.134.164.83
Subject: Re: [Qemu-devel] slirp, incoming packets get truncated
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Chris Heinze <c.heinze@precibake.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

Philippe Mathieu-Daudé, le lun. 09 sept. 2019 12:51:23 +0200, a ecrit:
> Anyhow, if you plan to properly (with your S-o-b) commit your patch to
> the libslirp repository,

Actually the libslirp repository already has something there. Since
IPv4/6 have a maximum of 64KB packets, it just allocates that size
on the stack, whîch is simpler in the end. Also it makes mru/mtu
configurable, we will be able to plug that into qemu once released.

Samuel

