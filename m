Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE8DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F4D206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhfm74Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F4D206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZUyN-0000nr-Lo
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSuD-0007Ro-Ij
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSuC-00064C-N8
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:56:53 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZSuC-00063a-Hw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:56:52 -0500
Received: by mail-pg1-x541.google.com with SMTP id k1so8315602pgg.12
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 20:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/6i85Zz+ehVsyD69rnS6jGlGAlEyw2hFM+PVcO7sG80=;
 b=Nhfm74FnqotytbF7EH2mtgHu/Cjnry6SBUt8tEfivs9UCLEZWqa2pBZCpC9kpHTOWn
 wGXIjThs4/6yFcqvpNniDrWCbBz4q2RrzE9ygHlerEZHV1iw0LjCq0egTV3PVDyVNlYO
 bUQK2AvHUzhUdkaOBmtSFUOHljYYj3l6G/AMHU6lbDxM9g/oHP4mfFJoz3I6CPvKYRtZ
 aih7a77AxXt6A9RWGWDaDyY6JEor4Nvnooqpy7gnrPkHqJSs0TpscODfrGREKcxV1AoB
 7rcMDrsaVZ00Jo4xr+BrnNaQfoP3WtGttdmRSOom1nyoAAFfLOtvyfcZCswgx5dF0pPM
 9m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/6i85Zz+ehVsyD69rnS6jGlGAlEyw2hFM+PVcO7sG80=;
 b=hgX7am6DPBdtxmZszQeIKAOGpf+ghhwTmDvudIHzXsr27G3loRwZexKzmqQHcidGyr
 VTqTXnPww1APwKwy0bzjTJB/6dZWMMm7OsEyrQPLsNw6xQ8Hsr47VjF/HzKzqZA0c9dH
 ClfIijymru0s+D70V1h8UV8KZ+/KZRaTsXvF/V4KZUenPqw9jqpv1R8HOfVAMoiPsvrd
 s4F69ej26tZl6hKjud3Vx8FOtppB75RCvK/ol0y8y8/9EJKZHdr9F7XIG/eKykVcotaf
 x3Bu2AZQB0TNdWZEnzTRwv+ToFY09rMCAOnVR058aepR4KkUeZK8aDELC6d88ExK0ui7
 S8dg==
X-Gm-Message-State: APjAAAVQkm9PyaEgPWZhLnBdYFU3HFTzkVhB0zbLjy2Xeb1Ef8ba7EFR
 xang96axjrC2jQPltY4OfpWcN6b/NVG/sQ==
X-Google-Smtp-Source: APXvYqyi7P/fYYkl6yhPCSjGb++QUpi445xj+6y+wS2Fuh6np1YDpRN1ZA9oC8A3dQKDifoaGe0cpQ==
X-Received: by 2002:a63:f54a:: with SMTP id e10mr19121113pgk.401.1574744209779; 
 Mon, 25 Nov 2019 20:56:49 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:73:1f7e:c8d0:6181:5329:cc21])
 by smtp.gmail.com with ESMTPSA id
 z1sm1081328pju.27.2019.11.25.20.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 20:56:48 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 0/8] ATI R300 emulated graphics card
Date: Tue, 26 Nov 2019 10:26:13 +0530
Message-Id: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
X-Mailman-Approved-At: Tue, 26 Nov 2019 02:04:16 -0500
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

Hello,
I thought of working on an emulated R300 GPU for QEMU video acceleration on vintage operating systems (Windows 9x-XP)
The following patch series contains the initial QEMU device and some register read/write operations.
Testing it on an OpenSUSE Linux guest and the kernel correctly detects the card and loads the radeon DRM driver.
It gets as far as the CRTC probing before crashing with an error that there is not enough bandwidth.
I know next to nothing about hardware emulation and would like to know if what I have got so far is on the right track.


Aaron Dominick (8):
  Add Radeon kernel headers. Will clean up later
  Fix MC STATUS resgister
  R300 fixes
  Got GPU init working. Stops at probing display
  Add Radeon kernel headers. Will clean up later
  Fix MC STATUS resgister
  R300 fixes
  Got GPU init working. Stops at probing display

-- 
2.24.0


