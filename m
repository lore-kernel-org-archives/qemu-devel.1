Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105CFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29CD206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF1ba+2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29CD206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc6DD-00047F-0s
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 07:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jc6CU-0002wf-JN; Fri, 22 May 2020 07:50:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <e.mikitas@gmail.com>)
 id 1jc6CT-0004bm-Rt; Fri, 22 May 2020 07:50:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so2593910wmj.0;
 Fri, 22 May 2020 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9rh1KUeQ6WingxFQSV+jD7fxH5dhUVTY+XOuOWCo0pY=;
 b=IF1ba+2ociACaw3elbBtT47u7XAO933QRtZvVojyiLSAhkAMMHDrvSrsYdqlKxLbK4
 mBx9o0ZMXbWk9YUw+j0EO4OmAxht6Mqrzj4oB2LOj+1a1YHeCt12cxUG5PDmiBxDrzso
 nuqtHN7ofxpp8Pe/VOy3dtHqH7q5o5Re0QPcxQUxObT9qRzAYj6bDyie8zwPKB0fWFJ0
 yMfqmfCBKOMT9fESj56cZvteYL4FWo+VDIysI8pPCGJmYhPcXstHyORwM28G9Dgi57vY
 YiTa7NdlB0VJknODaHGvq28/NTJWtpTaBAXR1Xhap4baA/09oAOpi03UORadwiWF2D0m
 9bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9rh1KUeQ6WingxFQSV+jD7fxH5dhUVTY+XOuOWCo0pY=;
 b=Iqh59L2EGsdStMeO4Ta6fZLc1jtF1+bcPnU+vbHPMD5OdFXR/+5hNKzc8E2ERqpk99
 BxZdp0gW71rSzmAQ7DeMY1rHT4BmRA955uRq7uJj0+DJbggKvwdqi6qSV8ZPdE2DTh/T
 /g2ECAvPf+b2B4hS9mxo21AYp1x0YISd/u42UFvLYdgW5oI44SgS1oWECqiAmU1oerJs
 kv294uFK9vA+fDJtsVZp+3KLYRi6o9gfypVSdI4LN6g9kQ221tNil7KHmV04QzGEyWkc
 0Awm+ZpMAUzSy2q0hi/7v6i9w+6yqtqQdWeYMB8hNL6OlAJ4WBFzuDlkYnmIUYipis5t
 mHSQ==
X-Gm-Message-State: AOAM531vD8U5U2FcTvpnUfsj0jmR5V4/DRwU2r35wHvysEQVn4XOpqmD
 HK/gKeD+hgyVxjF5NAt7LCM=
X-Google-Smtp-Source: ABdhPJzGAgqnG5YOpa6UXuItKZP5ghh5YrjqkWl31QwaRPovcrx4iDXuR99VG9Fe3CohUWKIOcq/8Q==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr12515149wml.62.1590148251451; 
 Fri, 22 May 2020 04:50:51 -0700 (PDT)
Received: from eden-linux.lan (bzq-109-66-59-205.red.bezeqint.net.
 [109.66.59.205])
 by smtp.gmail.com with ESMTPSA id m3sm9237640wrn.96.2020.05.22.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 04:50:50 -0700 (PDT)
From: Eden Mikitas <e.mikitas@gmail.com>
To: peter.maydell@linaro.org
Subject: [PATCH 0/2] hw/ssi/imx_spi: 2 Fixes to flush txfifo function in
 imx_spi
Date: Fri, 22 May 2020 14:50:34 +0300
Message-Id: <20200522115036.31516-1-e.mikitas@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFEAcA8FFc_Vf-UQO9f_3qoXiCJf9N1uWh7qB-WXrEWTzKBu8Q@mail.gmail.com>
References: <CAFEAcA8FFc_Vf-UQO9f_3qoXiCJf9N1uWh7qB-WXrEWTzKBu8Q@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=e.mikitas@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, alistair@alistair23.me, qemu-devel@nongnu.org,
 jcd@tribudubois.net, qemu-arm@nongnu.org, peter.chubb@nicta.com.au,
 e.mikitas@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This patch series contains 2 fixes to the imx_spi_flush_txfifo function.

The first fix prevents a case in which calling imx_spi_flush_txfifo while the 
controller is configured (by the guest driver) to use a burst length that isn't 
a multiple of 8 will cause an infinite loop.

The second fix makes the spi controller compatible with slaves + guest drivers
that expect to make transaction larger than 8 bits by removing an unnecessary 
cast.

This patch series was tested by running `make check` and by booting linux on
a sabrelite machine (which uses an spi flash)

Signed-off-by: Eden Mikitas <e.mikitas@gmail.com>


