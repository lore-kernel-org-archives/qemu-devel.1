Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C396EC3F2D4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDBB246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnHbY0kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDBB246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7crS-0003Nq-OB
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7cqt-0002vl-VQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7cqs-0002Jj-KU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:26:39 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7cqs-0002JV-EA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:26:38 -0500
Received: by mail-ot1-x32e.google.com with SMTP id v19so2090272ote.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KKr3AjB/F4dFrrGe2ZMuhk0ZYyBKFSGg3navKvsNvS0=;
 b=pnHbY0kvY+5mVDFeXN7eb17j1bGBTUP7/lLezcAG3MHutIjNUxfJzmVicXVl5lt2zv
 Mlebzvs3ItoYsTh4+8xHeGOnbD1u82IM8ZHNR/YFwQaBC8stAAipUaXaAtsp3Se3RaSF
 9ptuN5+815a5zpbkCK9U0j/aF7/12pyaP8SQxq9G3osXS2hR78K20TR9CvUOm+nMHluM
 Il6e3Hjc9vlmu7b1J2bfv8qODQZ9ASjV1Q6nqcACbBPi1ZXegrW7IHDkjlgYc3yqMgQP
 GyRLG9x9f4jqhUpfwr8MqGSiY8fPK45rPeowFjnUPlvnADRxWkM7IWEeygfeUKKEsXNp
 7gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KKr3AjB/F4dFrrGe2ZMuhk0ZYyBKFSGg3navKvsNvS0=;
 b=QtnHck3WYF9Kj3dBzyuLUWeHmZHQJWBeINw+v/gnEX78rieOfDNyBd0tpK42usj3xK
 9uTF070EFqdaUKZg57HWeV0bWrZZW9QJilMVWM7jm9zEQ1pv8Bcru+TURpWTSBkwmGre
 RHq17wTO+9H+vudvyHfZTz5RC62QqFSNr+an0c2FlLIC8r1UjAn6iMIbEygQqSJqPPPX
 6NOhVUA/lcVPx7ymTj+9W3o2V1m5A+pt8ZJAWdWUooyq9mq5gPbqKJUOqesZDW9bt//x
 ufhzUbugxjse7EzVnjzV2QEGvssDbd5TGT17RMpvH8jTK470bFboe/30+24XALgZtgV8
 Hucw==
X-Gm-Message-State: APjAAAX+RKLNiGo4BGZBPGGTmhvdHjFB3+j2zJhz3A9d8s96nvF6eck6
 Eei346SzY1cDbF3KVtA5omWbt4pxMAqUCQ18obGk8A==
X-Google-Smtp-Source: APXvYqypNTtw8UZcBzwCZWVHNSQEeUz5wo/CC5fpLYXsIQdzwnDoRwTI9xEL36HelRRL5nLFMGX34MY6zAXQf05w6PA=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr2693017oto.135.1582885597395; 
 Fri, 28 Feb 2020 02:26:37 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR02MB5935836FBB0AC02F56278FE3CAEA0@MN2PR02MB5935.namprd02.prod.outlook.com>
 <CAFEAcA_iXuc_r=wJWhHjZ1ROvfCwsxbU0yyiwJpqaxDfFtfmbQ@mail.gmail.com>
 <MN2PR02MB5935FCFCAB2C3CECE898B290CAE80@MN2PR02MB5935.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB5935FCFCAB2C3CECE898B290CAE80@MN2PR02MB5935.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 10:26:26 +0000
Message-ID: <CAFEAcA9h29YvbXSZxq4xFg_NbiYr-amqF9QGBS8nBvhvLi1WhQ@mail.gmail.com>
Subject: Re: Implementing IOMMU support for SDHCI
To: Sai Pavan Boddu <saipava@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 10:08, Sai Pavan Boddu <saipava@xilinx.com> wrote:
> [Sai Pavan Boddu] Our idea is to create dma helper function which can als=
o pass the MemTxAttr i.e like
> dma_memory_rw_attr (AddressSpace *as, dma_addr_t addr,
>                                      void *buf, dma_addr_t len,
>                                      DMADirection dir,
>                                      MemTxAttrs attr)
> which needs to be used in sdhci,  with "AddressSpace *as" pointing to smm=
u.

Yes, you want to be able to pass MemTxAttrs from devices using
the dma APIs. (Or you could just call dma_barrier() yourself
before directly using an address_space_* function.) Plumbing
that through is straightforward.

As an aside, we are enormously inconsistent about whether
devices use dma_memory_* functions or just directly
do address_space_* calls. I think the intention is that
the dma_memory_* include necessary memory barriers, but it's
not clear to me at least when the barriers are necessary or
why we have this family of functions that some devices use
and most just don't.

> I see we don=E2=80=99t need QOM variant of MemTxAttr for this functionali=
ty,
>but thought it would be good to use  " object_add_link_property/
>object_set_link_property " to set the values from machine file's.
>I would drop this idea, and look for other options to set the attributes.

The attributes of a transaction are set by the thing generating
the transactions (either the CPU, or the DMA device, whatever it
is). Typically they're either fixed, or possibly configurable
at a hardware level, or sometimes configurable by software.
I don't think any of those scenarios are ones where you'd want
the board model to be passing in a MemTxAttr at device creation
time.

thanks
-- PMM

