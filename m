Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F32FC28CC1
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 09:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537F4271B4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 09:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJGYSPLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537F4271B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hX0Qa-0003tE-AW
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 05:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hX0Pl-0003Vo-Tn
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 05:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hX0Pk-0007h2-VA
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 05:35:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hX0Pk-0007eW-O6
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 05:35:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id f8so8048580wrt.1
	for <qemu-devel@nongnu.org>; Sat, 01 Jun 2019 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=eer2gU7Njkk/2flakzZQaQX21JoLyyIwVLLnnGnhZ+I=;
	b=NJGYSPLyxEWXp0UeTY+Ag7wnZ1IfhqV/EHAE47ndYBG+oEYAQ3c9SiH7nBGkS/Lp/c
	ln5rgxUoRst/YSfYjOrVmP4/gLllaIXMEwTcqEOgdzItCTHyCrT+WllH8vYVW/1JJ/zX
	R8FVTAeVK5qqPDRbmCTBSydnVdGbTaCRAeh/axsqOeWpKA3IAcWu9sTDiLY0LcBF5qx2
	Q0t+cUP1hp1BlfE7NDwwUOb8Okj3P6POd7zzV2g/+4iaLZNgocEmOGcjcnhU9SWp3Usj
	bk+Fftnfm4egPTUj9J4vy32JAijYFl9i3Kfd/ZJFY2vzgD9iV82ocnwPpI9OsEZKUZOh
	pkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=eer2gU7Njkk/2flakzZQaQX21JoLyyIwVLLnnGnhZ+I=;
	b=Wf/TCLZ7gvLx3hIFZsB1S9kil30q3lsJWZhiwN/ka/CyEg0Bm26J66+I9nBlIBAsS4
	2kOYQ42pjmIGExPlSDhpMWF0evq9IwIXZw8K9XDI0jcYw4qFU46d97B92F5aQvsLi8BF
	pA4zb3wNhcSFhLEFdS+/zCW2uQbcsdL4shMY7ZoDc0AQFO/Aq6yBKE50b5fSjXV5+yzt
	Ovejfxywy1L8eReBzry39zgVaRDIQUV4dybIYxC6hk+zzY8eUtmm/naiqgLnbTj3dkjf
	HPzX2ciejkdyTk9p+J+E4lWwycnMG20K7fbQVnvQz7s5WB4zGBwpYJVeB/5+c0mDGift
	Za0A==
X-Gm-Message-State: APjAAAVV4X3Cna0Gjn4KM12uIaB5tDw9NMK6VKzM3wXbYCmjVrK2mBk4
	l0ok4Py+wWpzLYmEkaooo6j8IA==
X-Google-Smtp-Source: APXvYqzg66DkTEqbYLbWC+eYOIwnSIa7izfxeCqTqsmBXD+Yix9o4uoYUkhnNsUhfzApapMToQ9MaQ==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr1662054wrv.329.1559381699162; 
	Sat, 01 Jun 2019 02:34:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	197sm8797252wma.36.2019.06.01.02.34.57
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sat, 01 Jun 2019 02:34:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5877D1FF87;
	Sat,  1 Jun 2019 10:34:57 +0100 (BST)
References: <20190531154735.20809-1-philmd@redhat.com>
	<CAFEAcA9TJGq-8fMv2amQEEGz9QKCNWYwJxCXrjqSh=Yc87yTww@mail.gmail.com>
	<947e851b-4b95-3126-2eaf-d5d16f8b831b@redhat.com>
	<431872249.25606899.1559321648368.JavaMail.zimbra@redhat.com>
	<CAFEAcA_KKH62rK2pbR8dWXOCJWe1X8wif5whc+y0_e-hTpmoRQ@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_KKH62rK2pbR8dWXOCJWe1X8wif5whc+y0_e-hTpmoRQ@mail.gmail.com>
Date: Sat, 01 Jun 2019 10:34:57 +0100
Message-ID: <87lfyl8x8e.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] target: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Miroslav Rezanina <mrezanin@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?=
	<philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 31 May 2019 at 17:54, Miroslav Rezanina <mrezanin@redhat.com> wro=
te:
>> What about CONFIG_ARM_VIRT - can we use it to introduce dependency on
>> CONFIG_SEMIHOSTING or is there valid scenario of qemu build with CONFIG_=
ARM_VIRT
>> enabled and CONFIG_SEMIHOSTING disabled?
>
> Semihosting is a feature that works on all Arm CPUs
> regardless of which machine model you're using (or whether
> you're using softmmu or linux-user), so I think
> the machine's Kconfig fragment is the wrong place to try
> to pull it in.

Although amusingly it doesn't work in kvm but perhaps it should?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

