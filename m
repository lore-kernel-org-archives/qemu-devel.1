Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FDCC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66D620797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66D620797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3mV-00058w-JM
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ3l9-0004WK-9A; Wed, 07 Oct 2020 03:21:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ3l3-00015C-0h; Wed, 07 Oct 2020 03:21:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id i5so1068643edr.5;
 Wed, 07 Oct 2020 00:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LhXJiZ+b65QmDovICE4BRjry3VCOKT7pSd+Fk7bW12Y=;
 b=VcoxWtRokRLlvGGEzn2Di2tElo1QflxWM6WCSpyp5pf/Yep5qUhXnCZz86VQD4pVI3
 8qVSx5lXm6kKKmb4S1Q2tUvX3mQ1CJrQXJ8J8wH2eJxidVjvAqpfAZIsDZIn0WRjCmb9
 /TA39gUzB1ipICnWc16+S+mzEIRRlPFag5wW6fni86YJr0xoXnKMK1hU8nA3MSb/utcz
 gQ6DDU+EPrp/BHWdA+jZ1zpACIeIy1EMcblLKTo9wdh3gz27pSWCLFsDoFkaG6+idXmn
 Inkr/kv33eVGJUviT/uUk6SwvJpCGGUIh4UZphgYH9x8vkjJr4Tvpp5CnAWb7WaUJW+s
 iiqQ==
X-Gm-Message-State: AOAM533LTq3kMoHVNkDa4UlluIeGIxxuD36jA/UP2yclW8iMYURkLzPZ
 VQ0AdmGKvHBo8bw/2DtsamEGpXk+8iQdtug0PYo=
X-Google-Smtp-Source: ABdhPJw13CvKplUq6CJ1Xxhg531pOT8VijhBWWP1syViQyQtYxrz7C5r9QbA2tqm/PJjtXf9MjNB1/GeWZkLwIyNzOs=
X-Received: by 2002:a05:6402:44c:: with SMTP id
 p12mr2004737edw.157.1602055263204; 
 Wed, 07 Oct 2020 00:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201006221827.1682106-1-slyfox@gentoo.org>
In-Reply-To: <20201006221827.1682106-1-slyfox@gentoo.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 7 Oct 2020 09:20:51 +0200
Message-ID: <CAAdtpL7a7zWGYsKTF6pZuzM7tryLcN0hHJqHCBSVrk8HBYrWGQ@mail.gmail.com>
Subject: Re: [PATCH] meson.build: drop duplicate 'sparc64' entry
To: Sergei Trofimovich <slyfox@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.68;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f68.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 03:21:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 7, 2020 at 3:06 AM Sergei Trofimovich <slyfox@gentoo.org> wrote=
:
>
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index a02c743794..48e7c56cc1 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -41,7 +41,7 @@ have_block =3D have_system or have_tools
>  python =3D import('python').find_installation()
>
>  supported_oses =3D ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin',=
 'sunos', 'linux']
> -supported_cpus =3D ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'risc=
v64', 'x86', 'x86_64',
> +supported_cpus =3D ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86'=
, 'x86_64',
>    'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>
>  cpu =3D host_machine.cpu_family()
> --
> 2.28.0
>
>

