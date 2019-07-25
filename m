Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58356C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FFD229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szp70NQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FFD229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqi2N-0001xN-DD
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 14:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqi28-0001Qx-8H
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqi27-0000cn-7h
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:00:04 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqi27-0000bE-0N
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 14:00:03 -0400
Received: by mail-oi1-x241.google.com with SMTP id g7so38299838oia.8
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 11:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=elNNG/UcrQabTxjIvTIAJ4efMjiVM2QCOARro76Y5+c=;
 b=szp70NQuHKhZ/Q4tFtrPyoFAaBTNbN8nAkBZ6D5Y/OffaklRgz/vqb4dTuOgsDjgx+
 RjUAD9Me6h9TjdTUAE8HgKWJvw348FpFd40vEqqIGiEXnXryj/w+dc3nmj/DRCfaIlGW
 cPxVq3VXRkMvl+C7CQUitjzp4kfmsHtsVTszPxnOBFG6OWzV3EZc3+msisOpOTBA+SlL
 Xdumfl+7HC1xQ8w6y0XWVlkUNnhkbZkD36eFlUaNCWYERAca7EYtS/GT6udojeAHzfxH
 LHg0KHCmzVufmiCi1/aJFQJrXEA4TGiHSX5ko0f+0kvobYthFECM4wUYVkqKXFQVCUIi
 iCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=elNNG/UcrQabTxjIvTIAJ4efMjiVM2QCOARro76Y5+c=;
 b=AvKxx07SZgL23GeEs0WvmiEnJPfM3/Ae5Xd2KDvzt0yBlkk8qBxpYi6k4tl8dx3MRJ
 37T5O9aJtaprr78iu2JkeBa5GVgmC0fOFRaEQv9k43Vpr3ErnUD7x/GR2pusqS63jqC1
 V1uDm7aIEq8PETE5GbqjBdgtiF1giEtHa0YRmv3kisRncAvVJdmOArmBRrb+SSnHTU2T
 1aZTzlrY8YCO6ZsxLFLEf1YTS/L7w5Eu9K02xSTGKP9Q0FBdO7z/tcUN/W3uNrR14wl0
 GDji2D92FwKwdIjAxzt44JRXsqrmeuDH4Naj2y9zcAm8Leqn+1F/k2qPs80ew5y+BDrw
 cWPQ==
X-Gm-Message-State: APjAAAW36xjJayJ6WMLWUyP6xiHlKjjFHxrXa70VdmAkpCaktoLddCRA
 MnnDVd95DUplAJUrnDmIewtqlJdnEmxTaJiQWZjVbA==
X-Google-Smtp-Source: APXvYqzTbi4WwVLge6RCdZTBidwTp36a1WGfpy9F37nSAPY8qwLF63fZSKXWttDxib36oxBDwUgk0DXfLTpwykMmlQY=
X-Received: by 2002:aca:6185:: with SMTP id
 v127mr45544465oib.163.1564077601969; 
 Thu, 25 Jul 2019 11:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
 <20190725170228.GL2656@work-vm>
In-Reply-To: <20190725170228.GL2656@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 18:59:50 +0100
Message-ID: <CAFEAcA9RQBz=t8F_nOTH9FZu_jKD0XVMJtPwmdnJBfnFR4G9oA@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 18:02, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > gamepad_state::buttons is a pointer to an array of structs,
> > not an array of structs, so should be declared in the vmstate
> > with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
> > corrupt memory on incoming migration.
> >
> > We bump the vmstate version field as the easiest way to
> > deal with the migration break, since migration wouldn't have
> > worked reliably before anyway.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> OK, it would be great to change num_buttons to uint32_t and make that a
> UINT32 at some point;  it's hard to press negative buttons.

Is there much benefit though?

As an aside, I'm surprised also the macro doesn't complain
that we said the num_buttons field is int32 but it's really "int"...
arguably a different kind of missing type check.

thanks
-- PMM

