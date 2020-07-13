Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4063B2065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1hHxefU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4063B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juu9U-00062D-G1
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juu8h-000539-3D
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:48:43 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:41552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juu8e-0001Ju-PK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:48:42 -0400
Received: by mail-ot1-x32c.google.com with SMTP id a21so8930895otq.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J677XKowMiQfVwJh+f34zWIkGK4QKNIfX3aF+9SXTq4=;
 b=l1hHxefUynJpjWX3VNlUPeRd7pWMdChsFwu9tww3kyL9xY8qr736bTrAemzgttJ3UN
 cn20Hxtx/9xv8WVQY36TJhK/qedkgSZTM+sXbEm2CpbznazTPqpl6T50qMI9b81IrKbj
 TYTpHL41hy1pZXEiphzVro1xQuoGjJ8wdSqMoBywltilulKbOo0crD1FvtLnpFNevg6m
 Ue+KeS5FdC8MG8UigP9+99bwgKLN6I3/hDecqtU9Y0NlAxJwuiTZWuv/iw+T47ooMQLy
 L4TXNBoHmQz5ABKq3QbJrDTZL/PNchPkkq2G5uHhoGs7Ltg2A9pWT2jQIi4qWHo7SmCg
 zYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J677XKowMiQfVwJh+f34zWIkGK4QKNIfX3aF+9SXTq4=;
 b=AwfT2mSbKAogfv0hXu5I8dbiAR0U9Hpc+0lv/c3yUrzpm2XG3zyZMX6Zq3h8igCP7X
 CJDEU9M4Kf654DX6HvB+VWo+zPi3V1DbRqElqZ8uNLyknRW9WF6mcslZK6ubCBHsiTAi
 IuOfk7sm2xz6WlQvpS5htK6FW6t0KRnzkhOeaCyjgFkLsFScGnT9koHC8CB0bNFYSSvx
 MsSqr+Bg0vM5Nv6VIEISTu7SkZnw1LsARkYWv8IVb60SGqSockwFgHL5E4ekphytjO23
 dcJJ4kzRwrtcnjBflWI/gZnqBgoldXPqjYflscbaOiQ8RdLqCmtu9zGboN0TQqu3tC0r
 YCBw==
X-Gm-Message-State: AOAM532SUp/DwYDo2uLBQTvZKO826kxSJXtq5Bn9SVxHwNVS1aeB+Xtg
 VKeRonHNsQfNsEC/Ah3ioHSwkXWBApz9jra2rErfow==
X-Google-Smtp-Source: ABdhPJwFOds3yCmqiJvOGImYiArpHKv9v+WtUqKi511mmn7WXejUKgOfnLUNSkorXc+Y8EE5HmtOIljfickI6mVNcak=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr60380446otk.221.1594630119335; 
 Mon, 13 Jul 2020 01:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <5bf99e61-8aa2-53f0-0157-52becec1df26@redhat.com>
 <019332f6-c925-fc3f-6e0e-5d02513b28dd@redhat.com>
In-Reply-To: <019332f6-c925-fc3f-6e0e-5d02513b28dd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 09:48:28 +0100
Message-ID: <CAFEAcA_cJNQrd7JjaDUAgZJ+H_k6QriZrm7zAFJFpeqeFVgQgA@mail.gmail.com>
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32c.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 09:39, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 7/10/20 4:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > 7/ License Compliance
> >
> > https://docs.gitlab.com/ee/user/compliance/license_compliance/
>
> WRT IRC feedback QEMU licensing is a lost cause, I can not tell,
> but I think if GitLab has scripts to take care of it, it is an
> improvement over what we have now:

The docs say it only supports C programs that use the Conan
package manager. We don't, we just use configure to find and
link against our external dependencies.

>   b) New contributions will be checked for correct license by
>      a machine, so reviewer can focus on other topics.

The documentation doesn't say anything about it handling license
checking on contributions to the project itself. It looks like
it's mainly intended for "I have a javascript project that
pulls in 5000 tiny dependencies from npm, I want to know that
none of them is accidentally using a license that's not compatible
with the project's license". That's not a problem QEMU has.

thanks
-- PMM

