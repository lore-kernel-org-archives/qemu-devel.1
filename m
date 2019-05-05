Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBC7C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E9B206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFsptWz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E9B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJHE-0007Cy-GB
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:42:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNJGE-0006f8-AX
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNJGD-0003jT-EH
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:41:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hNJGD-0003iV-6w
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:41:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id k16so14057742wrn.5
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=qqmfqgms4TT4t1FNLF8RKK52eQNI+uOCVdyaa6GcZdc=;
	b=aFsptWz/o+OpOmjgTpTlaDD8/dCm/KhsUdIdR4OTKYZ9hsUo6w0tssQlyzA/+UVUBH
	FZLPkmhMqUU5/i487iPz5NQxdT/+gM5q3yrQ1LDC6XMt0m/HlVQTBi1v8OHMchnsGmKC
	da/y4Lb8lDBUp75YlKMPVrt35bbXkH2+tmfEauAdufvdVGPn7BobohRZtiblQMUURhA5
	wwG0Cmmb1Nz6xZblM05fVHmeIk5qH4Ou4grZDgM4vlUTIOq/xX4Y71MZgMhNN91eZel+
	OmPXPLopjg4rvz7iB51OzKib6/qk7r6ratZ4S1jrf3I93Wn6+57Ii3wkw6gDAoMV/GQw
	t3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=qqmfqgms4TT4t1FNLF8RKK52eQNI+uOCVdyaa6GcZdc=;
	b=qrnIpATtqxMtfpjyZQ0gtNjGPH3VVcUNSFI4zqV8fNZMwjBwhdm+GmzP9Kw1eJ0v4q
	g6+oTNc9EIple4lA3IcQnxOa/aZwefWMVSWHHiPXbdpDA6Mp8ZmMIqshWH/S4WggVacm
	PPD1OsXXnpXPw8r+dLx/Gyto7dCsVhmlDRJEEuuGHEbFEh+5TMFPTVQopmWMrLkugsqM
	Nt0Tnyv+gxbYn0iqO0zDGot/fu3kgUQHk88+yh0+Y5A75XjvKjE0kDq8yr2ao7rfLZQO
	7OoK/a6DRyFuQrbT+1x9oN58gRjg9ckpQKUBwXjgVKyBK0O60DhRBhPcwj9fAxx9Iade
	0xiw==
X-Gm-Message-State: APjAAAXYjaBbmDHittjch+yioefPE605w+FZm/DoiuoM/oF0HYFLbdgz
	7MmtyDqJLzDZA6EIryy+zLCDgg==
X-Google-Smtp-Source: APXvYqxq+USAOm1uooCFOhR3rSmJgVFFwYkns3fP4dPhaF4ZzL08CGCKb9R9Ip8o/VlQPBfy7nwZhA==
X-Received: by 2002:adf:cf04:: with SMTP id o4mr1961745wrj.212.1557070862298; 
	Sun, 05 May 2019 08:41:02 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	a17sm7001055wrm.53.2019.05.05.08.41.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 05 May 2019 08:41:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5A60A1FF87;
	Sun,  5 May 2019 16:41:01 +0100 (BST)
References: <20190504120528.6389-1-pbonzini@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190504120528.6389-1-pbonzini@redhat.com>
Date: Sun, 05 May 2019 16:41:01 +0100
Message-ID: <877eb4c3jm.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: Re: [Qemu-devel] [PATCH 0/9] Assembly coroutine backend and x86 CET
 support
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505154101.iH8OqRWFpoiSyYPjyCDPVDnrKiSmfbl-Cq-FlFiFyvs@z>


Paolo Bonzini <pbonzini@redhat.com> writes:

> *** BLURB HERE ***

I assume there was going to be a bit more background here?

--
Alex Benn=C3=A9e

