Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA1C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 12:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEC0213F2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 12:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbpKI04U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEC0213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD6Yw-0003Ex-BL
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 08:06:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6Y7-0002pm-Mc
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 08:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6Y6-0002XB-Tm
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 08:05:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
	id 1hD6Y5-0002Tb-VY
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 08:05:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id h18so11699351wml.1
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to; 
	bh=rZuoPU0o/Uip2PDGYhmwsT8kIFSnrij/QLZpNGe2h5w=;
	b=CbpKI04Un7K+vNUXL9mO+hXW0hfSMcCBu55ZBkCk92xFZ/TTQxEJJobnuTy4cs+2C6
	1krHkU12Z7ROxPOIXLk8c0/lXV0i+k+VfPu7wDZn849C392i0b5L0PAjhN5mj4FRgljb
	9LfbNtOdf7Djiyw5t2jOMPh/WE0r9S4RnmrKkbF4Q2DEfpQnEG/5WanGLm2auMviZJ8u
	JfUGpbeC/8vsqvIuLXrgba+higtoz4UuokeC7mYK3/TIz/aEtd/J/jWz7VXRdP+5PDrt
	k1NbvkBIDR2QnSHBhaI9RJgP0PCMns9erQ2xuIdmMz/bxCkCU1Knfk/6n/l1EKIjTZWW
	svKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to;
	bh=rZuoPU0o/Uip2PDGYhmwsT8kIFSnrij/QLZpNGe2h5w=;
	b=MOJwfhyIMH4II5VNd7B4Fp1rqJN28EpxZHPsVlpi1Mq2abI59aAXlgW1OHI/Jfnzhi
	4oUz6WWEwLEs4MVbLGauPgNgeQ5vFJoImEMFyHIHSu7PLr1J4eC+ATeW1fdQkckYYkWB
	drKhMXAOYwNzMXYFsUnwHEmrw9ywpxlKHqOqlvGjcjKmP5xFjauR7GJdjkNFzLO8vSlp
	9miWDW6WUbvg25CnpqeiKlKtHTJaOIli0xFRzpXHj/Yl2N8HuieZdKVFJMBURo8bTJuE
	UEjMB5437EUvHu7EPMXkBZOwytW5pA5bZ2dz7Wry1kMucQskajSUYphh3W2lxyEQKvf6
	WIeg==
X-Gm-Message-State: APjAAAV6KeXmvQH3Tj9pn6+AQlY5coVWBeUUj1IOuA45l7Pa7V8bZAu9
	zfuidTFtyJLrymvXM4mUuauL+qbFGoe+bjFltwIHfGoKgME=
X-Google-Smtp-Source: APXvYqw+iHqEy7xdSC8dfMjBzUB7JUOxEKnXNFHoVi+/w8fqPYyNqzvQy2eY/T4Q5fDzcU2C6yJJ4cRhhs9JdioboLE=
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr13119686wmg.56.1554638712770; 
	Sun, 07 Apr 2019 05:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
In-Reply-To: <20190407115839.25054-1-skrtbhtngr@gmail.com>
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Sun, 7 Apr 2019 17:35:01 +0530
Message-ID:
 <CAMzgYoODOUz8yJQH1=a_=e8HKEuRFv6UyX0Rost4NfWNxe91KQ@mail.gmail.com>
To: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
	Yuval Shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH RESEND v2 0/2] Move hvf_cpu_synchronize*
 calls to cpu_synchronize* functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407120501.iSBVbDT3NKbqP5D0PAGyJeArEIPLZzAjzMJEEVdKsEk@z>

Hi,
Are the patches in good enough shape to be merged?

Thanks,
Sukrit

