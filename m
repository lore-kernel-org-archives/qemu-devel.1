Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FEAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE4F206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwKN1W3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE4F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXW3-0007Dx-H1
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZXV4-00061C-II
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:23:30 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZXV3-0005As-Js
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:23:30 -0400
Received: by mail-ot1-x344.google.com with SMTP id j4so1470041otr.11
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I+CVRVNoW6KiRzqyNKlO+Y9DXrgjEYbM8n9WCNzSQAw=;
 b=CwKN1W3qrJJ2mYq9rICOdl3QWYXeLY4i6/AfG+ggRxMMe2m9TkqIhR/Q25pUViYBF5
 82VdByNWZlUSgx+xZ5Lru3NVIE7q9ZZkYK5T2FbM1Ah7Eqp8FU2NSxNRrcQ+5T6/w95H
 R7egQcI44zNHLo1ou8h4cxX6SeiA+RYyi1iyjeR7WMtlMykZ0f0xo1hvLZ3gFAosiC9i
 z46l/cIHnMWr/G/m0SG7vPX4jwysS1Zf9bA4JIEobjvofWUFDVbMm4e4DNepvfh18/ZS
 F4igSp9NQR/akkRye5ZbIhmrMgoeroj7P2Mbwb6HuloSGCKvOlfVV0+YdgEQT8SCsBQI
 r2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I+CVRVNoW6KiRzqyNKlO+Y9DXrgjEYbM8n9WCNzSQAw=;
 b=MvydghrKe7Aw8ln1p/1ZI7Fzk2sAMf06eaoIpB6eJZ8nykON83fBqPbSfCXOle4vHd
 U7MAjuUJIybq0uMbTdqugDCE8SMT96KnzKbV9Zt2n6HsNFPBZ5PmU9Vf9gDxCsDizMih
 rac+jwMUGp5VxSWpvuDn8Z1Ggn3AxtaGcuSodKYHcsfHouY0FXPxNGOctibBJyplRwyv
 twz6fyK9xxdOTlGyi54ShCYCZ/pIY28NJvjnh1dVtQhQ6tabeEMcN0TQMP3fqDnnTHF7
 7EV2NghqBxX+N7iD/A9FG+jmfSorI7mAkLYiKe+TLOv6bx1VkQTClp9CBMNXvGK9tJbs
 0a+A==
X-Gm-Message-State: AOAM531ltEJqk0yOJVLimKkMSQT0HK0GssKZ0XpIoFKo9r41hzTbNTbZ
 9P6je/gMTZwbhuI9L6DO6EZUoHK2DJv+1FJjV0KtIA==
X-Google-Smtp-Source: ABdhPJy5feyswCTvztcIA+bGuGLgQrA4p37xfYKzEza1d/mIkXkQcQkN4UrS2p1bSvCRjcP3+gNsVWoXR587z5v62pA=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr1677156otj.91.1589538208134; 
 Fri, 15 May 2020 03:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <CAFEAcA_p1x6S10yswHgOkMd=KrxcTGh9TD47+k1LRKM0xy5x+Q@mail.gmail.com>
 <567755c6-3bb1-b16e-af26-431dec4616ba@redhat.com>
 <CAFEAcA-67uGcwSu7mJ+w26xYqpTm4C0t3Yrr8gWCsA1VtHeaLg@mail.gmail.com>
 <49f4fc6f-329b-9afc-92db-c59dd1ce67ea@redhat.com>
In-Reply-To: <49f4fc6f-329b-9afc-92db-c59dd1ce67ea@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 11:23:17 +0100
Message-ID: <CAFEAcA93bQOh12CPS8xp9Qc45YrPTVSLo6yQ6raQ0WitHR184A@mail.gmail.com>
Subject: Re: [PATCH 0/5] docs/system: Document some arm board models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 10:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Sphinx consumes docs/system/$arch/$machine.rst files committed to the
> repository, and we don't need to build various qemu-system-arch to
> generate the documentation.
>
> If you work on a particular board, you might end up only building its
> corresponding qemu-system-ARCH. Maybe we can add an extra-pass once a
> binary is linked, and re-generate the docs/system/ARCH/$machine.rst
> files, so if you modified a board and its documentation placeholder in
> the code, when commiting your code change, you also have to commit the
> rst changes.

I'm not a huge fan of committing generated files to source control...
I think I'd prefer an approach that worked via some kind of
kerneldoc comments that we pull out and parse using the Sphinx
plugin we have for that. (There's more complication than that
but roughly I think that would be the kind of approach I'd like
to see.)

thanks
-- PMM

