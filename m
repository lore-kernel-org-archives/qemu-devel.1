Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC642C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 01:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F79820866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 01:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Q84lfQky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F79820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLdea-0003rm-Q7
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 21:03:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddF-0003G4-CU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLddC-0007hk-AT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:01:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLddC-0007gs-30
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 21:01:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id j26so7653118pgl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
	h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
	:content-transfer-encoding;
	bh=1kq09OnIGZpqdeeC4YtLnAhtFcWe2yby34JX66f38Yg=;
	b=Q84lfQkyu1zYJG/c7f/uV1TmZwC3LYM4nVLKiogl7mUJCr/F+VxgsPWIi+a1ymDUwB
	4RpwGRIbhIH2kV3mIyp0nMgD/2HqkU6qJLcPABIIdZHJQCF8StfjfN9mztwxQHauUavb
	X3duvOdVKXuHxlWcTALuhhgWdxV8VU1O6T9JppOlzLOhClKkGhfDfcb2o7tj1oRu1A3Z
	CSTyZeu8WXxOyGNFzjCx9bRBVSWLNpPyFQ1Qtl1XMdHSqxuchsj+8LmFLW7+WUYT6LOI
	/Xen8tfwn8DD6f6fE6FE8Srr/ApBLGzjxXWzzz2Irp3mCL7KtGj5PRhukow1cz+RLMn4
	78Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=1kq09OnIGZpqdeeC4YtLnAhtFcWe2yby34JX66f38Yg=;
	b=RQVeuc3j1BAIULynOKljZJg7Qya6D1HWZPmM3UDf742sof3PCyozdvYch/lZWtPIqg
	7cD1tQFU3wBNNk85GJCH15d44lMUo7FNrYIYDNF0HL2UUB1yf1hw4LNzviAqr+zaO9co
	+iYPR4Qc6AA1wDcohT0QTZXhwHNsqSbb5X9lKWEUKaC/tQzqIr35tdpbuw8iiaFww/zY
	KPzDsy9Na6ruCgJeogBozkE7RYvU8a2JGn839UroAuDHKNdDN/ensEI51uuUH0HFpZWc
	cfvK3KzL1L8GfN/CmsocVdXMrPLtFmnGVx262jyRIXTAERizaX0kioQgAmjbIuVd9r57
	rlkw==
X-Gm-Message-State: APjAAAVsT7XbnIIcUD/HvXm/5kaj0DZuCYk45SLihAyTc67SzaAXkl9U
	Ig77c1PQvTUhyIIRSAaw+hPE7+yGMqdLSg==
X-Google-Smtp-Source: APXvYqw/+IriT5gGZZ6+7/OF73NJd7kxwj4T/DrWFxkKGeSKUdK8p5/FgPrOV+ei6o3JvnLLl33lbw==
X-Received: by 2002:a63:ef46:: with SMTP id c6mr54381456pgk.392.1556672512222; 
	Tue, 30 Apr 2019 18:01:52 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	v14sm14607096pfm.95.2019.04.30.18.01.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 18:01:51 -0700 (PDT)
Date: Tue, 30 Apr 2019 18:01:51 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Apr 2019 17:46:50 PDT (-0700)
In-Reply-To: <9384b35d-41d0-65b0-17ca-7291c530d13f@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: richard.henderson@linaro.org
Message-ID: <mhng-a33acc90-e882-4238-975c-c5611090fafc@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/8] target/riscv: decodetree
 improvments
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501010151.G3HwgwXwji8TbA1knhk7X-m-xOXZabj4hiBtg-lf_uc@z>

On Thu, 25 Apr 2019 09:23:56 PDT (-0700), richard.henderson@linaro.org wrote:
> On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
>>
>> Thanks!  I'm happy taking this as it stands, since all those decode issues I
>> pointed out aren't regressions in this patch set.  Let me know if you want to
>> fix those or if you want me to -- as you can probably tell my email queue is a
>> bit long... :)
>
> I'm happy to fix those, if you'll point me at your branch.

github.com/palmer-dabbelt/riscv-qemu, for-master branch.  I haven't sent the PR
because I haven't banged on the branch yet, but I don't anticipate any major
problems.

