Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4FEC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23667218AC
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyTCee/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23667218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIux-0007fW-SG
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iIH1h-0003BJ-KX
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iIH1g-0007ad-8s
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:49:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iIH1g-0007a3-2G
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:49:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id z9so4257816wrl.11
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=X9WSqh8lzF1/ZGPdlYYplziYGw8NTu0WSOvsFIWuniY=;
 b=EyTCee/Ta3sMkxcw0bZzwOJoIKCF0Il+roHHD0a0hsZWJAGNPNL1jgQfST/fXU1PWh
 KKi14LHTQKf46HjYwWSbZ9Myw28xJeHB4W7xLtGe9VVSK9IdzVZoulJJXkECtLSwENNz
 HSUEvPekI+zFQUP/bbFqByBFrdqiVLwdmd7swdK9ATtnPkLNtmKmFa1k1cfsbIfFwhZd
 1FcB3rWPmbcBwpshWpUdKNw2eBXMIIbQah7/mvqbeJHGBdeW+OAxZd+VSZzZFbuGvrjZ
 nRpqAcIVP2FvD6LSOPR8bhm6DAZbT4SXFaBZaOYX/Sy3TaNglOQLIMvjJPwO76Wi0ufc
 04OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=X9WSqh8lzF1/ZGPdlYYplziYGw8NTu0WSOvsFIWuniY=;
 b=Zn+47TBBr7RC47mQuczLj07qkcksWDFTf/BX0iEP6w2319jiJd4xK0GFVgYl2jgavt
 jJG3MnT12LHZrJmgaHk/vrvUD2lJouKlkYSXXiWqELAUqCqG4tALhxjMOGUZYu0CZbdA
 lEz1+8Sd2bMDQh+dc7WhDslLy4oclps3JNkHXUukSi68h2573YmWxinf1nXxIcj1yxAD
 EOGfWfrgVTu5Lc7OMAc53RZp3K56L/rkD2wIr5JQQ8UVJtofM2LZcPi6hx+DAEYA+bw1
 ajBPdejb8i6xHrbDCxHDYpKGyIqzjC0U/Vz+xF+v1y8zr9wOtu48+5CdabPNtLCVYwWM
 dyBA==
X-Gm-Message-State: APjAAAVfZPctQh28MNm9YlIdJskZjKohPgN2gClqKcYcGpUroKpUwjua
 deogY2B3uJnozIAqPWpBwnms9w==
X-Google-Smtp-Source: APXvYqxDkr+f96MVD1mR24RFYdBX9WBO0YFQ2cTP/y7nvO09u549wxHn6l4nySb+af3QVQZrnro6/Q==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr4071842wrs.37.1570646969809;
 Wed, 09 Oct 2019 11:49:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r18sm5083061wme.48.2019.10.09.11.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 11:49:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 65CBC1FF87;
 Wed,  9 Oct 2019 19:49:28 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-51-alex.bennee@linaro.org>
 <20190801143141.GL5034@quinoa.localdomain>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Subject: Re: [PATCH  v4 50/54] tests/plugin: add instruction execution
 breakdown
In-reply-to: <20190801143141.GL5034@quinoa.localdomain>
Date: Wed, 09 Oct 2019 19:49:28 +0100
Message-ID: <875zkxn493.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "bobby.prani@gmail.com" <bobby.prani@gmail.com>,
 "cota@braap.org" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Jul 31 17:07, Alex Benn=C3=A9e wrote:
>> + * Attempt to measure the amount of vectorisation that has been done
>> + * on some code by counting classes of instruction. This is very much
>> + * ARM specific.
>
> I suspect some of my plugins will also be architecture-specific. Does it
> make sense to have a plugin specify to QEMU which architectures or
> running modes (i.e. softmmu vs. linux user) it supports? Or
> alternatively to have QEMU expose this information to the plugin so that
> it can cleanly exit if its needs are not met?

I've exposed an information block with the qemu type in it as a string.
This allows the plugin to take appropriate action.

>
> -Aaron


--
Alex Benn=C3=A9e

