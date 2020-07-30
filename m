Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E527C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 05:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495CA2072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 05:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV60In70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495CA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k10nc-0005Xs-HY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 01:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1k10n5-00057Y-IY
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 01:07:39 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1k10n3-0005PM-Vs
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 01:07:39 -0400
Received: by mail-io1-xd44.google.com with SMTP id e64so26956438iof.12
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2gtizjOoCVR5++1TYdK1qxPSRsgohqN5FAEG9G0TtOs=;
 b=MV60In70l2fgcjSv2QS+CLpWzSSmsmcZQ3493odLJjU3QguCeWVjzb5WNYvK85avsJ
 iuXDNc+RwipBXUonUimP5r1rdbnOJzVmZSXNLR7WAN4LmMRNPRp1JPF9n821dpNrWiz2
 /RfaA/QqT4rVumV1zm1UIfd/Xd83R1f0ZDJqgfqTWTa5dl24b5RXZlXmHsFJSmqJ3p1Q
 z8UgeL2CArwQF6RGZMvENb5u5EN+4XnBDBaE2GEW5f6aHLXaRpb0XzvIQ3GYNuSLy+r3
 5UyUjSM+5ZXFG4E7IJMwCOocyBxPASwSe04Mdq2ZYlnRCV2nnZwvVC/mhaiBKOOkXMBe
 TxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2gtizjOoCVR5++1TYdK1qxPSRsgohqN5FAEG9G0TtOs=;
 b=Di6kSKOcgR9JHMrkW7mNtYGluWnZO0yP8/dS1yIV/vznmN1Z2grLQEwyevd1fUcE+0
 Au9vu0Y+Djn7mpF2rh2cBt039m//mWjqIE9fphJnc1pEKH/mP1hQCo0iAK7aliCOP8bD
 zLkyqr2g4jFcs0f2NBos+Kd5AqxplsdNdNFdmWMVUnnZmuHvpz2ln+GXAaog5P/73oVv
 1RWKzx3u1Kj1amFqUqB6RHGm0S0uSy9KvNA+7oNoHiFR7xvzqjvaiK1ka3wIJmv5R1sM
 AIqe8pfq/7r0QlaG+Om9QHTSt6TqChrGM7a7GSWNKks0suEMsE5gtLRsAg/ndI1Zmorl
 0HTQ==
X-Gm-Message-State: AOAM5339N2Gn46On1HiM4WtYhcAsztttizFU8C4m8v1O8dqGnmAGPw7g
 GhqLlIL61/DSBERYk26Vo9yb+quOW35LmEbyk/o=
X-Google-Smtp-Source: ABdhPJzCstTFDD+ASPewfMc/WZU3Fi6SRyIkFHsctIlujw5NT7LqPYuaoX3qJlyee7wLzbCU1JSPQFwGffH25bCx8Sg=
X-Received: by 2002:a02:6d5d:: with SMTP id e29mr1544924jaf.139.1596085656477; 
 Wed, 29 Jul 2020 22:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200730010206.47051-1-jingqi.liu@intel.com>
In-Reply-To: <20200730010206.47051-1-jingqi.liu@intel.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 30 Jul 2020 07:07:25 +0200
Message-ID: <CAM9Jb+i1A5-oisY1Tn6A1XUeLktpLSohp1moGzuZSTwQxFFNoA@mail.gmail.com>
Subject: Re: [PATCH] docs/nvdimm: add 'pmem=on' for the device dax backend file
To: Jingqi Liu <jingqi.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> At the end of live migration, QEMU uses msync() to flush the data to
> the backend storage. When the backend file is a character device dax,
> the pages explicitly avoid the page cache. It will return failure from ms=
ync().
> The following warning is output.
>
>     "warning: qemu_ram_msync: failed to sync memory range=E2=80=9C
>
> So we add 'pmem=3Don' to avoid calling msync(), use the QEMU command line=
:
>
>     -object memory-backend-file,id=3Dmem1,pmem=3Don,mem-path=3D/dev/dax0.=
0,size=3D4G
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
> ---
>  docs/nvdimm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index c2c6e441b3..31048aff5e 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -243,6 +243,13 @@ use the QEMU command line:
>
>      -object memory-backend-file,id=3Dnv_mem,mem-path=3D/XXX/yyy,size=3D4=
G,pmem=3Don
>
> +At the end of live migration, QEMU uses msync() to flush the data to the
> +backend storage. When the backend file is a character device dax, the pa=
ges
> +explicitly avoid the page cache. It will return failure from msync().
> +So we add 'pmem=3Don' to avoid calling msync(), use the QEMU command lin=
e:
> +
> +    -object memory-backend-file,id=3Dmem1,pmem=3Don,mem-path=3D/dev/dax0=
.0,size=3D4G
> +
>  References
>  ----------
>
> --
Good to document this.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.17.1
>
>

