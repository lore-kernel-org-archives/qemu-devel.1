Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7EDC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6E92071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqRqcoSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6E92071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZaEK-0001tw-9t
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZaDY-0001Sb-GE
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZaDX-00047W-9O
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:45:20 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZaDX-00046T-3P
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:45:19 -0500
Received: by mail-pl1-x644.google.com with SMTP id az9so8098017plb.11
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y7G1bckN7gD5bEhJvNU/vbKtV9RAeTf0vJ2Vb1L3YkA=;
 b=qqRqcoSDh66pkGwHMg5g9RdxoDFuUbUeexn8gbvy/cDz33IoSOfnXn4eOLgmPR5Evn
 Cq8jckdHPqoujocJw1yDaVJs0570hBylyB1NA6B95c6ZxGdE9DvKIqS+WUOHppGEa2Xu
 IsmCwFc3OTg0j/P3KHrvksYFQgy4rHiTpDdfdYpPvNti+0iSbf9mCnIsty2Vq7z9HDKw
 QlWpdS4KyNTGbYexyVJkJ9xBzM07/eYjY/nVEKEGL2ZVw2d44Py1gvgjaMnJyloxnsBk
 iXu8fuhexsZki2PKIQkoGZuE84BA9OmSd+2qE6TWBXjgZW0V3JZOBIEYdMxGgVmKFakQ
 M9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y7G1bckN7gD5bEhJvNU/vbKtV9RAeTf0vJ2Vb1L3YkA=;
 b=LiXPbfZ73Kj0Y9lPV1MLxZIEhlyQvX7P3d43RN6GKQSX2IJ3FZPo63arwDnXkL/hdA
 GltPpfls9uCUtzdBnJhmEiaww1ikb4dfu55f8P682x3ejRp75rX4I74jvBp4X02hrdaU
 ZhX6G6x4jct9HrfNkh60ZqHzOW+VG/lKAjSXb3EOih2BSeMhSiZtdJGZjd7hnVjBR7jD
 A0n6dkdHLBTYAE8YMo/LNpdnAxPvQcXDWFMYh2FiuCKoVdVheVtyH8ZFqUx3j9+p3uJL
 BAyc474OVpuG0BmFBUM2Zvk/pm2CEdadpBphwcrW7xMKXiwCyTjWkTOREVI/9kEVw7FY
 xdAA==
X-Gm-Message-State: APjAAAU4dAP2EXePle2MK7zovsX/DvgkeTPUUVGNTnDfq1qfzNxcyQhL
 /eyxCVe64wvmkWGFRG3igFN1f2TrQHSpZK+f
X-Google-Smtp-Source: APXvYqzBs3sb05JUohD7XlCnxigjDASdHLcxB9ZaGScrbhxcHJtWh+WkoJqC73I+5/ZpnunfAJGyUA==
X-Received: by 2002:a17:90a:fc85:: with SMTP id
 ci5mr6825317pjb.17.1574772317178; 
 Tue, 26 Nov 2019 04:45:17 -0800 (PST)
Received: from localhost.localdomain ([124.123.107.186])
 by smtp.gmail.com with ESMTPSA id d139sm13685922pfd.162.2019.11.26.04.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 04:45:15 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 00/10] R300 QEMU device V2
Date: Tue, 26 Nov 2019 18:14:27 +0530
Message-Id: <20191126124433.860-1-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

I have removed the botched patches and have got the code working upto the GART initialization.
I am not sure how to implement the GART. I am guessing it should be an IOMMU device but I think that is a bit much for an emulated card. 
The earlier problem of display probing seems to be resolved by using an R300 bios I got from TechPowerUP's GPU database:

	https://www.techpowerup.com/vgabios/14509/14509
I am NOT sure if we can distribute it in the QEMU source tree. If it does cause problems I can send a patch to remove it.

Aaron Dominick (10):
  Add Radeon kernel headers. Will clean up later
  Fix MC STATUS resgister
  R300 fixes
  Got GPU init working. Stops at probing display
  Clean up Radeon Header files
  Add a new R300 VBIOS courtesy of TechPowerUP

-- 
2.24.0


