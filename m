Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD59C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164A1206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfxAZ9n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164A1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0IQ-0003fp-74
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jT0Ho-0002zf-5X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jT0Hm-0006GA-Le
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:42:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jT0Hm-0005zW-7W
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:42:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id e26so18785215wmk.5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=k97sNWzU0RUQ8HcGwHD7exutFNaktf7X81U7Sn1Qaz8=;
 b=vfxAZ9n6GyCCEBlkyBb0DkFkESFNehVBODGXPz17lf6ZiXV/ZL4h3Fp1fcF5PEE8fm
 7avTXo5Err2S4bbUVssbTw573UoW+sOO4BVwZkNkQTYv8278o3mdNn7phm2TTwSkwcEI
 1uWeeoPanBmm2KJx7ZTHNZ2jgGwdodd1ImL3jH7+LY245YGLHyzOL4CitHqnP0iPcun+
 C8+o6B/7Oarx3r/oJYnVPzNED8My2k6GpEipxLgHTAzi0062101eJEXq+IkkttcSmIUx
 e9UzObA9ds8jVw1WMjwnS7TUTA6UJcjL06YxD15LJuDOqQOn2TeKeq9G2qZO0hhfh1Zu
 WkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=k97sNWzU0RUQ8HcGwHD7exutFNaktf7X81U7Sn1Qaz8=;
 b=mK2ijGUVna4UVhCkwwpVVxTlHX+6wONXZmp4LTQjwc42P+TPr1nZBA72vK6KO7z70m
 DqqpDYLUKT/PeNWUqZ7bQfAUlMZJB6wrZLOwJS+1941wmwEq+cJr79fd10C5soNPi3Vj
 iLFj7F6/pV2R8CQBxj/QSwl69L9zGbMzul+ONmUuIIJlfDKzRN40ZsPak0tbCIgheS+6
 3c9TW1z2fx+Rtty4xAkt6ltnx0oS71MASl8LbR76XIMJ0Be8VHF8BGc+wQo3q2t9EHVJ
 9JZgVjCwKjlrXYSJjVL1kgLbm8/1BvmUsDV5PDdRYfxiNVMtg5HU0lbCDpQxloxqO1Lt
 ktYg==
X-Gm-Message-State: AGi0PubsmY4L8SkKz9WQzWrMc7Ni1BR3K2ZEzYiFanMCMhio6yuunyZp
 ts5AsWm8SRXIARKVMsEiUerpXQ==
X-Google-Smtp-Source: APiQypK+u4h3WJP2VO8XRM+wZU3KD5xiSZuELeC34LAH2KxauhWE4DeO+m4OjRqidi76d13xv3C6AQ==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr24619073wmk.120.1587980563697; 
 Mon, 27 Apr 2020 02:42:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h188sm16121265wme.8.2020.04.27.02.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 02:42:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C59FC1FF7E;
 Mon, 27 Apr 2020 10:42:41 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: About hardfloat in ppc
In-reply-to: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
Date: Mon, 27 Apr 2020 10:42:41 +0100
Message-ID: <87lfmhl0xa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> Because ppc fpu-helper are always clearing float_flag_inexact,
> So is that possible to optimize the performance when  float_flag_inexact
> are cleared?

There was some discussion about this in the last thread about enabling
hardfloat for PPC. See the thread:

  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
  Date: Tue, 18 Feb 2020 18:10:16 +0100
  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>

However in short the problem is if the float_flag_inexact is clear you
must use softfloat so you can properly calculate the inexact status. We
can't take advantage of the inexact stickiness without loosing the
fidelity of the calculation.

--=20
Alex Benn=C3=A9e

