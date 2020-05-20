Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F0DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F7E20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+v0NYTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F7E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRRF-00038R-Of
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbRQI-000227-LO; Wed, 20 May 2020 12:18:27 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:38718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbRQH-0007S2-7X; Wed, 20 May 2020 12:18:26 -0400
Received: by mail-io1-xd41.google.com with SMTP id d7so3768751ioq.5;
 Wed, 20 May 2020 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xQBk6Yl16LtvWTOZVMrhCPbzMNMqusPpV7Rabvf+N28=;
 b=q+v0NYTJ8GjhV7KPtmYgiQtbtap4dvazFGRQl8C9iVzgjMP2H7EUNwF1CEV7MMSGxn
 jgl4TDLy00VY0wDYrtZnsCiSn+FmRD+UOf2tNZ90MiXJBMjyC4YmV/ha03EnmnRzRjVd
 t22a/aHdfWhMPDbM3hl7khNNZt5xJUJ6ygJLGT9Atw2vr729IuPk60qMNrhyNlicpzaY
 5jXABfx6XEqy6DhMN9okGr3oWBAHN4QpWvw3WuWNZt/UA6Fgy8hSQ83nfg4TZlu6l2K+
 3J2NkZTa71jOLM1cq4On+xaZ1P7e5PUH7hz6aTq2m5LFka7Fcdp8PI2mQ527Rg6rZ0Vu
 Ue0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xQBk6Yl16LtvWTOZVMrhCPbzMNMqusPpV7Rabvf+N28=;
 b=mWnEE4h5HIS8peJEOT4AXfD7450bNA58fOUbRFzcPMOoBJLrl2etzeDxyC6nkee9Fg
 R74L4tR41Z/O23dOOF5EDFfUnWFUg7/svPYhDo/Yn8BCVjTja81JcTr9rwRt57h6iok3
 40fuezUR58W7ny2bbnSLsYxwMMoa7w0fL5Z8QAlLQDIAkhmwHAi9D4HV6FAsBppl5129
 hCXJrKRDO2qMxMKUDWpWptGypWjEjpLaX+vQbpsz8+GbWbKTxmmKsv1wR+a9ESUHjE+n
 Iw59utZP+2B7oUiLaCvdqsipJuJuJUpw9/UeiLTeTP0liIqipxp7yefeSMFvW+Bk8Lhy
 D3gQ==
X-Gm-Message-State: AOAM5308B4y6h+55wD0hRaUN2mCQEUwrRCbzNO3TKm/zD+V9pMDQn/43
 cIVqAw0ga57L2wwiicspSEM2FOnjBi1SYbl0OYU=
X-Google-Smtp-Source: ABdhPJw7f/GDRTlaOlu79erNFsxVxblLgB649Nl69bkNDNb5U1JMEokA69z4dqtjBVmKBM9Z/IN/B6+0NZJ34sKSggc=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr4144689iol.105.1589991503759; 
 Wed, 20 May 2020 09:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589923785.git.alistair.francis@wdc.com>
 <05ea15f2ec07e1c85273d4897d47c05225b116f6.1589923785.git.alistair.francis@wdc.com>
 <0fcaef83-ec31-d5f5-4677-d42a77d90e3e@redhat.com>
In-Reply-To: <0fcaef83-ec31-d5f5-4677-d42a77d90e3e@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 May 2020 09:09:29 -0700
Message-ID: <CAKmqyKPLL9=xm2sfdgZcovx3m_F8NEE+NC3vZyigbOk7QQyQKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] riscv/boot: Add a missing header include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 11:01 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 5/19/20 11:31 PM, Alistair Francis wrote:
> > Currently every c file that includes boot.h also includes loader.h
> > before it. Which is why the build works fine. We should be able to
> > include just boot.h though so this is a small fixup to allow that.
>
> What about:
>
> 'As the functions declared in this header use the symbol_fn_t
>   typedef itself declared in "hw/loader.h", we need to include
>   it here to make the header file self-contained.'

Sounds good.

Alistair

>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Reviewed-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >   include/hw/riscv/boot.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index 474a940ad5..9daa98da08 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -21,6 +21,7 @@
> >   #define RISCV_BOOT_H
> >
> >   #include "exec/cpu-defs.h"
> > +#include "hw/loader.h"
> >
> >   void riscv_find_and_load_firmware(MachineState *machine,
> >                                     const char *default_machine_firmwar=
e,
> >
>

