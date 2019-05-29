Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A699EC28CC1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7841620673
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDPb6bcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7841620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyGJ-00042F-MW
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:04:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVyFU-0003aI-RF
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVyFT-0004DX-Ms
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:04:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVyFT-0004Cp-Ge
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:04:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id m3so1747721wrv.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=NatGkdY/ltZOqJ5k0mlz42taQmztHVybRbDv+c/dqZM=;
	b=lDPb6bcL/1pS1u8C1qceqfSjimK7ldQ1AX3Qj1wGICcEJ5qGLs2uyvfSJD4rLq1TCG
	qS1xnAVoQEmjDCS6R6EzaLqa5OaRtY0eEkR+pgS+aSNBs9U4IXVIlMgq7VreAUGCjypB
	CBKJFslngEFd57CnRVLC8VzqDK+PYPYn3UjytS6xi9+y5kXuKoy3Q+66ew6sm9B2vHUS
	ZSJz7JMlvgVQ3Rv6vQHhEl0gF8Ojaj/zm0NAK0i1fWE1Lncq05nEja9/tNJqTkYGH0lk
	3TLcftc/d6Yi0HbBj83xkbb4GSSSY4CKZuAcLKNv9ZGkCnUQb9ZSb4dbE2mBVlQfcn8s
	3AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=NatGkdY/ltZOqJ5k0mlz42taQmztHVybRbDv+c/dqZM=;
	b=tRjjDRa950ytW3MIbD0OMziJluq1Rmd0+8XL5W7EmfF8TdxIVjeQfEPdgblEcDGiKW
	ooAxq+WWrVEAoiQ8DjsxXJ7mxpdzrCE2yiOb7ChywijTT1JcSLHgqWWEVm7rr2xg8mQF
	OvZfli7YRsMCVLH0o8nKNdvM9ZHLPsLGgUvTqbAhksJUzbzWh4kHBIMeYfFIAngHzvdP
	01oWTxZVRB/PcvpTFw2h0gx9g9IDi1/RZe2U6s5GDPARYsY8HZbWXrbpaWjg2UnLmUdh
	jKWxgtj3tCYUrzyid9pw5EZWWgsFiYU4p09Y9K9nJqVvyKPIb24ObVOIRGMsry0X71R8
	ILUA==
X-Gm-Message-State: APjAAAUm1EDZ48g4+0Z9PQ4/pQgKC2ks0oNNDadbwG3MLgfXMOapNjBQ
	F6s9LZeOeP7SzmONo1iqECyzLg==
X-Google-Smtp-Source: APXvYqx9RD7ZJ4kmbKNE7+i5YGmpy0+jrZSgdUub9jAECwIaB3O06CYZgs+/FdE6gy4BCEIxQxrggQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr40336644wru.87.1559135045555; 
	Wed, 29 May 2019 06:04:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s62sm9571343wmf.24.2019.05.29.06.04.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 06:04:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CCB651FF87;
	Wed, 29 May 2019 14:04:03 +0100 (BST)
References: <20190528153304.27157-1-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190528153304.27157-1-philmd@redhat.com>
Date: Wed, 29 May 2019 14:04:03 +0100
Message-ID: <87ef4h5s58.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2] tests/docker: Update the Fedora image
 to Fedora 30
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
Cc: Fam Zheng <fam@euphon.net>, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau
	<marcandre.lureau@redhat.com>, qemu-devel@nongnu.org,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Fedora 30 got released:
>
>   https://fedoramagazine.org/announcing-fedora-30/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2: Added Marc-Andr=C3=A9 and Stefano tags


Queued to testing/next, thanks (right one this time).

--
Alex Benn=C3=A9e

