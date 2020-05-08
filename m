Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA84C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292942184D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 23:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnww7iqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292942184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXCDk-0006SB-8c
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 19:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jXC7g-0004gr-H6
 for qemu-devel@nongnu.org; Fri, 08 May 2020 19:09:40 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:42414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <saket.sinha89@gmail.com>)
 id 1jXC7f-00080C-C8
 for qemu-devel@nongnu.org; Fri, 08 May 2020 19:09:40 -0400
Received: by mail-lj1-x235.google.com with SMTP id a21so3378482ljb.9
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=7FsOyFlogZIpwj5qH7w5pZ+TaxggstyoJqZeF6S/A/U=;
 b=Vnww7iqezleRdXCfkhX4VzWk0RF+vZLFEGFFqvQ80D/TmNK1EvXFtcz0PrymxKy7z7
 oiUdx2/v4TQJ4/41nAQkeihE3/CIMUYuhppfEBHFI01zoaB2d+qC4FSVUMiPSU2Zdhe0
 aP69d2NbvqqN25CEeYaGIGq3FVQsTW2MYp5ntWzMxk9/ndv4ZObVHfSbeAtP3RaqAStc
 Np+lhCFWRcXREDZ69XX1QT0esJTG6HQ78iYSmGaZbAKdid7h7vuEwsPqNMlSMiaXaHIJ
 GbEeGOPMooedqSCLRXMTRilwMGgQIUyLedtBRYdRNGn9RKiwveMuGs+RE+o7nj2RlpfM
 s1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=7FsOyFlogZIpwj5qH7w5pZ+TaxggstyoJqZeF6S/A/U=;
 b=X69KSeFEua7I8b2Wqn5dWtcbZ6vkz9396vrM2+M+m781kkpgWIjLMw+R0b/Zn6u/DF
 fl0Dm52AP9nNALPaxUH4AF1zWuCNWF09EsWZz+c0LDAESDFgiFaO/x540mhF+ILQcUjO
 EJQHsw3FRGI2nefmtF3krTiC0AfrxZhAms38qHxyKszO/ZiPwmNHkSTwHarAZSBjoz15
 mmmie6pO8i4sbV8wq48RL294wjht6oxKpvoFSGwL35TWu8a406zG5s0Pudzbub3w5v3A
 iDI9kQnhJTEM5BcjIlSCWJwZROnEpg7/9RMaDy4spXF/ChrfPo+tfMoMtlWmwdbdfdfX
 NPKQ==
X-Gm-Message-State: AOAM530xuANX1daZX7yOfJahX6ObVNN0DW3mrtOqFsntL3qYjiVSuqDL
 tOnOepKv6M+RQas7pBxcMNb/1MN3KLUHxIbBTLDD7xdO
X-Google-Smtp-Source: ABdhPJw3wU3dPlkNtKfDfJZq/Y+yQ+3z4De2V3bCcGpgbKr6JHp0T7oDdL8Qy286THh2It3NGMgjgPvrYhjdEGJvzqU=
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr3006106ljj.137.1588979376647; 
 Fri, 08 May 2020 16:09:36 -0700 (PDT)
MIME-Version: 1.0
From: Saket Sinha <saket.sinha89@gmail.com>
Date: Sat, 9 May 2020 01:09:00 +0200
Message-ID: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
Subject: Qemu Support for Virtio Video V4L2 driver
To: qemu-devel@nongnu.org, Dmitry Sepp <dmitry.sepp@opensynergy.com>, 
 Kiran Pawar <Kiran.Pawar@opensynergy.com>, 
 Samiullah Khawaja <samiullah.khawaja@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=saket.sinha89@gmail.com; helo=mail-lj1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi ,

This is to inquire about Qemu support for Virtio Video V4L2 driver
posted in [1].
I am currently not aware of any upstream effort for Qemu reference
implementation and would like to discuss how to proceed with the same.

[1]: https://patchwork.linuxtv.org/patch/61717/

Regards,
Saket Sinha

