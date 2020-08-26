Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB136C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E6BD20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPusono1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6BD20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAu0a-0002iG-TZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAu05-0002Io-0S; Wed, 26 Aug 2020 07:53:57 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kAu03-00011M-HN; Wed, 26 Aug 2020 07:53:56 -0400
Received: by mail-ot1-x32b.google.com with SMTP id f42so1213560otf.13;
 Wed, 26 Aug 2020 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+pDMaq0usRvQZ7ueN8k7FqGtCitNKC3enjyxczL2r1E=;
 b=NPusono1aQTJJnxYdTBtYbLmKLLmmKjxzz1Wh1QUkU1MtPw0m3iBuad0JT7VYmKjQ6
 Y5GcOGzoyPiFnrjuIsEz0DLKP43VkqoW6wf1CS3cVDLhDIZWDQKxd36GKBOpcgN+IDKW
 Pli3pCaKD48+FNc2hxAHTS63xJJXeS8qQojxSCz6U19DIjAlvHP80nANB+grCYSbNRmM
 xTCQZ04sCntF5wGQwe2EakmGT2VUZOzloVWdBIN9To3XudcLqE3acP9dv+SDz/HARa7+
 3q+K6DBstwDhccZs8cd/lzr0zaMiLugqjDH5ZI8QzqCqSKS5I7+Oy7sWidh8Y9w+s9SW
 yFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+pDMaq0usRvQZ7ueN8k7FqGtCitNKC3enjyxczL2r1E=;
 b=VhLyDvLCKEgfbDEpN5WyifPaF/dxe/hppgrdVm438xhADYflnkskuEGkESDTSMmTjq
 GVDAajaF3lHGKKef6Q0EuFxcyA6uMbYHj6VcKFQxLCgeQhSlV4Q0Y6xau/Rn1AgMcyN2
 NG7jm2DdDwPbpAAphS03QVCuyQpbprBunq0n8+cFwQ371CzX7+/eX+rTl96AH9LXsegu
 msES+1QqzjpDg9vo3xjPGT0v5GKAIGBHKRGINr4pnTuDwnH7GnHOoa12PP4rfPenIP6w
 irrLvl/WCOTZneuzvzKFghNvAi8qvsGhJd9a5G1Ssbq/zKjTgZSzmrMAdBYuYWInJHFO
 1j0Q==
X-Gm-Message-State: AOAM531kQihF4tOtB9/GGptgpQiCZI8PNF1BzrcUwYrtFSrgD24wF90X
 6LL4rDKNNvZ/7qeHBrg8gE6kHGNnEz5YBcuI6wo=
X-Google-Smtp-Source: ABdhPJzLLoUxJ+daUQ818fgUlzkVvTIcc41MMpA6U4IledO9N7wkXS7ISmhLpkD6OO0L89iXiQwZH7OWfB6PMZWI1A8=
X-Received: by 2002:a9d:788:: with SMTP id 8mr2975489oto.181.1598442832290;
 Wed, 26 Aug 2020 04:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-3-pannengyuan@huawei.com>
 <CAKXe6S+MV3fyCoyDbDV01CbuGoR8JO3e1=VAh4OFP5bKUVMXkA@mail.gmail.com>
 <20200826134118.07fdec61.cohuck@redhat.com>
In-Reply-To: <20200826134118.07fdec61.cohuck@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 19:53:16 +0800
Message-ID: <CAKXe6SJiyavybCe+PmrHU2ARu_oMD9O0X0LTFFQ_bMdMtJ-BHw@mail.gmail.com>
Subject: Re: [PATCH 02/12] hw/vfio/ap: Plug memleak in vfio_ap_get_group()
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cornelia Huck <cohuck@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 26 Aug 2020 19:03:37 +0800
> Li Qiang <liq3ea@gmail.com> wrote:
>
> > Pan Nengyuan <pannengyuan@huawei.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=881=
4=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:29=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Missing g_error_free() in vfio_ap_get_group() error path. Fix that.
> > >
> > > Reported-by: Euler Robot <euler.robot@huawei.com>
> > > Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> >
> > Reviewed-by: Li Qiang <liq3ea@gmail.com>
> >
> > I see Cornelia Huck has merged this in his tree.
>
> s/his/her/ :)

I'm so sorry for this mistake.

Thanks,
Li Qiang

>
> > Don't know whether this series will go separate maintainer's tree or
> > as go only one maintainer's tree(maybe Paolo's misc tree?).
>
> Whatever works best, but I still plan to send a pull req this week to
> flush out my queue.



>

