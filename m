Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4E1C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA12E2072C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itGlp9/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA12E2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFk31-0007fm-0T
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFk2R-0007GW-JL
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFk2Q-0003bB-0U
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:44:07 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:42797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFk2P-0003as-Np
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:44:05 -0400
Received: by mail-oi1-x22e.google.com with SMTP id 13so10421338oiy.9
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NEk2qgjf+cDAcrDFogVFeelmvrXXXeP76Nomtm9c3lA=;
 b=itGlp9/7h6yrDnn0rfpgsgdYco4nZt38zBbqVriA86bby0/iwO7wVjIzAoPzKdjk4Z
 Eh3LL9sWkkkZacLjb+KsdG+ePO8PB52M+H2egGvb4T9d+bQPokvj4EdikqgKvxa9oG9t
 tlztaDDUfkEFSSx66rmw+pHQeWdu+ewEDfyc4Q9mFQ15lc/xOkSV9dJo87PP7BuZKb/2
 UNn34EVnG/XotiZKI+Ple9fjffhl0FRLdaDophmHvGWep8/gHkZCBn8OWDd/iGrDehrm
 wWzltcWs3S4jcNJle+TMzyiqBQamnS15fE12TH4samGubaSYTj1yw6beZALCok3W7PSx
 1d/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NEk2qgjf+cDAcrDFogVFeelmvrXXXeP76Nomtm9c3lA=;
 b=neP6ectZ4msP3f37SE6UVtEbHCtNid4i689tvQhM74efe5c8vOQuYghFUQ2CQJnEgQ
 Cbyy/wNfMcNY8TV2N9E2bVMnToExoJ6eBtMsV1ST5tQvGnATU/uz4AE1W9fNokRESN3f
 undhUuvVOqRofIR1l3x+g+a6XqrUd1guYzAeSd0LbXySUrr7GUELQJq5cZFqZI4p8L6s
 VHO59E8TjrGV861QO8Y8CErthBiNk7fZvVy9gZHw8cOjzAUUd7ehCwQMtS00JJlUXAmx
 Yv+Kpb4JYVGsAep+au+fEQFF7AvnQA9Xx8BCCPOIqguiMJb5G7dduKGfyPhR0OqOoLXw
 hKcw==
X-Gm-Message-State: ANhLgQ0XR7PlmuHTuJb0fo3O6lW0MPP2RZlRfNS8fGWSNk5M1W60z+//
 hyXSXPL4QtSs2kOZy2kUn+pKmNSTQyMaQA43OQg5bQ==
X-Google-Smtp-Source: ADFU+vt6l+KeS1RmrOSVxTOQd89L90oraCA+aootkjuVdyQYPnSL8oGaM7cW5EpeUImNsOK0Xxyp87lTzLHFBMpeRUY=
X-Received: by 2002:aca:190f:: with SMTP id l15mr11080656oii.48.1584819844248; 
 Sat, 21 Mar 2020 12:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200320155106.549514-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200320155106.549514-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Mar 2020 19:43:53 +0000
Message-ID: <CAFEAcA-RBQGQm+oM0xe27tQgYgpH-PEvcoAXLjcq4+X7c7=jUQ@mail.gmail.com>
Subject: Re: [PULL v2 0/1] Slirp patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 15:51, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit f57587c7d47b35b2d9b31def3a74d81bdb5475=
d7:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-03-17'=
 into staging (2020-03-19 10:18:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/slirp-pull-request
>
> for you to fetch changes up to aa63573a84c92b14c23f557fcc93a12b1a93c187:
>
>   slirp: update submodule to v4.2.0+ (2020-03-20 16:50:12 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>   slirp: update submodule to v4.2.0+
>
>  slirp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi; this fails to build on most platforms (though it works on
the BSDs, oddly):

/home/ubuntu/qemu/slirp/src/version.c: In function =E2=80=98slirp_version_s=
tring=E2=80=99:
/home/ubuntu/qemu/slirp/src/version.c:7:12: error:
=E2=80=98SLIRP_VERSION_STRING=E2=80=99 undeclared (first use in this functi=
on); did
you mean =E2=80=98LIBSLIRP_VERSION_H_=E2=80=99?
     return SLIRP_VERSION_STRING;
            ^~~~~~~~~~~~~~~~~~~~
            LIBSLIRP_VERSION_H_
/home/ubuntu/qemu/slirp/src/version.c:7:12: note: each undeclared
identifier is reported only once for each function it appears in
/home/ubuntu/qemu/slirp/src/version.c:8:1: error: control reaches end
of non-void function [-Werror=3Dreturn-type]
 }
 ^
cc1: all warnings being treated as errors
Makefile:45: recipe for target
'/home/ubuntu/qemu/build/all/slirp/src/version.o' failed


thanks
-- PMM

