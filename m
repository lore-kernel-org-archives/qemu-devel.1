Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7152C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAAF206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSzAZLpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAAF206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5qJ-0000mZ-Lv
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5kQ-0006JR-Q1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:50:50 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5kP-00023E-8l
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:50:50 -0400
Received: by mail-ej1-x642.google.com with SMTP id z22so1451056ejl.7
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xiH9w16QnZ8MhSAJhQUehcZF69w548sdcPSigukhTRk=;
 b=OSzAZLpzB+o2WtFYm6JSvBQkIVDO/pmL80gXMQvgOWf4flbYUC/0RmTsPhRscb9AHP
 XOX0iUrTmj4SCcRnei6Mv0Itv8tCyDXI1DF5n3IFMaCmBenkJLaXGOf71I8vdoAvEksK
 z6CiF0KbxSihEml1wFIoZfzgiC0j1eLVAMN4RsezgMQ/VNCeosXl4vSDuujKE1DjjT0H
 MlxlKW0ELJzsiBKS9BM4pLWJ5K9T3MEnw1fdfmtx2FuCA8VZg2TyADC3Zu14l893TtZJ
 WHiYYvvgCi6g9Dw/V9/4sZS2lS0ow2DmVNesd2zbK83aWzAKUEy5OtuN0oKZH5YS5qEn
 NgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xiH9w16QnZ8MhSAJhQUehcZF69w548sdcPSigukhTRk=;
 b=V2DZ/mEa+c6MZzwGB5eNY32jmpoaUIG0x41MCNer0Nla6/FV9g5NldPf+xIpTSxUKk
 HEg6nEpIQGgXOtU/tB2WvGq1B5FkBhNG7qAKWqDQMWsVyDHp8yh+3cg6kdjtG0JuDsIe
 KYt+rwAsYHbd95itFVggJqxTI/48S5bBWRbQDp4fUPYMYGujB9nluzxqZ2mBRH9A0ika
 9yyseZiIrv99PPReEMZGhl1mkLqK4cIRgsbcoi3ZjN74zhEIBMGva8N2SvpXcMQj05qN
 wsVbzQOcuQx8L6zv1HCV3MADqoJiKGLz70v4+9Xfm8/+TmO52espD1pDrWCpc8z+SQV2
 LiZg==
X-Gm-Message-State: AOAM532eK1r22BIkjUO6PIa2uvlhwTu0pnjhmaAFjIcIZLS6cw0WLAEO
 fyPrUQHwQIJXs2wn+sHrCvWHZj6iNnuYvmBR21SXVDwkGe6BNQ==
X-Google-Smtp-Source: ABdhPJwP+mIZxCJv7UBB1alCmz0chSPyICVz88lEFJyXAI9T7k0qFh6ktP7eFojmqN+ZeB2EFfrpWErH3dpc9rmjfA4=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr1260143ejb.85.1598964647980; 
 Tue, 01 Sep 2020 05:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-4-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-4-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:50:36 +0100
Message-ID: <CAFEAcA_VYRKQq-3TU0xjoowbnaHsuHxxhnG8VSmsWrM=bKemFg@mail.gmail.com>
Subject: Re: [PATCH 3/4] tracetool: add input filename and line number to Event
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 15:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Store the input filename and line number in Event.
>
> A later patch will use this to improve error messages.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

