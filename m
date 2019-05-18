Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B81C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953EF20873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uceUUFda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953EF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37765 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4pG-00059Q-PR
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:16:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4n2-0003Fi-L0
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4n1-0002kN-Oh
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:39297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4n1-0002jR-JK
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:39 -0400
Received: by mail-pf1-x432.google.com with SMTP id z26so5264810pfg.6
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=rO0J4mv2XStY7l8n4TCxBzI2PfGSKqSrLz6qLFhfLN8=;
	b=uceUUFdaYPG6IzS0PIZl3Gy7ZldHQsXHAgEGVLqz1mwZSs548BSRRPadyvYKUjudm5
	eU9J85IHni0I7a6e2bb2r6b6FvM7JAb9hfsUcRxEiW1E/oYiIw0Yq8KwmFQK17eYuEgs
	H40+w8IuhMsQqGMiK3dgMsdc7QybhGuXOAxiea/+8M/2J63A4dk1IDsmvWxBmReSW3aa
	mlJFdDegrCpTkcQVqc2K3oO5AFSg8eGI8YCe2ehH+/XOJoy7qXMkosxuQgenOaR9uPQf
	TEOHVk17QO/JqtRoWCtwWfJJNAqKN9AXiUq4qGNz8I1B/a/LtRYBvvgHGzIbMBBa83Ws
	qCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=rO0J4mv2XStY7l8n4TCxBzI2PfGSKqSrLz6qLFhfLN8=;
	b=W6dcz14hv4y/XKTSbSJ0qwvlW3OSbidVMNWJ0wQdL9+odvmfgbtx05oEaeqdeUW0wJ
	XVsBwQp0ajrL7A3puG4JSljd9RmVs919Cmdz414Xu7UpyOOP1VX7SSCR/nZINvOTC9s5
	JeRRkfH+YWTlBIQ9duaFwNuZdlSsybajENaXRvDKz2YDYZUjew4zaGzYz+fynPu6KTRk
	eCoJIrYN+6ykKPs1YdKjCV4pZOUkbXJrbVPtNt6v3FYQyq8pmbbyzXRfZ9CT0Gyh+bzB
	98JoLDQ8FqR8V+WFlwETMhh8QGV8KpjAbJzt2aYmYMEoo/c6YkgGFVbq4zWC/Pa745Ig
	Hs4A==
X-Gm-Message-State: APjAAAXFEXYCfJTOIdtBQ38VXbCW24ZfUEwLy7EJT2kU8LZ/GAlIfL+z
	TbfC7cplnjiArBVQPW3iV0wgP9rWU9w=
X-Google-Smtp-Source: APXvYqz9W9h8LrxEQZ7i4OpQ8TcJSrP0cgMUjc+f4lC+ZF5Sa/ACq41YczGpNBvm/woDeYtlyzbsjw==
X-Received: by 2002:aa7:8d50:: with SMTP id s16mr8211422pfe.96.1558206877900; 
	Sat, 18 May 2019 12:14:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	d186sm19206675pfd.183.2019.05.18.12.14.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:14:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:14:28 -0700
Message-Id: <20190518191430.21686-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::432
Subject: [Qemu-devel] [PATCH 0/2] target/ppc: make use of new gvec expanders
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20190518190157.21255-1-richard.henderson@linaro.org>
Aka "tcg: misc gvec improvements".

Since Mark's initial patches, we've added (or are adding)
generic support for variable vector shifts and bitsel.


r~


Richard Henderson (2):
  target/ppc: Use vector variable shifts for VSL, VSR, VSRA
  target/ppc: Use tcg_gen_gvec_bitsel

 target/ppc/helper.h                 | 12 ----------
 target/ppc/int_helper.c             | 37 -----------------------------
 target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
 target/ppc/translate/vsx-impl.inc.c | 24 ++-----------------
 4 files changed, 14 insertions(+), 83 deletions(-)

-- 
2.17.1


