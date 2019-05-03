Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A721C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2C72081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWjlmBpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2C72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaPP-0008ED-K9
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:47:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaNn-0007Pk-68
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaNl-0008F9-47
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:45:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaNh-00086D-Cd
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:45:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id f2so2352721wmj.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=tNYEhLXkJmD/D5J4aI83NRW1lqtc8rwfgSVbpOUYQ74=;
	b=zWjlmBpK6Heoa5mnQiEXc5vjac/nl0+eM1UQMXk8D12zu0zZV7gqw1piAh1avSk7fw
	bS5I8m8KnEBriWwWPVUBzFQw24gyO1C7PDaJBTcaexbF9LZyFUrrCLpIHGsJ6z4mLnxu
	cZhFgpOOisBf7cqMsTtd8/A1Odq5Nqi7Xn0s/iZsD5v4IbKUMXxCNzHXRaNfPq0TQcyp
	vFIDSaQTG0WwJU5B0e4jrPaDZA8mNC5StHvyIhgfg9HfcnN9CMC7WKVFrFEt7/e1L2uN
	9xYp4yhWLH+9HgptSeBY9GtqzTS7pk68tn+SmrFmEuotguH3GSDokb+zOqOz3dJtt9+C
	SG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=tNYEhLXkJmD/D5J4aI83NRW1lqtc8rwfgSVbpOUYQ74=;
	b=GEqdGEdZpUYFQ6SeUHjFjrstgmEKSJVMeLkiq7m7WlRet/D+Zr0hB3j/3NESBDOW4Q
	Xt+ZKsFXJTJn5CKUhYOv+ZWTmaxxBRrt6sj6Od5kEXMYAXWt+WFZ22jnOpeLE9nDGqfy
	naxWFV4xSmQw31Y1+sESFtEGt2OLYjnG7KinEEoiWD1Hk96KQCTsGAtUrf/0NZEKDe2g
	qI1LbLDyg+UhCVK0eAlmBN6kBqkkCcbtISY41UmR2uDpdHeKa6qQA4WspCs3zkrlba8g
	MgLV+FjsQAB/LhmTIrtgdhnzxiGgRNUfjF6JfUq5dkO1urveqbESt8hb+9A8Qkqhcrzx
	w3uA==
X-Gm-Message-State: APjAAAUt0LuL3cS2eSAdEreWCFlubwdF8gf1kVoRVC23Iq+8k4QdiY5P
	C7T+YY32dmp8xi8qla0RVudhFg==
X-Google-Smtp-Source: APXvYqw82VBhpoSRgSyhrxiOdxbSWToT4jN2GRNzEETXzkx3rfYTrQXqvWsYyDCOwpxQkG2LBBnEeg==
X-Received: by 2002:a1c:c788:: with SMTP id x130mr6889285wmf.118.1556898345640;
	Fri, 03 May 2019 08:45:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b184sm3519957wmh.17.2019.05.03.08.45.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 08:45:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 8930E1FF87;
	Fri,  3 May 2019 16:45:44 +0100 (BST)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-4-ysato@users.sourceforge.jp>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190502143409.59600-4-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:45:44 +0100
Message-ID: <87k1f74k47.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH RFC v8 03/12] target/rx: CPU definition
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503154544.0_XPY7nF5U3yJIlnL54XueYb8vrXY9P4cyQbGnBPUJk@z>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
<snip>
> +{
> +    *pc =3D env->pc;
> +    *cs_base =3D 0;
> +    *flags =3D FIELD_DP32(*flags, PSW, PM, env->psw_pm);

You can't reference flags here, the caller expect you to be setting it's
value. Otherwise the compiler will rightfully complain you've just
accessed unitialised data.

  *flags =3D FIELD_DP32(0, PSW, PM, env->psw_pm);


--
Alex Benn=C3=A9e

