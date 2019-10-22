Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11311CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF15A20679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chgpGaZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF15A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqZ0-0008V9-1B
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMqXL-0007gO-9w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMqXI-0006BI-Ap
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:33:06 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34289)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMqXI-0006Ao-3D
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:33:04 -0400
Received: by mail-ot1-x32b.google.com with SMTP id m19so13612659otp.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ifT9Wm4jgFjzo1azh34MZt/NQ6jGmwccZ/hvCBDyV4=;
 b=chgpGaZEMknSrp+fgJihomOHlk3m41dJ35n3p6hWGXmMJTOckE+TuXgBIzgfjkqfeu
 UOyX4v17uklRWiTxVrznuxTs+76Jh6TBJ/dEONaZlNwA0ZrXUX8jDYp14HtLrsUnUgdR
 cSFLa8W6Ql5uuwNF9LtQVMHT01VN4dxO9tfekWRLepLV/TiAtFsBp1DazkKS/AMJ52ux
 gy5IK+DmzHJQiLJAcb0S8+bKsW4/89GxXqjjJAL1TWcZTNuA4A1O7jIfuFLf2By3HbOj
 vOyUfjM9TqUMFldrxrxvMxpPmyfZ364++zef5J8jTz6w39MLKBFUVIHjLHPxd9EMSDyJ
 fWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ifT9Wm4jgFjzo1azh34MZt/NQ6jGmwccZ/hvCBDyV4=;
 b=XO3q64OaQNlDquZNWwrOJ/qpHlvwCvwCNGcI3kC11s8EOT6FUOfXohYOVIrZdrEHUu
 nWdn9wXqizwgOyV7x/rCbKZgoMBsZYxwy3u0HdlHPZQVE99Zdg0cXYkY8UfnGk0uFFgD
 DjeyarinAOVzYWO1p9Gw5r3gHbp3cCBnsLOd9jfaSbbQUAhIuhVk+5zDoSF47qy9a7kd
 ZnMq8Z/FdM8YImH0sCIhGPY4UF1MQKk1rfWVd5ZT2OCA4kIWCmc+PVW5zGdczmVh7tTa
 nxB5robg9UXiK0qr6Uqm4Amb6mY4pTRQ7YPq4BVZJbX3r34/ccSivg/7QTvqp+tmLMfR
 uPvg==
X-Gm-Message-State: APjAAAWm1/dtdgZGd8XQhDo2QhHgjcqEFYP8ke0+sgRKkgT7n7yhHwAU
 5H7U1fd1jkhW13d9Olvy5OucdQHe/FF6J3uZNR0pxg==
X-Google-Smtp-Source: APXvYqwY1Se1I5IsrtzZ0rOVnlEtLqha4jgwZAoWRXFsNG5vxsFv31/D6tKc6ZKjqUDqDQbp2cQJlK1XF6J2J6E9TcA=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr1781305oto.221.1571736782589; 
 Tue, 22 Oct 2019 02:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191022075615.956-1-armbru@redhat.com>
In-Reply-To: <20191022075615.956-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 10:32:50 +0100
Message-ID: <CAFEAcA-zmrcD-6pLTMuFLYCkGrJdA8bZjkBOHwoF0fWqGzKdMg@mail.gmail.com>
Subject: Re: [PULL 00/12] QAPI patches for 2019-10-22
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 09:11, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-10-22
>
> for you to fetch changes up to 0582bce69e8688fd7dd5501d352695e5c675b89b:
>
>   qapi: Allow introspecting fix for savevm's cooperation with blockdev (2019-10-22 09:28:11 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-10-22
>
> ----------------------------------------------------------------

Fails to build:

  GEN     qapi-gen
make[1]: Nothing to be done for `all'.
Traceback (most recent call last):
  File "/Users/pm215/src/qemu-for-merges/scripts/qapi-gen.py", line
13, in <module>
    from qapi.commands import gen_commands
  File "/Users/pm215/src/qemu-for-merges/scripts/qapi/commands.py",
line 17, in <module>
    from qapi.gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
  File "/Users/pm215/src/qemu-for-merges/scripts/qapi/gen.py", line 8
SyntaxError: Non-ASCII character '\xc3' in file
/Users/pm215/src/qemu-for-merges/scripts/qapi/gen.py on line 8, but no
encoding declared; see http://python.org/dev/peps/pep-0263/ for
details
make: *** [qapi-gen-timestamp] Error 1

thanks
-- PMM

