Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618BC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93CCC276D9
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCcta2wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CCC276D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXnux-0008Pz-O1
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 10:26:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXntU-0007Ow-08
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hXntS-0004Nj-OY
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hXntS-0004LZ-Es
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:58 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so11305070wma.4
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=1aS5o9vpGmvunqllZGpoLG35euSGNQ+oCPTwjKu8l34=;
	b=FCcta2wu/QEkIm4yDyVrtcqUbmDp+QDmZbDqagjU5IzDBjuU3qBivaJBh4F58Z4yb/
	7w+C9sGOCXIe+VEOo0ykWX/UpII97mlDHj7aFzRkEkdAiyj03jlRN16rsl9cu6JzxXQ8
	cX5y3SafZRn9IzaEmZbFo86XBR3x4J6PbmqZ+rL8yebwJcBCo/Aqwv9SbuHwwvY+NvJN
	TduRp7lIcwvTomGrGf8P/7AIcJg7xBzirqh8nfbm05lUc2MFos3wnk9ZCWpgIOw+brVE
	dn6RG1HQCi4Vz6z0Au3OVBd0RUcXh4ofgSIug797RvNkO8DP2q4Ec0vM8oIZvGzE5eof
	IdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=1aS5o9vpGmvunqllZGpoLG35euSGNQ+oCPTwjKu8l34=;
	b=UPcHkPI/gkAcPOqxkSO2SyBzWdqsXGGdVUStHwYZY6JxKzzUOx2qpxkFy3NC8RfVpL
	Rya0sj8+kU4/pMi0EbBOmKRsJUQSsJsNvm7O4+r4baJ1ppkfM1DgOoFNLSnq5P2J4heO
	qK1AZjYYdO84kK0nfLxswhgPU/CKC0ZsyVnqvG4hMYCOBwMUaue1x5wzRmGX9Vkt0U+f
	/6SyLYajla/0Ap0pPXoAssdevmQ3HM0k7K4EAqWMo/bjU26R7P47FpTPIxL6j1b3EQc1
	s4QNMUq6p05vVQp2qrd2mu6IDBi4VlUC0/AOZffn+v16dcMNWLA1JN8XvPwmBigPeVrZ
	y8Bw==
X-Gm-Message-State: APjAAAWtTP6OhKY2KQEluUWge8E2kCUxvc4tg39Hwp2W2F2pLpivlrnP
	+PPQUAsXfZ3yFmAWXU9rse0iig==
X-Google-Smtp-Source: APXvYqy0kv/Cnfw4zj+ppw4jBDGIB59vdhfXIjaJYkuYVWVSbaqUCbEFecdRsn2WWy2ZluPDRzk3RQ==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr15027626wmj.64.1559571896919; 
	Mon, 03 Jun 2019 07:24:56 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	e15sm11489406wme.0.2019.06.03.07.24.56
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 07:24:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EC6861FF87;
	Mon,  3 Jun 2019 15:24:55 +0100 (BST)
References: <20190603134857.32359-1-kwolf@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kevin Wolf <kwolf@redhat.com>
In-reply-to: <20190603134857.32359-1-kwolf@redhat.com>
Date: Mon, 03 Jun 2019 15:24:55 +0100
Message-ID: <8736kqbvbc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix duplicated diff output on
 failure
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kevin Wolf <kwolf@redhat.com> writes:

> Commit 70ff5b07 wanted to move the diff between actual and reference
> output to the end after printing the test result line. It really only
> copied it, though, so the diff is now displayed twice. Remove the old
> one.
>
> Fixes: 70ff5b07fcdd378180ad2d5cc0b0d5e67e7ef325
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Queued to testing/next, thanks.

> ---
>  tests/qemu-iotests/check | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 95162c6cf9..44ebf24080 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -876,7 +876,6 @@ do
>                      fi
>                  else
>                      mv $tmp.out $seq.out.bad
> -                    $diff -w "$reference" "$PWD"/$seq.out.bad
>                      status=3D"fail"
>                      results=3D"output mismatch (see $seq.out.bad)"
>                      printdiff=3Dtrue


--
Alex Benn=C3=A9e

