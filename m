Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE9FC04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8666420881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipGy0iiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8666420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTjFL-0003oT-Sc
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:38:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTjE3-00039o-7G
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTjE2-0006AB-6C
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:37:23 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:46716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTjE0-0005hQ-ET
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:37:22 -0400
Received: by mail-oi1-x229.google.com with SMTP id 203so3733130oid.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=BAHaU6CcqADINlGZlZag7tEHtIJm/qYWaLrdUqMUMjg=;
	b=ipGy0iiZZsItmRt5ADLruOeJKuOX0vXb/EltDUxoinsVBC+0a5sChnV7HgmsovpPkd
	QKfBVYUlSbL2XvujWoac+/c0rlm+AKso7+21KvwE3vJqIu7hUnzlI0+2OPyEjKOM3cHe
	eyrSfoZKWKWlBXI/YbIZsAN9CR7SWgVS5YvSCV12S5OfMie57Q/Dt4mm4+CDuIedt2dj
	KQw/OnLoFEMHmftItlAaUIW2CDhJn0cF7hTXZjLqzRXQd+HDFLPEU1mGqXi2wn/mCZtz
	vqouZHvUJlSfiFLjoCZrCqFLPD5mUWcbp8ZIeaBRvwDvZKl6MGlXHbnUBTj+ow9gNK6X
	3+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=BAHaU6CcqADINlGZlZag7tEHtIJm/qYWaLrdUqMUMjg=;
	b=ClM40HWgoUH15xOiXD+4XXo0FiVDUGtWH3QhJK/a2imiRLOWnoywTSr2UFAif4E7ph
	CrGj3kBaER2hdVND05Vg6b1iCfX8hAAVgAz9hjbzKFKY559+mkJpKM0p0KxIHy8zQxOC
	sDx6LxlgMQbdENL0M7CecIaBNTiBj+Ht+82sLFPe8UU/RED7IOpDqf54U8ZuV9R/1q4y
	KLg8QgHTOLJICZ9zX2Pjqm2tgAIkSjIsfWh0Zl0VbT9ZQjRLJlk1ZIHcnrAOhc7+c20k
	iIk3cOsqWk0hmHUgVJGnrBX0yMR4LGHzZgu4K4u0lfMew7DYuKFgELmsJjd9i77kIzXB
	lIKQ==
X-Gm-Message-State: APjAAAWmFf53f6GTSNdPXUB9k6nhEXDTQ6RA6f3apwKf+WSjPdkZNQpi
	P1hNnbMAx88xObNku0B6eMuN2tiU/dgUhM0wwTHrKA==
X-Google-Smtp-Source: APXvYqyffb0qAUmF5ulbJPlMhn/+wwHaSm7Vx4FC/9KRMUNZahpIFWqj1Knebw39b51NLX9Fkwx6Y9HuhGg8W04IVqY=
X-Received: by 2002:aca:845:: with SMTP id 66mr1984908oii.163.1558600633795;
	Thu, 23 May 2019 01:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
	<20190521092553-mutt-send-email-mst@kernel.org>
	<20190522150642.3da34e6b@redhat.com>
	<4b230fb0-ae2c-5221-39cb-1bed7b6df8d0@redhat.com>
	<9d2e260c-c491-03d2-9b8b-b57b72083f77@redhat.com>
In-Reply-To: <9d2e260c-c491-03d2-9b8b-b57b72083f77@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 09:37:02 +0100
Message-ID: <CAFEAcA8wMUrdH_-b38eWPRn-Qx1-6L_jZ2BRXH08MPUZbu9w-A@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 01:51, Laszlo Ersek <lersek@redhat.com> wrote:
> I have narrowed down the issue sufficiently that I think I can hand it
> over to Peter and Ard now -- because they know AARCH32 and AARCH64
> assembly, and "target/arm/translate-a64.c" and "tcg/arm/*" too.
>
> The summarize the issue for Ard, the symptom is that AARCH64 ArmVirtQemu
> runs perfectly fine with TCG on an x86-64 system, but it crashes on an
> AARCH32 host system.

Thanks for the investigation; this is probably more one for
Richard than me.

-- PMM

