Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5CC522208
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BUXkWxwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CC522208
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIvj-000644-TP
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jvIv1-0005de-JK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:16:15 -0400
Received: from sonic308-56.consmr.mail.ne1.yahoo.com ([66.163.187.31]:43284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jvIuz-0006uc-Gz
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1594725370; bh=6CCeUxcm4NCxr2KBppn5W9fngEgyiL0nSWgPbaXu2YU=;
 h=References:In-Reply-To:From:Date:Subject:To:From:Subject;
 b=BUXkWxwQ+i020A0e9LLCuNfVTs5AAPpcwLUVDrSLbvEu93aHbJiRLYdTt0p1dMHpqyt7SyN2g7np/snE0jJtAVmG7+yNMloE4pdJ/4iwbhgIS3gaICSOMyragCtkpgv/ynVY3oEcs6FpcLf+SNp6uMvjo+pl+F0gHHMG2pBoZ1aU0T3HnzRSl5ypoZ7j75TG7P4nEPVaiUwNWhkuVlzsell5kBJeCLZEj62FI344bQsU4fkOS3p/IZYEnVGUZdI7+15vrBKJcJ0VitKdk7+Fw47oz3VcsOkS1IJv0iEDSEVyfrb1wZz//2yu2fhFgmq/lGV5W0fbDX/fGtob4kZPHg==
X-YMail-OSG: 6fpd5h4VM1ldHoD7KsxcBMKb6EWtQzNulUR8.tFGaFVpOXOAv1GNTMix.PSTAvO
 EkegtUZv3Z_0fMmM39LOV_On1R0rl1DCCXjovVs58q17eaA5CGblyQW_uQ9tk8Pl_9bzXnJRcoaF
 ZmpcipH0IBowE7vbMTpPvX.IVObNI0FIVYqRGmI27xte6V8itsxHPCjx9Rrz6qEtIXZ1Ef4R6TTZ
 6HYNC_7bjKRANpl.y5FbBlrdyTuEdmxgZfTSukiutInFxjG18So6E8Sfnhf_S_kiaK4fmro2TPdS
 16efLaTwuoQytXVzAZQi1JdGs7CgGTeJ.Uh.SvMNOpNqe1l3GyeObZ2ua1fA9FedcN_ggwTgOOOu
 p0dBlC61dhmLopsjUT2vLGvVpzGgpYBMW9Frkr7uYQvuIc3bg2_1WamkBTsblK5AXRDu.kHnbd1r
 yQyUBo4xjsQVLsZuMTeMcTsfK._L0BSMf5W9HPMyASe_hrF6SB6RxW3_0xWiokKA.18mUhi3mAqL
 phJNpEPA8DtnhzlOWEHRuQo8_AyoQJmBOjbfxTmk6f0NqqvtwyO2d_2kDrpLKnW1b6VZUULdz.YA
 qqn6537__VfCtuY7s.SbIm9n.JUROcmv5xYVPBAxLN.jyWTV1nOe_b19wGKuNx5Yza530uGaBO2Z
 zk7M.ntdVYBp_ARhWzZcRGRwS3Ex2sIu1n6WRUj6HgObT5hEvq3tG7.xXszQQg.7TWN5zYC8G6.E
 RjOCRdHphH9eeyTx7LMd3xC8ohPgqQHHLJFlRfvMXBbXU8bmh.7PI2OOgX5rlvYiUnvTM4d_Sqek
 .J9GeN.TigRNRbzkKyJhSXoQ9Pbi4i.Depai5.wA0qO7pTpBZvcBiKlea.WeoNOTbqCXdDncumJp
 gTFQW4oFPGG3Ubf4OeoblRDd71cDiity3n3uZcpt7jdcLrDySdOVPxqZhuZaGRzHWr_l7vp8fUDV
 u9svmjxj4EmrFevPm6bUgLJFpQnwLhWUhQihKMHgq_FrH3Wx37t0j4i0s9jrm.0cvlX_UWCHo9tm
 hvTl9BvEJVGecpXaxR41WA5sBxCoXQKowk3TASTHZLBiNxc3oCLmgzbWH3fRLRzE7_TE2gWE6Lfl
 cJ6hdxOqJlRP9aHjokeWRPIKpip.ZvUphq.e7JPzqAXaydl7pFSFcpFiIJD5fb2hNitKL0gaXt1L
 i8nQvCefaAcdstaUPoGr65Fgp4Z9tuR3QECb.gxTgsQBi8uxG2OKJlukkSWRyflGvYbwzGLuSQN1
 KiJjBctg76Tu7BG1sJg5LLndKtgogJmTIr_js7P1bpaBg.y65Z4Hs7xzxtaqLwRv9pVZhISt1qpz
 6pqgO1XjDz0mpLlzGQcqSJidIOsm7ZKWjHEStmH0wBdA3ipM6GlMdX.H1JBZtCX.wHQ.m0SzXF56
 kAsRqSemn_M0zJX1swnhD
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Jul 2020 11:16:10 +0000
Received: by smtp432.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 46bee7e279955da6bda8b6ec82fc28f9; 
 Tue, 14 Jul 2020 11:16:04 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id 1so7433640pfn.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:16:04 -0700 (PDT)
X-Gm-Message-State: AOAM533klT2hvE8QlJMGsbbs1rFrIbRPEwbcdKZckKLokJGcE3G/yq7j
 Gqh9xsk1Pgb8WQsnPxOb865+GLV+hDwMS2FyH1A=
X-Google-Smtp-Source: ABdhPJx+G5+5OCXmdsTvzyrENYnRnhuHvTqtupWggRfqTk5zWSqBoM8Yhw2mQlj5A8MODx35qfvPUJjImiXnlMWoHEY=
X-Received: by 2002:aa7:9a84:: with SMTP id w4mr3785444pfi.13.1594725363995;
 Tue, 14 Jul 2020 04:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJNuHy+CqveTjiCxpjiLX-D=NczSveUSDSAZyz=D5F0XvL5QQ@mail.gmail.com>
In-Reply-To: <CAEJNuHy+CqveTjiCxpjiLX-D=NczSveUSDSAZyz=D5F0XvL5QQ@mail.gmail.com>
From: Ottavio Caruso <ottavio2006-usenet2012@yahoo.com>
Date: Tue, 14 Jul 2020 12:15:48 +0100
X-Gmail-Original-Message-ID: <CAEJNuHze25wdA_Kjw8ryi+hmg0eLP8nhZMR50_2yqXPu_Jir9A@mail.gmail.com>
Message-ID: <CAEJNuHze25wdA_Kjw8ryi+hmg0eLP8nhZMR50_2yqXPu_Jir9A@mail.gmail.com>
Subject: Is traceroute supposed to work in user mode networking (slirp) ?
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4
 (Java/11.0.7)
Received-SPF: pass client-ip=66.163.187.31;
 envelope-from=pr0f3ss0r1492@yahoo.com;
 helo=sonic308-56.consmr.mail.ne1.yahoo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 07:16:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Originally asked on qemu-discuss but I didn't get any feedback.
Thanks for your patience.

Hi,

I have enabled pinging from the guest changing the
"net.ipv4.ping_group_range" on my Linux host. I can now ping any host
using icmp. But I cannot get  traceroute to work with standard udp
from any of my guests.

$ traceroute 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 64 hops max, 40 byte packets
 1  * * *
 2  * * *
 3  * * *
 4  * * *
[and so on]

And if I use traceroute over icmp, I only get one hop shown:

$ traceroute -I 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 64 hops max, 60 byte packets
 1  dns.google (8.8.8.8)  26.147 ms  27.88 ms  20.048 ms

I have tested this with various guest OSes (OpenBSD, FreeBSD, NetBSD,
Small Damn Linux).

I've played around with various virtual interfaces but I have the same result.

Any clues? Is this intended behaviour? Any workarounds that don't
involve tap/tun/bridges?

--
Ottavio Caruso

