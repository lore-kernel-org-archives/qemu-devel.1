Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F97C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 18:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6269220867
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 18:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYNAIqUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6269220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGoVk-00044J-I5
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 14:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1iGoV1-0003Th-RV
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 14:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1iGoV0-0000Bl-Kz
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 14:09:47 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736]:42779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1iGoV0-00009U-Ff
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 14:09:46 -0400
Received: by mail-qk1-x736.google.com with SMTP id f16so8902625qkl.9
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 11:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YgRvbaN3YsadbaMN7SVz0gavKujDfXL3t+TphPodf80=;
 b=BYNAIqUaMm+RY8skJkXoxtAA9HKi+NevdnelfGna+9a+jdkVBaSoDk+psKojKmuE1A
 tHJpF65hFPT4krn6Coj31MtcZ/kBqiJ4KB0URiu7W2P9WQ0uxdxlLkyjxkVQw6U1aptu
 LCb6YOPSPR0542qHtqnlrfGBvYCdChufybJ5EAav5uRTFqf3cr6wLGiHBlPE1XFQJ1rL
 O605M39bI0nfbB741gyzOgeuMYAaNvemh5vmrXaU+c2e8JAazFShXgHyuzzuCX2+wxjq
 qnHgAQs1vDGa5CaFNqVdaeQqbpjgfjsfRJfZBZGj3HyU1imzu7ZyW7G3V7ssBuPcme8Z
 Pi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YgRvbaN3YsadbaMN7SVz0gavKujDfXL3t+TphPodf80=;
 b=dpYEfgS9LYozfC+cEnk4TbanwMPAx5mNPxee5RkSoHWsuVnLjOAsidaxaDV/aP+jAZ
 BEymHWo14z3Gxm4hfgm4tjx9CcZYpfbjSTvUXyGlzCiEyLTglqRCwitsxX5usneZ/J5l
 +vmNHyibbpoVVv+JWTe2SvNK+avBnR0UAO4r9ViRp6sY4Xl/uABKYshqTuoSF4MM3qZJ
 cH+dfM7lNeWBuSkXyEx380M6odJ/mgmwMw3r79BRnHH15zIKI87+ZaMMSQatBpNeQxoa
 UzjwNBRAO67k7kkeMxB2Zon0rae+BoXdPqyil9Tc1MiWYyXVUpRrUJkcOOFM1WN9OFsl
 DgLg==
X-Gm-Message-State: APjAAAVgY71ISF9tn2KsZe19+26uSZ1xQcAxZ9C00nMmc7bw44AFLDjQ
 NpuOBUzeh4YgWrLUbPEL2SCwZpDrP9S8OUEtGVQ=
X-Google-Smtp-Source: APXvYqxNwMeeyittb3u9nmnFY6uaeb9dY1c6FXwThqLV22Ehq+u4dbnpf8cJWRs1W1lDgkXEQhmkqXV2e1Zn0a16pUc=
X-Received: by 2002:a37:aa96:: with SMTP id
 t144mr16650385qke.275.1570298984260; 
 Sat, 05 Oct 2019 11:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALvKS=EoaNnNQCmdp3rjjbaAYOoow8txsn1KX=Mb37Vk3he5Kw@mail.gmail.com>
 <5ef2c575-0bae-9f0b-cf2b-437280914cec@redhat.com>
In-Reply-To: <5ef2c575-0bae-9f0b-cf2b-437280914cec@redhat.com>
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Date: Sun, 6 Oct 2019 03:09:26 +0900
Message-ID: <CALvKS=HEx6BWWeCYTPye8gpmDfMxXAskEXLU5YmKESz49EYHbg@mail.gmail.com>
Subject: Re: Peculiar reply from mail list handler???
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::736
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John,

On Sun, Oct 6, 2019 at 2:12 AM John Snow <jsnow@redhat.com> wrote:
> On 10/5/19 7:55 AM, Lucien Murray-Pitts wrote:
> > The last message I sent came back with a weird reply from
[snip]
>
> I'm not clear on the particulars of mail delivery protocols or what
> lists.sr.ht is, but we indeed do not like HTML mail sent to this list.
>
The lists.sr.ht server replied to my dev mail submission with the
following sort of message
"We received your email, but were unable to deliver it because it
contains HTML..."

I was writing a quick mail rfc on capstone, and forgot to uncheck
the HTML option in gmail.  The mail was delivered to the list
anyway even given the "undelivered" message.

Was simply highlighting some potential issue in the mail server you
use.

For patch submission I have a script, so it wont come as html.
Just when I am not on that machine I will use webmail to check/send
quick replies.

The mail submission system is a pain, but I want these fixes in
so am willing to take the bitter with the sweet.

Cheers,
Luc

