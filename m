Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3904C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82F5A21783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 07:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82F5A21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFCj7-0001et-M9
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 03:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFCi0-00018C-Mi
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFChz-0001Hb-JR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:36:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFChz-0001Gh-BT
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 03:36:31 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58E4F2026F
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 07:36:30 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r187so585942wme.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 00:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bHALepBp7T34C29eX0JybfnBwuF1FLrdSyq9a3MMhIw=;
 b=BI4NJnfheb/L8kBF7qsscjPh2SUq8/fMpclkhoRWEQqOEpGp69u8/VTS4rsRj4N+3J
 dmKQP+Ncys0MXrzGR+3Cpzd+KoGNcVCUQcdGPbwIsIKjQdWmfVD1qWMPBUYXITXl3p/A
 NRxOQJaL/cQo58pYnMma781YeCKgsJKlqaQbdv0PDHaRMKKedc2l3YnEGA8XgNjWJLJU
 owoS38xdaOqUfokEDOgehF9y75it6MF8ymiwMFzhf06OtX7LWX8Minku26Kt6ueetlKh
 zKVPLuhV/91TA71Jfu5FhBGYs2yw4H/W/B4FXMOpMtUZmZLRCoRpzxsXivqTK6pG14rr
 lmUg==
X-Gm-Message-State: APjAAAX0yrEc1CfpagcRH0ZSYPwJMh6G9wyt8q+NiUD79jJuVYPiisDl
 Ds7qYQM6aGz3IqMot3ebXfQzGUckF2yt/mJs+GuvhpCDih/y6M9Czs1pS+HGFTGdSYP+DUAum4c
 g3AW2p6hwyGeKV4A=
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr15663700wru.395.1569915388919; 
 Tue, 01 Oct 2019 00:36:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQKYcxIXLTvtq6jIQfe9DJQb6gIBL2xrK2G6FZOmbf748g2uLi6XJYehwfYRMpzV5g+FMCqw==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr15663679wru.395.1569915388609; 
 Tue, 01 Oct 2019 00:36:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d958:8ffa:a1f9:6bfa?
 ([2001:b07:6468:f312:d958:8ffa:a1f9:6bfa])
 by smtp.gmail.com with ESMTPSA id l7sm13926925wrv.77.2019.10.01.00.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 00:36:28 -0700 (PDT)
Subject: Re: [PULL 09/28] tests/docker: add sanitizers back to clang build
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190926183553.13895-1-alex.bennee@linaro.org>
 <20190926183553.13895-10-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f97d6128-d755-ac94-a66a-be58ba39473b@redhat.com>
Date: Tue, 1 Oct 2019 09:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926183553.13895-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/19 20:35, Alex Benn=C3=A9e wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> Fedora23 is but a distant twinkle. The sanitizer works again, and even
> if not, we have --enable-sanitizers now.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20190912014442.5757-1-jsnow@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> diff --git a/tests/docker/test-clang b/tests/docker/test-clang
> index 324e341cea..db9e6970b7 100755
> --- a/tests/docker/test-clang
> +++ b/tests/docker/test-clang
> @@ -17,11 +17,7 @@ requires clang
> =20
>  cd "$BUILD_DIR"
> =20
> -OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
> -# -fsanitize=3Dundefined is broken on Fedora 23, skip it for now
> -# See also: https://bugzilla.redhat.com/show_bug.cgi?id=3D1263834
> -#OPTS=3D"$OPTS --extra-cflags=3D-fsanitize=3Dundefined \
> -    #--extra-cflags=3D-fno-sanitize=3Dfloat-divide-by-zero"
> +OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang --enable-saniti=
zers"
>  build_qemu $OPTS
>  check_qemu
>  install_qemu
>=20

-fsanitize=3Dundefined is not the same thing as --enable-sanitizers.  Thi=
s
is basically duplicating the asan (test-debug) test now.

In fact, since we have the asan test that includes all sanitizers
including ubsan, I think it's easiest to just revert this patch.

Paolo

