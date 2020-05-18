Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D1DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C536920709
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4b7yMlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C536920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajDp-0005PA-Uf
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jajDA-0004PU-HW; Mon, 18 May 2020 13:05:56 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jajD9-0004nI-H5; Mon, 18 May 2020 13:05:56 -0400
Received: by mail-io1-xd44.google.com with SMTP id s10so11397608iog.7;
 Mon, 18 May 2020 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L9k9qYuhzCDCbujEXRqKRvNubN+vICoc9TrmsvH+2XI=;
 b=u4b7yMlNu/3nLLw5nUE0jELTTuZi4Kw8l8cQVjwPM8JFj0PPUPfoiKr1Ao3sPCjVe+
 qd9brfWjp6XM2yTwd/rC5HtyyhgC9fotubwM3mXJv389xKDEqcKgnczDagwdr74n4XAQ
 nuyWbTlXJlGNk5QDWq7wwUZP8fBKBGxlyLbsvySWu71PPoDjcB78ZDnH5+mxlZ1iSNYl
 VE2Zd+1g/rMoVs2at1alwypFA7Om/oFaAbZUAKTZOGU7dfcNrGzX1CKwEz1Cp2hkqJ7Z
 fWJNQBZdHfiItrkNKuldc1M1erVk7AaLBdLEUFQDmPcg1Eb8F4HQiC+pxbfIx/XIwgew
 DqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L9k9qYuhzCDCbujEXRqKRvNubN+vICoc9TrmsvH+2XI=;
 b=T79Ix6EZKrN3wrIeUR/MbzJhqAPuWsG8Y9mEmi3yOkk6j7GXvHyRqoLPHbFiWb9A8r
 T+NZpO+U7inYiU+AJRazOtxDnZNeg0FOxklFmsJxNNZLBzGajvtek+Iasx9XZm8fGuK/
 dTSkgrKyaJ4T7aAJ6YOTKlmDbSq+hXl//AruA3eUvs83Ar+dl6DlqViwhsaw5HOvUA8x
 Ye9YswqLsZwdHLIUCf/FHuFZIT47FxKqW+9r20VxEZkfYKdKH6zTPx4ihjTMx8akbqG1
 sJMVIjAjDcpzmIBt7nTYMVE6NZ93LCbAU906rMZXSGH1nwkPLQj26v2izLAxyrf4wmb5
 CzRw==
X-Gm-Message-State: AOAM533EIwB9rTFzQDhj8iLGHkNxeqQPKhsGveTMEgyjbKUde+yms8ZU
 GzW0xv4pibi5NsiAnIO8VFZ7QSPNHCls4sM5xK0=
X-Google-Smtp-Source: ABdhPJz9z6gReMqlby+93jEq1NWHDxnb9TK/LD8Ud1d7hWGoBk6NSW8MxDX+5/PfgRdWO+Up0y13wBSbYnhwYZMR1Uc=
X-Received: by 2002:a02:a118:: with SMTP id f24mr17089184jag.8.1589821553988; 
 Mon, 18 May 2020 10:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-21-armbru@redhat.com>
In-Reply-To: <20200518050408.4579-21-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2020 09:57:02 -0700
Message-ID: <CAKmqyKON3YWJNGiN_xpM4z8x_WSa1kMbNE-gZectExboiCtqYQ@mail.gmail.com>
Subject: Re: [PATCH 20/24] riscv: Fix type of SiFive[EU]SocState,
 member parent_obj
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 17, 2020 at 10:07 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Device "riscv.sifive.e.soc" is a direct subtype of TYPE_DEVICE, but
> its instance struct SiFiveESoCState's member @parent_obj is
> SysBusDevice instead of DeviceState.  Correct that.
>
> Same for "riscv.sifive.u.soc"'s instance struct SiFiveUSoCState.
>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: qemu-riscv@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/sifive_e.h | 2 +-
>  include/hw/riscv/sifive_u.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 25ce7aa9d5..f05644df7c 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -29,7 +29,7 @@
>
>  typedef struct SiFiveESoCState {
>      /*< private >*/
> -    SysBusDevice parent_obj;
> +    DeviceState parent_obj;
>
>      /*< public >*/
>      RISCVHartArrayState cpus;
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 16c297ec5f..5f62cf5f85 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -31,7 +31,7 @@
>
>  typedef struct SiFiveUSoCState {
>      /*< private >*/
> -    SysBusDevice parent_obj;
> +    DeviceState parent_obj;
>
>      /*< public >*/
>      CPUClusterState e_cluster;
> --
> 2.21.1
>
>

