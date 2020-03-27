Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D706C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD890206F8
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 11:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1vTOSDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD890206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHnAQ-0000gD-1d
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 07:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHn9m-0000FL-2F
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHn9k-0004F9-QZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:28:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHn9k-000490-BO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 07:28:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id s1so10974915wrv.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+MQlhHHtZMxd1uEsPh6C8GgEnascv17sukYde5tR1es=;
 b=v1vTOSDJ6fT1JkaSQaG1Sx5c+QpftwEhfNtnUc95Z68YjqQGiw9oHsrJatNELHjSPZ
 FmnYPl6pCRSxtLX6rD0j9p0Ucrhp6gbIV1rvviKXprSEEZTPJrg2JjTJfms+/yLdyuyO
 03v0EykeSsAZikmpKw8F/SN1tJP848DNw3D0747KCllWEtXIVkOcomi9fCvTScH0Ovgc
 1owhUtY1tdVKbGpLwgSiT6UqkwtyHIelflKwUHlvUfRegPbF3gwA59qE8x5WVQmUqqqR
 f42tqgyEeYshTHxoEea44YlhgLtioO8hGBGSsqxlBB0vg/2AAS+joP/Chh+Eb9bJUoyH
 M00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+MQlhHHtZMxd1uEsPh6C8GgEnascv17sukYde5tR1es=;
 b=TkTddQar3nr3ZiV1F6uuEsujxgokSMRZjrx1PLJjiN38f77IJTSmspiCfHplThqL7w
 QWDBXBCASC3w1PDcrQ3bgkOpfibkImqouwiR+7F5bM5WF7eb8vo18h9X7u3XJZl6wQTs
 H33kdQ/NFFRj+57RH42wYkRKvlq+n7oAs8d1ySLBRNKvtFkWgGQ5/hFnuNQemd1HN9sW
 kglIm8EUTD7Ko9q8sRX/WoXwK5VJ8HxajkeFFl9+TJ2JR6OS217XRGSE7PSQUKDSneK0
 OfNMoUuoazCgeIq6Mw7KHSEWk5jdFUwJ31tdo0Fkg9M1BwyklFBBE0cb7uRWBHdPbyXH
 7w1g==
X-Gm-Message-State: ANhLgQ1uwqozFTjVSDMfPRGEv7zfQUA3q55vbofDgI6bTfZ1zl5I7/VT
 LZdlz10IJ4n+YSQ1R9U9sPorMg==
X-Google-Smtp-Source: ADFU+vu3zIsS/t/hSQ6zwIWJW1+Kbq/bNBy88bm2N702gGeytYrdnd8fUM/X2L7leWRShwake03SHQ==
X-Received: by 2002:adf:e744:: with SMTP id c4mr4771805wrn.133.1585308486723; 
 Fri, 27 Mar 2020 04:28:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm7680297wrc.71.2020.03.27.04.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 04:28:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B0D41FF7E;
 Fri, 27 Mar 2020 11:28:04 +0000 (GMT)
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
 <20200327101600.GA28583@Air-de-Roger>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
In-reply-to: <20200327101600.GA28583@Air-de-Roger>
Date: Fri, 27 Mar 2020 11:28:04 +0000
Message-ID: <87sghum3zv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?utf-8?Q?Daniel_P?= =?utf-8?Q?=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Dimitry Andric <dim@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Roger Pau Monn=C3=A9 <roger.pau@citrix.com> writes:

> On Thu, Mar 26, 2020 at 09:56:38AM -0700, Richard Henderson wrote:
>> On 3/26/20 6:43 AM, Roger Pau Monne wrote:
>> > lld 10.0.0 introduced a new linker option --image-base equivalent to
>> > the GNU -Ttext-segment one, hence use it when available.
>> >=20
>> > This fixes the build of QEMU on systems using lld 10 or greater.
>> >=20
>> > Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
>> > Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>> > ---
>> > Cc: Laurent Vivier <laurent@vivier.eu>
>> > Cc: Richard Henderson <richard.henderson@linaro.org>
>> > Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>> > ---
>>=20
>> The Plan is still to drop this whole section of code.
>>=20
>> However, it's still blocked on getting the x86_64 vsyscall patches upstr=
eam.
>
> While this doesn't materialize, could it be possible to get this patch
> accepted?
>
> This is currently blocking the build of QEMU on FreeBSD HEAD, which
> has already switched to LLVM 10.0.0.

I think the vsyscall patch has just been merged, however way I don't
think targeting HEAD of a OS release during the rc phase is appropriate.

--=20
Alex Benn=C3=A9e

