Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A368FC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EDA20640
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umhRwboE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EDA20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADpi-0000Mf-C2
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iADlZ-0005B7-77
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iADlX-0000SD-2I
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:43:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iADlW-0000Rk-T9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:43:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id i185so2847282oif.9
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fh0ZbYYidaK1w0KVDkBIcPA8wIL+RsxEomQqKOopJe8=;
 b=umhRwboErMdtHS9x0zk5M4gDrZFZxhLGKvEABaAa4fyQr6w0IUrxa069QuGmgJXyR/
 4D2qyGCeWf0W8A1l1Zcj/iaO07p2dnpf2LWDzHhXhEKkvfjfneQ9Sqd/tZYTEdLuUEHv
 DCrnKQH0tpwO6VRmhHVzFXCcebDT6aZMFDLQ3Ha/D+YLUM1BdKiy3WbxLxQ08qqXEGMs
 frGGJif3fo0aE/k9YC+iS869i2OyE3IcptGEyGEVUnk9u17DbjKe94IvbBE+dQs/Nu8F
 hwc2yqL3pSj0PILwD2ezHxhPN5FTxhXppFz6Njlm57rG9kNrTbXtWNlOeTvYQHGQ1TIR
 2vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fh0ZbYYidaK1w0KVDkBIcPA8wIL+RsxEomQqKOopJe8=;
 b=lSRvXpGJWw3AUj2RPITiPFl+9zJZiEybTJcUZr70iGcA+XGJeXzouuYEtfkiRjqBbo
 ac1rgn/D8LTwI3CT4ehBT3kEHlHojLbKJl59jNnV67BGHucQ1rjYCin0+90QnCbHgd2P
 0OJd7wNRdz+RgeDIWovt0FReHhOG5jjXpT0Vw8tOoJ+loI9DrJrE7DMvSKWH1T6d3Sl/
 fS0k1Iz3a729CCELTnCHzei7WZSQszAEFP5pgcHl+pnm4wntu3kqYZL2bTrYfqasvtCt
 XHTlieE2cG8gMUN+I1Wmuci5jSB8JKSBMgy6xestub2VafV7m9rQt9xuIeyL7ASn6R/7
 xKIw==
X-Gm-Message-State: APjAAAXZhXQLFsqCAFS3u98DH85tomJHgTbNUJVaMi8s0Z9q7VD/12Gu
 hbVVYOikWHMuJ8pqMWP2dm78VHOK21/yhz2286g=
X-Google-Smtp-Source: APXvYqxc/0BXdX95Cy8PzEpVZ6rU4VV/XeM3PYFfowZZD3i83JGnEggWXQ/CIBI31Fmw2GcYyT+mD78r7SfkrPg5WS4=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr3800679oib.97.1568727813758;
 Tue, 17 Sep 2019 06:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190831153922.121308-1-liq3ea@163.com>
 <20190917114536.sh7xbekebne4pqox@sirius.home.kraxel.org>
In-Reply-To: <20190917114536.sh7xbekebne4pqox@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 17 Sep 2019 21:42:57 +0800
Message-ID: <CAKXe6SJnHqwDA9qoGvz_9yF+HCTcctavdckLmWtuQYh_bd9-ow@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnect
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
Cc: Ying Fang <fangying1@huawei.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:45=E5=86=99=E9=81=93=EF=BC=9A

> On Sat, Aug 31, 2019 at 08:39:22AM -0700, Li Qiang wrote:
> > Currently when qemu receives a vnc connect, it creates a 'VncState' to
> > represent this connection. In 'vnc_worker_thread_loop' it creates a
> > local 'VncState'. The connection 'VcnState' and local 'VncState' exchan=
ge
> > data in 'vnc_async_encoding_start' and 'vnc_async_encoding_end'.
> > In 'zrle_compress_data' it calls 'deflateInit2' to allocate the libz
> library
> > opaque data. The 'VncState' used in 'zrle_compress_data' is the local
> > 'VncState'. In 'vnc_zrle_clear' it calls 'deflateEnd' to free the libz
> > library opaque data. The 'VncState' used in 'vnc_zrle_clear' is the
> connection
> > 'VncState'. In currently implementation there will be a memory leak whe=
n
> the
> > vnc disconnect. Following is the asan output backtrack:
>
> Added to ui patch queue.
>
>
Shouldn't we care the race condition between main thread and the vnc thread=
?

Thanks,
Li Qiang



> thanks,
>   Gerd
>
>
