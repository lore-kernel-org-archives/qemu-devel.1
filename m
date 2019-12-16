Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C529CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F796206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMRUME4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F796206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtvA-0000no-BP
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igtFo-00063f-9n
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igtFm-0000nf-Iy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:51 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igtFl-0000jz-RQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id b6so8074120wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ay5wgkevcGKw2HS0wTu3yhWdeoZOrZJoZd/dXeHN+oA=;
 b=LMRUME4t5UeBib0WA9bqKk7YGxaNJH4i7quohSe1Iitsz2XcrUBqlo61z73xZhDQvc
 KlsKJhYlMlDiLF1fiC/dCghF/6KnKfknBNx84OkMJrpOwZHY+CNfQhUXPhA2qbBE1xER
 lN1XyfgSUa9/30nRZMaM+6jJiVOZ40pz3Nidye1W1PvUCk50K5e72EPtQRh83/YwbP3k
 EUNLblPNloH/+LUJ3WHdFyXWkq5HS3Y9CCoK/eAPHR1NwtYcwkKZ886CIPH4eSGHziD6
 ltSgnleBPmcU0T9C7h8hBtxHO0mndxTUC0MUDPkXXTcoTM383WvGeuQSc5o0gO5bsaNf
 Eahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Ay5wgkevcGKw2HS0wTu3yhWdeoZOrZJoZd/dXeHN+oA=;
 b=I1Snied2u/fcTvWkcnAWi17nkCU3CUWP9KuZuj0Id7jUJmXsB74HUGdnn94NAElUrb
 /TzvRmdCRLnW2EtcAibRLhQhaWU/qtvj774BzDnk/ctbjImojyoyGKkHZRRBCaWFKvF4
 prEKfj1j6/E7ESigvPm7ZYCVZeUrsh4oWLYmEFAz/CNxiTun3l06a5khM2VIuSsHLKKh
 1Q+3403M4tfh53aBUMb8FHeqiKrgCJQ+wCuGUYNsB0hch/byd1SBcoIF/ykRPCJ36bCE
 l7hpwcO60Eb8KX/tAj7Ap830r+WPBZ/ALMlllvVs+Buiuqv4W6ujdZFQCdTFCxpaSyVt
 EywA==
X-Gm-Message-State: APjAAAUP1AV8O5Zj9o+JVYTJka10fXZz8rM5URaqAZEAdUjBxM6I4F/a
 a/gXREr9Bv4tv6nsOuS/0OqsWg==
X-Google-Smtp-Source: APXvYqzU+u9Yxl11hBTfuWb/VgxyknxjS9s9r90p5HQLONdYfJHlPwMvyNZzWwOtkNDSa78rEqWfAA==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr31677573wru.220.1576513788871; 
 Mon, 16 Dec 2019 08:29:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o194sm11988561wme.45.2019.12.16.08.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 08:29:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E594C1FF87;
 Mon, 16 Dec 2019 16:29:46 +0000 (GMT)
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: jeff@codyprime.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: qemu-project git server not utf-8 clean?
Date: Mon, 16 Dec 2019 16:29:46 +0000
Message-ID: <87k16ww7wl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

I was doing some housekeeping of the wiki links into the docs page and I
discovered my name getting corrupted for:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/devel/tcg-plug=
ins.rst;hb=3DHEAD

Looking at the headers:

  HTTP/1.1 200 OK
  Date: Mon, 16 Dec 2019 16:24:50 GMT
  Server: Apache/2.4.6 (CentOS) OpenSSL/1.0.2k-fips PHP/5.4.16
  Content-disposition: inline; filename=3D"docs/devel/tcg-plugins.rst"
  Keep-Alive: timeout=3D5, max=3D100
  Connection: Keep-Alive
  Transfer-Encoding: chunked
  Content-Type: text/plain; charset=3DISO-8859-1

Shouldn't we (Apache/gitweb?) be passing UTF-8 contents?

--=20
Alex Benn=C3=A9e

