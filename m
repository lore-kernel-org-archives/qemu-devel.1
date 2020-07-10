Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7099C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9694920772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK5Yqf9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9694920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsO6-0000xd-Rz
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsNV-0000W7-UL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:43:45 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:44348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsNU-0006Ro-Ae
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:43:45 -0400
Received: by mail-ot1-x331.google.com with SMTP id 5so4072245oty.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jzZ4tdygMYk94EEE7lclKYcFQ7u+F7kr7cFzrJ3yG5Y=;
 b=GK5Yqf9IUx1kafksat0/yXvFTWmVT0w67l5kBN33nIjSA4x8PiyJ46GFafi5AHODIm
 pW3lkaqq15HldZlrz5UHam4t45dMIgM5TexxU+vxiWTkkbexQBykB3Sg2/1ZEFVIbU4Z
 yAhXHZxdvVdM59a7Pmsh9TO6xwG1bKUTvFYRd7uiNb8XcRJEM4O3s6dsyfj+oi+rvQBR
 ILaZHQ7TuSlnH9ibkM49w0mxckDjdQ0mE6Ei302cEVbWoTjcdALs5umDdu7pBzeJXyWi
 pPdn+W4omJdG79ikBQM8UQSN37wnk/lV6fzHPhm1D7M76x8VrIgimlUvTY/N4gPwfQqY
 yj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jzZ4tdygMYk94EEE7lclKYcFQ7u+F7kr7cFzrJ3yG5Y=;
 b=phfb5uHS/AoPw2NIk6IRxiQd31qdBte0HDagbMdGv07kCUjhJS8dlWO3VCdtqCymzY
 pzXvjSIgu91Gnis+M8Yi3IrmGl0fLOa6EmT2ChnQIfit1TELLKeM1ml+IHstWrPjgbaK
 6uNpyW6YD5w2Tq1GQ2wOSQAHw5bANOUBfSU9h2FbgCO3RT8q60qWs/UwEVkKcq0gebW+
 gbGWnLO6gbc+H41LuCe29Aoh7bkt2m3MP3l4XJV4jdF4jR2KFv0xg/fw7XtXMNh7gfMo
 mgFqs2LdFUJK032RksZ8zk73lRDPLMC6TWnQImg8c1Qyke5X0nYKFPGTfXywSRG4Ecjj
 zxjg==
X-Gm-Message-State: AOAM532gjOaTA5GIh0+zQ6Zg5lXUsgBLu54+9YTBcDrwaSgl1ft9Ct4u
 DxJ/xwA5qMf0ITQOuk2GsZd4jDII6XCgxqrQHYmL+Q==
X-Google-Smtp-Source: ABdhPJwvs5EuSZy1Cm/g5+0FtKf2KEX8GCAk0//F/Elr2XinulJzD/vTZqk2FMF1XRIlz/JUYSMeaFklisaDch7/6yI=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr51209389oto.135.1594385022737; 
 Fri, 10 Jul 2020 05:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
 <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
In-Reply-To: <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 13:43:31 +0100
Message-ID: <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Claudio Fontana <cfontana@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x331.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 13:38, Claudio Fontana <cfontana@suse.de> wrote:
> I got regular green test reports from cirrus-ci for Mac, seems different compilation options.

That's odd -- what is cirrus-ci doing differently? Building
the cocoa UI frontend is the default and is definitely
something we want to be testing in the CI...

thanks
-- PMM

