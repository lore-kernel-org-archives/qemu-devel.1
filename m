Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D990C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4262320891
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 15:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoYBtvhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4262320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfso-0004Qc-QI
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 11:01:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfri-00024A-UM
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfrd-0002Sg-TG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:00:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfrd-0002RF-Kx
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 11:00:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id c1so9673922wml.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=dehFTAF4Pl2fY8atiaDoD4+qpew/Ir71ep8CuobcJRg=;
	b=OoYBtvhXX1mwnAPTwzxJEaJl8O514/dyavV6kHaLb0oVfG3sleXGQzaNaAHYfo7fuH
	hMmJq7DA0+RFPkSr/cF0nBJfUXa9wxEZIQWgT0q+O286oDxCHZilrQIZdag377EsiBQc
	E9nLbYnti6G8JpvQFsRZFdX64PYpi6QQ85dCxMnMPRLUC82HarCUz0Mi2l+tb9+q2UNP
	tdzRHkfFe5EKsVIW7Acy6bVuPTmkZnR1WGL3KRA+Ju8NTp3J2lFq30l5SvXgN2QF9lxB
	fbRyQXPprMG3eWmLSWQ7dbnvekO2sqkNUi0zWxLLInyVjA8w6P6G7DDsNjidFvGu/w49
	y62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=dehFTAF4Pl2fY8atiaDoD4+qpew/Ir71ep8CuobcJRg=;
	b=Hvz8WiFgDVrDiCkvMXhwnyzuZODzx8YZs8MM/AtD6DEMjQIhxq5VM3MZaY1bfSU6xM
	Yn3BqK4CymV6HwuEgAuDiIdprPotKaDb72M6pENnneRL1TJYpfBmPGJJipTBj9pnDD43
	5nDqvMZMOIEl9x1lPzXqAaVmexD3Q7/31WZwGIvB6+11AmvvJvdZxVGEaayi1SdMso64
	IUziWDOAk9ThdCnB/JuflrTte6gu0U9D2xMtukr2v6ysj8q4tp4olKQ1uSRr1pnp0r5x
	8v+1TaaM5M24hUVjIZXL6RoY5kn0DmzWaf0jW67ebA93z1F2j3FhWR/nFfnh3SvFwXS/
	Z37Q==
X-Gm-Message-State: APjAAAXJSX1bQta+wDwkNI7MXI6HFK/NO7vNm3OAy53T5ptAPcHPzit/
	wQNE55UH7Vhf/19n3Qfb+wJtgg==
X-Google-Smtp-Source: APXvYqx8X3nVu5UFL5E10NjACtZtahtUF/lPa5lXnUi+YEWuRDlgdTG4T24VL8SVi3VRla6rKuzNWQ==
X-Received: by 2002:a1c:4d04:: with SMTP id o4mr3991241wmh.126.1556204440059; 
	Thu, 25 Apr 2019 08:00:40 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	v1sm23394657wrd.47.2019.04.25.08.00.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 08:00:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E5B8C1FF87;
	Thu, 25 Apr 2019 16:00:38 +0100 (BST)
References: <20190424142714.28460-1-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190424142714.28460-1-arilou@gmail.com>
Date: Thu, 25 Apr 2019 16:00:38 +0100
Message-ID: <87r29quo2x.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 01/20] gdbstub: Add infrastructure to
 parse cmd packets
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425150038.OOMqFgcS06-t6powrxmHguSfsRlcmTQCE50Hy7fVZyY@z>


arilou@gmail.com writes:

> From: Jon Doron <arilou@gmail.com>
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

Multi-patch series should have a cover letter:

  https://wiki.qemu.org/index.php/Contribute/SubmitAPatch#Include_a_meaning=
ful_cover_letter

Overall this looks like a nice improvement to the parsing code. Please
CC me on the next revision.

I'm still curious as to what additional commands you plan to implement
once this is merged?

--
Alex Benn=C3=A9e

