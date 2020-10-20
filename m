Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1778C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFF22237B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFF22237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlNB-000331-V1
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 02:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUlLz-0002Jl-L5; Tue, 20 Oct 2020 02:42:39 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:40766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUlLx-00036h-Ow; Tue, 20 Oct 2020 02:42:39 -0400
Received: by mail-ej1-f65.google.com with SMTP id z5so1022911ejw.7;
 Mon, 19 Oct 2020 23:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n5wA3F/wNadLtgZKL7hEJNVuHrBuhC/d+3AOnovrj7s=;
 b=F0wyKRSEyovPqLJEAFMHrNL06pLkdznSKBOGwgFIfaUhuHAmoQPDFQld89zRNOCsda
 22H8IXc9mUO/2081tigrhsbcF2LBKTeLFU6olzgbS0/wFn6+56SG0N8QDO8tq3eI3wKU
 a9kX38ToWTuT0AXrO7Jx9ztwtHEGcjtVy5rhkgVzpmS06efiJf74gug07HD29yvS1Vwu
 3U3l/UeVPbBmaMATGRPc9ot4ueLvF0eTAeV4NzqdLgBTQu9lILUC6sVe9PC30ltfnjT+
 79TWt3ABkaImPGMZclqBdcbNjhhKrk2wILDTy1c5Giq5BcuP7QMYbLdh7Pe56dEFh6a7
 DU6g==
X-Gm-Message-State: AOAM530yiz7NOZwPvuKiz3+mvdzU/Z/cm1KcOHxsMX9n5nGIDHhABPxE
 2n2nDd/c7+3tQNRpAS/vVmV8IVUHvfjKc4DgwG8=
X-Google-Smtp-Source: ABdhPJzOTKSm0mIIS2FPQf0RDVsv4FcrMyx267Rcq9bvKebT0LHe5ufxq7CB+qm+iBIC7DACIM25SfCFe2EcbAciBsk=
X-Received: by 2002:a17:906:fb86:: with SMTP id
 lr6mr1609234ejb.510.1603176155998; 
 Mon, 19 Oct 2020 23:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <a5a68476-0ed8-08f9-f993-464317d798bf@huawei.com>
In-Reply-To: <a5a68476-0ed8-08f9-f993-464317d798bf@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 20 Oct 2020 08:42:24 +0200
Message-ID: <CAAdtpL5HZzb+_gAyNGQfM1N7vBxmLck2TXiGohv9D9dgO16cRw@mail.gmail.com>
Subject: Re: [PATCH V2 00/14] fix some comment spelling errors
To: Lichang Zhao <zhaolichang@huawei.com>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 02:42:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You forgot to Cc qemu-devel@.

(See https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintain=
er)

On Tue, Oct 20, 2020 at 4:46 AM Lichang Zhao <zhaolichang@huawei.com> wrote=
:

Now your name is properly displayed, so I assume you finally ran:

$ git config user.name "Lichang Zhao".

To fix how your name is displayed in your previous contributions,
consider sending this patch:

-- >8 --
diff --git a/.mailmap b/.mailmap
index 663819fb017..a56c5ba5ee1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -113,6 +113,7 @@ Liu Yu <yu.liu@freescale.com>
Liu Yu <Yu.Liu@freescale.com>
Li Zhang <zhlcindy@gmail.com>
Li Zhang <zhlcindy@linux.vnet.ibm.com>
+Lichang Zhao <zhaolichang@huawei.com>
Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Llu=C3=ADs Vilanova <xscript@gmx.net>
Longpeng (Mike) <longpeng2@huawei.com>

---

(or Ack-by it here and I'll send it).

>
> On 2020/10/9 14:44, zhaolichang wrote:
> > I found that there are many spelling errors in the comments of qemu/tar=
get/.
> >
> > I used spellcheck to check the spelling errors and found some errors in=
 the folder.
> >
> >
> >
> > The checkpatch.pl file in the Linux kernel can check spelling errors in=
 patches.
> >
> > I'm trying to add this function to the checkpatch.pl in qemu,
> >
> > so that no similar spelling errors will occur in the feture.
> >
> > It's not done yet and I will commit the patch when it's done.
> >
> >
> >
> > v1 -> v2:
> >
> >   add reviewed-by for patch
> >
> >
> >
> > Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> >
>
> ping
> This series of patches have been reviewed. Can you help me to pull them?
>

