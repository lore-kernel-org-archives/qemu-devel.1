Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B624DC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785E20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmBPANj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYOj-0007Sm-Jw
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1htYO9-00072U-Sn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1htYO8-00079H-VS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:18:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1htYO8-000795-JQ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:18:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id j11so20979344otp.10
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oZE1A/d0B/Z4FaGo46WCCYaZPAH6Cb7O4NrVTCVzfO8=;
 b=gmBPANj5my+Ny8fXPHgU4adaI3IroCT4RQBpXD7K9OW8wz+gOXyrZNPpffKRWYTcSY
 hsgiojM5RECiGbBI0nlL3gU/GQO/E4Hawace2OBP31vGx2VGD0qwyDIyAsrs+zPfJt2H
 pzB7Z8Bhb3HPHlquURDmRlcFzAejtDAOOt/r75YZQvCAxnGBsTAT+ZHc4i8sP51U0jc+
 NPEh+JNv5qf9ecvNTZUcIO8C833rT8y2KrVoOaF4m4QOVqrywYdnEJbmm9Z2TH8BQv/u
 xcMvg4YCQmnoHuqlR8zUCm22Xxe66X8URVBO+soKh+W+rGpHdRCncZKQCsL98O/y85kk
 Ld+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oZE1A/d0B/Z4FaGo46WCCYaZPAH6Cb7O4NrVTCVzfO8=;
 b=TJP8YpH/tkyrZ1APOKA5Y7HlShPd0WFlmkJHBtgcQDu+ymqFbjT2pgPR7Opr315oHP
 ruveJPH+e1S2+tJsqfVhMg8qPunL/OKWoV86hSDN7VH/Ypd/aG4w4GMcO4lh9+LUyMJF
 CktMb/V/eiJUykNYQoEam4CfqeezIPWdUZpqBClAHpnCqPNJy0ji2vDvOT8qIXXhvT5n
 cvXzXOQyZpQ8vCyKzrOqMGCyzfSu825UVvz5ky2zwFj5fTIV8T+pAO/U8nVsjvYkfjnG
 +ICIKcNeA13iZhICcsZwwQlKNf9bn6DwbuOgvEgZAp+0f3c8i1lq3vTDqOLKqt8yuHXb
 d11A==
X-Gm-Message-State: APjAAAVz5+p7oDgWqzBb9HgdIaBf2pP3o+o0p2Cj67RN1qNgDzLFaZqV
 0cmZToqMIDs2au1/cBdQzWY9Hjxm9z+Tr8JIB0k=
X-Google-Smtp-Source: APXvYqwfk0cqb0L5ovyzWSa4BjNkjqWHqkbL6G4PuffRB1DqjWRZ9NISSIFTUoAgE41YnkfahgwKOM0vG646awLKUkY=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr15063168oti.341.1564755511490; 
 Fri, 02 Aug 2019 07:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-23-jan.bobek@gmail.com>
 <1691a32a-e0a2-931b-2d17-4dae8dde7c7e@linaro.org>
 <CAL1e-=h2eHpH2KAtT+orB9gbqnaqTVYf+W_eVfmNrj+jxVsnnA@mail.gmail.com>
 <bf8155f6-4f03-dcb6-5159-5f10dd0211a0@linaro.org>
In-Reply-To: <bf8155f6-4f03-dcb6-5159-5f10dd0211a0@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 2 Aug 2019 16:18:20 +0200
Message-ID: <CAL1e-=i0xU3W69gCzie5RNBvdVeHm8TTrcsY64ym=gkSPbn4RA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v1 22/22] target/i386: reimplement
 (V)P(EQ, CMP)(B, W, D)
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
>
>   Functions whose address are passed as a callback, as these are, are
> always forced out of line.
>
>
OK, Richard. However, on a much higher level than this single patch, I am
really
curious about this: what would be the rationale beyond the use of callbacks
in TCG
vector support interface? What is, in fact, achieved with such interface
design that
could not be achieved with callback-less approach?

Thanks,
Aleksandar
