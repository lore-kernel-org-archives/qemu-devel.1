Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F3DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C6D20857
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8WclEcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C6D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0sl-0000bA-Eh
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX0s8-0000Ad-Nh
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX0s7-0000a3-Oc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:36:36 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX0s7-0000Zs-KG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:36:35 -0500
Received: by mail-oi1-x241.google.com with SMTP id y194so18459690oie.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 02:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aU+mSrMBMJgTEJF7vpM5Zgzgp1lRwBuKJVJ4fT6oY38=;
 b=m8WclEcLpkbooIrWbd5hzpnb+6zJp5c9yUSOy4t3aMI3jBmir4F+Zwl69y3AO3J1y4
 cuH6OI8vrExA1sx6klcBrAN5UScqZvV0TTmD1q6+9hgv+zriJwxHnLYZ1iexjUZP2HFJ
 olXvpLaA3Oz/fVH4AAuqBd7MGzTmVxZ2mVEdtWWYNruT2bl0AX7GPpDxLT66Vhd9ZSCL
 l36ZZqIWNroFETq0siiWyancwFL4iYGBNdOGvtUm/no+e6TYXHX7QstWFNmQ9+3NAasw
 cNXRrob3KXmpzLk0a4ybc11kA+0Ok3gfjIQL6Gxe6lwUr8zHIXtHoiZ/zYn4T8mfveo0
 Qa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aU+mSrMBMJgTEJF7vpM5Zgzgp1lRwBuKJVJ4fT6oY38=;
 b=DYWxFxfHif065HqJXfrVWvt5HRHxFhiX4lLVEuZr/zUO4MWmSUAqwRcZm1XdW/d/fA
 zuszPz5CEt4jDpagAQc5Q5JYWnQmIPeMtOfz0a4zmZElnG+a+GmwEpAWd0lNx+l7aBEw
 Y91a8CX77GNqlfqbYiU5d1pXmy5KUlo2LLSFaPWuyAuHCD3SguM0G77RziororVw6V/G
 mmiAbnaXtzT2cnoNC3Xp/vFAAZ5dNKdEajpH/VDN8/bUzK0S6tyX4T4AgBH2krCns6cg
 cjJy2Pt4D13TWcYOGoR+9RUJNuWs0EzgaE3JkkWsiGeRuFopCOa5NTH+dpQkUI4DzmwZ
 VYEw==
X-Gm-Message-State: APjAAAUQW+37zb44oBdwZVX4ewuAmS5CoSaKjAqP+yR5sipwV/cAKQ9E
 vYUBV4v5lEm4xBhsXzJjA5OIWKYbpetgpO5jlC8seVKPTRI=
X-Google-Smtp-Source: APXvYqwep+EebC9qCjjKPmJu74L9qePu4HjozMgJg2z3Xgej5MyUrhGqQXWuZ9NlnjoC2OteDYxJAjCwHMbRagxBn/w=
X-Received: by 2002:aca:4945:: with SMTP id w66mr3563619oia.98.1574159794921; 
 Tue, 19 Nov 2019 02:36:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
 <20191118184906.GB3812@habkost.net>
 <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
 <20191118220417.GF3812@habkost.net>
 <CAFEAcA8XoyeAfHuKe0AEvecCzo748Yk1VD1+VD=C3ACZdfzwsw@mail.gmail.com>
 <ca517ad9-46bb-c0ac-2227-a64ab8fe5e15@redhat.com>
In-Reply-To: <ca517ad9-46bb-c0ac-2227-a64ab8fe5e15@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 10:36:23 +0000
Message-ID: <CAFEAcA-egL5kbo81eBT+FVBz7vSaWqUVzFUF3MNOttnzY6vZMQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 09:59, David Hildenbrand <david@redhat.com> wrote:
>
> On 19.11.19 10:22, Peter Maydell wrote:
> > I don't hugely care about query-cpu-model-expansion. I
> > just don't want it to have bad effects on the semantics
> > of user-facing stuff like x- properties.
>
> IMHO, max should really include all features (yes, also the bad
> x-features on arm :) ) and we should have a way to give users the
> opportunity to specify "just give me the best model independent of the
> accelerator" - something like a "best" model, but I don't care about the
> name.

How would "max includes all features" work if we have two
x- features (or even two normal features!) which are incompatible
with each other? How does it work for features which are
valid for some other CPU type but not for 'max'? The design
seems to assume a rather simplified system where every
feature is independent and can always be applied to every
CPU, which I don't think is guaranteed to be the case.

thanks
-- PMM

