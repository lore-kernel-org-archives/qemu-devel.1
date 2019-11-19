Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE4C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EFE22363
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irNIz5li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EFE22363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5Zl-0000aD-49
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iX5Yz-00008h-U9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iX5Yx-0003EK-7J
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:37:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iX5Yw-0003EA-St
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574177826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1A0zJ6Z4FSOfW7Y8zFWYJmQrHdGw1qqxWATSE6A8kZk=;
 b=irNIz5li/S+27mRTDtRiG0DETHxAZMQcfJdx9kX/gRq7WRjBvcU7D1PHANtPbovIatLmI1
 CVB4o4KoMqMu31eOaXvDM5+pkled1UDhclm59GITCmaBZpI54LrBSGmss6IxTHRZaulblC
 Soh5PewEI5Ush2tiJHnr1xrw5F4YeiQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-EzGQUR-6MVKqsYpl-CBbCg-1; Tue, 19 Nov 2019 10:37:03 -0500
Received: by mail-wr1-f72.google.com with SMTP id v6so18327892wrm.18
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 07:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pgDhRhE/j2pAN6KLxpBmLuf6oLQfjn+RA15n3cF1rYw=;
 b=Mo0/p7kuAMkdLAn6iOY9/UmjUNsYUEt887N4Tjasp4oemEb9YX8ncMQ0ChZ2zkyXOq
 7mhbuQpywCSmXIIEQ0uhEbt6r74Y2s5hoK88cZa7toGEZHt4JDoO4pQwMCcmUSzyyzVk
 n2dL9iDnt/9Yx7tQvJit33UZcubbxDCW0p7q13k8wUz/b7XaxUV3aZHhbNRoZOj/HMgX
 yeir9CC8nQJoSiwpJnRTV46Slbq0vz1E+O35sVUJ7eDKUa09euM7o22G7zK2s+dJe455
 pLysuV15ejR+seLlhlwGGDQ1zmeKgol9+kv9mxWnhg394Rl8LFNKurdAk7Jj1e04QuYh
 CC0w==
X-Gm-Message-State: APjAAAXquGV9oCkzfivL7nqTEgDZZ7yR2EQvcRswk3ycZHwzUDUyjZlr
 pE8zJiho9G6CSZ1URAOXVPkbWTSwEx4DoYl/ot61RmSkOKNN8WmYMmwoCzVCKazWfcI9dt1gaeu
 IP5x+M2LcE0e3IRI=
X-Received: by 2002:adf:e74e:: with SMTP id c14mr7506874wrn.124.1574177822547; 
 Tue, 19 Nov 2019 07:37:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9LCwLfjdg9k82wu1V28DtIczubtS0zh5VwoCJkJJqbomPX3qmomfJC8vtHWiW/K6JOg2JQQ==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr7506834wrn.124.1574177822248; 
 Tue, 19 Nov 2019 07:37:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:dc24:9a59:da87:5724?
 ([2001:b07:6468:f312:dc24:9a59:da87:5724])
 by smtp.gmail.com with ESMTPSA id q5sm3379848wmc.27.2019.11.19.07.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 07:37:01 -0800 (PST)
Subject: Re: Exclude paths from checkpatch (was: Re: [PATCH] Add minimal
 Hexagon target)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
References: <157412709300.27250.5531224491109755641@37313f22b938>
 <7851e556-a5f2-9059-faf7-3d2a4e32958c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <def79672-7227-97ae-08b0-02aad6d9f850@redhat.com>
Date: Tue, 19 Nov 2019 16:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7851e556-a5f2-9059-faf7-3d2a4e32958c@redhat.com>
Content-Language: en-US
X-MC-Unique: EzGQUR-6MVKqsYpl-CBbCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, tsimpson@quicinc.com, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/19 09:51, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> $ cat .git/hooks/pre-commit
> #!/bin/bash
> exec git diff --cached -- ':(top)' $(test -e .checkpatchignore && sed
> -ne '/^\(#.*\|$\)/ ! s/.*/:(exclude)\0/p' < .checkpatchignore) |
> scripts/checkpatch.pl --no-signoff -q -
>=20
> $ cat .checkpatchignore
> # A line starting with # serves as a comment.
> # A blank line matches no files, so it can serve as a separator for
> readability.
> include/standard-headers
> target/xtensa/core-*
> target/hexagon/imported
>=20
> Would this be acceptable to reduce patchew false positives?
>=20
> git exclude pathspec trick from:
> https://stackoverflow.com/questions/39931781/git-diff-stat-exclude-certai=
n-files/39937070#39937070
>=20

Could support for this be added directly to checkpatch, instead?

Paolo


