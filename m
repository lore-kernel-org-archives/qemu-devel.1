Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29879C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86BB20659
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 13:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScDWZ//i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86BB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0hw-0002ww-U1
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 09:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0fs-00027N-33
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0fq-0006HB-No
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:46:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0fo-0006Eh-Qf
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:46:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id v8so19833274wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=ScDWZ//izVK/Kjcz/qtNRfNlr1QEP1xm4MLqjlbUZPZ4iyPfn5rqUWNJpe4CvSZrS5
 PE3ezyLY3IjpG5Zvn6bARlVIw7iA9i03nYEiIsQK0W/wMDxseCMITTWxnXDWQKtFSxj1
 91tVHGuYngJICaxjuDDmXaqE9Busgp9ombNgWsECHlaqiPPvLeJnzAjI1Xed0PHpl025
 OedkrccncAsVn4l5Bj3ZpvdB0mmS+zVvur7Ddv7mSfT5PiMuhH//uYnBD5jT3vIABlhA
 9Dyshwd2CrbJz/wAdM40FDpp7QIoawNhG4DAW8uhwaPsHuAjcq7GsTfTmlpieC5rxaKU
 i40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UEXCjAhdu0FKHjjtnW1230km7QIS6Nvx34ZHiSKDVCA=;
 b=g23TaYmLSCxLbXOantoju8h+aWbaCO7nNWNyTPH+mPomXvgKaN/gx+pFTKO4PC6UDH
 JyT0qpVKLJ7GSsjmLPC5CnFoOP7841OaqpjV2QQpIt126ZSZkgpC72bM/Dtw5s6NgNgC
 p25ISk63Fvmr8TuW9fl/JudluIJJc1NXCZKP+rABycfUmo+aqL74evnu9iPjbcD3tHvw
 eCBqLyQHWmXOk0qV8t9QgPeMKJVe/03lPvDuy3cXUvjkXTDpEWLrz5UOqvylK5W0x+5r
 vCeLFi0ty14XvpXnSrQ78Q14BAuKV2y/NyjtvMSoD7dDcoe9TijgcU2yZQ8Lljp/CVr0
 muRQ==
X-Gm-Message-State: APjAAAUIcjazkiOrTH+W99GzZ4ZXP2dgZuubsi2RnoE03ByweWuv4JPo
 rhiqvEd023+ft3WYpstWyYGMhQ==
X-Google-Smtp-Source: APXvYqwoGb9PzPxpwS/0hyEDtrdNlt8DXCaJVfE2dqelZJrY+mLZrLX2zo2/Z66Cr36Cuu1ffLVx1Q==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr11725119wrn.258.1571060766150; 
 Mon, 14 Oct 2019 06:46:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm25408208wrv.63.2019.10.14.06.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:46:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D29BD1FF87;
 Mon, 14 Oct 2019 14:46:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v1 0/5] gitdm updates
Date: Mon, 14 Oct 2019 14:45:59 +0100
Message-Id: <20191014134604.21340-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

With these changes I get a reasonably clean set of stats going back
two years and to the top 20. However most of the individuals are pure
guess work so I won't submit them in a PR without positive feedback to
it being correct. If you want the numbers to be correct by the time of
the KVM Forum QEMU keynote now is the time to let me know ;-)


Alex Bennée (5):
  contrib/gitdm: add more entries individuals and academics
  contrib/gitdm: add MontaVista to the domain map
  contrib/gitdm: add Andrey to the individual group
  contrib/gitdm: add Bin Meng to the individual group
  contrib/gitdm: add China Mobile to the domain map

 contrib/gitdm/domain-map            | 2 ++
 contrib/gitdm/group-map-academics   | 3 +++
 contrib/gitdm/group-map-individuals | 6 ++++++
 3 files changed, 11 insertions(+)

-- 
2.20.1


