Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45DAC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E4C20644
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2ZMmBSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E4C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbQ6-0001g4-SR
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 11:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlbPs-0000vc-9p
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlbPq-0004cy-7K
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:55:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlbPo-0004Uc-Gn
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:55:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so6919308wru.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iuhittMExTkGJFQcOQ8uMsERN/IsCK564e/XwqIFuKo=;
 b=D2ZMmBSfvBxPkNoPEnR2L1bEBmBCBXSyAIOPXoeMOGUdIDaiShl6OVeyLrV+cDXAuE
 Z0jBaoaq45hmHQGz/PSt2+W5ZGcbL7bzp/aDPh7cIuDPkUmBxx3raNqUvg3+oVLg2B7z
 e4khloe+ZkBCO4+SlkHpe1e02x/LZdonANJ1l7g6vK7g968CsB5E4BphlQjoiaqy+8Fo
 BkP9PtXStQiF7pET5nLU6aRUlpLoNGtEWTutEuzgqXmb6zHvuzHQ61wVwSgJf6AVrbXk
 /afWqZ61GKFl3slNPMpvTuhaOdd1jYONs6z41Fa0EPCZ2ylYzt1z9jDzzgLO9Rlcw2Gk
 LDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iuhittMExTkGJFQcOQ8uMsERN/IsCK564e/XwqIFuKo=;
 b=DFcy1oLkGgZr5g7Md6xJj7/RQHqR5q3lJ91aHqt6KBiZNxwxj6CoWprM9yhfucMKY5
 ZPbi+Tc8C4SDvh5ZsnHV+QPmjkSjHwzqGGt/MTdcMA3fimgfseQBD9yxOc4jlrwwcE5I
 elhXw6qK1OX80NB2BmD3walxvIRui4W1oqLDL8oCC4x1lTF/ZTnateFyKJjTS/5kplkX
 zE4g9A0wFKB7nJC4an7TeiGtatQbJcsci8JEbFUTYhrT4aoRx2q21w3mxlygqjTfrq5Q
 mISR2fNRun/AneZJzo8wLwLBX+P1tbBm2Gh913sGfp8IaqCRipkuwO6jaksWuP+mhvvK
 DMow==
X-Gm-Message-State: APjAAAXUBfU/iNMIVG4KmwOBlmwUfen1kpTyEnnibSm5Ks7o6VUcSeQa
 BGV/kTIB0MZPQ0ir5Gp+8aX0LzJVyl8=
X-Google-Smtp-Source: APXvYqwTth/VkRoPsKZd7fTjvekBpnX5o3BhUYBRYrFfiTgkPwObikeMEMDav+uoIbBZauwVXPlW1w==
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr6124554wro.33.1562860521828; 
 Thu, 11 Jul 2019 08:55:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g11sm6802164wrq.92.2019.07.11.08.55.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 08:55:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF7231FF87;
 Thu, 11 Jul 2019 16:55:20 +0100 (BST)
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-3-marcandre.lureau@redhat.com>
 <b6823a5f-658e-19c9-6bb4-559a12517a66@redhat.com>
 <CAMxuvay5jPM6AnsZtLYvVB+nb4nopGnRP=BWxUctA1aZNaMdog@mail.gmail.com>
 <d8e76f7d-a96f-3ed4-4c6e-d9ad48b5490e@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <d8e76f7d-a96f-3ed4-4c6e-d9ad48b5490e@redhat.com>
Date: Thu, 11 Jul 2019 16:55:20 +0100
Message-ID: <875zo8efbr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 2/5] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, debarshi@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>, Debarshi Ray <rishi@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/07/19 10:39, Marc-Andr=C3=A9 Lureau wrote:
>>> Why not do this in docker.py (either as part of patch 1 or separately)?
>>>  Also, can you document in a comment why this is not needed with docker?
>>
>> Doing it in docker.py would probably mean parsing and tweaking
>> arguments given to Docker.run(). Since it's a "temporary" work around,
>> I would rather have it at the top-level caller, in the Makefile.
>
> On the other hand that splits the choice of docker vs. podman in two
> places, and Python is a better place to implement workarounds.

Yeah I agree we should move this trickery away from the Makefiles.

--
Alex Benn=C3=A9e

