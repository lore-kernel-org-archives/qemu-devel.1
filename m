Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8B0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861B52189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBels177"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861B52189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zPt-0007T0-Kv
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 10:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zP4-00070o-9J
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2zP3-0000z1-7L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:58:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2zP3-0000yH-0A
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:58:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id r17so1962735wme.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JhW2J0PwN4JDjYwm1e87OUlQIe/Z5tlnolHOWrv4hRI=;
 b=SBels177aHurus761rT9BY+KCshUAVMD18Xz8B8cCNSH6FQ9KXovysE+E3TfbT2CsG
 aGybwF/NMBC6VmRGGF4fUq9R++k7KPb8/NkRX1urn2X//WKs9jHTADJZWowYFliPVtOg
 f8Xcksn2FlVoKDhBRu1B1LY/zaOazearJI4hRBNmMjl3W6ylB1Ov0Sl5zS7cPwQIV9zi
 3oGIhN+no9wppolxQgu6Q48Ltea6N6+1w5zjsBuJT0jltEcJlddj49QZd6AcPvTp7SRN
 KageaKvp168scY6r4Rjhg6lZJKApPQGTdrw9vqnzFDiEGd6iJFPm1RSyAxzajEF2D2ml
 f15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JhW2J0PwN4JDjYwm1e87OUlQIe/Z5tlnolHOWrv4hRI=;
 b=G5n1tLYj9J03ec6clCqHmV32Cegu0ehcg87mO6Yq5hlSM9oA6867DtfwA9t9giXOfC
 1kNt0FtzR7q5Ti9v8NSbXXEkGIWfcGOEJT74eQvboE0Cas9RJtfkbuEC9UbbIoD3NL0d
 DI6d9Pux3cfHbDjfrjiLVt4d19IFWiur5IjYW9AIuifR15gMbYM4FSIo0g4K7/pcaEgL
 47gyOloRuRBYHHtuuncWXHtvpDk21WjHmg7CWynRld6V0j6PQCCtDXZxQgcWoIioj0oz
 eWzubD/Rme7IRtWw0m7+kYMTAzF12b5nN4DpWbpzyV3Iri4iC4GNSApF93jvLSB1JXov
 Mx2A==
X-Gm-Message-State: APjAAAWewhz96mgqlDNlEqNtkE/GrPV5+KAT/zmSCR6rzL5Ji8Tweg4R
 ADX7XgA8vs2GwWtn9qbuJeJuRw==
X-Google-Smtp-Source: APXvYqxIhJtwVusZN4MrTwf/JD6JaLA+fBSWu2ouM8fb6KIzNAVKMWtz0Ov1g2EeQy1mvvjW4/w/XA==
X-Received: by 2002:a05:600c:2111:: with SMTP id
 u17mr5713654wml.64.1567004307384; 
 Wed, 28 Aug 2019 07:58:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a7sm349893wra.43.2019.08.28.07.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 07:58:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1FF331FF87;
 Wed, 28 Aug 2019 15:58:26 +0100 (BST)
References: <20190828120832.9208-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190828120832.9208-1-alex.bennee@linaro.org>
Date: Wed, 28 Aug 2019 15:58:26 +0100
Message-ID: <87blw95obx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH  v1 0/8] various gitdm and mailmap updates
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> With another release out of the door and KVM Forum approaching it is a
> good time to clean up our gitdm stats. As usual updates for academic
> institutions and individual contributors involve a bit of guess work
> so I have CC'd those affected for their confirmation. There is also a
> large amount of verbiage added to the mailmap and aliases files to
> (hopefully) better explain what they are trying to do.

Apologies for the double post... when the initial run returned an empty
result I thought it had failed but no - it had just complained about
some utf-8 names.

>
> Alex Benn=C3=A9e (3):
>   .mailmap/aliases: add some further commentary
>   contrib/gitdm: add RT-RK to domain-map
>   contrib/gitdm: add more entries individuals and academics
>
> Markus Armbruster (2):
>   contrib/gitdm: filetype interface is not in order, fix
>   contrib/gitdm: Add armbru@pond.sub.org to group-map-redhat
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   mailmap: Reorder by sections
>   mailmap: Update philmd email address
>   mailmap: Add many entries to improve 'git shortlog' statistics
>
>  .mailmap                            | 137 ++++++++++++++++++++++++++--
>  contrib/gitdm/aliases               |  20 +++-
>  contrib/gitdm/domain-map            |   1 +
>  contrib/gitdm/filetypes.txt         |   2 +-
>  contrib/gitdm/group-map-academics   |   3 +
>  contrib/gitdm/group-map-individuals |   7 +-
>  contrib/gitdm/group-map-redhat      |   1 +
>  7 files changed, 159 insertions(+), 12 deletions(-)


--
Alex Benn=C3=A9e

