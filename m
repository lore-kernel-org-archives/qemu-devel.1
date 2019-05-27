Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11DDC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F17C2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FggMI8ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F17C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVB2H-0003zT-Oo
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:31:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hVB1H-0003YX-Pf
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hVB1G-0004mo-UB
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:30:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hVB1G-0004k1-Ou; Mon, 27 May 2019 04:30:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id z23so10850903wma.4;
	Mon, 27 May 2019 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Q7IqZHr8tVazm2kY+SBdT0BiQc2NnWFWM6w1M1eRPCM=;
	b=FggMI8riK5CL6jGfJmMUzsFHfgB94GOAH1eHNb5TINY8WrmW8/ocQ40H2H19QSYsbh
	ZLsvQKpfVXytrMi22068Gj0TTWepguxDmNIam3J22kLpjwj21qyv6Fi9Njxw4Yf7RVJg
	MPy1DiPQISpwEUc6tZvzNJVZENdQQklZmSXqHAjtnsU+roXevdEebWcCscHVOH7YJu/t
	Gjb0TUoDbrCSg18i8VCf9PAORAXMaX3c8WJV4aDQrr0DrzReCobzBWm9k9zMNp2NANUq
	TJb5K4yTzbzzr1blwD1aTZFM6EICp3xOfkyAHYJO/9LUJDIi/+qYkm7jsjzoUsKRo8XT
	R6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Q7IqZHr8tVazm2kY+SBdT0BiQc2NnWFWM6w1M1eRPCM=;
	b=nd8ZZlQ43VuPLqxaq3psMi/lvNQKdnBRm+JafGor3jtatFKLEdzJMbEtMGb5UNFrrY
	YwQrfTfThKUnv4ofGbVsG1Jkbhkk0S9YxsNnn7eLsVyFNOx3Qnq/MjUNwNsw8AIFtEvr
	Awks2hKTTC+k2bOiwJbTLhZryloWbR6Orn9DIBq8ZtpS/pjKM0vJGw5yEPfuO1X1Wwnt
	2jN6t3ly4/FFWO09NGKOxlSslEqJMyaAtxYprHykumM9DH0kW9i7K88eW6VkjOyHugQk
	PpcREj8srDhisW4ro4rFB6bQ/QpU0F0lAbRkqR7RmGaMcQhPqo+YzKR8gI+U9v+oa94m
	ScJA==
X-Gm-Message-State: APjAAAVu5xpSUEKKv9u1fRVBy6WgI9zNklA5hR8uhr1G5QZKD7ILAper
	JryNSAhpXvvjMna+KXlTqqOzlRd0y2FYh0UUUx8=
X-Google-Smtp-Source: APXvYqwYUm9a+a73eJ3+qsXhwDt/RNreOCJDXDYR9+l3Qz9j6yx8L7pHP0y9LL04kiIEmnVMUNDAe2samtvb8OcSiBQ=
X-Received: by 2002:a1c:7511:: with SMTP id o17mr8696964wmc.39.1558945809633; 
	Mon, 27 May 2019 01:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
	<20190527080327.10780-3-mehta.aaru20@gmail.com>
In-Reply-To: <20190527080327.10780-3-mehta.aaru20@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 27 May 2019 09:29:58 +0100
Message-ID: <CAJSP0QXLYGA0NHGkbkmj5kqNrft2SW9sZ=AqxrbBct8Le5DC2g@mail.gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 2/8] qapi/block-core: add
 option for io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 27, 2019 at 9:04 AM Aarushi Mehta <mehta.aaru20@gmail.com> wrote:
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..2773803890 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2776,11 +2776,13 @@
>  #
>  # @threads:     Use qemu's thread pool
>  # @native:      Use native AIO backend (only Linux and Windows)
> +# @io_uring:    Use linux io_uring (only Linux)
>  #
> -# Since: 2.9
> +# Since: 2.9 @iouring Since: 4.1

The convention in QAPI schema files is to mark the newly added parameter:

+# @io_uring:    Use linux io_uring (only Linux, since 4.1)

