Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C24C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD632076C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcdbedIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD632076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsQP-0001m2-Ng
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQsPf-00015p-27
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQsPb-0001Vw-2c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:54:06 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQsPa-0001RU-Hh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:54:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id 19so430422oiy.8
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IgsfLu8fDKex52tmXBw1daG8MMez6w409cisdImQGE8=;
 b=DcdbedIHgKM86dQEhfewKkda0z9fm2elEr4xmnEJ+nh7njpUwVbF6jn/242+knSab/
 AMFoGs2jqRtzZQG+oe7pz0NTskBGgvrBtdHiVS5CN7j+rYda1uqF5nbqNS1z+eMlKgWg
 gw9lOfreQUOTZWfe0+OkqNEqQ9DR/pLkY11qCZBBggX2GBLswVtQSB2IjwoAPYXcCaDG
 8cg6oepbE7uyKJqxCkvmk/I3m1+3/XJVer8LuYX3SxRj3DX+0XGW8EhhLICCUXrykhBV
 T36Qs+HBYqv6A3/CYPeZIvkVtPp3S1GvxombtRW3Ao/1N2QAKquy1AvTCZR72txs7qZ9
 flhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IgsfLu8fDKex52tmXBw1daG8MMez6w409cisdImQGE8=;
 b=tn+7uA7Wq0nsjB1ieDDmX/O48aw9QarLLI5G1SHkNCMWSyhr1ehuHno0WCLhK1hHUw
 eEFiM33riDkx4lvwy2xTF2eFRruqiUNZWaR1nUJAnMaqJxC5hNMv8bjN0Ls3oJ+5tIN6
 dPF+ud1QQPxZeZzTCvxjxSmSHBri7PA4vy89smPVGpQ121SpFORZl+i0GZZU6Hs/r/Jr
 R0ohobmKcwU6G170Jw8nzTWOgwLXGRdW0dLUCjJKOpHzu83zFARXcxi5MGDdyK7Mkm/Z
 j2gaPsfKopMhk4lbnOXZec19KXIY8SeK64AmMzOlyj2QFvFNKow/luXhwfT0zXt1xOIR
 aI4A==
X-Gm-Message-State: AGi0PuaE5GrxWf6egZ/rxauRts039weUR3aBP6D7MynbNcaCgqBE7p2C
 Ad1W14/ER7qjX9zQPayYx+h3F65bJaD2KkGdhJJE5w==
X-Google-Smtp-Source: APiQypJvGaHnNkElBBzoPXMJSQ2VWx8PpBFUWKXnJiDf0Rvse4kjll1V6jtA6DoI1jpn6CH5Wk1xSTdVahDUOi5c0Nw=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr2845018oig.48.1587473641137; 
 Tue, 21 Apr 2020 05:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
In-Reply-To: <87sgi49uf6.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2020 13:53:49 +0100
Message-ID: <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 at 16:33, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > I think we should start by getting the gitlab setup working
> > for the basic "x86 configs" first. Then we can try adding
> > a runner for s390 (that one's logistically easiest because
> > it is a project machine, not one owned by me personally or
> > by Linaro) once the basic framework is working, and expand
> > from there.
>
> Makes sense to me.
>
> Next steps to get this off the ground:
>
> * Red Hat provides runner(s) for x86 stuff we care about.
>
> * If that doesn't cover 'basic "x86 configs" in your judgement, we
>   fill the gaps as described below under "Expand from there".
>
> * Add an s390 runner using the project machine you mentioned.
>
> * Expand from there: identify the remaining gaps, map them to people /
>   organizations interested in them, and solicit contributions from these
>   guys.
>
> A note on contributions: we need both hardware and people.  By people I
> mean maintainers for the infrastructure, the tools and all the runners.
> Cleber & team are willing to serve for the infrastructure, the tools and
> the Red Hat runners.

So, with 5.0 nearly out the door it seems like a good time to check
in on this thread again to ask where we are progress-wise with this.
My impression is that this patchset provides most of the scripting
and config side of the first step, so what we need is for RH to provide
an x86 runner machine and tell the gitlab CI it exists. I appreciate
that the whole coronavirus and working-from-home situation will have
upended everybody's plans, especially when actual hardware might
be involved, but how's it going ?

thanks
-- PMM

