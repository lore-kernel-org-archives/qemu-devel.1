Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA998C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94B22465B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llsnaEST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94B22465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ3b-0004dd-SG
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irIzJ-000803-9e
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irIzI-0007UC-4B
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:59:53 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:41539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irIzH-0007Tx-Uk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 04:59:52 -0500
Received: by mail-qk1-x731.google.com with SMTP id x129so11495753qke.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=sltQk+3R4u4RoUfKnu7u41rtxOhQ0P5DzbS0zzzBhdM=;
 b=llsnaESTTsV/4P17RszWw+FbIcXQaSikdZH19MJTHecGYq9jBR0LO7FB6NwRRGbR4Q
 inmeOeuERQ/i5eEmA01xZe3ZM9b+vNk4lUMgKpU6QWWHY4PiKHUesjLGFP9MR5LTBCxf
 uOF3xfeg7GqzZFZTXiAz97E/BldsorOZiag2kORgpwEq/h5dWn8QpIM4DYIuVIYCyrKv
 N/sGTdhboTlaRjQW2G6VIoZRGTU73AZ5Fjqg/MEz3tTMbQ5dsLSKHYhOA+Z016WSfGSw
 KrR2dfYyp1VmxdCv5ZWne69jRl+ujDnPF7bIpodTx/8T7PBzXn1iN+D4gekJH39qJ1Lc
 gLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sltQk+3R4u4RoUfKnu7u41rtxOhQ0P5DzbS0zzzBhdM=;
 b=AXhLc7adhi4jU1803sMP0i6x8ub/ubXmx4yHFhXGzFTId+imv2W3LzIiJFwBALCc+1
 +SOBPwEfqtEyDc+MIcM5u2NML2oyTrMp2lafskedHznaw6U5lF6gNce+2M5D7jEPPzVW
 j7QDEwlnk6xzU1bGsISvVsR4ERgaOqVXiIWIlwjpsnLsRt1mYKbU1z6CkbZJAIAlchtN
 rQA+ecPifhu9/2wvYPBbDt+5m9fBdN0ayISz3PXnASGyaevt/Wwo6z05YE4Sp5ivCaTk
 d0uPSeyDrC3DdFg76Hc5CjBzPcD7Iceuiefe9LmAkHsSXLv+Dcd6bZdbX5Es6EcCrPK3
 7PWA==
X-Gm-Message-State: APjAAAUhH5F3h6wwnxzE1UtLN00mhaoi+npYGtYUBtBtx+prdrHv6M7K
 F/fkN9G2DDoQZFcLwlArx49xKRIkEEsP4czCS5t8EOV0Jv8=
X-Google-Smtp-Source: APXvYqwdk59/LAU6Kga1kx6Hy5xf+a82RQyXJlZodMDokvpkh0jQxSjo9AzaLim32iEcRUkw7ZCZ1ykpXGNh4gDvu80=
X-Received: by 2002:ae9:f714:: with SMTP id s20mr20584909qkg.236.1578995990801; 
 Tue, 14 Jan 2020 01:59:50 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 14 Jan 2020 09:59:39 +0000
Message-ID: <CAJSP0QUjwNF2FEz9zpDBVLDzEuwu1NKD8E35O2QzFQXvqvTOnQ@mail.gmail.com>
Subject: Call for sponsors for Outreachy 2020 May-August
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::731
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU has participated in the Outreachy open source internship program
for the past years thanks to the generous sponsorship of companies
supporting our community.  This year QEMU will apply as an Outreachy
organization again so we can provide internships to anyone who faces
under-representation, systemic bias, or discrimination in the
technology industry.

Internships are 12 weeks long and consist of paid full-time remote
work.  An internship is paid for by $6,500 of donations.

QEMU relies on sponsors to fund these internships.  If you or your
organization would like to become a sponsor, please email
organizers@outreachy.org and CC me.  You can find additional
information about sponsorship here:
https://www.outreachy.org/sponsor/

Thank you,
Stefan

