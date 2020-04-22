Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B5DC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EC720781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl+BEv7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EC720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDXL-0001UY-DT
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRDWJ-0008NA-6N
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRDWI-00029b-Jn
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:26:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRDWI-0001xA-5W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:26:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id u16so1910449wmc.5
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ra52FAG13ucLbvULc6jzejkIs0yNh4EYrH0ae/i4wGg=;
 b=Gl+BEv7UPn8riuhxM22WWl3Xs87mcyT8LI5mOOR7rPqqfNM78ykcwnHBCb+/ytDzW/
 aqF/egLn603tXVQ9k75kme4U43U1a0WotG8+9wK24zU7jC6qZVbwDz5BcytU7Tii0jeg
 GAUQQPFEbxVR20OaPQ3fANMGmJKuMhWn3BWgbJhk0zqtGEDvtiVETj1uY4JEfwC7uaJD
 1twgdNMuu0BL58Wf1OpvZzJxJbTM8QKKZg4K8RYhCaxtt8Gqyj6FM7u5Jw9Spku9GVFi
 QlrFHKvTI9yfzeeF8uxsxDm/ad7ooVi8iWYjeUn5fT55SIzkEhK44rhVuTFAphswjRNI
 pcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ra52FAG13ucLbvULc6jzejkIs0yNh4EYrH0ae/i4wGg=;
 b=oLA3xLrwBOnGaAhJZBim3r/SmuYknvUY49X71+jMeEGumLF1kHhZ8wNj5q/mmNLQKx
 cim/q9c++1JOxiLTOmb9emeeOKVyVTS+8DXbm2fW2fGaRcdp6F0cL8OJYiAI4TSqUPdx
 d5+LJSwgBbE7ufP9djvfBhDUsuYv/Cgaeu3D8z3aJL1V/pZsAv1FniZSX++d9coBKpaY
 OkvPAKUNFnrC38/cpfyLjxbgyqrt912FMZxEUnNaoVslQXhrwQtAiPr7w3eveeVj0wkx
 dr0YPep3spgqXW+1iexxKRUn01f6ZLqQaJXlVHjx1tAPZD1khTcdpoENxDGJdcKRl5sB
 BtNw==
X-Gm-Message-State: AGi0PubMgA5YJrh5HvMrQ3gDNJCYhBB6VNkjKCRiOeV/e2RnUYqvIraV
 N6T/aM4ud4ZSoHrSgaZQEiWerA==
X-Google-Smtp-Source: APiQypJbrM2fMEGz1RhfILt18c1qQGsjycp1duqacxg9RHp0+TkmvjloajbLUBTPB3uvBhPBZjH17w==
X-Received: by 2002:a1c:f418:: with SMTP id z24mr2299619wma.122.1587554780125; 
 Wed, 22 Apr 2020 04:26:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s11sm7885395wrw.71.2020.04.22.04.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 04:26:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5BC3F1FF7E;
 Wed, 22 Apr 2020 12:26:18 +0100 (BST)
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-11-richard.henderson@linaro.org>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 10/36] tcg: Add temp_readonly
In-reply-to: <20200422011722.13287-11-richard.henderson@linaro.org>
Date: Wed, 22 Apr 2020 12:26:18 +0100
Message-ID: <87sggvdan9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> In most, but not all, places that we check for TEMP_FIXED,
> we are really testing that we do not modify the temporary.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

