Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7EFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCFCF207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zw2x5gJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFCF207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugDe-0005lP-JE
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iudrn-0006ns-MM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iudrm-0003YH-Ms
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:53:55 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iudrm-0003W7-Hl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:53:54 -0500
Received: by mail-ot1-x342.google.com with SMTP id 77so2970070oty.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tkr6PqzEfQkA9K+1Euxc0bFsw2CSLTP4amowZdrc9SA=;
 b=Zw2x5gJRu+D6UIRJtnjH16kE+EEIWj4lWZQ8G4DLTtALB8Z6lBdZcCkJ36b3VLtjQm
 3DTunJ3AoTVt4CDRALAruc/lJfS2kxvu4wrlE9ddy+O6HYvkpoC2FfQQFa6aZSod9XGV
 IvDVA269eiwcmLcaSpI1fGlWXJzu/0KRCzjswWPepw97R3zyAk3F3HpQ+5pMsBZOaU8E
 tbatrfGfRMOx0vc6sgKpkmWD+vqVMGmaWBOOOeBsIjh3VTYdO4QpSkIEgaGMJZgdEhTx
 6DIHjBorMuf7MDJznLYbgseDg4PXytobKUELbxpxg1AgQKEK2x35JG84LBNt6DuWIN7L
 0HuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tkr6PqzEfQkA9K+1Euxc0bFsw2CSLTP4amowZdrc9SA=;
 b=sGc9rkIyV0Gmy1YfmpZP3vFmzj9zWWta5e8V8r6D/RAMXxf4mfvlP2/GekZI/c+/Mu
 tsjreGpm5Rmg0SS8F5iyWaNnXTOvGJdcmExtJEoPY3ZqWySn5YIn0JNTSqJWHNuIgzR7
 aTg3Vn65Z2SnFU5XHjNTBueQvv04P3xh7dc5zY8xb505mtya1ssg7FT33vLr1UemXcC/
 xFFwhQslhLX1AMg0USXOYQjwxYI3XUGk3uCeiTHgbnhU5VxcKF7RdJFmF8cq0hmAyZxX
 QI2eLjqWygTGcTWEVVN5ydluDt30/22RJva2Zvi59n5+DUJoV6xrbNtobML/SKBNIYs4
 XNxQ==
X-Gm-Message-State: APjAAAXBjLmfupeNs5Qgky248pDal1qlxKVI6oIkFscu5Ffjeoi3g5s7
 M1Fyt09WbueLVMQH0gvy51kSQ3xw9PsmgaA0Rqcrqg==
X-Google-Smtp-Source: APXvYqwulAlc4PotKEu5zavoZBGCnP6nY0JOaEmUS2r1QnrhB9T8XwHYsB3sdSX5aBJX4p3YPoHiSjCS7Dc0OohtWXk=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr11567446otq.135.1579791233683; 
 Thu, 23 Jan 2020 06:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20200120101832.18781-1-drjones@redhat.com>
In-Reply-To: <20200120101832.18781-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 14:53:42 +0000
Message-ID: <CAFEAcA9+amcwA7WGzXxc2Cb_J7-=rxFb6ubk3ZYn-Y+zWoWk4w@mail.gmail.com>
Subject: Re: [PATCH REPOST v3] target/arm/arch_dump: Add SVE notes
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 at 10:18, Andrew Jones <drjones@redhat.com> wrote:
>
> When dumping a guest with dump-guest-memory also dump the SVE
> registers if they are in use.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/elf.h          |   2 +
>  target/arm/arch_dump.c | 124 ++++++++++++++++++++++++++++++++++++++++-
>  target/arm/cpu.h       |  25 +++++++++
>  target/arm/kvm64.c     |  24 --------
>  4 files changed, 149 insertions(+), 26 deletions(-)
>


Applied to target-arm.next, thanks (I fixed up the checkpatch
nits).

-- PMM

