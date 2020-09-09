Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E233C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C7821532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C7821532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3yU-0001Rv-9m
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kG3xE-00087I-1H; Wed, 09 Sep 2020 13:32:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carpeddiem@gmail.com>)
 id 1kG3xC-00037s-8e; Wed, 09 Sep 2020 13:32:19 -0400
Received: by mail-il1-f196.google.com with SMTP id b17so3124579ilh.4;
 Wed, 09 Sep 2020 10:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wJWyn/gFcvxRWShfpRjEtoqO38uPRdrcC9A4hymXxcg=;
 b=LE+W0OjvwbEPNqRR9XW+Gk3ZdOYQT9Y1P7HYzrx1/nC6uCYY7QJb3ETdAFdW2VQrbq
 o7oVs9SCubW+ut65MHMbfKQrS6lMMlQ7OGOImMCkUn1+YILZDD0wRH23Q3qfWo+I1nvM
 M2GrlMzeRJFP1fojGwIehaRuFFCin1E9qyoED7shnuKz0yiMZD8RTiy1Fan7SMOailiQ
 aD7tJgR0nmkCg36hn8coYCSzYBQbLJnRwZ0lx2weTFApqCvqlK2lgvO3oajxEvIjJQrc
 QbUscDX0QGGM0p9a0RBfi/VZwUF6d6C0R8dRaLUWTYw8IhQ+3AvMP+aTulZ8NWIFpmJS
 y8nQ==
X-Gm-Message-State: AOAM530vj1A+JTwqZoY1k2AticLZZsVurqMVIizXgeNkxAYdzvWGrQBc
 ECTbXeNMb0zR6dPBIGu+TUdLCfLEMJL4/VYgeP8=
X-Google-Smtp-Source: ABdhPJwRALttAJX1FTaH/oJLCmpTbAbCVgpvqnL3ty55QOvAlFXGyPIvlWl1QTQOq9GkzwlKc5xtPxTTUBzxLmmk+1Y=
X-Received: by 2002:a92:9a0b:: with SMTP id t11mr4580385ili.98.1599672736312; 
 Wed, 09 Sep 2020 10:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-15-luoyonggang@gmail.com>
In-Reply-To: <20200909094617.1582-15-luoyonggang@gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Wed, 9 Sep 2020 13:32:04 -0400
Message-ID: <CAPyFy2BrjPh_E3YaxEx73eJjSd3TXeghiokeKL-Y+suupmiP8Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] cirrus: Building freebsd in a single short
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=carpeddiem@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 13:32:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 05:47, Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> freebsd 1 hour limit not hit anymore
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Reviewed-by: Ed Maste <emaste@FreeBSD.org>

> When its running properly, the consumed time are little, but when tests running too long,
> look at the cpu  usage, the cpu usage are nearly zero. does't consuming time.

So it looks like we have a test getting stuck. After this change is in
we could split the test execution out into its own script so to make
it more obvious if/when this happens - for example,

  script:
    - mkdir build
    - cd build
    - ../configure --enable-werror || { cat config.log; exit 1; }
    - gmake -j8
  test_script:
   - gmake V=1 check

I can follow up with a proper patch for that (and making the change
for macos as well) later.

