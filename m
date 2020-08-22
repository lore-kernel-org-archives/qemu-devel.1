Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16594C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27DC2075E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh6WK7hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27DC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Xyp-0007xb-3h
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 14:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Xxm-0006Ig-Eu; Sat, 22 Aug 2020 14:09:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Xxk-0007af-Su; Sat, 22 Aug 2020 14:09:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id a15so4801455wrh.10;
 Sat, 22 Aug 2020 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K0k77PmVQN5AlBGF9o/Ch9CVjiLjAUW6B49s4OWNij4=;
 b=fh6WK7hpjUb9zIuu8p0/G2pbR5mxLrfgvka3gmh8bMjclNJ8ec5h5D0et9lEYIilpl
 m3No3XuM6lus6YGbaM2bweqyXeJxcd0MtFGOsl+C7OkYq/F0krk2W7f8DuNoVOZrr3pt
 pnorpuUUcoMe8W42ceesImIdBWoVviBGd7ChxxiVv6DpMQINPE61NYDzjVE9bQAp+TXp
 L3nJxVR6r3RM6g1ejtMrIT9FAPlwnSwxwW/bc5FhyzluQV2YgXGGwMY4DLA4HVo+R4U0
 nZouK+ulbsPVLVw4AsT3pLGN5WJ0MAYUIC+h5e/W4Fci6NA+cPA2pMlqezKpLfvcftaA
 aBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=K0k77PmVQN5AlBGF9o/Ch9CVjiLjAUW6B49s4OWNij4=;
 b=nq/uLmstYHTHloWHHXsnFySz1ksPY/3P9g7pgTFc/Vm8BsJxM9uC3T45Bwb1lhr0Bx
 ilS8ieLT6qKEzA+70UTeAfkZUj+FwFtFdAt8M/bpyVKa9K0ueSDM6PGiZpvEi6XK9P/J
 hP+YXQyZ0wf/i7VSegQ6yO3DKa2KU7GVZfDC9Eogjf23QBLeFxFErPD2NtOu2Flwu3v3
 6h5jZ8yF4Gi1nD0gnJUTDd3lpFJJ86oF8wBjMQTwJPu3yLlSneTrCZ2QCwVaV68MPItW
 gQsSXRc+zpchxPX5eLdFcRCR4KnrTNfS+thCyUh1fmL45gyu1iEDQERPRdXICOintNgC
 A5VA==
X-Gm-Message-State: AOAM533ml0y4D0T3E4xVjwBWI414qJ4u0ZahlAiYparKVBwm2xbO2zMn
 vWCTYbt50vGrrk2GcR9+FhWYRq0AU60=
X-Google-Smtp-Source: ABdhPJyk0A2XQxUxafONw2VqXsVdHuZxBEplJA1xrrWKhvyx0BTFgol5WJVsZ/+Q4VIx83isaevmMg==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr8208684wrt.191.1598119793555; 
 Sat, 22 Aug 2020 11:09:53 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 126sm13713876wme.42.2020.08.22.11.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2020 11:09:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] util/hexdump: Cleanup qemu_hexdump()
Date: Sat, 22 Aug 2020 20:09:48 +0200
Message-Id: <20200822180950.1343963-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Zhang Chen <chen.zhang@intel.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Pass const void* buffer
- Reorder arguments

Supersedes: <20200822150457.1322519-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (2):
  util/hexdump: Convert to take a void pointer argument
  util/hexdump: Reorder qemu_hexdump() arguments

 include/qemu-common.h    |  3 ++-
 hw/dma/xlnx_dpdma.c      |  2 +-
 hw/net/fsl_etsec/etsec.c |  2 +-
 hw/net/fsl_etsec/rings.c |  2 +-
 hw/sd/sd.c               |  2 +-
 hw/usb/redirect.c        |  2 +-
 net/colo-compare.c       | 24 ++++++++++++------------
 net/net.c                |  2 +-
 util/hexdump.c           |  4 +++-
 util/iov.c               |  2 +-
 10 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.26.2


