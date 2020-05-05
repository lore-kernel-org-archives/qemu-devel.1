Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF58C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F559206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2tTYkSuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F559206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0KV-0007uA-H5
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1jW0Io-0006n7-2D; Tue, 05 May 2020 12:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1jW0Im-0004en-7n; Tue, 05 May 2020 12:20:12 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
 [209.85.166.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 117D320746;
 Tue,  5 May 2020 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588695608;
 bh=r6Bjjvzb6Ki8isabF5JpTLoDnvLql3rNKrGvEOuF64c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2tTYkSuRwZlGqBbU/w1inP0ExvS1mR7PTs06XVXMO0KXecK9pCnjT0kUqFkwNh+CK
 3pgmmg8XQQN/huH0lt6+cSmywJ7tMdF45vWT/No1n0Kfqy/oYA4WVUrsAQr+5IsKgu
 ucMYPcFG1Lsm+eW/BnBTzTpR+EXCojzLB7i3HzjI=
Received: by mail-il1-f171.google.com with SMTP id m5so2792846ilj.10;
 Tue, 05 May 2020 09:20:08 -0700 (PDT)
X-Gm-Message-State: AGi0PuZTFYsro0NbRxKJjoyTzdFZbUKV5vg4WdSIpOB6h73a+BJqohd4
 OKLOLrd+Espphl/4cpwx4Re/L5l3h2tGzyR36UM=
X-Google-Smtp-Source: APiQypIWEAAnM6Oq7P/xwjFkxnfsLy3p1Qqv2ClfONAQYq1GzWMAE6c33E+1aN8MC6NPmaVXzbSWzG8e/VVcFtGjA6A=
X-Received: by 2002:a92:aa0f:: with SMTP id j15mr4522559ili.211.1588695607461; 
 Tue, 05 May 2020 09:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200505144419.29174-1-eric.auger@redhat.com>
In-Reply-To: <20200505144419.29174-1-eric.auger@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 5 May 2020 18:19:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHKLg8ySP5guG+ZnDCrmzqKuJW_rs7n9vZqtTwEZmWMgw@mail.gmail.com>
Message-ID: <CAMj1kXHKLg8ySP5guG+ZnDCrmzqKuJW_rs7n9vZqtTwEZmWMgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vTPM/aarch64 ACPI support
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=198.145.29.99; envelope-from=ardb@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 12:20:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
 gshan@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 imammedo@redhat.com, eric.auger.pro@gmail.com,
 Laszlo Ersek <lersek@redhat.com>, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 at 16:44, Eric Auger <eric.auger@redhat.com> wrote:
>
> Those patches bring MMIO TPM TIS ACPI support in machvirt.
> The first patch moves the TPM2 ACPI table generation code
> in the generic code. Then the table is added if the TPM2
> sysbus device is dynamically instantiated in machvirt.
> Also the TPM2 device object is described in the DSDT.
>
> Many thanks to Ard for his support.
>
> Tested with LUKS partition automatic decryption.
>

Thanks Eric

Tested-by: Ard Biesheuvel <ardb@kernel.org>

