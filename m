Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DD5C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A44D2072C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LmxEESqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A44D2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFk91-0002xH-RT
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFk7e-0001r3-Qy
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFk7b-0006Am-I9
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:49:28 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:44883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFk7b-00069k-Di
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:49:27 -0400
Received: by mail-oi1-x234.google.com with SMTP id v134so1409371oie.11
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wxS2n1qfBjTinTrtu0P4p/AbYBm81q0DAWQNozY5h2I=;
 b=LmxEESqzbEmK36kOtnbQCattN9wvyVJpfd9SCJF/HI/J6VrIkIPnGBxpkWAYZvuXUO
 pcR4THeqWu9Kb0G00HliwF2Lgfj7fR+r55MGSnPiLpornUvnoYpm/kQWS0GLlSsUG1OY
 VYUf+nX5DbS7RSY2Tsb+3yRgl6BzrEe4AVE7Uls+o06U0GQz1ccZnEzV0pE07cyWOPxl
 h/K8EjGNwM5hwV/HkJ2SU8BfZ02HgzqMbrPSgO1q6wKV+oTzyoqgRKaJVUFtPp0gOrsL
 mBJzK0DETe01NM3O06St/ptmPF8m4x1QrjuLkeK75kK1E+ZCd0t8GaZED+WJXvi4Dyv/
 TyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wxS2n1qfBjTinTrtu0P4p/AbYBm81q0DAWQNozY5h2I=;
 b=R6yO6KmiiNx7tXYJ+RzZDq2k4nUZgXAaODDFURTsii7bbsgoPGxX8fDnBi6krL4etM
 CuYJSJBXq2Jmqv6J9vHJm6vEulYBRpWidm44eQDv0VTmV+190X+aBrODPkg/HDoqVKmA
 ix4+WBU1ge1EFeeGPeQUHRAozakV3S6LvrNg+XXa4WdFKUQ/bgckZYpXsahhkB5/t+TS
 AN0ofG5i1MXt8teD3ZCCF/dJNOcNY6DMXC4Hm3IK077Os8uPm/pxCOVRHaH1z0DyE8dH
 Wu3IjoV4Cu1kA937tyv8xeZ2GJD/7BlGGL2rcKq6AFvUk9s4qZlSWNhJROCr0av+Zzv1
 Ulcg==
X-Gm-Message-State: ANhLgQ2c2nCH88THj1xqFxahvqqudI1J3Oc9TNhCC9Ux7gSGfsDy+RJk
 EH2COS2riwnsiyT08pKHa1zb8w4TvV4JKZni7+7Olu+wEXY=
X-Google-Smtp-Source: ADFU+vulcElA6SCqJzHeU1h1mRHcWF6B1oxhV2+6wgZkV6VB5d6C9z6Hrki6fhIkOYwM7g6FLbfldVQ4QV0AqGAeU3Q=
X-Received: by 2002:aca:c608:: with SMTP id w8mr11796706oif.163.1584820166556; 
 Sat, 21 Mar 2020 12:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.BSF.2.22.395.2003211825370.55214@zero.eik.bme.hu>
 <67cff836-d895-3a1c-1ead-13a0e14507d6@vivier.eu>
 <alpine.BSF.2.22.395.2003211924410.70812@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003211924410.70812@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2020 19:49:14 +0000
Message-ID: <CAFEAcA97=hHU+GqSjM90tP54HVjKnf-n2T2QkiqBen5otL6EUg@mail.gmail.com>
Subject: Re: In tree configure errors since 6116aea9
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 21 Mar 2020 at 18:32, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Sat, 21 Mar 2020, Laurent Vivier wrote:
> > I didn't see that because I always do an out-of-tree build.
>
> Isn't there a test for that or should there be one?

It's not in my set of CI tests (mostly because it's a bit
awkward to do). We're planning to drop support for
in-tree builds at some point: out-of-tree is just
generally better and trying to support both tends to
mean that one or the other gets accidentally broken
periodically.

thanks
-- PMM

