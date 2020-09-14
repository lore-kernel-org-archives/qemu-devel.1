Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB4C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D937C20719
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKxyIW6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkpM-0001Do-VD
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHkof-0000jW-E4
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:30:29 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:34675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHkod-0001vw-Mi
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:30:29 -0400
Received: by mail-ej1-x62d.google.com with SMTP id gr14so22283958ejb.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9Too/4cEaerJ0Pkpab8F+F548C2e2ATuXcNLZ2P3bm8=;
 b=dKxyIW6wOntDpAmP/Kd4HUA/j/WRCKKog+exjIDXhIQov+SamuIxcPtFLEqMboLuXe
 99XjXsVRGenTt2WNGZJrLcYHAXR61NFDk110c9D8qQe+2nD5zfMx/Ujc3uuMy5kEuJns
 S11WilF2hbTTeErejzdPN9vm3ouo437HSHlLYO0TFBWzABWbFCPyYP5N6pL1xjz1EDwK
 XfX5XtWegVFVTcnB2amkvExGJHTGATOYdHCNjZ+Ul4k/8UFi8IBG/H9jGvrtStoBD8/v
 1Yt093gwpPzti6BcsU3rJFeT3jgX5qs6Rz0VI4usUjrNZLib8E1u8aDpyXw62A6feRLb
 3sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9Too/4cEaerJ0Pkpab8F+F548C2e2ATuXcNLZ2P3bm8=;
 b=h6715WS2DolN5VauLdfnmNXAKrEgSHN2+BHuKHmB3qQSNdE/QwLDlV4xsxSKnRLlZI
 EN3BKVaLKDfekxFOZKi4xRd42LmNFtko5kQxxIPkRw5LUD+K930yTjQ+NdT34gM/zZdF
 0PBiL7QsFuc9DXKZR2LFXUFbr/zbZtyB18+Li/57awEQ+MwaYuWqCQaMsLY6RK+7P6vL
 qMg6wLao0zusZ3OIvhdzwVwDwXvMhC+yxJgQXVF3YSVINndVruJ+3aPafFplgg/ReDY8
 B8Sov6bxOwiga0nGmlw2uT1UdlsJnpxDuih710qWEDHPof1fFsmipO/ya3J9slBlKisR
 osMw==
X-Gm-Message-State: AOAM532r9nHOdyxeUYW58BS24IHpwmIhbNKDN9w12QAHVRyzhCSA/v4O
 F5Mn2ldIEOVF5UFoVm4Rn4Vxc0hSwO6uFidq4eDZFw==
X-Google-Smtp-Source: ABdhPJxthx/Ja4Pcg06Su8TmkC+qj1/jgRutx8UHBaZwbzLCA+lRo3yiJaRhPsZfijBdJ7YXmGC/q+yjJ4GY3o/624w=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr13139242ejb.382.1600075826120; 
 Mon, 14 Sep 2020 02:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914085458.GA1252186@redhat.com>
In-Reply-To: <20200914085458.GA1252186@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 10:30:14 +0100
Message-ID: <CAFEAcA8Mgtt484Jf2rLzS8BpNHiGHpDbYQ8QhGkdfoO1ZP79fQ@mail.gmail.com>
Subject: Re: About 'qemu-security' mailing list
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 09:55, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Do we think the current QEMU security process is working well for the
> community as a whole in terms of our downstream consumers learning about
> security flaws in an appropriate timeframe and manner ?

That sounds like a question we should be asking our distro contacts,
not guessing at amongst ourselves :-)

Personally, my view is that our current security process is
absolutely useless for anybody who isn't either (a) a distro
(b) using their distro's packaged QEMU (c) big enough to
effectively be acting as their own distro by tracking CVE
announcements and applying patches by hand -- because we don't
produce timely new upstream releases with security fixes.
So unless we want to change that, I think the key question
is "does this process work for the distros?", and I'm happy
if we make adjustments to fix whatever their problems with it
might be.

thanks
-- PMM

