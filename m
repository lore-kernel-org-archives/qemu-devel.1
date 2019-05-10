Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AEFC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF367216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xT9On4yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF367216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6U6-0001Pu-S4
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:26:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6SN-0000JL-BX
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6SM-0001Hy-En
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:25:03 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:32803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP6SM-0001HY-9C
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:25:02 -0400
Received: by mail-ot1-x335.google.com with SMTP id 66so5755826otq.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=G2rv3kdtDbwrJD6ExZWEq7EQJxFc3jj1TSgcRZUFelc=;
	b=xT9On4yf7a2WLnM/MUKU1vnhqGY2nWw/843qn6l0tn0qdAU3OxkjVN18ZM30vWVII6
	V1GeigWhCO95bHhGyiqCznv8l8uedqCdjXF+4wQp8p0YWXKh10DsangQ97S2i0QSFvA2
	9pGVuqomRiFKJD1WzP4AzxTvtjZTNtUI+lC8Vc2TGJnDvAdQHH3uTWeNWKAuy3EjCjd/
	ZZ+KtsdH35E20D4xjALfD/dtX3kHQX85tAdXVVQ0UPwQ3S5rAjYK3RBEgPKcUqNqTGxD
	CWL3ikKuH4sZf91xxqKnSUlyZN7Tx2FSSc/VMyIsawmEAx1dqnjZvS+LTSOqtA/BIWbw
	vGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=G2rv3kdtDbwrJD6ExZWEq7EQJxFc3jj1TSgcRZUFelc=;
	b=Tvm1BMN2nuAFnKvLMjjyzDAvEp8BBrWWqsB0KRwzn+ugOCSplHqROur6XOa33g6UBE
	6/T9EY0xNWZp+czBAMXtH9MHOdfDvinU9vIBg+JmaEOYb2bwJfj7PLrtjvX0wH1TXcqM
	KsLsZQL4IkpkzzhDyDDiPnoUCULAWzivnjDDWOEA4I4xS5HI/GT3q9UK4qI8Ta+KvQg5
	ywvE6XJ/avrYIaQWznk/8A6zr7jjVirmgumKnfFltfFYPtSnGd4MzN+Gj9lAalEaXk6N
	3FDMtVLYhFr8gTJsCjeW3Sw8NN3OjNMiTBq8L2bpIERFWDH1VEqWZq8llcQOrVwQ4XvZ
	Gxkg==
X-Gm-Message-State: APjAAAUy9lJMMAeYBi6DS4snPeg47EdRgRG1AcMwo9IfcYprPUwuDVz1
	FcZhrLkMZ+IUEGk0iAC8au05w00D3jpRGUsYwb/XPA==
X-Google-Smtp-Source: APXvYqxxogIaed4AtoJygX5iiBe1JvGCDnXf8F+9M9PHZfKOp0Dsp3juIf2AFsTJSyaYGtCOCT6lULmQp06xmAliICs=
X-Received: by 2002:a9d:404:: with SMTP id 4mr6915445otc.352.1557498301212;
	Fri, 10 May 2019 07:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190510130243.8887-1-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 15:24:49 +0100
Message-ID: <CAFEAcA99qdBXWeR+YoTz_X2++xQFgz2b9e+Ew2midP5nhmYdtQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 0/8] Block patches
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 14:02, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 812b835fb4d23dd108b2f9802158472d50b73579:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-05-07' into staging (2019-05-09 16:31:12 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to e84125761f78919fe63616d9888ea45e72dc956f:
>
>   docs: add Security chapter to the documentation (2019-05-10 10:53:52 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

