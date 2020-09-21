Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E820C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8D9207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYkplt7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8D9207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKFqK-0004xr-7Q
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kKFp8-0004Uo-Mv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:01:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kKFp6-0006if-Pt
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:01:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id z9so11350760wmk.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=PRTP9pJnT/ANfkaxCdNo1JK+sAEOCK+Nch36YZGDlv0=;
 b=SYkplt7SU8paCSYVzoktvk4It7G4RdVOMLKkOYb/aEh94zuHVhkZYQz+Wa0qFWf+Ev
 SHX9f67MueHKxWIfnektyp+WZLRO97d5cVqRZNIUjIsN0XCcwxlANnHg1K7OK3Ng3KfE
 P37DPurpiTIJ5b6smshWvz8LjVmQ61DBmiN58VQuVufXPXRXcXXaglZHL6+2y/tRiLoF
 tL1R956rpbUZ+EQSuY+URWUzOBTyHkNhsLc83ER+qRI8XkZs7Mc1sLOsH+NQmDclD7zb
 xvcOw5trd1zb3kHmIavrbzqEmCDSiW5S6KZkmEfvyEUToyode9Kpo9lD2GtUkE7Nex3e
 k69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=PRTP9pJnT/ANfkaxCdNo1JK+sAEOCK+Nch36YZGDlv0=;
 b=IvpBYkAJfAXLbaColbtSIi5/lPrxadwuXhQnIOyZomjn45NR0w4cGHfMpktnQ54ZnZ
 duTDVw8EqTFcYjjVWjyaycHbc4WgF87PWnDpg6yt1NNFydeVv9kxHDtQuGchBalyeH6p
 8RtpNw7X2xtO+MpR+WxDdnMZLdfpLChbJDwtJnmJHCHluJMJr4f1sQFavMkY7z4ANqCb
 MWMUIrffbcpfc60cJRE7vBTGuw5KXxcMcocWsKBA0FwnWwTh8vpxNMO62JG8nsjRpKl2
 qyuX/BidK764htiViHK0qkX8g/gI63ds4CQwTUylOmbQyTEDbFo/QZS9SZsXhvKeV0Ta
 evMQ==
X-Gm-Message-State: AOAM530ifZVOZgRO/xmcwFayRlUI8krzw0Vbh/H7lT4oUo/4vi5V7gx2
 FOs9fTq01MnRiJ8unMoPeFE=
X-Google-Smtp-Source: ABdhPJwEiTX6V1oyzmC79sSVLtad3lEFRiJekKKLM/doSUItcaZT/J2ashlSOhZx60h8d5ruZxrj5w==
X-Received: by 2002:a1c:b388:: with SMTP id
 c130mr28443795wmf.175.1600671674556; 
 Mon, 21 Sep 2020 00:01:14 -0700 (PDT)
Received: from CBGR90WXYV0 (host86-176-94-160.range86-176.btcentralplus.com.
 [86.176.94.160])
 by smtp.gmail.com with ESMTPSA id f1sm17725791wrx.75.2020.09.21.00.01.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2020 00:01:13 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <f4bug@amsat.org>,
 "'Markus Armbruster'" <armbru@redhat.com>, <qemu-devel@nongnu.org>
References: <20200920114416.353277-1-f4bug@amsat.org>
 <20200920114416.353277-3-f4bug@amsat.org>
In-Reply-To: <20200920114416.353277-3-f4bug@amsat.org>
Subject: RE: [PATCH 2/2] qdev: Let BusRealize() return a boolean value to
 indicate error
Date: Mon, 21 Sep 2020 08:01:15 +0100
Message-ID: <001401d68fe4$ffc9a990$ff5cfcb0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQDbvKXwPh23OQy9Fcef/bcPW+QfeAHn2BnTq1kRznA=
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>,
 "=?utf-8?Q?'Daniel_P._Berrang=C3=A9'?=" <berrange@redhat.com>,
 'Eduardo Habkost' <ehabkost@redhat.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>, 'Laurent Vivier' <laurent@vivier.eu>,
 xen-devel@lists.xenproject.org, 'Anthony Perard' <anthony.perard@citrix.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> =
On Behalf Of Philippe Mathieu-Daud=C3=A9
> Sent: 20 September 2020 12:44
> To: Markus Armbruster <armbru@redhat.com>; qemu-devel@nongnu.org
> Cc: Laurent Vivier <laurent@vivier.eu>; Paolo Bonzini =
<pbonzini@redhat.com>; Anthony Perard
> <anthony.perard@citrix.com>; Stefano Stabellini =
<sstabellini@kernel.org>; Daniel P. Berrang=C3=A9
> <berrange@redhat.com>; Eduardo Habkost <ehabkost@redhat.com>; Paul =
Durrant <paul@xen.org>; Marcel
> Apfelbaum <marcel.apfelbaum@gmail.com>; Michael S. Tsirkin =
<mst@redhat.com>; xen-
> devel@lists.xenproject.org; Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org>
> Subject: [PATCH 2/2] qdev: Let BusRealize() return a boolean value to =
indicate error
>=20
> Commit 9940b2cfbc0 introduced qdev_realize() and qbus_realize()
> with the ability to return a boolean value if an error occured,
> thus the caller does not need to check if the Error* pointer is
> set.
> Provide the same ability to the BusRealize type.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/qdev-core.h | 14 +++++++++++++-
>  hw/hyperv/vmbus.c      |  5 +++--
>  hw/nubus/nubus-bus.c   |  5 +++--
>  hw/pci/pci.c           | 12 +++++++++---
>  hw/xen/xen-bus.c       |  5 +++--

Acked-by: Paul Durrant <paul@xen.org>


