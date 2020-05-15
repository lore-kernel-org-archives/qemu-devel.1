Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82600C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 20:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A3620671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 20:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A3620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhCl-0005t3-GQ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 16:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jZhBa-0004JE-Vi
 for qemu-devel@nongnu.org; Fri, 15 May 2020 16:44:02 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jZhBa-0004VK-69
 for qemu-devel@nongnu.org; Fri, 15 May 2020 16:44:02 -0400
Received: by mail-yb1-f196.google.com with SMTP id o134so1799452ybg.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 13:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NTdxlXpwO/kgIukTqov8VIFVfe5Qx4AJlpkNjhO8IUw=;
 b=Y4D3r9uaLrlC5BzKJdD/JdnDXwtprbSv7J0bhDKV+GzdiOIih7cq2QVVtmykTuxpZh
 k/9tJMW1G9TnCcajXJPMFVb5MHFTG0of1mhV4mazVCWlQUpg+8vxrfL83gA3IKca7eKN
 kAcejxrsN2sr9THJolXef234x+3flGVvwoCLohYfQIIcf8dY2O4l0E4+/G/lILHNbzRJ
 uczsrB0KMd/h8/NMR1j4HGdZUuX/KqK86yZh5hnJ4JFXFbtdCOFspt19P4awkoh8MQkl
 3H1Z6bLwiOKa4Z5ObT84WZmpYsixaIUGKMI3NAbPixEXN6FvSCG9Md6h8ltEuUIxE9KR
 TQaw==
X-Gm-Message-State: AOAM531Xzk+Ea0QdeXBiegCL+iHxiO71pv3dXQqJGNiaq5enLN1XceYR
 GjCqMkOA0LTCC1MfsrQ1mQkRkgQdBBcUMkrod70=
X-Google-Smtp-Source: ABdhPJxNXHDP/fmrfTJ742EG3JguN9pY0hBjqbxqtBqGiFayCkAtS6jRoJX1tjf5pWkPEGVFP0Qb6U1nhbTxQUJRbN0=
X-Received: by 2002:a5b:5d0:: with SMTP id w16mr8674482ybp.110.1589575440683; 
 Fri, 15 May 2020 13:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200515163029.12917-1-philmd@redhat.com>
 <20200515163029.12917-5-philmd@redhat.com>
In-Reply-To: <20200515163029.12917-5-philmd@redhat.com>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Sat, 16 May 2020 04:43:49 +0800
Message-ID: <CAKBkRUzLvW5TgA83_hrEqn=zrPrYN6ex2--D8n+L+0eUyysJpQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] cirrus-ci: Remove flex/bison packages
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.196;
 envelope-from=lwhsu.freebsd@gmail.com; helo=mail-yb1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 16:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-devel <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 16, 2020 at 12:30 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> QEMU does not use flex/bison packages.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .cirrus.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index de0727cb09..ce7850a320 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -7,7 +7,7 @@ freebsd_12_task:
>      cpu: 8
>      memory: 8G
>    install_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg install=
 -y
> -    bash bison curl cyrus-sasl git glib gmake gnutls gsed
> +    bash curl cyrus-sasl git glib gmake gnutls gsed
>      nettle perl5 pixman pkgconf png usbredir
>    script:
>      - mkdir build
> --
> 2.21.3
>

Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>

