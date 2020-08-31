Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0E7C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65363208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="boB20FgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65363208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCflU-0007N8-Kc
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCfku-0006uP-EU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:05:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kCfks-0002By-Mq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:05:36 -0400
Received: by mail-wr1-x444.google.com with SMTP id a17so4277575wrn.6
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 02:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=K8ko1AMIbQ+xswgJOXzrzs1cnBOiTvWGd0vWc45HQmE=;
 b=boB20FgRThqhmDM91pIy0Hsb3K1ZJg+6aLsHuJjT0pEGQngOl6+hOfA4dx529jrSnR
 1LsjFDN0e/lgDWIc4kWoXbwLkiVx0gia/YVnUDiDdaZmIb7+X6s2EqiHEbHwuX1YuMA5
 NgBKLK73qs1OD/MsCNFGkOo7hZn60BEbyLvhyZg1Vu2aKPzZNLFM1buGZHxsUmLsZzsx
 fcaEcOTWEya6hiqQHA7OOYsaW3G4FbJE3bvGKqTLjMb2M4tu02abljLzYTQ7rK38X7dK
 QJ8D8P41FKKE0wMjC+DlxVsqZgLD7APA8cmh84xxGuIvPh8fZjEHh82izFfbso6iSJAs
 8YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=K8ko1AMIbQ+xswgJOXzrzs1cnBOiTvWGd0vWc45HQmE=;
 b=cEuv3OEkDafQd6FlyJhEFgOI5tigEShbePeK59rk4fBMKjP3dN9H2F4UkIpLxYFkhT
 zjDKLCzQXF6p7K28Gc/RDra0kLA7XjYVaNTcYx81EOLewdKcfraY3qu5Fq7AFPbF8yPl
 9EFxxQX269muY8iTGCMqV23233wQyUwkWqo/SrJmREdF1X9baM+zUD/IvCjdxBGYDGId
 tXD2bkCD5eCi9lIphz7x0N8KjHAwYtBiFKLc86TNimQ7LQwAXfQiReL9bddgFoprj7Kk
 c4gBrvjA4iRsXbGaEc1FVlWIHolyW4UHdIVP87XaH3Fcni4BzexgGuy9e29cv2O3cAY5
 5fHQ==
X-Gm-Message-State: AOAM533qQj9Ep35+10ouaEtCRbHIe7CNAbNqEDwBUsjvrfbUlcr1Suly
 DtH1YGU5NtaDh+2shB8wjYw/Mg==
X-Google-Smtp-Source: ABdhPJwJJFBe3d7mcvZ6r396JXalFhp47a7XjRXfHBKLaX+SxQtVL31XFmZW7lv7d3ZlKlPnVbzvbQ==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr659966wrq.424.1598864732576;
 Mon, 31 Aug 2020 02:05:32 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id z8sm10473749wmf.42.2020.08.31.02.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 02:05:31 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 42804ab7;
 Mon, 31 Aug 2020 09:05:30 +0000 (UTC)
To: Chuan Zheng <zhengchuan@huawei.com>, quintela@redhat.com,
 eblake@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v6 00/12] *** A Method for evaluating dirty page rate ***
In-Reply-To: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Mon, 31 Aug 2020 10:05:30 +0100
Message-ID: <m2h7sjchid.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::444;
 envelope-from=dme@dme.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trying to think like a control plane developer and user (of which I am
neither) raised some questions about the overall interface provided
here. If everyone else is happy with the current interface, then I'll
shut up :-)

It seems like it should be possible to query the last measured dirty
rate at any time. In particular, it should be possible to query the
value before any rate has been measured (either returning an error, or
if that is unpalatable perhaps a result with a zero interval to indicate
"this data isn't useful"), but also *during* a subsequent measurement
period.

That is, the result of the previous measurement should always be
available on demand and a measurement becomes "current" when it
completes.

Given that we allow the caller to specify the measurement interval, some
callers might specify a long period. As only one measurement can be
taken at a time, a long running measurement rules out taking a short
measurement. That's probably okay, but does lead me to wonder whether
the API should include a mechanism allowing the cancellation of an
in-progress measurement.

dme.
-- 
I can't explain, you would not understand. This is not how I am.

