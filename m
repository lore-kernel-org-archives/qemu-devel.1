Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CBCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F58B20870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miuW9VFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F58B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Pv2-0006uX-FS
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9PuF-0005mh-JT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9PuE-0003MW-9K
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:01:31 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9PuE-0003Ll-1y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:01:30 -0500
Received: by mail-oi1-x243.google.com with SMTP id t24so1360567oij.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yVj8NnETaS9od26eo3j2Z38YQEqPFPFafRYo07f9MGs=;
 b=miuW9VFGxEwbhqARiN9aP7CgjGwPK28lWNHsZ/fqT5f4iEc8MCeWpezUetXDSqkwX/
 mvjEkctnt1xy46Zn5gkQrlu7zER88J9HGXGqlWhkPMaNRyhxjum2OwYJkjZ5WmYZWc4N
 VYz1UO5LNqA0wV5mm5DgoepQJyQ8Sh2iD42Lh4BprPwuC5O1UFvrvyNGWs2qAMseg8YH
 zJ1b2sWu9QwcSEqWNoGhF3HEJyZ2RBbyWQGtmW41nj5eavB/vGmYjEkfwucy4PotBds5
 dl+tv/LrFnvSoFJxTJjEkteog2Zi5lqPc6uvkmq5IC0Qlo8WwYI0mqVXnRWGP2GPEmGq
 WgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yVj8NnETaS9od26eo3j2Z38YQEqPFPFafRYo07f9MGs=;
 b=HupI41gUGMAbFyV5NAr2WzxNKgHC6tGUicXplTEVdKP59XKC+GrYk3o9fXAzNLDvNa
 dyb7c/JPXP1pr24gpAQBVYAI9aZJAie+rRalV9Y0vtdDbfDLMn5wIyBVas58ZUQYLUG8
 atbhG73dDon1amFbWUOC4G1jRJ6V9n4vEuHw8sUBzw5nOQPnqk05y3NbspU53DaiJpoO
 ziDCxa0az6mGpNbOBIAl2eSf4lIbQA9V/vT1hOwnmLI4MdC3NblX/GR47Yd9jsASDybG
 E9v8UQ4b5iNs3MuvdsTbCyGwNEIiGpVqvSk790ffCKFkSQz0r+mX/SrWXMmqVJqO8V3V
 +qRA==
X-Gm-Message-State: ANhLgQ1eCJ/vLf7vo1W+fOTxMDDGW/AFUNsrNK2lXy7KbeQnAIYTHpWZ
 fnWS+oBy4mTaiU6T1pToqHcUGzkejxYe9tQd1okinA==
X-Google-Smtp-Source: ADFU+vsarRMluy/ZrPTdnN/3I4DESEpivuPQvn50+j1EIeVomXkiuJG5jh8GK3+rfmDlxYBEiLXwXX7oWsc4yFU+dvE=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr1032990oif.163.1583312488636; 
 Wed, 04 Mar 2020 01:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20200303163505.32041-1-armbru@redhat.com>
 <CAFEAcA_g=ghK1OO0dTdEoYL2Gon4gPff4pfj5kEo8C1v8N4=wA@mail.gmail.com>
 <87r1y8pm6w.fsf@dusky.pond.sub.org>
In-Reply-To: <87r1y8pm6w.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Mar 2020 09:01:17 +0000
Message-ID: <CAFEAcA8hbmZAEnJzBXa=rwaNdgXgCP2LH+EiErcp1O6mcvrp=Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/30] Configurable policy for handling deprecated
 interfaces
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Libvirt <libvir-list@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Mar 2020 at 08:18, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > How much do you think this is likely to affect the
> > generate-rst-from-qapi-docs series? I'd really like
> > that to go in for this release, but this looks like
> > it's shaping up to be a big conflict :-(
>
> I paused reviewing your series to post this one, because "I'd really
> like that to go in for this release" :)
>
> My series touches 21 existing commented definitions in qapi/, six more
> in tests/qapi-schema/doc-good.json, and adds new module
> qapi/compat.json.  Consolidated diff appended.
>
> Rule of thumb for reducing conflict resolution labor: the bigger manual
> change goes first.  Yours is bigger, but I don't remember how manual it
> is.

We got pretty much all the manual changes I needed into
master already, so all that's left really is the script parts.
The conflicts would basically be where this series affects
the generate-docs parts of the scripts -- any changes here
to doc.py are basically dead-code-walking and would need
to be done over again in the equivalent code for rust generation.
But looking at the diffstat
 scripts/qapi/doc.py                           |  16 +-
so hopefully it won't be too bad.

thanks
-- PMM

