Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605DBC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83B020679
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4RBhQUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83B020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTA4P-0002fI-Pj
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTA3j-0002Ge-Eg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTA3i-0006V2-EH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:36:39 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:37223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iTA3i-0006Ui-7i
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:36:38 -0500
Received: by mail-oi1-x22d.google.com with SMTP id y194so6288542oie.4
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ioWIcw9TNiMPUA4rpqzxiQwAumFE4fwRXWFKvdnCtCU=;
 b=p4RBhQUT7pUJQzt0V/wMIu4tmWhXRIvjFliUdaM7D350T36xr3rGesLyK5hRQFQsKO
 YxDAeowYwjtF4BcEoQbbddSsQHbDE75QShDAQ+Rl3yLCLKKF2gHxFrF81u1ty9+nsoTF
 dkxtoKddvAFcZcaFVuop12YxxA9iBKJywM2IWdpm3CRKXi0LBBl187ivmMce61P5B0qe
 k5LhiwAUVE5ZepAs4EU3NuEDpFLSwzYFpyliQ+NA4jjKSbuKBQJIItarn2kkFW+BBiRA
 UMEuVtGqylWTe6638cLblLRMJ3pBJ4j36kluQ6/JJref1531Bi3koCVHblxi95xh99jo
 IFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ioWIcw9TNiMPUA4rpqzxiQwAumFE4fwRXWFKvdnCtCU=;
 b=dp1hrzdsOhFHkx2qmIYjwZLHNJ2Hb/uR+fqhtg9jY2q0u7MOkLlBuJElVwZ+NLuwcs
 Olk3zJARDMfWHhrmjxPEC8lColt5HKnj/xTXbYyNdkHyYGicFLyIYws2FP10R4smXOq0
 0qw5ezEvlcveB7e1d2JmE6rQBjwKKH7lX4SEYxMCBz62csFIg6Un6hk3s5euDhO1+A6f
 6McuS4n6EhNlSmHp4n5ox2CFjqplAE0SNL2gU3Z3KZhLUGdR/ub0uEGUylyIn9SDYo7K
 NEFMODmTOq4JrnpHOyBXFDFxtZf4/smy9Jfu63ILDqtiBajq+N24SI4CzV4rNZeTMllU
 Q/vw==
X-Gm-Message-State: APjAAAXUK47gmEJeBzfV6obwPlKVxzX6NoDibJp3ZdUSyfV/pfq9rF1B
 ll47iWQS3DcJ3QgurF8+UGTKoFMa06/9KXyZRcYp1A==
X-Google-Smtp-Source: APXvYqzpK4LDjYvrzD9hqa399UaSQNftNAJMvafXnfyhcF4Obw2rDxUVh1F+Q4qEKO6tZ69JHSGosoP2NcznjotX0KM=
X-Received: by 2002:a05:6808:9ae:: with SMTP id
 e14mr10779730oig.79.1573241797410; 
 Fri, 08 Nov 2019 11:36:37 -0800 (PST)
MIME-Version: 1.0
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
In-Reply-To: <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 8 Nov 2019 20:36:26 +0100
Message-ID: <CAL1e-=iCJntxh3r05kJgKnARV=EsREL9rMKG6JZSTi-QGY9mZg@mail.gmail.com>
Subject: Re: Looking for issues/features for my first contribution
To: Rajath Shashidhara <rajaths@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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

> [c] DS3231 also has programmable square-wave output + 32 KHz output pin.
> M41T80 chip also supports this feature. However, qemu does not support
> emulation of these features [2]. Do I take the same approach ?

Hi, Rajath.

I would rather have you amend M41T80, if there is a missing functionality.

cc-in Zoltan the creator of M41T80 emulation, for his opinion.

Yours,
Aleksandar

