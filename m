Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 03:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D939206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 03:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuY7PHBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D939206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaAHS-0008MP-Ez
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 23:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.guo.simon@gmail.com>)
 id 1jaAGm-0007ws-1a
 for qemu-devel@nongnu.org; Sat, 16 May 2020 23:47:20 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c]:42475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wei.guo.simon@gmail.com>)
 id 1jaAGl-0007sY-79
 for qemu-devel@nongnu.org; Sat, 16 May 2020 23:47:19 -0400
Received: by mail-il1-x12c.google.com with SMTP id t12so6542034ile.9
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=dqGQ7M2dCAQ5p+35xxg7WUHWM1qPuOIAs36/6csMUjQ=;
 b=MuY7PHBK3RlWGzJNx8C4jT2vVXvEMn80vV4eP6dDi1Pvv4Rd0mv3rX11fuCdcRou7t
 zHW2UiKEWT5kFVx/g/wI9JQQzW0iG6T53TbCtSFa7HhMHhXMTxcG8QXmzgGKS9g2611x
 jg0msvgugR0aw4iBceZU2+mXGoc/GC7RlvMwhCHUjC+kWXKl3Os+pGuZuef1k8vYmeDG
 C7dRPsxyv+xWIJh/a2tSWtImYuwZGp6D99g/rs4IFAU04f7eLGYlqr9xZc+hAaLDjI7H
 9MwB2XlKHQAzJeqeRil0hjFqC92+mb12wK8oYwXi/VuZgCaT7oG7njA+RO76vwe3a7v4
 Ya2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=dqGQ7M2dCAQ5p+35xxg7WUHWM1qPuOIAs36/6csMUjQ=;
 b=NOINjH3yJjvXijixWeSe2WKDsLjUPPwVnJpeCrkOcNkfXuIj3bSS8GfyquxxUqx8y7
 sAfRF1a0q4nS0xFTrgxgTusDcNvxn0Hd3hztSLCltkyfE0QSCYokmO8le0NY9Vp4ZJV+
 oNzmsl7Fc5+g1lHhW5tikxritmqzsquDMD1H3Xm8M5NQKSuzGDC4JuzO7XsF8E1smxtd
 MSnGapu4yx6qxnS98R4ZX3QvdzrO33KqAuYmmXaeI9wHSHNGEWPtobKALku8BjbbTzFU
 iwOEkx46fbOFjWXWU7h+3EBh24V3W4qUHgEjba6Mxw03+D7pS7Y/ONJR4Tzcx/PMjqeW
 aTog==
X-Gm-Message-State: AOAM532dxHY4CpkIS/nEsvOTR7GjYCr+9zDHigCR1KwJkXHMm+2xM3tu
 QMtOITYnBb5ZAQX8BF2EriE0X55SvTkxqqmxMJ97Ng==
X-Google-Smtp-Source: ABdhPJw5x0AEgkl0zS7TbqSdAxQN3uf0Hx2aH3PJcVdok7gm1HKtRxBtcQWI5SdStVwHukOCx3YMDf1PbC5G4xDJzGM=
X-Received: by 2002:a92:8d4c:: with SMTP id s73mr10268123ild.93.1589687237093; 
 Sat, 16 May 2020 20:47:17 -0700 (PDT)
MIME-Version: 1.0
From: Simon <wei.guo.simon@gmail.com>
Date: Sun, 17 May 2020 11:47:06 +0800
Message-ID: <CAB3_kSXU1FUMuTD1ibo88hV0ja+PCmFTCB+JX6dXWoNORR-EYQ@mail.gmail.com>
Subject: Does memory hotplug work when VFIO device already attached
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000122f6405a5cfe7c4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=wei.guo.simon@gmail.com; helo=mail-il1-x12c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--000000000000122f6405a5cfe7c4
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying do memory hotplug(add new memory DIMM)  in an VM attached with
VFIO device (host running with 4.9 kernel). What I observed is weird:
If my original VM is 10G (already occupies 10G RSS at host), and hotplug
add 30G DIMM to qemu,  the RSS of qemu keeps growing until nearly 39G and
suddenly drops down to 10G or ever lower. Then the RSS grows again towards
40G. The free of host keeps decreasing and it triggers OOM at last.

My question is: is this scenario valid and ever supported? (maybe some bugs
in my environment).  Is there any known problem to Qemu memory hotplug
(attached VFIO device)?

Thanks,
- Simon

--000000000000122f6405a5cfe7c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am trying do memory hotplug(add n=
ew memory DIMM)=C2=A0 in an VM attached with VFIO device (host running with=
 4.9 kernel). What I observed is weird:</div><div>If my original VM is 10G =
(already occupies 10G RSS at host), and hotplug add 30G DIMM to qemu,=C2=A0=
 the RSS of qemu keeps growing until nearly 39G and suddenly drops down to =
10G or ever lower. Then the RSS grows again towards 40G. The free of host k=
eeps decreasing and it triggers OOM at last.</div><div><br></div><div>My qu=
estion is: is this scenario valid and ever supported? (maybe some bugs in m=
y environment).=C2=A0 Is there any known problem to Qemu memory hotplug (at=
tached VFIO device)?</div><div><br></div><div>Thanks,</div><div>- Simon</di=
v></div>

--000000000000122f6405a5cfe7c4--

