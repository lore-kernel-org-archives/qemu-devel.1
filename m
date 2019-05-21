Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1316EC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34662173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDwBdQug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34662173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6nw-0003U3-47
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hT6j4-0000fP-MV
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hT6j3-0002js-Ov
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:30:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hT6j3-0002hh-Eg
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:30:49 -0400
Received: by mail-wr1-x429.google.com with SMTP id r4so19101098wro.10
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=7APRVUc7NbPKkM2bncbRt/LrcoKK7WtEZXyu9xb3oFI=;
	b=UDwBdQug+vAsZNxxKNrLq/cLMKBpWUYlMAMa+2HXF+Jw3ykG0AmliAV38GtrgVhzto
	BUR7/VoG+PmpIrapGzPD6ENHu+voAjmSgJg3AMpAC14qzARmR3Mksv8iejJa5n9770/G
	IoivKVPgLDJKJSoTX5jPm3XVIgZx679ve+T4ba6Hp2JkKD+tP62IQef7omwI7ebhnlLw
	Tfkv1WcjW98tRkoioo6fDQdVk4AYozt9f80RGRCjyPICrC1RVFgoy9f3vl06MMXbrAno
	N2e2DXGVVda9EYEnd+OgtBRXow9IjzVO6f9KbA+TBZKRUnsIG4nBsEw1zcFNkuDHFRIs
	osIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=7APRVUc7NbPKkM2bncbRt/LrcoKK7WtEZXyu9xb3oFI=;
	b=JCvrWr9Jn68jn1bt/r3X94UF69bv0gs7TG/4lkQNAyamAQv6cF6lyMYZEuN+IXLhY9
	vb6XFyDXvuS83YnQfXxb3AVwJi0px1sMwg2DqG4f40C/4FYdqpbfc0VBIzZBxCCJzS6d
	zjjKt/F7TMqfMTU+J86msPRjAtAyG80KUShttD1ltnmYnAwqHvO/xIlqSaxaFycSkzdB
	7ZzPRLJWmYlw40C8Bg4fBrP6Q1Cjh5CSsnogiFVIuAxHGY90g7PLtHU3kDhfm6brUIxM
	rS8EoeX5FerxeH60NV1H+wAldF8bmdVcOHOY4IiQR2Sdd0Qs/Ve6lGNpmQWagrgEkgZI
	/VPA==
X-Gm-Message-State: APjAAAWzfpe36c+Hp3coukE3QVye9kR6sqrj/0CIAbZVNMyLZ3SiI4hK
	gpQYOXgASxRS2YOG9L1l0toR/A==
X-Google-Smtp-Source: APXvYqx1+i/qc6IxSobCf3JPsDbkQCFuzeOC9fPZGJU8Mpa5lO1BEbupd12qV39zyZ+M3isC7p4dqA==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr11183560wrq.10.1558452647936; 
	Tue, 21 May 2019 08:30:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id k8sm8299058wrp.74.2019.05.21.08.30.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 08:30:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id B79561FF87;
	Tue, 21 May 2019 16:30:46 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-8-jan.bobek@gmail.com>
	<87zhnhgw1c.fsf@zen.linaroharston>
	<CAFXwXrkiShudOkAKks7VwB5-tUskeY1pfSeftvS8n=ez8Zgeog@mail.gmail.com>
	<87h89ogoo0.fsf@zen.linaroharston>
	<eb8797f0-c615-e60d-0bb4-990e08901883@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <eb8797f0-c615-e60d-0bb4-990e08901883@linaro.org>
Date: Tue, 21 May 2019 16:30:46 +0100
Message-ID: <87ftp7hljt.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: Re: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm
 to gas
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/21/19 5:08 AM, Alex Benn=C3=A9e wrote:
>>>> We probably need to zero or reset the xmm regs both in the test and wh=
en
>>>> risugen dumps it's preamble.
>>>>
>>>
>>> That gets fixed later in the series.
>>
>> So it does, but I'm still seeing the test fail when played back :-/
>
> Um, no, I mean this test is extended in patch 9, exactly how you suggest.=
  Are
> you trying to run the test as seen in patch 7 against the final
> series?

Running against:

  commit 555748b35849ad4d354a9a3cd7f8549994b2bea4 (HEAD -> review/i386-supp=
ort-v2)
  Author: Jan Bobek <jan.bobek@gmail.com>
  Date:   Fri May 17 18:44:50 2019 -0400

      risu_reginfo_i386: accept named feature sets for --xfeature

fails for me.

--
Alex Benn=C3=A9e

