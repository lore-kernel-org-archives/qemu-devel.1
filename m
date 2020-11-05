Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F6C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47A32087D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8P4hbsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47A32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajd1-0008Cl-Am
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQs-0004Lo-RA
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajQq-0004sD-Vw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:22 -0500
Received: by mail-wr1-x441.google.com with SMTP id w1so2797783wrm.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JUuYXLxqbj/H11iBsBJrgBGgIp9/33Tos9HDbHcOfOU=;
 b=g8P4hbsq5PR4eAB+DvQTRsfkEr4tBEie9gVWObcgehdg2yM0l3T593yMa+2qa5JirD
 lIY+2XM7Uol+Mxus6oNXCWMPlw7xSgGUmts5qZGdvQnyAJk0XU9zCvS01VAsmLr9p49K
 8qyP5uvdVfO+AbFb/CosYdv1jvmhGRLs+wNxlji0AgL8rvrtgxs6TnEEgBRIJtIuL1C0
 EUJV9PQlP4iJ136z6x5DsocG7gpdshLYBrsMFMIKAlhdl0JDuPp1a+QwpYo7bgKEoHD3
 9piheMQRo0PCa2Ynprw4KAGJzuZgVybMebhD32FSQUmDJZSAndp5pWnB83y1+qqn6rRX
 RSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JUuYXLxqbj/H11iBsBJrgBGgIp9/33Tos9HDbHcOfOU=;
 b=VMGzaxXZZBR73p569Z/OtE9X0WUK9x0VSE0lcPEmhk8arr0qk9Xf3rl5ZLQY1lh7az
 hecoRcgoLbtEUld8Ae2lEDP1EjCc69W4rTsFSVIDzPM65+RXBESzCVzsnoeU5P1SHvL/
 H5uzh+dibxDqz7K56xrFuX1qcwOOppDIZmr7qgCd3zyx3rao7wOYH+gQadN2HzQut5mZ
 XOhBjK61QjxXeaRSNuIqpvYNxdRaewRar0WIvsKJ3Wn12Fh+RjwQE2wbuthUBdQSPeyF
 PIhBsvHgQjj+BNavkgknW44kocoJsTr2oTZnGRYP3RZvh655uobbu6ccv5jn/4Fk3bQw
 gI2A==
X-Gm-Message-State: AOAM531xL5YJUSiQyBCLqtmKXX5TFFOLjgP+BHRhL9/fNcHd8FLVz32b
 WQgmtAD/CftH/xfsB0cNhXSu4w==
X-Google-Smtp-Source: ABdhPJwHXfld+0PUDho8ID5T7Nhk3axT7fNwmvX3sF2CfB/4JpG/XC46ClFAF1NNuoGZtb2cxqvaUA==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr4345020wro.393.1604598739653; 
 Thu, 05 Nov 2020 09:52:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d3sm3965139wrg.16.2020.11.05.09.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7A381FF99;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 10/15] meson.build: clean-up summary reporting of XEN and
 it's features
Date: Thu,  5 Nov 2020 17:51:48 +0000
Message-Id: <20201105175153.30489-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Report XEN support along with the rest of the accelerators. Repurposed
the existing Xen support line to display details about the control API
version and the additional enabled features.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 46e4c2fc3a..79b74fbda7 100644
--- a/meson.build
+++ b/meson.build
@@ -2078,8 +2078,15 @@ if vnc.found()
   summary_info += {'VNC JPEG support':  jpeg.found()}
   summary_info += {'VNC PNG support':   png.found()}
 endif
-summary_info += {'xen support':       config_host.has_key('CONFIG_XEN_BACKEND')}
 if config_host.has_key('CONFIG_XEN_BACKEND')
+  xen_features = ['backend']
+  if config_all.has_key('CONFIG_XEN_HVM')
+    xen_features += 'HVM'
+  endif
+  if config_all.has_key('CONFIG_XEN_PCI_PASSTHROUGH')
+    xen_features += 'PCI Passthrough'
+  endif
+  summary_info += {'xen features':      ' '.join(xen_features)}
   summary_info += {'xen ctrl version':  config_host['CONFIG_XEN_CTRL_INTERFACE_VERSION']}
 endif
 summary_info += {'brlapi support':    config_host.has_key('CONFIG_BRLAPI')}
@@ -2092,6 +2099,7 @@ summary_info += {'Linux io_uring support': config_host.has_key('CONFIG_LINUX_IO_
 summary_info += {'ATTR/XATTR support': config_host.has_key('CONFIG_ATTR')}
 summary_info += {'Install blobs':     get_option('install_blobs')}
 summary_info += {'KVM support':       config_all.has_key('CONFIG_KVM')}
+summary_info += {'XEN support':       config_all.has_key('CONFIG_XEN')}
 summary_info += {'HAX support':       config_all.has_key('CONFIG_HAX')}
 summary_info += {'HVF support':       config_all.has_key('CONFIG_HVF')}
 summary_info += {'WHPX support':      config_all.has_key('CONFIG_WHPX')}
-- 
2.20.1


