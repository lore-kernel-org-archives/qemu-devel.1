Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C2AC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 09:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC731206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 09:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5gykMCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC731206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMr8t-0004u6-VO
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 05:39:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMr88-0004TN-Id
	for qemu-devel@nongnu.org; Sat, 04 May 2019 05:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMr87-0000MX-Pe
	for qemu-devel@nongnu.org; Sat, 04 May 2019 05:38:52 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMr87-0000LW-I0
	for qemu-devel@nongnu.org; Sat, 04 May 2019 05:38:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id b10so9891219wmj.4
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=PgxM4+Rgya3vjxxV5oLcZJZTuSPNombv15j6QC4x3TE=;
	b=K5gykMCd7VlWnMgY25EsE1di5Bjoa3VDxUtrK1jQ1xTSUBbZAicAfTPs+PIm0HdsuM
	hdPWNpudHONZOSd8ff/Euz989hKi8bKsRJ7Ahty1wCGcoPI3HZu7TGRMfpj18h5qBII+
	jJUPQLwfBuV8wqQqKXrK0odjXCKxwczr5Oyuv149PoqowJQz1Tu8a0UQMpY2JQvemgWu
	quL3iofAgIJLiJO8rwtmqGgQ7xr21a3hYA4V30kFWnlaEXvK1PAttb6sbWf9fMpfm0sK
	kDBW/wj/QzosEX0458BG16F7ibajZ3gtQsS+PFaTANT614CBtBgadj1kUC85msamUKr9
	atiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=PgxM4+Rgya3vjxxV5oLcZJZTuSPNombv15j6QC4x3TE=;
	b=hc2RA2rXPhrWtGazn358UlRRAC98Jg4IRVp2RsOP/TyoP+uKuqmeErj8sHfa61sX4f
	NUZq3emE8g/37mffs5fW8g+ZT6Xwl/kHnQdHbQgTlIFvnGwnxLNukM89SHAj3vIdi09+
	eWGXYsNc6DXorkey2aWeNAjcbwEgrFeMxCKBPIKWVaOPCpSpZ2R7PtuNhnF7X9pOmZUG
	sf0K1Y7mgnBzz2PCUe6VaveY2VlAookT0qNy7WAD3h+3aaf74LOwmY0DEgLbRa71yhcf
	QsRKxLZEBmGrSPrzJJ8BGZ1cmsUO4hE12OYdwuFsPST7n7hyqnVaZXtPgaoqn1OhLECH
	m+9A==
X-Gm-Message-State: APjAAAW/v/oYhZ1WUgWUqYICQqdAeUfzrs4P1eDGYfz/M/oUPAvrJXgS
	97GUUcONxZZKCE/9nkrjUt05Ow==
X-Google-Smtp-Source: APXvYqwIFnmocz7wOWhHui2FppDba30RX/anyLnlgbJ29eHh47Cr3Q51qVWQpSQlNVpksyeB49mIpQ==
X-Received: by 2002:a1c:a8ce:: with SMTP id r197mr7783615wme.66.1556962729745; 
	Sat, 04 May 2019 02:38:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id c2sm3132480wrr.13.2019.05.04.02.38.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 02:38:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A01931FF87;
	Sat,  4 May 2019 10:38:48 +0100 (BST)
References: <20190501184306.15208-1-richard.henderson@linaro.org>
	<877eb74gc3.fsf@zen.linaroharston>
	<6206383e-d092-28cf-1549-ab01a306bb05@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <6206383e-d092-28cf-1549-ab01a306bb05@linaro.org>
Date: Sat, 04 May 2019 10:38:48 +0100
Message-ID: <87a7g2bluf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/alpha: add system boot.S
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504093848.fSvdC9TjEZjOWYej3HcyO67jsElfKKgk568sDPARIsw@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/3/19 10:07 AM, Alex Benn=C3=A9e wrote:
>> +	ldah	$sp, $stack_end($gp)	!gprelhigh
>> +	lda	$sp, $stack_end($gp)	!gprellow
>
> Bah.                           ^^^^ $sp
>
> As is, this works only because the test case is tiny, and this happens to
> evaluate to the middle of the stack allocation.

cool. that fixes the exception I was seeing while running the
cleaned up memory test.

--
Alex Benn=C3=A9e

