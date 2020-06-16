Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA68C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF502098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4DPh2B8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF502098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF4O-0000NG-38
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlF3n-0008OE-6Q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:07:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlF3l-00078r-Mw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:07:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id p5so21538643wrw.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HsMXYP+KeBXPlRXl5pQV2QPoFZ2uwW33VsHKr2BDHVI=;
 b=c4DPh2B8KYZWXVtZLdnPSZYkT2KfDpjC2jZQDOHcv6LdjXXoOHMRYSUXqyGb0yzdtF
 yLIW8JbshmJpaCRVsx7KB80XgrBdeRtQlFM1JugGE5lQplIp6nXsGt9ctklda/Qd7xf8
 vhl9pzxn9Ki0zMLOGM8Muz0si+4Y09zOd+DlTnObMlUOnyr/cpcx5oU0t0z97yQ0NbBH
 jp6SxIx2rqJpcBP8pRkNlwXjurcCsUwi3tAwyQcL6B1qRl0NsHvB+g9BtRJRCRp/BvVl
 LoLY910K5B4C9cH5F55+KBtVIPwcun1Mw2FTRo3IR0yqKzkZHt4WjQQG8Nxex7VbYSVr
 JM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HsMXYP+KeBXPlRXl5pQV2QPoFZ2uwW33VsHKr2BDHVI=;
 b=Ad8dcspDhBe3M/C1d4OC47XqxLej8MjWEJnwwItINgLdxxkWspycrLu6lAZSF9et9n
 O0LhIUsh9BjaOsroDUxGfrDO2K6m+paMTJKEFAUF/anPCxmBTYQ/fNZgBoMXBbk03eEe
 6obHOAr9w6Y7HPQagnI/BQGILLhZIhHHkuPR00KOUiso1Xcv6qi5apBqSPS69mzWSv1Z
 PxuGbVJ8Ls8HEW2ogHz3BAnzmauMeVRXcQKJGxbiMh4SywdW65SdlLPNl39yyC+MG4Gl
 Qtuq+SRo5Z5nTK6+Vwz4a1swg19CNmqsvp3AG7W3kfZmrQHTt+ZprmVU9VTVKJGeYZaK
 dJ7w==
X-Gm-Message-State: AOAM531RI8Xa0ePT8WtJtFB1ehf0QRaROzH/EfAT269w+Sfv4yBw5OmD
 cYovWbglt7a8F5LGJtqseuRVNw==
X-Google-Smtp-Source: ABdhPJyabmRfYbAeRBjugvJOCiF7Glc2YlgROi0uSJw7i70U2SSdq1NE4RRbqP3QPq5qputIoR9Bew==
X-Received: by 2002:adf:fa89:: with SMTP id h9mr1180910wrr.120.1592327259684; 
 Tue, 16 Jun 2020 10:07:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm30561700wrm.57.2020.06.16.10.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:07:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08BCF1FF7E;
 Tue, 16 Jun 2020 18:07:38 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-5-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 04/15] hw/tricore: Add testdevice for tests in
 tests/tcg/
In-reply-to: <20200604085441.103087-5-kbastian@mail.uni-paderborn.de>
Date: Tue, 16 Jun 2020 18:07:37 +0100
Message-ID: <878sgnym5i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> this device is used to verify the correctness of regression tests by
> allowing guests to write their exit status to this device. This is then
> used by qemu to exit using the written status.
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

