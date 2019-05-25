Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4059C04AB0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 07:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AD82133D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+PNkRuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AD82133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37614 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hURU5-0006dK-2p
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 03:52:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hURT6-0006FP-JG
	for qemu-devel@nongnu.org; Sat, 25 May 2019 03:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hURAY-0000xX-1Z
	for qemu-devel@nongnu.org; Sat, 25 May 2019 03:32:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hURAX-0000vP-Ph
	for qemu-devel@nongnu.org; Sat, 25 May 2019 03:32:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id e2so3240392wrv.6
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 00:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=vVl9V4zuTn5tE2qNAT4YMa/w5EjFrpthmm04wHF3sk4=;
	b=m+PNkRuutMe56Bbta+KYOG+E7QnLT/kbfjlUlyfyUCTRI8ZtBKz4/ZEEE6aDuOVvk2
	Efqwh3RoM0tHqysH2jZ+HY6/Q18vadDlEQ7dICA7Eot2XXFSrKoFPdfvf9RQAr7dWVwQ
	VbUasQNI2NQGljTnktlekvyL6GkYi0rOEGV89eWPLqSO+PJ0oensWicsHjI71XdceB5p
	UkrpnJ/Kp1tg29KJ/+dCwblbMiMjtGSWhtY+la/YaY+wtpHJl41mizXBURA9lrGiN/ij
	ChPsTd/8duGQSBGkvwLfZr45B5ijJc6xdh5tEKmqVk5SKlPSmvrV7c8HNKN2gF3uAMEz
	glTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=vVl9V4zuTn5tE2qNAT4YMa/w5EjFrpthmm04wHF3sk4=;
	b=lM2sbpWchDtmK5T2zcd+5UdSRpwTM9aSc5dymfNjqItp3lYvtpqDvmPi9n7EGizHys
	AKiHOWNjm9j4eZREH+SwHkf0kAVH+slXFV0VRB9398gD6ma9vAkoFCF1c/NaEmoh1e93
	hIGxB+JO+uSgfeUzN3p57yU4yOc2jBHYnhy/ERORgoHm5kXUhP/QRg7Xpt8lfY/St+C2
	3gDH7Db0PcMuSz4XXf4c06CzwkvfuKUzSSh/Yf/bsVDu8RmsWtp96x/ntU6mtB0UjrsO
	4uM0MNIU9qt0sVODoqKsy8RKSy0SIvVQjTgMmUC3j5pOx/HV/Zcq/Q9diXvSzo/986wD
	LDmA==
X-Gm-Message-State: APjAAAU1qzjdkRR6XjTFdW390htrknX6vUP69eTG0KGmt+d4PmkyOoi3
	HEPusZVVS+epZDOIBqDFJBP9aQ==
X-Google-Smtp-Source: APXvYqyrO+97oU1HtGYQHKbCcgswX4otJOxbLNXwCVtyGfZKWHPP9vTSX7AG5Zv/7Qr5Iav1JlsjsQ==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr2790026wrs.128.1558769559906; 
	Sat, 25 May 2019 00:32:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	t194sm21207234wmt.3.2019.05.25.00.32.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 00:32:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CF59A1FF87;
	Sat, 25 May 2019 08:32:38 +0100 (BST)
References: <20190525062832.18009-1-liq3ea@163.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190525062832.18009-1-liq3ea@163.com>
Date: Sat, 25 May 2019 08:32:38 +0100
Message-ID: <87sgt3q99l.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] migration: fix a typo
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@163.com>, dgilbert@redhat.com,
	quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Li Qiang <liq3ea@163.com> writes:

> 'postocpy' should be 'postcopy'.
>
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 4c60869226..359dc8f1bc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2236,7 +2236,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_add=
r_t *offset)
>  }
>
>  /**
> - * get_queued_page: unqueue a page from the postocpy requests
> + * get_queued_page: unqueue a page from the postcopy requests
>   *
>   * Skips pages that are already sent (!dirty)
>   *


--
Alex Benn=C3=A9e

