Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BEC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41062217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6rr5qAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41062217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gAV-00045i-1o
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 14:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2g7Y-0002Ly-MI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2g7X-0005AR-CI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:23:08 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:33508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2g7X-0005A9-8P; Tue, 27 Aug 2019 14:23:07 -0400
Received: by mail-io1-xd43.google.com with SMTP id z3so484465iog.0;
 Tue, 27 Aug 2019 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w8yY0OFfbc3YxG9n5Dn+LNxL5AoCkqUrnmktVS2lDM8=;
 b=G6rr5qAAD+zuJgqORsj35djrAw71okScTOdo8GrcLae8lNf4lQFLU5AOt6W2zmfVsH
 YFGF6h9l1AlFZzjJh6j5w8Nj/uD2+KAN0ajksHLSbU8bFsWgUYXSqQqGUSaA+ZB9xk5A
 Ykl9v+BYCK1P2i6TMpPMRvSz6j6I0YYmPFCm6Z0wtmyZLxKSDaLwQO31W4fj2HebUkcj
 zWpFnMVkEVbxgxeLdjQf7ciLRc3bDikup+IHqOc8EO+pTkjOVWl1iGyYMBPQkaKnme6x
 68FZnTiL7AFppA9mpX9QLoUJipwOsT2lHFURn8mLGOfvphIzsdxqZKQiH7ERIDYxawCL
 8anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w8yY0OFfbc3YxG9n5Dn+LNxL5AoCkqUrnmktVS2lDM8=;
 b=G2Tw11IlKM/h6RGRRnO8Y27h9CSeoPON3CRimmk56GiU8Dv/enmoBzb0ie4uPzHvUW
 xshqYrEhXhfssyzwoIF7LFnVskvO/BsJjHWZlkEIbWgYEsP6ZMLXGS3KyKAIQaB2ip7J
 wBtwBoYS6ooVCA3eoQYn0w45bo1c3+WnnmpPvG8+Srw8hg8UA3xV5rSmlUCh9iL+baK0
 f1EuWkO6kWHKnHX6hl8fWWln8HPcw0zXET3czRc4y0jFwSyDSpgKX9ygVs4mPqpmsk0e
 E/eUrTZlIyk1GFmm1FobThuZj4b6PTaLtBT8D/9BWONe8iwmNGQ5X2Jw6hAjqqnfOsTS
 m9pg==
X-Gm-Message-State: APjAAAWH9NZMT45kraQjnXMMnOE6uCmMXTGhRTTAeMWZMZVyu9Jh7u4G
 L7SubI0cSA7L07HbAzrnu/dbk7gVR6gJrn+dHAw=
X-Google-Smtp-Source: APXvYqwL5WpM+hN1WgOrflzTC/d/I4XyZ5kcAI64nlcudyt7b52J5o+eOHiPzhxuDfeAehzYHlSqNxp46sjtbYYvXKc=
X-Received: by 2002:a5d:9555:: with SMTP id a21mr7573493ios.299.1566930186433; 
 Tue, 27 Aug 2019 11:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190827173432.7656-1-nsoffer@redhat.com>
 <80a6d9bc-1f5d-2bee-c761-978835f70e27@redhat.com>
 <CAMRbyyugLygGoa_GwkZSgiOfBK6b_zS4wbpgmG90dj4ysG-Trg@mail.gmail.com>
 <55e399e3-78a2-5df0-49d7-fe2a3a19aa9e@redhat.com>
In-Reply-To: <55e399e3-78a2-5df0-49d7-fe2a3a19aa9e@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Tue, 27 Aug 2019 21:22:50 +0300
Message-ID: <CAMr-obuEvj8CA3Zpn965_U4GGYfyfq3edopW3_ig-2px2qDDoA@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PATCH] iotests: Unify cache mode quoting
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
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 27, 2019 at 8:43 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 27.08.19 19:38, Nir Soffer wrote:
> > On Tue, Aug 27, 2019 at 8:36 PM Max Reitz <mreitz@redhat.com
> > <mailto:mreitz@redhat.com>> wrote:
> >
> >     On 27.08.19 19:34, Nir Soffer wrote:
> >     > Quoting cache mode is not needed, and most tests use unquoted values.
> >     > Unify all test to use the same style.
> >
> >     S-o-b is missing, shall I add it?
> >
> >
> > Thanks!
> >
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
>
> Thanks, applied to my block branch:
>
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>
> (By the way, did you set your author email address to an @gmail address
> on purpose?)

I configured my gmail address nowhere, I think this is a side affect of using
gmail to send the patches.

>
> Max
>

