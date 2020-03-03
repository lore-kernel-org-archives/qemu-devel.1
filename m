Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD89C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3DF20857
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJm063qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3DF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99YN-0004mM-KN
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j99Xg-00041j-PO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j99Xf-00029E-Pv
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:33:08 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e]:43086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j99Xf-00028n-KL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:33:07 -0500
Received: by mail-qt1-x82e.google.com with SMTP id v22so3074403qtp.10
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XfVDRMJHx/cYRZRNvgoDG7ovGpknV4F33gp1iyD64rg=;
 b=OJm063qtOnz0qq4FLD26zzukvRzvklk3R44kLWgnKQ7jKAiw0EGSpn3Q7iGAytOC2W
 Fj8f1kTuUNBTFncw4MFm8nD7nceayJ6JLNqRd1n7g1OiRFtdqHoK0Ida0fyFUz+ylYVW
 fkqHaR1YnTSuu0g0pz+J/d/8t/WiNSEkJ776iNaUJfzRMknx39U4dL87hRVUK+p12Cyu
 WSED9XiWaDAEA581vH1t3fPzFPJp5K4uSNZS/6IWwvx7vHtTSOQgYbmKx5X4Aug2N459
 bxT0mrzrx+0yc3F33p23pz45SE2oWTiEAz5YApXL2Fnzmj0XPLgKYT/NhtbmHobADePZ
 s2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XfVDRMJHx/cYRZRNvgoDG7ovGpknV4F33gp1iyD64rg=;
 b=uJBYYatUtXFseFxjAd9A7DZnHE0Y85+H4BeOEjKlMSbvY+U7aQGjZfyhZDTdXrm1VY
 02EiqDiX6IphSn2aHQUH0tlAikbuHJkwHdLqvG4QhxolxWuy+qyEwXI/OkWkI+zWXuSV
 dZypZii+t9277i+F35+eii2Dv3kJdMZQdTPyj+d0jj283V2l0za2L0BRs5AbZgeKcciC
 hSg4HqnAt8P+sSSqT1HCAawNcds5rjPKWzCzQRjnjVFgq6vfbv6BLTWajTPvfN5EDpNx
 ic6/SCQCsnkzwhrK7cVpYA5tFPKWIaEH8uIJpVaE4iFOQmkyUR6kdh2yRKlt1ZN5Z+BL
 12dw==
X-Gm-Message-State: ANhLgQ3v/TB+3JwDFlYiNmLB4LaZkl4T5O8ZNz9foEDnbbikQPHatTJb
 v50Dku2RujRXHdH4A5bArk90HHZRYd1VYnw9b9g=
X-Google-Smtp-Source: ADFU+vuoYAEoB13TA36OF7t8T6CZOt0rKGZkUPl9SslEFpKg5PX9WfrvzOb1ry/9bddXC/pvijvkI1jHLl+iqCzZEwQ=
X-Received: by 2002:ac8:7511:: with SMTP id u17mr4750404qtq.316.1583249586594; 
 Tue, 03 Mar 2020 07:33:06 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
 <CAPV47zesfbVEBc75kDg9YFjGjQi5ZpjrPasQZJvmkp3bTcaR3w@mail.gmail.com>
In-Reply-To: <CAPV47zesfbVEBc75kDg9YFjGjQi5ZpjrPasQZJvmkp3bTcaR3w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Mar 2020 15:32:55 +0000
Message-ID: <CAJSP0QXNhn_QxTv4fWB3vJ-Xe=+zy4Y-sttrKTHxqf9Jnt2GWg@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82e
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

On Tue, Mar 3, 2020 at 12:53 PM Priyamvad Acharya
<priyamvad.agnisys@gmail.com> wrote:
>
> >. Using git-log(1) can be helpful because it shows how new devices were introduced.
>
> What is git-log(1) ?
> How to use git-log(1) in Qemu?

It's the git command that shows commit history:
https://git-scm.com/docs/git-log

Stefan

