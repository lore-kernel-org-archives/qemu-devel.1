Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CDDC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F7D2051A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 19:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FykcvsuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F7D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyh1D-0008CL-8l
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 14:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iyh0S-0007lG-HV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iyh0R-0005YE-Hb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:03:36 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iyh0R-0005T0-8K
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 14:03:35 -0500
Received: by mail-lf1-x141.google.com with SMTP id m30so10455284lfp.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 11:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CBX8J6cOZPN3S4r7anZv7gsXHdZuj/QP/4vY+YGBCwQ=;
 b=FykcvsuK9V1q+ubE/lmUibmu7aJYr+uf7FydXWG82ODlPVlOs0LfpW8r3q9oT2fNpc
 9uMyOKhxQMKp9fb/F/noifR5xZv3CDFWh4HS+VnjAad0QjeT0Dc/dTIejYcRvzTrSAcG
 IykbZyh0+vfpHatScEAssg4ZtM/qwg2vNwahZoVXrpQOVzLrlaK7BNsHYGg9wAgoBmMS
 HKWylUMAmvpxXvEV4cTjN0NYv18DoEImjYWrmVLoRK0b5FyXzJhnCWoeH9hv/ElVgxfE
 8qRdcA7b76ra8toBuk+GWG+NG/jWwwAgCpQlVjSLqtZKco9AZXZPS4ehpJCx9kpu9gzm
 PWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CBX8J6cOZPN3S4r7anZv7gsXHdZuj/QP/4vY+YGBCwQ=;
 b=it075YoxQ56GDKA2oWnXBRsmg2FhtgBAWoE7FSAhlqD4L5WMZMWHcND5TNPjrZvw7A
 k6+wXlH17/JCqT+bN+lKo+6nlE5jzyvfFBLdtnAw9VcsxZoXW+Kpu24lwf3gNR52TnGx
 DgKPVrXohERjdbL/9rmylELnrJyOy8uKP5Ba62EvMTDeiP5DnPY7HC0OZq1itxQ4G3kw
 L/CCI520MUuGYC86Q4Ewx55zxGYAaajBBAxuV5U9dOLT1GJcwKkPm6PghJ6cjrqdDMQp
 wHGi64LKlIBEYmrhPHfthPRtFhVZag+Sie+JcImLoKFz3w91S2p3XvsrbdiM63VAg5DT
 5SeQ==
X-Gm-Message-State: APjAAAU9U/biaA4Dc2wGfT8tYULtjEqqK7c/gyojE1eaMQtiE/SCg3CL
 GOa6J4sUOR8Yer3bT7rPzUSkGrDWSqZcpCnukHZ6jQARBk8=
X-Google-Smtp-Source: APXvYqyDvIJWW6wEpp8okS7V8nvJkS9eqDsSjhPbUzExBGC+sb2ZNmIX4aOVzvbLlOyYnXecpQi2Avy/EuAiAil2ov8=
X-Received: by 2002:a05:6512:1cc:: with SMTP id
 f12mr13095075lfp.128.1580756612973; 
 Mon, 03 Feb 2020 11:03:32 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR13MB2455076A60A04F532838EED580000@BYAPR13MB2455.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2455076A60A04F532838EED580000@BYAPR13MB2455.namprd13.prod.outlook.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 3 Feb 2020 14:02:57 -0500
Message-ID: <CAEyhzFu8Fyb9chNgOvLn2p+b7N_jskRz=H_LQuiqwMu01899bg@mail.gmail.com>
Subject: Re: [PATCH v3 02/17] tests/docker: better handle symlinked libs
To: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 04:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Subject: [PATCH v3 02/17] tests/docker: better handle symlinked libs
>
> When we are copying we want to ensure we grab the first
> resolution (the found in path section). However even that binary might
> be a symlink so lets make sure we chase the symlinks to copy the right
> binary to where it can be found.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

