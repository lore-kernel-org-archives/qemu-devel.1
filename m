Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E3DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A43206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKpg8+EQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A43206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtjM-00088Q-4L
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgtiD-0007GO-Ky
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:31:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgtiC-0004Xk-GJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:31:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so7050300wro.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hGzNbfKDc3cOU6vZkzZmG0vOKa9Dad0cHwXcYXHBvK8=;
 b=ZKpg8+EQl5hCGuBxWY6X0iZ0j7mHOJLfJSeJh2/8xWSktXJklojEmycudoDUYvGaKk
 dk1S54iYiH73CVtN8jRbxNVQFaXxNp4PVgweEoZYeVlgOxISs+SQPoCFlFLyrp3RpOKd
 JVwxRDbC8jP444wG3I/H7uoNgnlxUZghue80dT0U73Q2ir8b0L99o8GyNGl6LZrZqSzf
 ysEFY2BhigaACF+C2psp21NiUNAs4dbJKmMsciAm1c60FlAbuuv32Xp2pGkROzLDTatc
 aDFWFx+qwIMw2EryfuMwuNg4EkAxOEyinyCfiid/GXa39I31ktDO4slt51jY8HIMRjoO
 5dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hGzNbfKDc3cOU6vZkzZmG0vOKa9Dad0cHwXcYXHBvK8=;
 b=LZp5uvETb7hbXYODdStbcgUCL3HKPMko+nPhEZg787CtctVbisOhbYkOw5TfRbAYC6
 4Xy14Ihjaz7KdXrT3IYp98g5q59zKXawYure1bwOeSzdjGEQmOhFt5fPNV+cYdMNZPlU
 SupkZGV6oQw7lo8w73ySU/mR5mshMX2YUeYHv02JRlipb109ktjlBHkKG1uMqUB8Dy11
 Jw2CKniQoBI08wJvA7n+nNqXwuGNN/XxLPjWFzwYGKszfAqNX4+zZMCU7TK9FrZa+DpE
 ljudWXCFtpjkSxrjrsg/nCtlorqll336FUCmRl0r0hrw4wr6/jKSCvIoJ2+AAuiLKGJ5
 KdsQ==
X-Gm-Message-State: AOAM532tcCXnfY0E40t00esSjgpANy6806aqGClLC5B5SqXTysSn0qeg
 lBeXXwTM0rhb/uFXDCRzVCL0AA==
X-Google-Smtp-Source: ABdhPJxo2f+igeIKvE2rGnZ/16I/S/G7GTP3fvhilIBJgsAjlSB44CAwNVyKOLeTLVE3/nDU5mfLDw==
X-Received: by 2002:a5d:6391:: with SMTP id p17mr5873889wru.118.1591291886282; 
 Thu, 04 Jun 2020 10:31:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m129sm8752892wmf.2.2020.06.04.10.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 10:31:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 14F301FF7E;
 Thu,  4 Jun 2020 18:31:24 +0100 (BST)
References: <20200515144405.20580-1-alex.bennee@linaro.org>
 <20200515144405.20580-6-alex.bennee@linaro.org>
 <843d72a9-22a7-b0b5-0a92-edf1dcd290d2@vivier.eu>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL v2 05/13] accel/tcg: Relax va restrictions on 64-bit guests
In-reply-to: <843d72a9-22a7-b0b5-0a92-edf1dcd290d2@vivier.eu>
Date: Thu, 04 Jun 2020 18:31:24 +0100
Message-ID: <87zh9i4u1f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <laurent@vivier.eu> writes:

> On 15/05/2020 16:43, Alex Benn=C3=A9e wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>=20
>> We cannot at present limit a 64-bit guest to a virtual address
>> space smaller than the host.  It will mostly work to ignore this
>> limitation, except if the guest uses high bits of the address
>> space for tags.  But it will certainly work better, as presently
>> we can wind up failing to allocate the guest stack.
>>=20
>> Widen our user-only page tree to the host or abi pointer width.
>> Remove the workaround for this problem from target/alpha.
>> Always validate guest addresses vs reserved_va, as there we
>> control allocation ourselves.
>>=20
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> Message-Id: <20200513175134.19619-7-alex.bennee@linaro.org>
>>=20
>
> This patch breaks a test case in LTP with 64bit targets on x86_64 host:
>
> sudo linux-user/mips64el-linux-user/qemu-mips64el \
> -L chroot/mips64el/stretch/ \
> chroot/mips64el/stretch/opt/ltp/testcases/bin/mmap15
>
> qemu-mips64el: accel/tcg/translate-all.c:2533: page_set_flags: Assertion
> `start < end' failed.
> qemu:handle_cpu_signal received signal outside vCPU context @
> pc=3D0x7f0015f6e7cb
>
> Could you have a look?

Can confirm I've replicated:

  18:30:20 [alex.bennee@hackbox2:~/l/q/b/user.static] next/various-fixes|=
=E2=9C=94 32 +
  sudo ./mips64el-linux-user/qemu-mips64el -L ~/lsrc/buildroot.git/builds/m=
ips64el/target/ ~/lsrc/buildroot.git/builds/mips64el/target/usr/lib/ltp-tes=
tsuite/testcases/bin/mmap
  15
  [sudo] password for alex.bennee:
  qemu-mips64el: /home/alex.bennee/lsrc/qemu.git/accel/tcg/translate-all.c:=
2533: page_set_flags: Assertion `start < end' failed.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6c28=
c2

Also TIL you can use buildroot to build ltp ;-)

>
> Thanks,
> Laurent


--=20
Alex Benn=C3=A9e

