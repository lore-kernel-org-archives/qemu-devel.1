Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19550C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D871E206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5BaDPJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D871E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT9zq-0000Rv-UN
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iT9zC-0008PM-IC
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iT9zB-00045f-Kv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:31:58 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:34203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iT9zB-00045S-GI
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:31:57 -0500
Received: by mail-oi1-x232.google.com with SMTP id l202so6280305oig.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 11:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EZnzvejeNJrnfK1eBiO4cFlK5C3AABtLn2gBZGdpMIc=;
 b=u5BaDPJidxqFYk9YfMfMp1YZ7YFdftHFJRjd7fytCliN4QK0yug956EF+ISZ1c3iHL
 XTnwi/DHvbmRUwNlpsvSvEaLPkn5tHkwUoXjDjXxqhExeSlrtB5nWlc456WjHXsj+zT2
 y80eFgHW3z2cyH5kzP+L+nhNAInc5VQiM/Jn/uAs4ItTs73m1FzFB793lTFdFE7xYDQT
 gpQArkgECBVyus0ECBcGsYp9k50NJ32iwSI8vNIakO+5PHQZZ7Yu1oMjoDzmZMjDWigm
 cE7O2bd8VtosAkY2yOlxNHgIv7+MW7ZhndoAIWcAS2ZnXui90k7lfefFgcG2Qjr2MrMQ
 PXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EZnzvejeNJrnfK1eBiO4cFlK5C3AABtLn2gBZGdpMIc=;
 b=VMkSCbF/akGDmmO0zbFVY/zbQ2XV0nvArklmB8SMd+YgLYvVCzFU44qdPjVb8vaYbO
 xjoa63NbfYSoFbsXXHSOZRHxggu/dERMfS1VjlVqrUDV4bq8ie/tEtiW0CkXqZxXBpN4
 FBXqVJMFr75xinLQR+QQ2szpsISwCF8FE/hVnRKyd3GyYqBAB1VN26n24PvFQ3Qa4KkE
 CYW5dB1DrvADgZNNTdA8v1hZb9095o1pWSuaHH/hyArEBYSYZ86Vdiz6SrPBFCv1QNt/
 ZTMtOWgCYYcWKcTcWFcMRpkiRmKV67nVz3uu9dHygA5eLdBKR3QycnWQHudTbKq2VR3M
 oeWQ==
X-Gm-Message-State: APjAAAXQRXBEenSyrl0+HmKNAlNLFFNh31QN6vDbW+vmJQH5TDA/PMLw
 pP6Rb8K/islgsU8mdahV5mQEn6rL6VetBPOY6Ps=
X-Google-Smtp-Source: APXvYqwnA8cpTkQ+7MdLf5oadCTYjwnSO+9V9a92q/dm6FakWYU1hFVCIlS69Lp798QdrtXIk8JRez2pMW+vmaiebTE=
X-Received: by 2002:aca:d17:: with SMTP id 23mr3787452oin.136.1573241516430;
 Fri, 08 Nov 2019 11:31:56 -0800 (PST)
MIME-Version: 1.0
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
In-Reply-To: <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 8 Nov 2019 20:31:45 +0100
Message-ID: <CAL1e-=hcS8_2Y1YJS01GTwFbMYBJmWopYkSDi_aw6yzOHk=3Lg@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Rajath Shashidhara <rajaths@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> [a] Is there any particular reason that you picked DS3231 ? Linux kernel
> has drivers for DS3232/34 only [1]. I did read the datasheets of both
> 3232 & 3231 and found that they are quite similar except for the 236
> bytes of SRAM support found only in 3232.
>

Yes, DS3231 is a part of a board we want to support in future.

I think you could make your QEMU emulation cover both DS3231 and
DS3232 (and call your file ds323x.c, or similar). If you do it right, this may
be the model for handling similar cases, and I am sure there are plenty of
them in the whole QEMU tree. (for example, DS1307 and DS1306)

But, if this sound too complicated for you, please just cover DS3231.

Also, you can contact kernel DSxxxx drivers authors for more info.

I suspect their DS3232 driver works with DS3231 too.

Yours,
Aleksandar

