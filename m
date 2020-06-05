Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20802206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeHoL3nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20802206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhD56-00077m-CZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhD4P-0006C7-CD
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:11:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhD4O-0006FW-9j
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:11:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id x6so9865104wrm.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UGj8BSbD0th0MUKGjBtqZJU8PYtHeKPunfXtMZaEcq0=;
 b=PeHoL3nC6ynW0jc0f6mmRnzCqQiuDP9xn3mJlIcqNOX5OkgXtwNgk3+dYuWxx4Xjq7
 tqW6i/gS0YaxYBN/rdGTOQcGzXGdZ0Vr9fLF4xS+KCP4L0UcP9oDBw7EZEeDCXwO+XEN
 b+XLdbF9Vs/SLWfZmnICMK5cr5jl1SlYldmmnsOafa/Ds4T6IE4YdL4GNGNIz0nODvK8
 zDiXCBh+boVlPlqBpgYNCSnBtgQ6eSB23CIv8Q/NCpUwK6EK7wU8a17LGJrRbHObIkQH
 KYjsHRBVmEL9w9vVhDQEfKFU4syVT23ra/97uJpwM8kxmFp/9e76NIHfqeOdNsxuv2t+
 mnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UGj8BSbD0th0MUKGjBtqZJU8PYtHeKPunfXtMZaEcq0=;
 b=eraEZND1j0vR8QCniPXBaXbajOBaQVr+N83yY7dR2C8Xu/AkAQ3sehyQgg1NUZLT73
 H0nK+q28yYpzGGXonnR8RslhAgxBYaaO8XmpFRnFlE81ZVPAG+FpfEvcsM4GdMd78xUS
 +yup5+EaXKeMPFapIpPYXWl5LXyhZT0Q8HZPtRqRvgN3R8NrffWELKd+NjS8cDaSDYtz
 BtH9x5A9uBZAQIktQP6m24HB38moYaA4Vrj5Ufvh+DTz/S4gXWLL0HQ11Ee7M93lkKx8
 LXIyI3+o82U7wRSfB+YjvDWAJU1Kvliz0UBRj7IJMAh9kcUBeG640cwTCcK8xcegntH6
 isYA==
X-Gm-Message-State: AOAM53369C7HOPiPteKjw+6jSbqOwyOUjHDfOZhZSpuaZujWNuSqrhbM
 QAIy6oOiKKRe6oDXJ9OhWufh7w==
X-Google-Smtp-Source: ABdhPJz8xuhfk5h078JMcDoSr69gFa328q7RsW3OBsDVAog+FpI6dBHp0mKC7taBpAurJwkh7x7m+g==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr9452096wro.176.1591366298481; 
 Fri, 05 Jun 2020 07:11:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w3sm12283646wmg.44.2020.06.05.07.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 07:11:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9DBD11FF7E;
 Fri,  5 Jun 2020 15:11:35 +0100 (BST)
References: <20200515144405.20580-1-alex.bennee@linaro.org>
 <20200515144405.20580-6-alex.bennee@linaro.org>
 <843d72a9-22a7-b0b5-0a92-edf1dcd290d2@vivier.eu>
 <87zh9i4u1f.fsf@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PULL v2 05/13] accel/tcg: Relax va restrictions on 64-bit guests
In-reply-to: <87zh9i4u1f.fsf@linaro.org>
Date: Fri, 05 Jun 2020 15:11:35 +0100
Message-ID: <87h7vp4n6w.fsf@linaro.org>
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Laurent Vivier <laurent@vivier.eu> writes:
>
>> On 15/05/2020 16:43, Alex Benn=C3=A9e wrote:
>>> From: Richard Henderson <richard.henderson@linaro.org>
>>>=20
>>> We cannot at present limit a 64-bit guest to a virtual address
>>> space smaller than the host.  It will mostly work to ignore this
>>> limitation, except if the guest uses high bits of the address
>>> space for tags.  But it will certainly work better, as presently
>>> we can wind up failing to allocate the guest stack.
>>>=20
>>> Widen our user-only page tree to the host or abi pointer width.
>>> Remove the workaround for this problem from target/alpha.
>>> Always validate guest addresses vs reserved_va, as there we
>>> control allocation ourselves.
>>>=20
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>=20
>>> Message-Id: <20200513175134.19619-7-alex.bennee@linaro.org>
>>>=20
>>
>> This patch breaks a test case in LTP with 64bit targets on x86_64 host:
>>
>> sudo linux-user/mips64el-linux-user/qemu-mips64el \
>> -L chroot/mips64el/stretch/ \
>> chroot/mips64el/stretch/opt/ltp/testcases/bin/mmap15
>>
>> qemu-mips64el: accel/tcg/translate-all.c:2533: page_set_flags: Assertion
>> `start < end' failed.
>> qemu:handle_cpu_signal received signal outside vCPU context @
>> pc=3D0x7f0015f6e7cb
>>
>> Could you have a look?
>
> Can confirm I've replicated:
>
>   18:30:20 [alex.bennee@hackbox2:~/l/q/b/user.static] next/various-fixes|=
=E2=9C=94 32 +
>   sudo ./mips64el-linux-user/qemu-mips64el -L ~/lsrc/buildroot.git/builds=
/mips64el/target/ ~/lsrc/buildroot.git/builds/mips64el/target/usr/lib/ltp-t=
estsuite/testcases/bin/mmap
>   15
>   [sudo] password for alex.bennee:
>   qemu-mips64el: /home/alex.bennee/lsrc/qemu.git/accel/tcg/translate-all.=
c:2533: page_set_flags: Assertion `start < end' failed.
>   qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6c=
28c2
>
> Also TIL you can use buildroot to build ltp ;-)

I'm not sure how the change has tripped this failure but it seems to be
a simple overflow. The following fixes it but I'm curious about the
formulation of guest_addr_valid and why it's written that way:

modified   linux-user/mmap.c
@@ -467,7 +467,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, in=
t prot,
          * It can fail only on 64-bit host with 32-bit target.
          * On any other target/host host mmap() handles this error correct=
ly.
          */
-        if (!guest_range_valid(start, len)) {
+        if (end < start || !guest_range_valid(start, len)) {
             errno =3D ENOMEM;
             goto fail;
         }


>
>>
>> Thanks,
>> Laurent


--=20
Alex Benn=C3=A9e

