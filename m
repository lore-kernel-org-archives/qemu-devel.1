Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5BC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4962721707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1GGPhoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4962721707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJek-0001ww-7h
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJJWi-00043S-7A
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:46:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:34108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJJWf-00015w-AF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:46:23 -0400
Received: by mail-ej1-x634.google.com with SMTP id gr14so9069009ejb.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4iEN90sRCtZGoQtgmYKhzCkSyhtoHW3nalIUtvdnjok=;
 b=X1GGPhoT2KYgRAuCbZtaMb2GnbzsMNqZJ1a0xbYaBfVoynCIH2Ht8bA4AOLnIfd0qQ
 YXWIodklj1J/q29jpVPgsTf6OfzJH+/2QqupCoFhUXwcli5QiIJh1NKuWOKEXC2jyyhf
 bJGpz5XpQlwhWeqF+TI00ndkqlIKQcFtWko6pUF5K8N2cVqifA27v3y3K6oZpx2gGYQq
 CUNC25AlppByJ3g+/kcc8M+Oy+9B0ZrJvePxWFAXr7K74KIPhUIMto8aKciLPIKKH1Lu
 oqCpRw4vNRYpFV8jiblSpe9t3tnDDCg5QL557VvL32nh+IWDbaq1YvAV7pByhzofKk4H
 b2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4iEN90sRCtZGoQtgmYKhzCkSyhtoHW3nalIUtvdnjok=;
 b=Sa5M7hWdTljnVYF+eH6SqaJ/Eix+IaH+2k0OG+zH5fhp/FO98kvu2GNGYKw8NDRlMG
 RufGT3daA8p28+158p/mKaY0fyYIsYvxDlH0owkMZ8qc3NiXXg8FzL3c/VeZs9emfJtr
 v7xSEJRRI9vHMO1NGn5ngFgUnQ5PzWE39OxqWREqop1d2Wjo9FA2Rb5mRSZKHL66VIXh
 Iv7HykYMKZNyvYQYAjmHp9YAp9W4WN3cmq0Xxw9LESwXo/FcrALJKS+SYThJbU8mhVCP
 MGYb2fdce+QWepMFGOVSQ6uvvY9MK7A1IM+i16F4EA1/AWnqiJgqbrgcNZeHJuVMHztq
 US6Q==
X-Gm-Message-State: AOAM532vAcEefpLRyOHBhc66tjzmVBoIGGtcyY7oaefzmQ1DvoK9pPtC
 uKHnqy1mC7wZeh8xTXlMBgGYvR/t4py+UMKFoi2byA==
X-Google-Smtp-Source: ABdhPJxAmbEnGBzYvfefjxpx+nmxeeAbqemTqQRxBuPnTaZeCJ8h4HQhIhet2KReYmIGnGphQb3bg/aFl5MJ2ykiWw8=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr38790923ejv.56.1600447579656; 
 Fri, 18 Sep 2020 09:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200918161836.318893-1-mst@redhat.com>
 <20200918123517-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200918123517-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 17:46:08 +0100
Message-ID: <CAFEAcA-k93J5rv8_fS6imN+SPq55ax6+cxfp2gtSQHTC01dVqw@mail.gmail.com>
Subject: Re: [PULL v2 00/15] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 17:36, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> found a problem on some build systems. sorry.
> will post v3.

aarch64, osx, x86-64 clang all run into this one:

../../tests/qtest/vhost-user-test.c: In function =E2=80=98vu_blk_get_config=
=E2=80=99:
../../tests/qtest/vhost-user-test.c:1076:14: error: taking address of
packed member of =E2=80=98struct VhostUserMsg=E2=80=99 may result in an una=
ligned
pointer value [-Werror=3Daddress-of-packed-member]
 1076 |     config =3D &msg->payload.config;
      |              ^~~~~~~~~~~~~~~~~~~~

thanks
-- PMM

