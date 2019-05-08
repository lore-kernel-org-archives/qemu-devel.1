Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99851C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F87A20656
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 09:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzOnPjCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F87A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOIkl-0006I2-MJ
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 05:20:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOIjz-0005vy-0O
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOIjy-0000LE-3c
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:19:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOIjx-0000Kg-RW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 05:19:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id v11so6066299wru.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=zzKMN5PHQaK5lVbPLR4qxYW9E9uzQ7YU2GoTiuZgJP8=;
	b=bzOnPjCenOKcM7aeSiXvCTeKhcF3KPvNPXJ8IFMg6U6x6MpE9vESuGwWLPHBF6lKVe
	s4ZPe3oZf0gMsypJLOnApnsDipPXCGPO4UF8hlFqUz0agn7jdHEUkX3GW9IgbZwUy5zH
	MtqkFRA428LlrQHZFTu/dFafDPVNODHM9CW8gxzsce+7HyRPYAnj0oiXdWZuXlvgGDuz
	V+NjZNM8g3oLrcnArXufsvuaq/eOJKH6ubpHuwwaISMRQl62zm8o5aSugmPfR+pYgqkh
	ujXBNZI2fF0eiVISiupaUCN1zNKtCtSkDXE2UxRqPk29OTa1FFPtgf8TC7DLpQlX3glU
	xoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=zzKMN5PHQaK5lVbPLR4qxYW9E9uzQ7YU2GoTiuZgJP8=;
	b=k5u6hhoIPrk4+40E8WQ+jQgVElp2m0XhUO+GunrrB9XKjOjMcoYZzDtmqwTmmlvtPT
	un7OivSODXeqXBLc3uRwp9362NxIhy3BjdDhHYqLvZuXroTwe3/qtQoaieX+IirSAaMs
	BIi88zv84hSgjzACRu8gWADhPQwtfXJ0ehtDt8R08w5un8ILrWTsS+kddfRMm+pKWCOD
	8YuQmr9jqkfDQMspR8/XKBK9X/+UfGtLkGtKVKm+el9rqnuATPgfWcQIsrIidc+pibR1
	xaEqst5e900nHkKByYloR9+As4HaQN6P/OxpCVrQrVgacKlWpDNm10Mf6f//3nW2fPZY
	5DDQ==
X-Gm-Message-State: APjAAAVvaJfdiJnFPtgPDRimLsGU2L8kB7hfjlswewTPpajFt5Lqd7GM
	Eh9NOokl4ovQKi3h+xSWo7hZsA==
X-Google-Smtp-Source: APXvYqwtDTVGh0b9g8/rWKdTKkObU5Z1pTxcjPYiIxJLCOlXgWUbR8meGUFT8/bxl94CW5CL6r3KPg==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr24978178wri.220.1557307191934; 
	Wed, 08 May 2019 02:19:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j131sm4388607wmb.9.2019.05.08.02.19.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 08 May 2019 02:19:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 536071FF87;
	Wed,  8 May 2019 10:19:50 +0100 (BST)
References: <20190506213817.14344-1-ehabkost@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190506213817.14344-1-ehabkost@redhat.com>
Date: Wed, 08 May 2019 10:19:50 +0100
Message-ID: <87v9yl4821.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] tests: Force Python I/O encoding for
 check-qapi-schema
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
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eduardo Habkost <ehabkost@redhat.com> writes:

> test-qapi.py doesn't force a specific encoding for stderr or
> stdout, but the reference files used by check-qapi-schema are in
> UTF-8.  This breaks check-qapi-schema under certain circumstances
> (e.g. if using the C locale and Python < 3.7).
>
> We need to make sure test-qapi.py always generate UTF-8 output
> somehow.  On Python 3.7+ we can do it using
> `sys.stdout.reconfigure(...)`, but we need a solution that works
> with older Python versions.
>
> Instead of trying a hack like reopening sys.stdout and
> sys.stderr, we can just tell Python to use UTF-8 for I/O encoding
> when running test-qapi.py.  Do it by setting PYTHONIOENCODING.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7c8b9c84b2..af88ab6f8b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1103,7 +1103,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotes=
ts-quick.sh qemu-img$(EXESUF)
>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
>  $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH=
)/%.json
>  	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
> -		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
> +		PYTHONIOENCODING=3Dutf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-=
qapi.py \
>  		$^ >$*.test.out 2>$*.test.err; \
>  		echo $$? >$*.test.exit, \
>  		"TEST","$*.out")


--
Alex Benn=C3=A9e

