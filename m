Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D38DFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC4F2067B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Og8Qi/RE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC4F2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhTs-0000At-Tr
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iKhPt-0005mO-JX
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iKhPs-0003av-Jv
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:33 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iKhPp-0003aI-UF; Wed, 16 Oct 2019 07:24:30 -0400
Received: by mail-qk1-x743.google.com with SMTP id y189so22373863qkc.3;
 Wed, 16 Oct 2019 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=X1wLTwckVbez8zZGtf0g/B6tnQebMFF5Z8kQian0sJ0=;
 b=Og8Qi/REf4WVbtAX5wfM9WUj60NfGQpjdYxg1Jgb+TUkXzMHPF0+PbZjAaByn6oqbZ
 6ZfWIVMz4rQytOvNv033mFLrbVFLgzmT4J6a9mGQa6290GBHjFJWOm2ajIfLFJ4ZKkVo
 6ZvG5HCYQvhgvF6nmlJWR7tEn+wc47YHcgxXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=X1wLTwckVbez8zZGtf0g/B6tnQebMFF5Z8kQian0sJ0=;
 b=r89fFxLrm4Zuj5CdLxfTP/uHKbaQ16ugLJa2mv4tPTPLyWFHbFD5Jo6mWtOJRq1Wmq
 B3TksDMEVjXATPPLB+n3Yu1rUshadvfvqxM/uaZWhQZ5hVDSc9DfFyl44JNZgotm16yi
 4ScCFtejymo+O8b4Sha7g8QcOW5BHTaKFkh7KmyUw2H3kxQqLA+AcJf5rE/qkCIt4S+0
 I+YZRPbqGWTc2uZk0IlZDSnIHd2WU3iSpVonPmj2EWNmWi6PGuYis0SQgVJKYxcWBf+A
 919f6aP4JiPpbVMPqvWJ08gpLFA+spin+Gjxq0dgHMhM28hDUWyeEYs9Lkv7F87xFKgj
 fs2g==
X-Gm-Message-State: APjAAAUT5rFWRGzxhzEeqpdVejUNwlgJQ6L+bVW6hXRaIZ2ozonCzxt0
 aqfWZddvUu0tpZNPZJaNU+M4X9ThvGODx4rZ+d0=
X-Google-Smtp-Source: APXvYqyLPnYcgTV5ro5VNgP9UWz/ueQwEUSXvQ3z3RKurwm/ysEnRagZ1Nk4pF6SoMw2T7ZKMgMp/7dPOmIoVFbLdFE=
X-Received: by 2002:a37:4dca:: with SMTP id
 a193mr40163108qkb.292.1571225068768; 
 Wed, 16 Oct 2019 04:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085035.12136-1-clg@kaod.org>
 <20191016085035.12136-2-clg@kaod.org>
In-Reply-To: <20191016085035.12136-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Oct 2019 11:24:16 +0000
Message-ID: <CACPK8XdULytZOsapN=wmAqz5GDD-v89-eTi0byo1O9DtVm3y2Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] aspeed/i2c: Add support for pool buffer transfers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Eddie James <eajames@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 08:50, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The Aspeed I2C controller can operate in different transfer modes :
>
>   - Byte Buffer mode, using a dedicated register to transfer a
>     byte. This is what the model supports today.
>
>   - Pool Buffer mode, using an internal SRAM to transfer multiple
>     bytes in the same command sequence.
>
> Each SoC has different SRAM characteristics. On the AST2400, 2048
> bytes of SRAM are available at offset 0x800 of the controller AHB
> window. The pool buffer can be configured from 1 to 256 bytes per bus.
>
> On the AST2500, the SRAM is at offset 0x200 and the pool buffer is of
> 16 bytes per bus.
>
> On the AST2600, the SRAM is at offset 0xC00 and the pool buffer is of
> 32 bytes per bus. It can be splitted in two for TX and RX but the
> current model does not add support for it as it it unused by known
> drivers.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

