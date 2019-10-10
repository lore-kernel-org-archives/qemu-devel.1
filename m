Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1827C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 17:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E7E2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 17:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="BwvslfUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E7E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbvz-0008FA-OW
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 13:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@mail.ru>) id 1iIbvB-0007pn-NT
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@mail.ru>) id 1iIbvA-0000m6-C8
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:08:13 -0400
Received: from smtp40.i.mail.ru ([94.100.177.100]:40792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@mail.ru>) id 1iIbv9-0000ln-P2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 13:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version;
 bh=Smcudi6WvXNiujziFxQ+rzk0507Xo5NWXQGspSMQDv8=; 
 b=BwvslfUF6pHYFhGZxIeSg5/UPm4Ow90v0qs37m4pnXR6XCsMVMmC1MvYkjMD0zXEQl/dmLkMBubamYDrE/2wmJSmfZGWuP30TWNsAeDOyAdSQYHsAGD5BAGBwETcztmPc8u121hxrHivSP4sATV+2zIU9fSFw+D5Qw6QGj1USAs=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <jusual@mail.ru>)
 id 1iIbv6-0006XH-Je
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 20:08:08 +0300
Received: by mail-lj1-f179.google.com with SMTP id j19so7029630lja.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 10:08:08 -0700 (PDT)
X-Gm-Message-State: APjAAAX1aKQRRL4Yhzc7AcsjUqQeG8MPnp2Ohx1nmT4LiljSfLAW5U1e
 AlcoPuWCAYehKX5kWaIaTJ38dasJtkwPrQYpXENw8g==
X-Google-Smtp-Source: APXvYqzghEgm7pB9ul4DeS0IjIqzVQ3qCQ/xux72muOUDHx1DS1hAHPhO3DotsBI/Ea4H+0rVqJ/c/RGVHx8XujGJUU=
X-Received: by 2002:a2e:9e85:: with SMTP id f5mr7123853ljk.203.1570727288203; 
 Thu, 10 Oct 2019 10:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <878spwct7p.fsf_-_@dusky.pond.sub.org>
In-Reply-To: <878spwct7p.fsf_-_@dusky.pond.sub.org>
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 10 Oct 2019 19:07:57 +0200
X-Gmail-Original-Message-ID: <CAMDeoFUdzL0-Mqj=-RcJUZAS4GTSemnmOZ9V9nuoYvHCAW7Pcg@mail.gmail.com>
Message-ID: <CAMDeoFUdzL0-Mqj=-RcJUZAS4GTSemnmOZ9V9nuoYvHCAW7Pcg@mail.gmail.com>
Subject: Re: Is network backend vde worth keeping? (was: Is network backend
 netmap worth keeping?)
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 renzo@cs.unibo.it, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: smtp40.i.mail.ru; auth=pass smtp.auth=jusual@mail.ru
 smtp.mailfrom=jusual@mail.ru
X-77F55803: 2D1AD755E866B1545A78504BD2AC2941EF4240A57205167398B7DE5AC6068369935C91B1721AA75B2CD4A999522F0939
X-7FA49CB5: 0D63561A33F958A5889FC3F9B25866C37A64F7FA1A6C233CAB1A450743822BAC8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224950E8A67647349DF376E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8BDD05361B700AE1BB3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C361DD96311B40C2D43A24D03A4753F5B01F42DF47398C4A6DC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: 4C235FE2E5D2D8903F5BB8719A0E45F69750A78EF78D2A0096FF3C4319F3FE0F976AF1CB91E6F681342D7E53901C55FD6F53C80213D1719C4487B406A59785443329DBF425CF03A167EA787935ED9F1B
X-Mras: OK
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 94.100.177.100
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 7, 2019 at 8:23 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Please excuse the attention-grabbing subject.
>
> Again.
>
> [...]
> > So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
> > build and install netmap software from sources.  Which pretty much
>
> CONFIG_VDE seems to be similarly cumbersome to build-test.
>
> > ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
> [...]
>
> The vde backend was added in commit 8a16d273887 (Jul 2008).  The commit
> message blames it on Luca Bigliardi.  Julia (cc'ed) fixed a bug in 2018.

This was a bugzilla entry dated 2010 from the BiteSizedTasks list. You
can definitely ignore this commit when deciding whether to keep vde
backend.

Best regards, Julia Suvorova.

