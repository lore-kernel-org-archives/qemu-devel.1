Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23C12075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 14:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2y+Qh3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23C12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYru-0001XG-2m
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 10:08:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYr9-0001E4-Py
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYr8-00052e-OP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:08:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYr8-0004yy-Hw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:08:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id g8so5374554otl.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=4cgU08O0eqAtwzGynPIDBDEFFxmGG4D0pHCJ8lOJjrg=;
	b=q2y+Qh3y3eQDw+/jWLZSqEEq4ifSEB76a1czL5W0j88K3F06YD4/kf58aDLi+4c7oL
	cHcMZjhaNRKv7hrQAHQKVNHCzvyJfcwSjWrLQ7MvoI3N/TY3YtrVlpDx0CpXx1G4Pa8K
	npbZV5wm2nmZWwzqksWYVMX2ZgY5R5oibfa8SBwQNdMmDqwrRpSAq/Ddbf/EQnP8l5rP
	1+Vs98VvPfRt+JtQup3iE4p4mUapO9PPqJLdiiU9l/8ly/uv5FOceUpHovjiGFqS8HeP
	VUE05m8orXbHXFiUQJopXPvAca2/vVJ1I3RocaFKA2kt3xc8FcVRoQOlroOubAke+zb9
	IoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=4cgU08O0eqAtwzGynPIDBDEFFxmGG4D0pHCJ8lOJjrg=;
	b=kpMu/Y63tuXLNOFHpgY/ls8TIBn4isZwM71cMB5to0XIlUnp2PQLAED6leYXH3dZdz
	xPJCIWBAGqcW5Kh4a1J+JT+ZXCR7bl44sU20gvrvvFy30ID3ual0dDX9Ou9BqZl4x2qX
	HIBPv1pk6QFkRxUI65xqxPiD6WTnZhnkZym8PkWlRlM6urUbq/rzCamuC31QXQoKaaBH
	G7Hw4lp5A2QatAb6CaFTEn9xk6H7ymtfWBw0l6+X2V5edxcaQqPL78A7f3/xbPzh6PM9
	k/r8eFE452g1FlX2/3IhMCzo/yTQxLdNnX07bKDP1P5G9vePVozFUf6ssMDCBVf/jww3
	8d2A==
X-Gm-Message-State: APjAAAV5IQ3lPvsOISZFqNdC3c1BGlbJhx3D3MQlRE/KD7lLlxxj3Wcl
	dehCfd4J4JN/wZDmKicJu7B6uNC/4HKDhJLnEB5UWQ==
X-Google-Smtp-Source: APXvYqwM08lJ8JkP6DywkPfM2r8MPn6OTLa2UKTgDslhU3ivrqb+WHzsnACQ/Ly33d/LYXbZS30SZsYbm3qnpHf4z7w=
X-Received: by 2002:a9d:6156:: with SMTP id c22mr6457774otk.363.1556892485182; 
	Fri, 03 May 2019 07:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<39b71c2a-9630-5a56-17c7-d74625f97d55@redhat.com>
In-Reply-To: <39b71c2a-9630-5a56-17c7-d74625f97d55@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 15:07:53 +0100
Message-ID:
 <CAFEAcA_o1tF6VEiEZCeFeKB67bDtCGTEHvE0cMAWxicTDfRUOg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Initial Windows on ARM (AArch64
 64-Bit) host support
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
Cc: Cao Jiaxi <driver1998@foxmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503140753.VLAqk73y0VOILa5OM2nXDGJ4EkfXzTt-Naehs_CGp8M@z>

On Fri, 3 May 2019 at 11:20, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 5/3/19 2:22 AM, Cao Jiaxi wrote:
> > Initial Windows on ARM (AArch64 64-Bit) host support
> >
> > This series of patches is for initial support of Windows 10 on ARM as a=
 QEMU host.
> > Currently only TCG intepreter is working correctly, it crashes when TCG=
 JIT is enabled.
> >
> > For now we assume it is built using the clang aarch64-w64-mingw32 toolc=
hain,
> > you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mi=
ngw.
> >
>
> I'm a bit confused since those patches appear 2 times in my mailbox.
> Assuming this is a git send-email setup mistake, please consider adding
> my Reviewed-by/Tested-by here too.

Thanks -- I've applied these patches to target-arm.next, and have
consolidated the various tags that people have applied to the
two sets of emails (and checked that they actually are the same
patches and not different code :-))

-- PMM

