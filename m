Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC4EC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20952473F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lR1UI+Yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20952473F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXlCB-0001PO-Aj
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXlBP-0000pj-Mr
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:08:07 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXlBN-0004vP-Nc
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:08:07 -0400
Received: by mail-ej1-x641.google.com with SMTP id dt13so7067100ejb.12
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jLIm5qwowyaNOtDHvKZ3loVnWhxmKmWaHmOXmo650Ek=;
 b=lR1UI+Yt1hxzxMnAPC+AH0+zEl4DRLWdYe7SETqoVPQXBQM3WT9L6O7l0uwfphyDBE
 x7By1UJ0ZYgp0mJF+kCfi53JbXlCfe1XdPLJoW4txBO2iV1TfU43t9b84cTTH35PG1J8
 82QfzjYP4Dv/J/XQSzdYO6K4atIIwS+6zvGvzP8gq+Z/JWoHz7Iq1Y3Ww9fudTZvTZlu
 H4hMoZPOLxCcvovDIMroZ+d0wAwdS26qAzysurDt+z6nzRVV5l2+R+IB5drArtE98G9O
 hzaw3VBw33G7Q0pb83J4kZmTAe131tq5iJvvxewm7frEU1ElsNe5ZTTQzSgXxAhBSn14
 IsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jLIm5qwowyaNOtDHvKZ3loVnWhxmKmWaHmOXmo650Ek=;
 b=aBsR+Grk8sT+3u1vRn6yGSP+tAvQnBqyubut8TH5kLhb9W+qDepoY7Ahfr0XE4lVwh
 SUNXhkoQWsMJlosHh5TkLLA2NKr75M3Yu+YkSH+f5PYoJMrVAxrNTwDgADymofdDlKTH
 ftBR7N5e25uHJETFb5Eo3kZB56wosf4l6vRJ756SFjaTwU5eDqEBL/qk1eGOUv80riL1
 6DWZ4JZvrSPzSUTrQjf1ESgcicAi6M9My+h5jHrDv29E1xlH11W9CHU09gJ4BeyoIBQk
 jrWPDPrvUZFmpt1blmUTLmqz4BDvUbVklm3j9GKnIPDN5l85h4GgGKFFZXhbEucOLjPM
 tVBw==
X-Gm-Message-State: AOAM531wDl52DR6jGj8HGFtQDgc/HM+908P+B1D1eE29RpDCK1ceKIcL
 aT8wUdufAGCTVZoKs+6ZdHY+xh46u7NPpNYRqZ5h+g==
X-Google-Smtp-Source: ABdhPJxGMdC+ffTLUPZIgoL47ND2no6Tlr1NqHtwLI+d5q18dV9OkHR7+3aLd0lLGE6cj6TpYx2wUYqlpBSNsXTVnCM=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr7417488ejd.250.1603890483827; 
 Wed, 28 Oct 2020 06:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201026220624.60878-1-f4bug@amsat.org>
In-Reply-To: <20201026220624.60878-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 13:07:51 +0000
Message-ID: <CAFEAcA-2+FerNXySJsUMesSeg36b7iuHYJN4L5CGE-VU+VHx5w@mail.gmail.com>
Subject: Re: [PULL 0/7] LED API patches for 2020-10-26
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 22:06, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The following changes since commit a5fac424c76d6401ecde4ecb7d846e656d0d6e=
89:
>
>   Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/block-pull-r=
eque=3D
> st' into staging (2020-10-26 10:33:59 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/led-api-20201026
>
> for you to fetch changes up to 06972067c48fc21a47445b5d706368f1129f216f:
>
>   hw/arm/tosa: Replace fprintf() calls by LED devices (2020-10-26 13:44:5=
8 +0=3D
> 100)
>
> ----------------------------------------------------------------
> API to model LED.
>
> CI jobs results:
> . https://cirrus-ci.com/build/4879251751043072
> . https://gitlab.com/philmd/qemu/-/pipelines/207661784
> . https://travis-ci.org/github/philmd/qemu/builds/738958191
> . https://app.shippable.com/github/philmd/qemu/runs/891/summary/console
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

