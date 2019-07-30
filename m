Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE245C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991C420651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEpV2Kv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991C420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSom-0007NV-Nf
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsSoE-0006V5-7w
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsSoD-0005CN-AE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:08:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsSoD-0005Bt-3a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:08:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id g17so65947871wrr.5
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/KcOJWJRRtK90cF9IC37nfXGU/xRIVABo/wGKm0TZJs=;
 b=eEpV2Kv6FCQ2rjRU9/fadgIukzD/3UOwAAbG8EGrPBaGHfKsTkqSm4TAOyI0MretmK
 6c8YTBVcGIMWDkNEqaTrxcpqNvc9mnj/3LPZ2p5DD9OPAx0r8C6BMrSugMwdjClD9gaz
 YicVS7GVoNP5eS8E8ifr+q3SGo7f11CQynHZgb6G4J/Z2UcC6o/FuKHPbbFPffErgnyW
 nNAu9QBbJ+SxdLeP8IIhOXYc1DeNMkozQotj6clywBW+MK78sUaOH/4j70L9E35FV/r+
 JKeNEDqUHqvvYBpdwA91HiesB6jGPburybixlmFUTes90r2pjghEFseyRxoyt2TeTysy
 G+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/KcOJWJRRtK90cF9IC37nfXGU/xRIVABo/wGKm0TZJs=;
 b=QfTA3af50cFgGvsabkcxItOoBxuX2LNgu9PowlFl7Mgic0lXc3560wC4WjdApMvvH4
 gFo+rpcexZuH7pRLqCRJB0ICQpC4mFNfM/45eVK8zXNoAiBnfiTYEYNRlU21TRQHs4O+
 xxzUXrkqoQaaY8Czw3K6Zoa3oFE3atidyNOVgEjy4szkjkLQdfnLreoLgaYuoKClGcNJ
 ciUIDsCiArzUgnkF2lts0aFf0xXzffj+Y9iUmKep+EckWBtE/sUTHQU7k7tVDPTxEVcV
 YEzacHr76ksm83G1dS0Ds4BgqrTOykzhgmiDgEKfwEnAXS7mJeUVO1oiQTpGY0KqBn1W
 x/Iw==
X-Gm-Message-State: APjAAAVhn596EYxjiBUK6w9veFPa7H7xP2wE+swIPV+1K6p+OfNooxoS
 jD1dBa9e/eRuM1PHc/8j21l6DQ==
X-Google-Smtp-Source: APXvYqyp60ytLkfJ62moBg/UwZYOAFoghZGFUe7d+67jhSmIWtmQVpp6rkmyoVEJpvroTbsWG14p7g==
X-Received: by 2002:a05:6000:14b:: with SMTP id
 r11mr54134157wrx.196.1564495735801; 
 Tue, 30 Jul 2019 07:08:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z1sm72740019wrv.90.2019.07.30.07.08.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 07:08:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB6CE1FF87;
 Tue, 30 Jul 2019 15:08:54 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-26-alex.bennee@linaro.org>
 <bd131b16-2f38-4112-4e09-6a2f63908bf2@linaro.org>
 <87ftmnitjp.fsf@linaro.org>
 <67b32364-c3dd-ff0d-fba8-7737327fc1b5@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <67b32364-c3dd-ff0d-fba8-7737327fc1b5@linaro.org>
Date: Tue, 30 Jul 2019 15:08:54 +0100
Message-ID: <87ef27iphl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 25/50] translator: add translator_ld{ub,
 sw, uw, l, q}
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/30/19 5:41 AM, Alex Benn=C3=A9e wrote:
>> Do we ever need _code access that isn't part of the
>> translator loading instructions?
>
> We use it; I'm not sure that's the same as need.  ;-)

Yeah I've run into others (e.g. alpha alpha_cpu_do_unaligned_access). So
the question is do I attempt to deprecate code load in this series?

> Lots of the uses that I examined should use a mechanism
> like arm does for recording syndrome data in the unwind slots.

Yeah - hence the semihosting fixups. ATM we only touch translator_loop
guests but deprecating means having to do them all. Maybe we could
poison the build someway and ensure as each legacy translation is
converted to translator_loop we convert the _code use functions there.

> Quite possibly the only legitimate use is sparc, where it
> has an alternate address space that reads with execute permission.
> We could probably find a different way to accomplish that
> if we removed the *_code helpers.
>
>
> r~


--
Alex Benn=C3=A9e

