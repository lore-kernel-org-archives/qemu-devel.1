Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2D6C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F049B21734
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poPHBzzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F049B21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVB4D-000544-82
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:33:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hVB1m-0003pN-Pj
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hVB1m-0005Db-0u
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:30:42 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:42774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hVB1l-0005Cx-SA; Mon, 27 May 2019 04:30:41 -0400
Received: by mail-wr1-x434.google.com with SMTP id l2so16007555wrb.9;
	Mon, 27 May 2019 01:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Lzj/yiNDFh4JW84RkK4BcDNLtWpH3d5QATkJFn3L+HM=;
	b=poPHBzzEHtMfwhMJsxjoGirEgFK2lJNmFiU5hRavRGFW1wYz4F4ORCDgqa1qQ+Z+JS
	g/5y6MnJ6+EOhtSDowqngzzyKJQSryUZUzKgv6gb4pa3/w8pl6V0k4lIOX/CZz1p18ea
	lZXsfe7n5f9Qj3n4CrLkEHZCjeARQ943y7+nACyDT9HgIuPGdq4dP7ZiSYZv7UlaoQdN
	uRJx29MtW27gAc9uni3biLw3nujt8OdSzcJ7tCifwXIhtV9vux7N1PL/9sr+OObWJLD5
	4t24QhERgzGTCZJdpvhaL1QQ7fd/aRYqC+4DxU5U04KCLeq0vx7g/xrNCkLfDqU2iJ8X
	ZVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Lzj/yiNDFh4JW84RkK4BcDNLtWpH3d5QATkJFn3L+HM=;
	b=t7n2SpiWUtpj99y6cRMXGhWrzylPBDvO2HbJsTdDDlqOzAFgyxNQpvn0lICBU3bxfA
	UMNo/Vcx5ug9LWfcyqNspsmkPx5YuLD5eYRPbX1hhb8qAtOVbJCeVy+wNjj3bWnOo36k
	bZzhVw3CtQbqJlFZPWVy+OsiyErQoFI7l49GJmt9WSpyC13ZeAREaCCyQgyycZZhK/zC
	lJLqzbZtT5rL27zLN34LQ5tpNelpMl/gjg/RdBhM1Eq14IR/G8JDr7EZWv5nEQKcubB8
	x8jNJd6Jsi/xsH8oFdrx8pC2YIdy9O5pMjJcoabnw+FeO+aVyVxglowEh1ThE4zmBxlF
	T+hQ==
X-Gm-Message-State: APjAAAVqljfCJm+ify/sQKxS+QwsOy7IYDrh7J3IFheHvEEDnnjHa8HP
	6Subj8qWzGQGNm+f3rNB3qBLgDdvaTO673NS+1Q=
X-Google-Smtp-Source: APXvYqwuw4jc9RlE56yf4v0WXikgtMAKjs6V8UOb/oaFG3nXlpqxpPyF8w5IDs0vpbwKrlBsylwJkiqgQBl3nttL8sI=
X-Received: by 2002:a5d:6607:: with SMTP id n7mr6029503wru.149.1558945840676; 
	Mon, 27 May 2019 01:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
	<20190527080327.10780-4-mehta.aaru20@gmail.com>
In-Reply-To: <20190527080327.10780-4-mehta.aaru20@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 27 May 2019 09:30:29 +0100
Message-ID: <CAJSP0QXOP+mB07LZZfWn43hJO7fNQV9KF7SsXqCR64uLQter3A@mail.gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: Re: [Qemu-devel] [PATCH v3 3/8] block/block: add BDRV flag for
 io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

