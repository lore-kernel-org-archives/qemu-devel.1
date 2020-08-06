Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386CBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F0A23117
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytShs9Jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F0A23117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fSL-00073j-B1
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3fQG-0004gJ-3j
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:55:04 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3fQE-00060R-Lw
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:55:03 -0400
Received: by mail-ot1-x342.google.com with SMTP id 93so25900440otx.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xv9JbfgdSPkznTm3rAcpGMr/8FgBsek9LRQfnOTdiAM=;
 b=ytShs9Jk4kW+kwi9e0nJcyUUl6HzRKro8BdXzQ+vrP8pI2DV1cL7mPVmybv0rzcYTW
 g7t8B33HWxeTf38JOQV3EyGGjQzANGgcBWJOO8AqgWRU/+z3lWftSHsaO+VEIgk985mm
 j2nePhhGMMQAUG8GTqmBxNJbCppdAc/mV51kvuFuRRFcJisu842uPCSpsFHvxOSKjJgr
 z7rN1tuKsvAkxazLgUeLkz7V/6XNtNgHr9MM/CMyWt1rM+iW1HEZJqdCMO6hKWt8Y4Lz
 TUIDpRpMLGOnhcC2JJGFGeFbMyn2mY9CIhklROBgzAdUDGap2YSSB276XNsCv4VhZsve
 LXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xv9JbfgdSPkznTm3rAcpGMr/8FgBsek9LRQfnOTdiAM=;
 b=nKfy+AQqXGs1QJqWy0SG2oM2NEIGh2XN5wq3poeZwfqLKionY11G84xgxyNJKz3iGl
 a272GhlC2uyCV6oBf8g+HHOAu1d2Um5BTpsvEkR8KvrqQlIpFUvkUrZ7vFCCLaZ7T+dU
 0aCMZAtDKtmSlrLJMIiRIWWkcxt/Qh8jr0oYnRAIfRwKokWJRIUvrl/89U1bkbTXcq32
 5G0WcDAU+e0LBWH0bOn+sIgCSeA+Ok8Qv8w7uJQjZX6I1bjpYXZunj0bNbeMNDN+BvFJ
 WoobHha8tVvmBhD8iMTfBvmKVL/Du0gGpjsWuHwvx/8VteC8rXi881h5NGnpgmAR+fhB
 XSNg==
X-Gm-Message-State: AOAM532WARMdTXb5ViA0vX/FI92u/6dbydseRvQMiMpIcHNnFGvCHo1p
 rP1hkSxzU346yMYPaMDQQr3D6RCjvBT5INOT/9cH+Q==
X-Google-Smtp-Source: ABdhPJzIaO8CLttjH3XX1tONUk8FKkjy81WLqtKHmaIkEuLHkz1ItEBhJxElKG4vNB2VIrG2e1u30CEaLe0AL/pUlrQ=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr992915otq.221.1596718501383; 
 Thu, 06 Aug 2020 05:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200715173418.186-1-erik.lucas.smit@gmail.com>
 <b3c8ef39-5a1e-c49d-6ab8-342f42be088c@kaod.org>
 <CAFEAcA9H633W4eDsXJ40o0pAje6t103MaKjkaSqrW2BHLmaP7Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9H633W4eDsXJ40o0pAje6t103MaKjkaSqrW2BHLmaP7Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 13:54:50 +0100
Message-ID: <CAFEAcA_j2_TqLfizv8VgrLwtx14LCLvM2pzXuo1Pky4HgQxjCg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/aspeed: Add board model for Supermicro X11 BMC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, erik-smit <erik.lucas.smit@gmail.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 15:07, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Thu, 16 Jul 2020 at 07:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > On 7/15/20 7:34 PM, erik-smit wrote:
> > > Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
> >
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Thanks; I've put this in my list of patches to put in
> via target-arm.next once 5.1 is released. If I seem to
> have forgotten about it please ping me once 5.1 is out.



Applied to target-arm.next for 5.2, thanks.

-- PMM

