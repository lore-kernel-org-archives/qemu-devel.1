Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FC3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F8A20890
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjE5gE/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F8A20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxgY-00054q-Qv
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxfk-0003gj-77
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:45:52 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxfi-0005A8-C7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:45:51 -0400
Received: by mail-ot1-x342.google.com with SMTP id 97so5056162otg.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6RBHGHSFzApDsZRTVdR+LRXMgANO1DFHsKV1ezT9ZA0=;
 b=jjE5gE/mlHG/Df46dUQ5hRaJ0WvGf3PQsPLWq31+Uks9Hb7fe6ILLqamExCJUlQI1u
 hVC0c6DRBRS4/lbLQpNYfAl1GYIBqhQsmd9HqOVAyeMDrefXX7v5HmEpeQawdmJ30icM
 shKeU9lS/WDIDdxx0VbpDgoAKGhilSTRYLAVO8OTPuGQ3CFCLO4kaYfF+oTWy5gMk3xC
 i+D+soIsjmn2SBSyimb62ij5h8CqhiaVpDHfJFkenTepYHNdbW2xZwU8pI7bMXf7HiAD
 7YIIYm4lsh01vC+M5v6H9Y9Z1yi5a74JhY6mR4iD6kYQCezIlj0z+4o0l1OZbqfmJygX
 aRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6RBHGHSFzApDsZRTVdR+LRXMgANO1DFHsKV1ezT9ZA0=;
 b=g09ci1NvzmFg5xPhgvdB5JgSTwDNqzDu+3UEunbKz9MLPOtDlqJHFetWsRio+bTcg9
 8Eyj/UxRoxW3/q9Rrd+b6mRv+GKMQcjj5UqjoMdt08YAcbHXUJtbK04Fxzc3kd+5KHT2
 4wnIWfqIDXoIDCmVHZS92q34C3+HPr/sEKzPLDsWcwnpJuF92WsKJD+asmeDKsCue9Ul
 3R22YhBRxCLJVCSj2//MikhGreo27CrGtt9x41HaGd7TSD3/YBcs8UKhsbnZj6DYDNM6
 Y20QvrxLzQ60vRPwAlMaqcrnRrQNa46zNLeofnAoCGE42zJaJpcMFo98fJtJjAzKxSN/
 q2Ow==
X-Gm-Message-State: AOAM531sQFjjR6/gml/2T0sWRTqHXti2UT9M+/cOnnlEWvf8A7OR8hoe
 xCNoNucPqaGrqjbmSkvyFzSgljuE09Ct75sYrpZrug==
X-Google-Smtp-Source: ABdhPJw5OSxSv07U1LB9oEjULwmypbpVn2cR34TJJ/8iIJS9hdATyNiU0j+2XkzX4FYx2BX+v3h4wAXn5GcJSI62PUw=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr4137912otn.221.1592498749083; 
 Thu, 18 Jun 2020 09:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592266950.git.balaton@eik.bme.hu>
 <728903de06f672d4afc9c29827c246027860bfb8.1592266950.git.balaton@eik.bme.hu>
In-Reply-To: <728903de06f672d4afc9c29827c246027860bfb8.1592266950.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:45:37 +0100
Message-ID: <CAFEAcA9ZVOMNN62f0_fMst553=GbDctBoSnCj2djL1-4cJ_=ew@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] sm501: Introduce variable for commonly used value
 for better readability
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 01:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> The bytes per pixel value can be calculated from format but it's used
> freqently enough (and will be used more in subseqent patches) so store
> it in a variable for better readabilty. Also drop some unneded 0x
> prefix around where new variable is defined.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

