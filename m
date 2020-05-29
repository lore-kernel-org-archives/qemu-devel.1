Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8571C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A010D2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaoTNXld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A010D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecH2-0004P7-Qy
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jecGJ-0003a8-PT
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:29:15 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:37576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jecGI-000264-Et
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:29:15 -0400
Received: by mail-oi1-x232.google.com with SMTP id m67so2145542oif.4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OwQhexAqH28RpYFwFIoOCRJDk+PQALWmWutKQyXstaM=;
 b=xaoTNXldeeu22OPNodXo23pnWLR4aa4GWe7uOnsovO2xN4AniOJXOFRMJ94zqxp29l
 pqugCZRhvy+q60Jkuea/M0r2/WhGYXYp6nwFPOZR8YqfeIt9PQH73Z3af7VLda6CZDSW
 gIT2ByrvePzNJb7qEOT7FE1j0ZucZ2aW0BRM9cwUJC6o6aLH+D52LY3IX/hzqQVhwdnO
 UOzUeT7NcAQeOPSqh9xg41S1djhWIANcewcXdY8hzWrfPR4H//D3iCpJfRQsSufnfIAk
 2GMx4P92ik9KTnIG5i1QDF+JtH2k8VSqXo9qnwufnQUnRXRkEOlBBvrKdN9uiEUM2pZW
 0Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OwQhexAqH28RpYFwFIoOCRJDk+PQALWmWutKQyXstaM=;
 b=g+pdC58H0KWNzLuXoVmGz/COQ9YxVdBakT3eCNfRzapT1THYc41dJSS5xwyazjT409
 3YmSDbGKbCRWwaL1kei6w6QLEwCzBKg3c/XyxixyvEfkQ5AZBF0IluhwcuCCrG4oaEDm
 q9p9wPGdnXOpF1MqqZKDpELfcGGBru0LtCmCNdMtmbhm0AWqlEzqOz8hJYW9zw8m4wAx
 GhxnIBklmAlcbsd0NtYuZbB4IEa2Fi4vhz4cRCTdMV2OYam3cJOUGugN+Z09BqmfxRCG
 kEzUEyH9qGJLh8JIzKmmVzA23ACPOjUUCnQdvBNkFMI2EJjFMDB9ilRG+csgZe8dD4XB
 uLIA==
X-Gm-Message-State: AOAM533btIkQIRjEnGhS/FWvJ/WDsCkk+nMq7niqdzCBYnYoEWdJ/d6e
 +AaIuB3yuHw7L60Jqaesz2vZ2lkm5yOU8UEZN3XKjg==
X-Google-Smtp-Source: ABdhPJwkGEBrp/rkvuwy/xdE/zsbjKanyd/3+EjneFaoYSiDAU77wtgUSdtibZQmpupx93oz0updi+RF53vc0LOX5Hs=
X-Received: by 2002:a54:469a:: with SMTP id k26mr5179512oic.163.1590748152733; 
 Fri, 29 May 2020 03:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200528123609.27362-1-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 11:29:02 +0100
Message-ID: <CAFEAcA98OyyyC6gs34e3U03=dXz8GkDn5qf38UaO_XBB679V+g@mail.gmail.com>
Subject: Re: [PULL 00/21] Vga 20200528 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 13:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-20200526' into staging (2020-05-26 20:25:06 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200528-pull-request
>
> for you to fetch changes up to fa0013a1bc5f6011a1017e0e655740403e5555d9:
>
>   sm501: Remove obsolete changelog and todo comment (2020-05-28 11:38:57 +0200)
>
> ----------------------------------------------------------------
> hw/dispaly/sm501: bugfixes, add sanity checks.
> hw/display: use tracepoints, misc cleanups.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

Could somebody send a followup patch to fix the indentation
error checkpatch notices, please?

5/21 Checking commit 97f369f2479d (hw/display/cirrus_vga: Use
qemu_log_mask(ERROR) instead of debug printf)
ERROR: suspect code indent for conditional statements (16, 12)
#34: FILE: hw/display/cirrus_vga.c:1038:
                if (s->cirrus_blt_pixelwidth > 2) {
+            qemu_log_mask(LOG_GUEST_ERROR,

-- PMM

