Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89F3C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7135D208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+z4QJX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7135D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqYo-0004ft-JJ
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:50:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqWq-0003bl-Ly
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqWn-0002jb-JR
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:48:12 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqWn-0002ig-Bi
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:48:09 -0400
Received: by mail-pg1-x544.google.com with SMTP id z16so8384536pgv.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=VIJuHIpKvUcVZ02vd5bDbLNfE3oPYwrTjUosQXqdGxc=;
	b=q+z4QJX3klSV1xNSkH39BeQr8SAGtj50yLYWLSD4EEMf1M5c8/FG8haYxS0JnajlPw
	bJwoS5AWOluIT9mU3GOZr/OZkj0J8ccTZ5kwf9BMF851C15fXSat0FKie5UxmkMqaMnq
	fN/8TmJfXZMt3ToRX2Ks6N3TcE9ozLT1kTKqyC7Lc/wb3XPJfB15+7Lsytia9zS2lF+R
	kANLZ0wXeaUkcSzjZQrEZGhdwgovl4KX4P0bp0burF4A8aRLqTpl5rEISdlmE+v++hxj
	fBbY0jvIbzM2+/SqtJw0I8r06RtCHxQnYBHZKETk3U/e7P7GuSk/tlinWB03Anda9yQ3
	9i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VIJuHIpKvUcVZ02vd5bDbLNfE3oPYwrTjUosQXqdGxc=;
	b=TQRovF8eQLAuU90S9zT+wljW/5f9XQcsPUuREh5jt5ofUsQxbUx/xbSGQzKUkXVIQk
	zFoiUuUnIhS7N+6ENO6+lTtf/dK9BlOmgxyfS4IpkIoonQz9s+zILeYDiwfShxYHAFgk
	SZjiMZcEPNNNMx1pAjXK99y3WbESpy9kD6qt9n58eRjdly0L+7k3Z/UZ6DJAOj15uMNM
	Rsb13n6tnJzV4TR3HwYxl+KnOWEWEQid3nMJju6bEA8Lg6M9OiTUbUnpmOrUXLLgcy9I
	jPFoYN6osOeZLpOPnhW2qxT/vls08BWEtJjHgNdQ4x9xXu+h+bAuOB+E7g14X3viEUIv
	6kBA==
X-Gm-Message-State: APjAAAXb7pDWzn9vM4uQoJ+uSuJOETlIVIc+00gmSfolFek35G3jn8Yp
	59J3iQNYW3UbYqZyomjGMfRdNQ==
X-Google-Smtp-Source: APXvYqz7f5M4TzcRsi+EpqCP1BW5YFxKG8Zj9d0zAxpREBHNspYjxza2DiKY/9XCAU6lke26FxapfQ==
X-Received: by 2002:a63:2c55:: with SMTP id s82mr73048706pgs.356.1556722088179;
	Wed, 01 May 2019 07:48:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	j1sm43885961pgp.91.2019.05.01.07.48.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:48:07 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4495b23c-99e8-d9f8-d408-fcd9aefeb458@linaro.org>
Date: Wed, 1 May 2019 07:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v5 13/15] Makefile: fix coverage-report
 reference to BUILD_DIR
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501144805.uWDzbcLJadUn204ujD8vAE_abE0hxXuLVihKwvlh-iE@z>

On 4/30/19 9:52 AM, Alex Bennée wrote:
> Commit 337f2311f actually claimed to do this in the commit log but
> didn't actually. Oops.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


