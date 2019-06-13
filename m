Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FEC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05FFC20896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIW5CD0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05FFC20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMOs-0007ct-AG
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbMJJ-00026D-3E
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbM5M-000575-4m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:31:57 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:32853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbM5L-00050w-St
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:31:56 -0400
Received: by mail-ot1-x335.google.com with SMTP id p4so15087386oti.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lMwlrDlAqDz/fy6DIPcDYB9RHfW88ItwY6g3u1uXDAk=;
 b=TIW5CD0Fvy07P89y8Vg2+NH5Wta5/uK4umBH9WG3HmKD09aWhlO5GyXclvZGiiDRoX
 ISkCIXEgRCmCgz9qttBI2AaDOYuLFcrmMN/s5MxzXYtAPUPQ5M/UB8LLYKUzO1o4pqGQ
 XCkF6ECgf+Jj6cbe7mX/b2uUCulxziCvdad9BBRcB7k9vRjfesnOWKO74TV4lpw+yQvY
 vWj9sNIjz3YxA8CaogsuuB2OQLmO2fSjTh5YjASGzMNrKVkWqbC30/xkzPE6CnftdmtR
 h6tKHMi9qvPnrs7YjDGxXTYfNMu2gFmHmco2JXJd3212DkYGjDIPI9YpGhOAuKbTWrRa
 y9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lMwlrDlAqDz/fy6DIPcDYB9RHfW88ItwY6g3u1uXDAk=;
 b=b4V8XUeqn2JYQduCxeEk5k+JmK/F1JQ9S6Tzt+ZVcjqOksAdd4RZRI9yLNKbcqne6K
 TX9/53FtQNKxviNuKprxshDqseWTJeXwkWfBw/Krhu7pne2RbaRhrivsWMOGP44ouMNq
 +UoojSkHO4rZYrHOBWH2s8pRdqcYRVeLCAGw9yAMxwFsY8eLupL6VaDkLqqERztDecih
 OFUe91cKGFNZo7HFjcGiTeNnK0j1GJikfs+iKmB2uNPSDQgICf747VPsJcEMQe9XK+t1
 Ac95y0dVm/H4c2iCc3tjsqHE3qnz7z50wqhJzviCdQgb0Fc5NuPFkJtxqXrvUOJVS2xo
 BsRg==
X-Gm-Message-State: APjAAAUPHkJIGNFYDb+g9WtN8ZkCizH2ygTgnclmH7KT+4gtO9dFffT/
 /U06F0ScCUMRMHkW4z6+Fn29teCVd/m/7JUIi1KPTwDvGYM=
X-Google-Smtp-Source: APXvYqzvaZPTFikx4n2OSI2eufR//+Bj472uxyVsjdxYPImrmiQolLg5UZlF27dc/ezpY5hxwhrtaD8ZW0vf/6d/RKw=
X-Received: by 2002:a9d:630a:: with SMTP id q10mr7526179otk.91.1560418303350; 
 Thu, 13 Jun 2019 02:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190612173121.21057-1-alex.bennee@linaro.org>
In-Reply-To: <20190612173121.21057-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 10:31:32 +0100
Message-ID: <CAFEAcA-MMKxX3kR_Od3J53D4ueE8PZHOgu1R3hzGX9Ruu+8NNw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL v3 00/40] testing, gdbstub and cputlb fixes
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

On Wed, 12 Jun 2019 at 18:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit a050901d4b40092dc356b59912c6df39e389c7=
b9:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190612=
' into staging (2019-06-12 14:43:47 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-gdbstub-cputlb-12=
0619-3
>
> for you to fetch changes up to ab4752ec8d9b0b19ab80915016b739350418a078:
>
>   gdbstub: Implement qemu physical memory mode (2019-06-12 17:53:23 +0100=
)
>
> ----------------------------------------------------------------
> Various fixes and updates:
>
>   - editor config tweak for shell scripts
>   - iotest updates (still not default for make check)
>   - various docker updates
>   - gcc/ubsan updates for travis
>   - some clean-ups for tests/vm (no serial autoinstall)
>   - semihosting fix for Coverity
>   - fixes for cputlb in 64-on-32 cases
>   - gdbstub re-factor + maintainership update


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

