Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE3CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C7B20870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3XXPcJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C7B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9EHT-0003UF-BD
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j9EGk-00032V-TZ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 15:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j9EGj-0000qn-W4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 15:35:58 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:34170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j9EGj-0000qg-SJ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 15:35:57 -0500
Received: by mail-qk1-x729.google.com with SMTP id 11so4884972qkd.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UrcGLEi16G8LGim4fv+JhHEr/g3tRI/Vm7o/WJWqA/8=;
 b=P3XXPcJww+tdPazyNpcnRM7mEcitXlZ8DF1kroeSpgFhfIDyEuFoGSQCEzB7OFVa4j
 PfDF8rJSG5l0mTgT+qjedCcjPBha+/1R+1O1MIVO6OZs+YGekciHW3cXHw1gWbbDFZJb
 5+DCtRgqYLQ7FlSsYhyAF9iSKux7jvDiv0YOzAMXWRlkO7MCjTHdQOInDG7fs8LaaR4N
 mZpLQdPZCz9+mfksSNMWExsQmThbemmR9/Q22zAysuwFxVvk7iQr1qu3bnG6xtyCwtNg
 MVQkAbPipG7/yUTtVPokqFnqhm8sqvSz3fi5REZHWZsjef2khbqaVTWg8Hv8qJZKoRaG
 G3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UrcGLEi16G8LGim4fv+JhHEr/g3tRI/Vm7o/WJWqA/8=;
 b=huxKe1mmJr1zfnVFaWxDjDW8DtW+xqkiVM+R1CZZsamA1jcEAb8ef2fOD8+JQN5VJ2
 xWo1cxpVzx+725MlwJNE4bn/EBQKKxnklKS8ZVhQz8/M41pC07NLQoBqNU+ttOLYdC+B
 rPV3ydrKUIJ9ID7roycW4BMKkmHpi4yHGk9YW4sSz6PPM29m+nkxw0RlW28Ps8VA8F3Z
 iunF6803ryGjvJnc6a01jnyiuz/oWsAW8Y3aIkT3xmdvuQdgyfnUxmVFQptblmkQLMeK
 zxZ1F0lz8Joq0IzVgegRQYRaXn4RdD2kaA8NsJqaScoxVLzpvo8VbD+v/db55FutP6ZE
 cDhQ==
X-Gm-Message-State: ANhLgQ2RP8bXYgsHzlVS+e3K0iQnPJ9ly+fQcJO2CvDq+rRE6VNsmEvM
 W1Grqx31v030ixNZS4ZJe7fYG+dw8yQAAjhNWEc=
X-Google-Smtp-Source: ADFU+vs5bSmP90Uc4kFzHjBfECCWq+oGm2WO0UgY4rxoetVKPrsCp/r2NcATXCsz9kWw7f61npMB419PrTLr5+vnUZs=
X-Received: by 2002:a37:a28f:: with SMTP id l137mr5752668qke.196.1583267756929; 
 Tue, 03 Mar 2020 12:35:56 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
 <CAJSP0QW2ooLK_0Hr52h8HYdmm2j6CunTAnhFxS3De=azMutUeA@mail.gmail.com>
 <CAPV47zc6R1fX_RrEzLQkQuRtjKK87HNtmkgnxazZGOESGERwxw@mail.gmail.com>
In-Reply-To: <CAPV47zc6R1fX_RrEzLQkQuRtjKK87HNtmkgnxazZGOESGERwxw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Mar 2020 20:35:45 +0000
Message-ID: <CAJSP0QUoqdRiQp6zCWpsPQ_iM4K-BgAFCDoqU4ca0dafd3-rNw@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::729
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 3, 2020 at 5:12 PM Priyamvad Acharya
<priyamvad.agnisys@gmail.com> wrote:
> > These errors are probably due to the Makefile.objs changes in your commit:
>
> If I am not wrong, we need to add a rule i.e " common-obj-$(CONFIG_TESTPCI) += testpci.o " in Makefile.objs to compile custom device in Qemu.
> Shall I should remove that rule to remove the errors?

No, keep that line.  All the other changes to Makefile.objs in that
commit seem spurious though and should be removed.

Stefan

