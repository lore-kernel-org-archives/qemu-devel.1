Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD13C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2956520663
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbx4paPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2956520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joS26-0004lF-F4
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joS1Q-000425-6Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:34:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joS1O-0006yu-Fw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:34:31 -0400
Received: by mail-ot1-x342.google.com with SMTP id 64so5239559oti.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NLad+mlef+5KxmOwMd4XiGWmOMWI4i1o5GSmm+83lxI=;
 b=kbx4paPN+kL+4sVYmiN5VAm3tpyPeSS8o/yT9NIujcOzBaV5fKyD3FOG/5l+jeVeIy
 Vmwxz/K0KJwTpfivlZ4Dd++XylfIvdOYZ59mBinp4Fyh48T2+Yg5B7BRSGOnjNwVimPv
 oAiGG1u/nfCU0838tAagiCRbmH9U0dwdArwnb8N0bqGbbQ6reSWwcvLIkG5+mEHv/2Kq
 GD/so6wam6wG4+xthFeNBlrufIcwQ6LUQpspg7/9q1lFDfC3UUC+Z1VwHJiQm6YgOLso
 bEqLkc6rRblCM3KIZu53vt0p/OxGcxIDoVeDlEXA/lN66H7eCUfuAS9AQj+WvmQkw3PF
 Z/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NLad+mlef+5KxmOwMd4XiGWmOMWI4i1o5GSmm+83lxI=;
 b=Vvan20QYMSH4u7u7eWAiDZitwwmO/l8hcf70CNEqjUlFwdnO4KIqEfOCzvKLKX8oOn
 /GghuWUCeKm2fW0bJjKs0HSlUdu+ayeNuzWKwnmrwtMcJvfCeJ7TtItbXQU5MDUKYXm8
 xbrhgVj1e/Updmi7grpDUyM5EMcpZc58uzwvvMGOipvfeLoWwCnOp8ZEkfSAn2YT12SQ
 6jK8p8dt9LUHbF1XpG3sV0XoBUjb5Hg6NHP82pmVYD8ZFoD2vIqptMq4xThd2JGEXVWP
 ZQJYZpprc2b4sdJ6yODgjX99lhuq43pbJryEQVMuSZBaEGKv9jwnKaqmgyzlmGOiIuku
 dZtg==
X-Gm-Message-State: AOAM5331T+AkM5UxOuOrodR2zfONZCTUI5OyevNAYH1XckDuBQs9VUd0
 MjgLrEcrgCJSTZfUZEOGTackng1PK3EU8yD8b/rGSA==
X-Google-Smtp-Source: ABdhPJzwp7oRnAHVwMHXfxKzGOEHOeABY8NddsLswpQn09xOm6+Ox4qaPj21tVkOT12iuBQl03AERaFZlFHhBlTJRx0=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr25534916otn.221.1593092069079; 
 Thu, 25 Jun 2020 06:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200622140620.17229-1-eric.auger@redhat.com>
In-Reply-To: <20200622140620.17229-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 14:34:17 +0100
Message-ID: <CAFEAcA-NgFtwrKVWJ4x+9gGo+y4yK8t=gkfUa5XE2yX0cfuZxA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] vTPM/aarch64 ACPI support
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, ardb@kernel.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 at 15:06, Eric Auger <eric.auger@redhat.com> wrote:
>
> Those patches bring MMIO TPM TIS ACPI support in machvirt.
>
> On ARM, the TPM2 table is added when the TPM TIS sysbus
> device is dynamically instantiated in machvirt.
>
> Also the TPM2 device object is described in the DSDT.
>
> Many thanks to Ard for his support.
>
> Tested with LUKS partition automatic decryption. Also
> tested with new bios-tables-test dedicated tests,
> sent separately.
>



Applied to target-arm.next, thanks.

-- PMM

