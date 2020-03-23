Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96704C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B8420663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vektu3eJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B8420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJOu-0002mA-GG
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 05:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGJOB-0002Cn-7C
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGJO9-0001Ik-QM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:28:54 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGJO9-0001GS-Ar
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:28:53 -0400
Received: by mail-oi1-x243.google.com with SMTP id k8so14118677oik.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qbCvJzrlTYFgAhw+8VzgPAyasjyyOlY02styTbfmu2M=;
 b=vektu3eJ/68tUY/fA6Yowt2NKMKQrUXjYCsZUDanmvY63xyimbk9kvcp1Rjg1kPQ2X
 DP8Z/w8Eg/VluB66q+lB0Pc+bikfmbzXdEDhYTYkM164QTfCry2APk5YvfRjjCoH02Bs
 a09AkjC9thhZqmbooXBUTdE9D42E34pVVjandsw0FqrZtoLIh9y4nONEdtwWk2a27Zwo
 GBK44Vi1GfAEY97cvye0cYaWqLDAQytfsn2RN78PxM3G0iOldV40rKWJ63u3FFwhl6j9
 IwSMIWayURVD3jHc278xyPhoBxG/o+lJDHNa3O6L/6fewWRD+/K98LvcFsHs7JOGh+Ik
 seyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qbCvJzrlTYFgAhw+8VzgPAyasjyyOlY02styTbfmu2M=;
 b=iqeOvZBtIsYr6pOkSk9J5FWJ/OhiaWqLIJ1F5mSJ+WwxsNpSmR2eNN0a7uQWKUQEuq
 MebOSXX4XNO+IayPRZ2rOP9rFoIfwj858YAbtqbvwdNdMTFbwaGXFyz0qFL2bryheoaD
 goBS961ZnncaRpHeV9XEkOU/gHlt8B97iyLvAGK0d1m1cCHSu0Ze15sxj23nxNFtnTKO
 j/7y/ZKG1T9EgyHp5mkZGYXgDPJ3ndF8sU8mKztcGnqBIEhAeiuPVuzKKpUnr5YgOPJH
 NMVKyn2nbQBJ+/+2GSUioZJlsrat73ovYfhhnN/dOR9MyvDKe6nOzvI3hhc2TqPFwhau
 YsOA==
X-Gm-Message-State: ANhLgQ21EYRfwYUXa/sQcBfa9AyzIhM2qCiFvIT5j5NRutu9K8BRBYgs
 HXQ1/G3n5ur5TCfhpprHVfFiv/4Fsj5CUofHMNmzyg==
X-Google-Smtp-Source: ADFU+vtrX5GAc1Cl5p71sq0Qg9Zt7LbQ+bf/jRBK9upzwA0L40HE2pMd5KdW0qPLY1ZMMUIfiNxNkdIunjRLQMw7uXI=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr5578179oih.146.1584955732313; 
 Mon, 23 Mar 2020 02:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200320091805.5585-1-armbru@redhat.com>
 <20200320091805.5585-3-armbru@redhat.com>
In-Reply-To: <20200320091805.5585-3-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 09:28:41 +0000
Message-ID: <CAFEAcA-dToo-PDpkJ_R6=y0=x9u7KK5mChKwU+_bhx73sDuWpA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] qapi: Make section headings start a new doc
 comment block
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 09:18, Markus Armbruster <armbru@redhat.com> wrote:
>
> Our current QAPI doc-comment markup allows section headers (introduced
> with a leading '=' or '==') anywhere in a free-form documentation
> comment.  This works for Texinfo because the generator simply prints a
> Texinfo section command at that point in the output stream.  For rST
> generation, since we're assembling a tree of docutils nodes, this is
> awkward because a new section implies starting a new section node at
> the top level of the tree and generating text into there.
>
> Make section headers start a new free-form documentation block, so the
> future rST document generator doesn't have to look at every line in
> free-form blocks and handle headings in odd places.
>
> This change makes no difference to the generated Texinfo.

I think this does make things easier for rST generation
(which now can say "if the first line in the freeform doc
is a section heading, do section heading stuff, discard that
line, process rest of freeform doc as normal"), so on
that basis I like it.

I do kind of think it would be overall nicer to go further and
say "section headings are special and not part of free-form doc
comments at all" (both for the doc-comment author by mandating
that they be standalone, and for the consumer of parsed info
by separating section headings out from free-form doc comment
rather than requiring the consumer to say "is this line heading
syntax?"), but that would be more change, so pragmatically
I'm happy if we just do what this patch suggests.

thanks
-- PMM

