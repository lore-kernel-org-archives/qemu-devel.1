Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09818C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71932178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMA5Kb/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71932178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjvb-0007cu-Sz
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSjus-0006wz-Dx
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSjur-0000A2-HR
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:41:46 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:35976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSjur-00009k-Dv
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:41:45 -0500
Received: by mail-qk1-x744.google.com with SMTP id d13so2377854qko.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 07:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VW3Wa00Ka01SD08qKtLplRF357oGvmmmmd9JytaWrLY=;
 b=sMA5Kb/yAbcl/qpcXFQm9Z+5Lb3xeKOgnKHED7PhkwYK8VwFwSUYDpPcmuJS6PmkWB
 xADSkXELIbzDbKKhjS08+wQzgSrdspDBzeRZifMD5eXh12BovlP3n7e5xShdjNnDKfnq
 O1swZVpq0u1dRtVl12sZy7AvmLDcl9SUPA+YNMI29SD2VRPLEfMeEIBE9+Jd17S1FKM1
 YTkb5lbc/ztmliY56ULLk9uw/yPMGGviBx+zsFflnMrk4dadrWWy3BxFHQzzCv+/DSn1
 Wm3EB+6T9qFWkh/QvArZwrq3kLUmuN7Z3M0/LbmSBz345oAw6qHXjVvAiQyPUGq3OnLA
 bA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VW3Wa00Ka01SD08qKtLplRF357oGvmmmmd9JytaWrLY=;
 b=eHEFAZtnrmw7Q6LYoT/mKosWDFOCmVh1Hg2XeivyzQGAqGRgmJBrtTxEZbZfuC37MR
 y+1k9ezrPwq4ZwLx/QzOTMY57RGRcGPeZvTxsJXcO6BQIVzAxjdASSRZsbnfS08OWWE5
 +7tGvxOZ8SGt36INdQdfQ8OmVPRcGx+I/M4Sl8g/H+pGUt+8pUTF60mL8XAswsQUPuSf
 3FcZrBrrDI/8e0j67cGGVP0Yk9bHVeobFiL7eo4HrmVBoYd2ER6jKa2J/MI6a5RQfaEg
 Ua9A8zZ6gJT/MkQeh3QVXgls8RAFB4YCspisWdCPKwmW7py1gv8sLztchCZHInrZnoy0
 y7vw==
X-Gm-Message-State: APjAAAVLticCZ0YkaR1dCs6NXcNDQwK1jupSJ0Ar2iVMYq/EiYRCTiBa
 od5QAH5iynfZq8KcI1CXPjW6GZ5RjyI51haateo=
X-Google-Smtp-Source: APXvYqzkM2Cu6M578N8IRwaSInHg8NWKdg7g4a49mw5W11Fpit4Kc0joPoksPYEwWsZ9nECZztJPK3onMATBCnTkD7g=
X-Received: by 2002:a05:620a:14a2:: with SMTP id
 x2mr3449910qkj.236.1573141304560; 
 Thu, 07 Nov 2019 07:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-20-alxndr@bu.edu>
 <66465e73-d009-ec62-58dd-279bfac6894c@redhat.com>
In-Reply-To: <66465e73-d009-ec62-58dd-279bfac6894c@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Nov 2019 16:41:33 +0100
Message-ID: <CAJSP0QVNe5FcA_fb97iNnzxj7txjV_j3X86zFVTPLL4iVTkqfw@mail.gmail.com>
Subject: Re: [PATCH v4 19/20] fuzz: add virtio-net fuzz target
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 7, 2019 at 2:44 PM Jason Wang <jasowang@redhat.com> wrote:
> On 2019/10/30 =E4=B8=8B=E5=8D=8810:50, Oleinik, Alexander wrote:
> > From: Alexander Oleinik <alxndr@bu.edu>
> >
> > The virtio-net fuzz target feeds inputs to all three virtio-net
> > virtqueues, and uses forking to avoid leaking state between fuzz runs.
> >
> > Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
>
>
> Can this fuzz vhost-net or vhost-user (I only see socket backend)? If
> it's not too hard, it would be even more interesting.

Fuzzing vhost devices would be awesome but this patch series does not do th=
at.

libfuzzer uses coverage-guided fuzzing.  It needs to instrument the
code.  vhost kernel modules or external vhost-user processes aren't
instrumented so the fuzzing engine has no code instrumentation
feedback.

It should be possible to solve those problems eventually.  You could
also run it as-is, but the fuzzer wouldn't make intelligent decisions
about mutating input data to explore new code paths in vhost kernel
modules.

Stefan

