Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07AEC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE36321473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEdgduj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE36321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9rP-0004w4-Vh
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hi7ZE-0005cq-PF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hi7ZD-0001oj-SV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 21:26:44 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hi7ZB-0001oR-JI; Mon, 01 Jul 2019 21:26:41 -0400
Received: by mail-ed1-x542.google.com with SMTP id s49so25733865edb.1;
 Mon, 01 Jul 2019 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1nT6RCzhoW9fTgxDD6WsSBGm0pOf4Ir8rW7Q20NZpTo=;
 b=AEdgduj2fpPUPddZjLdryXwYgh2tlHGsgZsgw0GmlIGEg0WJ+RPM7c9qOmv7P6646P
 xnglk1m0CHOa/PgQd4jshi/Ikxy94oIGkC1FZj+YkFUotFQBdtUZqJpT8p0FzHYuOcni
 sdHIv3YRl80hnyGRwYOWtn23L9CFfDw5hzz5n1tCJR2sWEpOCq2a2CNA9FsB4jYRK5KV
 bjyF/LOq7YgzzIbrlT9GAk48SVSJGovx66ksu+nuIlsGa43IRg8dbumFVhCSithDpMex
 HTyusaWhrMrLiUEv5NL33GljIwvAu5skc+F2mhJI17uCu7iRzLaQpNvm0M49GyWmNL2G
 jhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1nT6RCzhoW9fTgxDD6WsSBGm0pOf4Ir8rW7Q20NZpTo=;
 b=DdwWmSW9L303kPofA3Gfs+FRvPcVli1gD9vb817Bp04EUUXObTcOGEXOJAYOo4tPa7
 HCGpzGayIj8TEUH//Wjf/EKEWGo1h63NYd4ADYWpsifKHVB4nA5yVtXVz5Vqa+E4DZN1
 sJB8Ju/Qcl/k3jv8U5ApZ3VWCqiH5oJLtWfLBFmdzkp9XK4R5O9rlUpAr2CUThHRvDFW
 SYFUt+745va4CkBucrQ5gmgmTnjx+xdc9Av76gipMPfNRJWNqDTIKaByr+WdzQ69olBB
 HqM+AkWdWyDk/Yxaqc4MEjeEaGpo9Wwr+KOHl9cpu10mVpcHZ2tPMiEl3NntUrHN3UD/
 EKPw==
X-Gm-Message-State: APjAAAWhx0/7luiWkA6yRwtDDUd8dbOtzju5ukGzKOssv/RGLkp9eV9Q
 BIKnHmBvU5+mu7SFd2XzZRmxiMUg5ds3b89/hXk=
X-Google-Smtp-Source: APXvYqx3dSHpMyWZYauhLTIklNiaVIi+7cOKFdkJuJ+94wbyIzo8YEDkOPEHtk3tnxDOKFxID4vJGjB2yzk/0pA+Irw=
X-Received: by 2002:a50:94e6:: with SMTP id t35mr32906403eda.137.1562030799386; 
 Mon, 01 Jul 2019 18:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190701154617.22908-1-jonathan@fintelia.io>
 <CAKmqyKOsMO7SvvDfiqhywxb=oaqo=NDjw==reVpU9sLh+3dGuw@mail.gmail.com>
In-Reply-To: <CAKmqyKOsMO7SvvDfiqhywxb=oaqo=NDjw==reVpU9sLh+3dGuw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 2 Jul 2019 09:26:26 +0800
Message-ID: <CAEUhbmXBnu_Fet99AjQj6XZ10m045N8kY7d8VNy28ktmFBsrQQ@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 2, 2019 at 8:20 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Jul 1, 2019 at 8:56 AM <jonathan@fintelia.io> wrote:
> >
> > From: Jonathan Behrens <jonathan@fintelia.io>
> >
> > QEMU currently always triggers an illegal instruction exception when
> > code attempts to read the time CSR. This is valid behavor, but only if
> > the TM bit in mcounteren is hardwired to zero. This change also
> > corrects mcounteren and scounteren CSRs to be 32-bits on both 32-bit
> > and 64-bit targets.
> >
> > Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>

I am a little bit lost here. I think we agreed to allow directly read
to time CSR when mcounteren.TM is set, no?

Regards,
Bin

