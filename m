Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102D9C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF7A21D6C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ert8oIq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF7A21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5bV-0007Us-7W
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG5ak-00072U-93
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:17:14 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:43491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG5ai-00047s-Ka
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 15:17:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id o8so5156103ejb.10
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 12:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VU4BKFRkKsvFkb+uEvzXg7BGO4wCkGlnDFZUxkDwp80=;
 b=Ert8oIq36dWlfrADSzBJsoU12AmYr+JOSL88uv28lswbJWU3nN39upk7q9Cv/RMk/t
 cAA8ZGHK28Rvw7hs27y8Fl/HK9hCsiQrSeUbeGlIC9u0Wb15xa1we6BdvFmfumUcY5mA
 927bhi3OF5z+R9dOQ6AgRS9Zbmz+Y+qH5//D1p2WEYWT63WqnFuzzmgCkwiHBycjNFSe
 Ixe83LshkhkfPHj0XxbJpcl73ARZIzuZ7h1UjIdQtYud+I5JtIAaLLDLvwqmqosS5Vfj
 rLT1VGwtM1VPuEOSCqR2ZFSxwLGZiWSnEWId7UXYW8BRYWvDbi7cRf9IFsFCksp7Fv78
 h9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VU4BKFRkKsvFkb+uEvzXg7BGO4wCkGlnDFZUxkDwp80=;
 b=d8ktlp32dA9qPMSyvv9m8gZw/gGWErfOJZsW+gYoqBYZP3W1uLaZwvS+OT+KWBaqYY
 ArTF9cmhtlEEKk3QazoNPrW5CVgzUzEdV49GAdPmWLic5R5HsNvZnUf+h9zA7ch+gJxV
 QoTPsf062vj+LtI7w+UPnvVlGlsdUms/yW8VyVNoMe2FM25WhMwZqtEoWN8r6u8RrYvz
 ljeLlCRtzAPHcoh7eDmc8ahbhGXLSjAJ3kpWEqKbVcnMhJVQjbmPwEVYzjFHmVbgvi0N
 Ko+1iasmwqwjSOyKkcfS3oDGf3sjWRfO9jGV4br9jtewoEUwz+6CdoHrgSDnVtry8olb
 NaVw==
X-Gm-Message-State: AOAM532wqC6rbhegPghLT8gxAuezYCcGf5sROgyurWhCXWTIAM/Xm7B4
 sAw+80pE2B+d7S6sDlK6u4QA0fhBq0K/B/Olw8W6Iw==
X-Google-Smtp-Source: ABdhPJxum8jCJSykiwVOuOon/IpC4GibnGg6sLqtZNYWph9TweiGBoHCBGqY3EwDnYl77Tw4WwFcZjGjMu5rQoKkS10=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr5066634ejk.250.1599679031040; 
 Wed, 09 Sep 2020 12:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <2764135.D4k31Gy3CM@silver> <13443969.F0S6BcH2UH@silver>
 <20200909181355.GV1011023@redhat.com> <1695914.5EixHECA2G@silver>
In-Reply-To: <1695914.5EixHECA2G@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 20:16:59 +0100
Message-ID: <CAFEAcA9m6Qd1C2EXHKBfVrq_bd_AJo8ggf0t02bLufkmT5jZ=w@mail.gmail.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 19:56, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> Interesting! That would defuse the homebrew problematic.

You still need a Python 3.5 or better for the other scripts
QEMU has as part of its build process, so you will still
need a python other than the Apple /usr/bin/python to build
even if you have a standalone meson with its own python.

thanks
-- PMM

