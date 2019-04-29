Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ACEC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270812063F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrmEmvH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270812063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8dd-00083w-Es
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:56:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8co-0007RT-G1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8cn-0007a5-60
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8cn-0007ZO-1d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id a10so253272otl.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=sZad7pqPaqxv8J0C49FcSl+C1cBSPKCJl77xw4EoB30=;
	b=KrmEmvH4mbjkiit4vzV7L3ldUP5g1HKVoFiPkhJzTELC6E9fIzjeylKjAFavh31SQJ
	ji6vRJCYFv4OXocu58LTUcDcCE2VA3gu1wqbmdC4s6YyeqFdSdRJmPK1FrgCJV1I4SP9
	7hH9AhER0wHVw3fJ602k2sC3tTK9JpAR2ooChBgr2YOmNDRd5QdLRuXqh0OoWESldK8q
	GUe70m0qOcl2vulLK0PJpEShDagmBFAzWpxH5P4Q5a3NUvAoe7eFb6Iuq7bpQhSrdVFb
	0QT+fofuCwDdgT3rpbGEeEiLDDFaKsJB/H3A7/yUtacIlcLOMoHDbNZ63pPpp8eOMoJu
	z3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=sZad7pqPaqxv8J0C49FcSl+C1cBSPKCJl77xw4EoB30=;
	b=ld1j8lPZuJoJraLevqmJoNc8mawSSsVblUoa6BvWiXfugxKv/v+w0yjX7rTK8OvI0b
	pzvPZFSDHIQM8OR9JJKWLJ6l5hsnJuPveJ/OFGPk3pIWyWmnj3eDEZvBUxLJcGw6guwK
	3xWoxwxWfKh2i35CK3OPQN5We54+7GqPyMQg6xmF7jZwFhiPbkR4OTtg+hippn8zl/YA
	eZjLbWxjU/eUABGQblgsU/ovU3rtTn2ez6e1k/6d995dxll31C166JPLubgRjCv8oNZ7
	XzB+hhv3/YxPTbjqL0pJE+lhuniR5m7AyZ9b74fKhztfTreFRk6rfwnPxt/XU3caTF5w
	vfLA==
X-Gm-Message-State: APjAAAWN6V0ZvmhkDFPwU68z82EJgNk2YFaq3k383rHsDJBhCKlrR9Ge
	dVxsDDo5K/+LonnbQI5qIgi3zYEsZIMkVubiu5KwMw==
X-Google-Smtp-Source: APXvYqyC8Hv+ceMR6M0uk13VESCJh9gbjGmfwGHzFR9DDQYPGU2Xz46XOcCCB1lDIrOQe+sejh4dq90yi3wQ6coFNIM=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr1679663otk.316.1556553323951; 
	Mon, 29 Apr 2019 08:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:55:13 +0100
Message-ID:
 <CAFEAcA_X+rmREYo_HRjKwwNmUGG4vEeb6s=5eLb3MudmEsUH=A@mail.gmail.com>
To: Sandra Loosemore <sandra@codesourcery.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v7 0/2] Nios II generic board config and
 semihosting
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429155513.MjjiTA1C-NzOzvrabyAo7QM3KR_j85YA56bLQ7NH1O4@z>

On Wed, 3 Apr 2019 at 20:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> This is the seventh version of the patch series last posted here:
> http://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg06255.html
>
> Changes since v6:
> - Fixed block comment formatting for QEMU style.
> - Fixed fixme for interrupt handler (now added to libgloss BSP).
> - Added link to libgloss semihosting documentation.
>
> Sandra Loosemore (2):
>   Add generic Nios II board.
>   Add Nios II semihosting support.

Since Nios II doesn't have anybody actively handling
pull requests for it right now, I've applied these patches
directly to master -- thanks!

-- PMM

