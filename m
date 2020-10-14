Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD949C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCEE2222C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoMd3eDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCEE2222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmTh-0000Rn-PZ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmNY-0001se-Oc; Wed, 14 Oct 2020 15:24:04 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSmNX-00025j-0f; Wed, 14 Oct 2020 15:24:04 -0400
Received: by mail-il1-x143.google.com with SMTP id p16so638384ilq.5;
 Wed, 14 Oct 2020 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=47ncXARBBUogvJeqAUK8leawSEH7PX2pI1ulDIol+5U=;
 b=KoMd3eDUB8EFy8rOUMrZC0YNLul7ArHcz96eM4lv9akQDt0gi8VV54xih4Lh5+vwEm
 esAu49j78ON7NzwFeyiSXoaXKhuNGqDRKyVw8Ka/ePDn1us0l/F2NHUn6os6ck/7fOkz
 pXDiHiqPeX1oPFiQkJ/tROqA9N4AW8YyniB/LPNKbSKkKRfx2CVsVOmLyKFcuuUVa/KO
 LXZdumsMbXN+gLcfWySuEQygK5eYDatfm7fL/94ph/t6KrrcFJDaXgLGHQs3AxztpvZa
 FPr/WaCMfuGk4o9zRdGC7x71jM0TdKKCFB73A3dqE5JC52WdU1lUa5/kjt7c8VnYWtYV
 euAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=47ncXARBBUogvJeqAUK8leawSEH7PX2pI1ulDIol+5U=;
 b=aWXd5YNWP+WVr/IejAfzv6GNCPPHSjVsbjdeWBnhBeIfEVE9QzqyI5XsBSEYLj6x9A
 sKg82QpFMQXwg0MRmqG/z5qco4F7OSFDD8cDIc1Y4vkQrIHfpb4tcZS8b7i8Ab8xoGSe
 2iHaGiL6kzSbamLD2zvybnxRXdah4yNgHNR7wlYcvmx3nxYTXaKQoXaNJTt6kc/nK15H
 nSvaoBb9FKFbMoPKwkO3S6NKgxeWZ1D7A9Tk6LLQLhRL2inCX2lLY8isgCkXfGXbc86G
 COi7FbP/mNeIst/qgDsZph36gjdzoJN2GXQOR8kpAlL7fgD/FdTihiD/rOMQlQu9okZ3
 gaHw==
X-Gm-Message-State: AOAM533iE533WDZ+Bw5hqGc72L20ENCQlfMIH4whkp6Mn2+UYbLZqPGx
 gGY6xLCDXqMEkGSPpeGIvbeRvVGJNVXXmo9Erbk=
X-Google-Smtp-Source: ABdhPJwCz1oqcGLKY/faEsqchsfX5WZYAufv0laopp2Ay5L+c6rchQoURhPSd2/ar2tdzDIB21z5eY/u/zOuMGibbcI=
X-Received: by 2002:a92:dd0f:: with SMTP id n15mr601457ilm.227.1602703441365; 
 Wed, 14 Oct 2020 12:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201010080623.768-1-jiangyifei@huawei.com>
 <20201010080623.768-2-jiangyifei@huawei.com>
 <0bc022ca-35f6-8579-51f1-65005e89a9a3@linaro.org>
 <cbbaee32aaca498294e599ba7768279a@huawei.com>
 <0d4fa7cd-b534-5635-302a-6ef0c4b8426a@linaro.org>
In-Reply-To: <0d4fa7cd-b534-5635-302a-6ef0c4b8426a@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Oct 2020 12:12:23 -0700
Message-ID: <CAKmqyKPcK9jKCF4VrVsSuPMpTJXjkOdhmRc0jPqkFVyRLA1qUQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] target/riscv: Add basic vmstate description of CPU
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jiangyifei <jiangyifei@huawei.com>, yinyipeng <yinyipeng1@huawei.com>,
 "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 8:45 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/14/20 3:21 AM, Jiangyifei wrote:
> >> Would this be a good time to expand mstatus to uint64_t instead of
> >> target_ulong so that it can be saved as one unit and reduce some ifdefs in the
> >> code base?
> >>
> >> Similarly with some of the other status registers that are two halved for
> >> riscv32.
> >
> > I agree with you that it should be rearranged.
> > But I hope this series will focus on achieving migration.
> > Can I send another patch to rearrange it later?
>
> Well, that changes the bit layout for migration.
> While we could bump the version number, it seemed
> easier to change the representation first.

+1 it would be great to consolidate these.

Alistair

>
>
> r~
>

