Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96DFC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25742086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25742086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhfK-00022S-L1
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan@danny.cz>) id 1hzdbA-0004eU-Mn
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan@danny.cz>) id 1hzdb9-0006PB-O9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:05:08 -0400
Received: from 72.155.broadband6.iol.cz ([88.101.155.72]:57612
 helo=server.danny.cz) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dan@danny.cz>) id 1hzdb9-0006Lq-IH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 05:05:07 -0400
Received: from talos.danny.cz (unknown
 [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
 by server.danny.cz (Postfix) with SMTP id 4DA2111A6CD;
 Mon, 19 Aug 2019 10:57:11 +0200 (CEST)
Date: Mon, 19 Aug 2019 10:57:11 +0200
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-Id: <20190819105711.ea79a7962ff9efcc7054e396@danny.cz>
In-Reply-To: <CAJSP0QVKV4mv6xJS0Oyx0GZ3QtLM+NhQGhyK24WqpuBFmg129A@mail.gmail.com>
References: <CAJSP0QVKV4mv6xJS0Oyx0GZ3QtLM+NhQGhyK24WqpuBFmg129A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; powerpc64le-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x-2.6.x [generic]
X-Received-From: 88.101.155.72
X-Mailman-Approved-At: Mon, 19 Aug 2019 09:23:44 -0400
Subject: Re: [Qemu-devel] Patchew s390 QEMU build issues
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi guys,

On Sun, 18 Aug 2019 12:05:27 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> Hi,
> Peter messaged me on IRC to say that QEMU Patchew s390 builds seemed
> broken.
> 
> Any chance you could take a look?

I'm looking into it now ...


		Dan

