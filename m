Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2796C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE352173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7AqDkqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE352173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kOy-00032J-Qh
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kO5-0002JF-JE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8kO4-0003eA-J7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:41:33 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8kO4-0003di-C4
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:41:32 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so11019282wmc.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Y18CsOOMaOHPkI+ohzeYI9YcP17yQSLbt1d7wtpVxFI=;
 b=W7AqDkqFntcG1GW4NW/Mc4p7NsR/M1rn7kVhsGou2SxD/3rpZKtCCD2bHfdH5wxe12
 2jKoK+AMSbSGOXt0GCt0VnHuAnAxjDwV0Z7UUc/HDGQjJjk/8JJq2jgzfkSO8tgXrsaB
 +rMfv55zXBKSHyCzF8OBKDAg/jAm/3NV5Q4MRPuv37HhuPfjQuMCcsqKC9MUVCqwiKM/
 43wy5kERmBhc0il0JAN0fFg9Hgz9DDoH8462tRhwvfIdPmAAEXB4LXzKdcz4CS+b13Aa
 lo2TsQquPC6FxqXkXwU91ht1lkoUHYHbmH/81QYY0jCDtdC7zj5ejpavhgZOvA5irm71
 JI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Y18CsOOMaOHPkI+ohzeYI9YcP17yQSLbt1d7wtpVxFI=;
 b=eqcGOJBw67qTJ+MaqD29p72WSI9ZwShCxymVEYJk1x2Zg+jvTDKkYEWB9uCrfVy45T
 M/ZdqX4YlNx2OF3JxGmhLd003tNCK2VFlDjkgkx7jO6GQYCp6UF8Qv6sw/ym9t57R0jU
 ltKwP6s7oyQQJhILWmmGXMIRJ0gAuo2EvSVbUItoKkhLmJ9HnWmtZopJi4znk4AeFS7p
 D/GMMqYkvdXbb0ESeTsZsNlxnlJeilz71bbJwzrQJIk5IHOFMIX0unAJjXHiqtNs7hik
 aBJSTN05aAPdPZk0wClO9mK/UPegEWdOr+omjafK8Q6GXwbVjEP0ieVdghg5MDiK3z7E
 iHEg==
X-Gm-Message-State: APjAAAU+aG1FhClMRcTJkyPWTNWbVQCw4VqBOcxvgAXS5zWND5p8+K8v
 8DRpRumoyx6Svhd99QEzUxDX6w==
X-Google-Smtp-Source: APXvYqzIJPk9zNZSOsAESNsMaOGY1gHLOWjw95NJ8gFUVsoGV2lPrStTeLpWTg+Y8+1LCbj4lLR38Q==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr18662517wme.23.1583152891004; 
 Mon, 02 Mar 2020 04:41:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z14sm28035542wru.31.2020.03.02.04.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:41:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 122761FF87;
 Mon,  2 Mar 2020 12:41:29 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 00/33] Convert qemu-doc to rST
In-reply-to: <20200228153619.9906-1-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:41:29 +0000
Message-ID: <87o8tf7wue.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Hi; this series does a complete conversion of qemu-doc from
> Texinfo to rST, including the hxtool-generated parts and
> creation of the qemu.1 manpage from rST.
>
> It's marked v3 because it's a development of the v2 that
> Paolo sent out earlier this week.
<snip>

I should mention the whole thing is:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

by virtue of my custom rtd branch:

  https://qemu-stsquad.readthedocs.io/en/doc-updates/index.html

--=20
Alex Benn=C3=A9e

