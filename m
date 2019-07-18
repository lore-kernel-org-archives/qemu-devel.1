Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5951C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 23:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3CF20873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 23:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBgtXg93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3CF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoFmc-0001DY-Rl
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 19:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hoFmT-0000o9-4i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 19:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hoFmS-0005KA-6z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 19:25:45 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hoFmS-0005JH-1C; Thu, 18 Jul 2019 19:25:44 -0400
Received: by mail-pf1-x444.google.com with SMTP id r7so13304890pfl.3;
 Thu, 18 Jul 2019 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=U8990NzakMHSHFaK5MYyIZEq5tcNLakIOcTEUqI6Q9I=;
 b=lBgtXg93DfAyLCuCG7shXCp7ajPjoZO3TthSGhD5tGapf7BRp2et1Gwd42SgKiKI3V
 x4D0XNFkrtUJQ/PHybSpnUmScu+A9mgJpkDfk3nQ8GA01lmH9HViLDQxAC4qQBrEDXLQ
 1nDl5hCRagI/Au+XzrZ0pwLF1A7e29lUc66AQN7AEpwOqBe5dg6PdMvUAvT3PQ5ZEKhe
 fzzcGE+PL/wWcN8Dc/pGbsFBhUOMtotSEaEU70U9MoonIiYV+eqBMg9IkoZYgANP4dEH
 5t/IO+sVkf9FaKfii7ADjYyiPkNmfA87DVlAAQVlawWPz6y/EeMfvnLrpFgaNyRrTPeD
 141Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=U8990NzakMHSHFaK5MYyIZEq5tcNLakIOcTEUqI6Q9I=;
 b=oxUO4sIVGnllMVnfB4PMcmgv23gtatYxZT5gaJiYybyj99CQ3YWWqiRsa4z4fwoSkC
 +dmQfDMKNCvvQDudLAKvfo8xfIsHwZ1Kyl0h5gLpEiWVvV3IwdnaDTCtiO7a1XfgpU/f
 07VNneZZ76iZ12I8VQWgABdgCTjnGrrwrUsC3z8uUVV8mNFW4+xZTWmstfjajvdr/CO+
 0GYcR/ow0H2g3WX878JeWgIZugHKYGbyX5PmoOW6G63GnKZnNiBHlUftRZEMjQxQ7d8S
 NMdVximAcqDOq3eXOWk91fBesnf3q3qSgP0FwUlKlxhjCVgZ4a2/4nusozJtg14uJOxs
 3viw==
X-Gm-Message-State: APjAAAXGcSTMKXOY5p/UZf34K6D3a91FEfRTaYaOd+dBiAI4QQd5Gxk6
 onPdeqqosjTelZdnoghRfRM=
X-Google-Smtp-Source: APXvYqxhTPV1MS5titEczFcKeb/j/wpy71AYaIXosd4GwgDvRRKXXm5upja63SzE0c9GpBl+P/ejpw==
X-Received: by 2002:a65:6691:: with SMTP id b17mr35197239pgw.217.1563492343026; 
 Thu, 18 Jul 2019 16:25:43 -0700 (PDT)
Received: from localhost (61-68-63-89.tpgi.com.au. [61.68.63.89])
 by smtp.gmail.com with ESMTPSA id p187sm42796943pfg.89.2019.07.18.16.25.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 16:25:42 -0700 (PDT)
Date: Fri, 19 Jul 2019 09:25:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190718103951.10027-1-npiggin@gmail.com>
 <a411dc3f-3b9d-8977-0ec4-dc0e8456af51@redhat.com>
In-Reply-To: <a411dc3f-3b9d-8977-0ec4-dc0e8456af51@redhat.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563492269.ojsbkzrhy9.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 0/3] Series to implement suspend for
 ppc/spapr
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini's on July 18, 2019 9:08 pm:
> On 18/07/19 12:39, Nicholas Piggin wrote:
>> Any comments on this series would be welcome. Hopefully someone who
>> knows i386 can give some feedback on the possible bug fix, and
>> whether the new wakeup method will suit i386.
>=20
> Looks good, though only i386 supports wakeup so perhaps it's better to
> DTRT and move the reset to the PC machine's wakeup method.  Then pseries
> need not implement mc->wakeup at all.

Yeah that probably makes more sense because the i386 patch should be=20
quite trivial. I will try that and re-send.

Thanks,
Nick
=

