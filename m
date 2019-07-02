Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF1C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 23:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB9021993
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 23:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FnEwdVEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB9021993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiRt8-0003EK-GG
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 19:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51536)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiRnm-0002K9-RU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 19:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiRnY-0006Ej-SH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 19:02:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiRnY-00065p-1p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 19:02:52 -0400
Received: by mail-oi1-x244.google.com with SMTP id w7so424460oic.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S9qeM8vWy0uB4VAISFKtNYlTp5oUVKNejgc9HWOD0n4=;
 b=FnEwdVEc7vAcFgDhCvH1o4rEO/pdybDS1CX5gSt8804tEeKfscakO7d8wa7NgXbvcT
 to4aS/kRjDR0Z0XASB/mbZLviJxkp70ddRfIxPmb969JDQPNPOt+f+pG2Khy/iAacbd9
 //g0mhsc2DZmSeohYwuwMyL8L2iiijJQ1OvaoYEO0kUhMpqKvUuMW1dDcvG6PfZIwvoL
 qzTHpH88jP9aywelNldXBtjifz9zfkC0f4kBDvqWgdH9qRHmIGKL4wQJ7bpz1xa6iF2d
 /OmgVHrNlGODKKHtSqovpAchXE+kNKaejpsoS8ruH8GcIHM/dgHsv9igKpTl7Sz/r6hV
 +g3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S9qeM8vWy0uB4VAISFKtNYlTp5oUVKNejgc9HWOD0n4=;
 b=TT1vQ/MhXAR93hZuTjDJy4akCcE48J6+Ps8X+d9Bde6W69D81/9Wgi1zoVg6MPF1a+
 6sk4Cv5estRIUzwUWd6TWX+yLGwBLOZcpinb9g7IJJpAPqCY6rTvtYuHFD9mT9YsPVuC
 GVQ+LCkSK+P4m4wIKbnyXHSeOfk06VLliYj+tAU9JE/pYY7gB53lG718ZSO9wY3+LEgA
 7Tv/BTB6eG6x9VD10k2MfqMmnLMuk2kMT1pdBSgs+ZbuCrcucsn/hats4jOzcBNZ+nMr
 uU3VaU4xIAYEtXxJhcxvFea4O8IVAiLehbviYURmjHrByTSBFaSeLDL5n1uqbOi3JXDI
 z0YA==
X-Gm-Message-State: APjAAAVtXtYYDYs9QAINZNrBryQcQv0jwVASUbp9Xje9QoGvWmgzQc03
 pYLkKIbea3RPxFTvMC2pYP0bBQckspGTS5D1HXtHHg==
X-Google-Smtp-Source: APXvYqxb8ncffKJ+d5+zhwoST4KcnuBYQ0fVstTRdVBIwbjKnpxKOh04WGuhD5loZr0HP5H8R2dJ39WN2yE/JP54W48=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr4845337oic.170.1562108567210; 
 Tue, 02 Jul 2019 16:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190702102505.32044-1-alex.bennee@linaro.org>
In-Reply-To: <20190702102505.32044-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 00:02:36 +0100
Message-ID: <CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL v2 00/20] testing/next for 4.1
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

On Tue, 2 Jul 2019 at 11:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-020719-2
>
> for you to fetch changes up to 83fb8fd71de2f80afd4ec83761357d5f0dacd9c9:
>
>   migration: move port_attr inside CONFIG_LINUX (2019-07-02 07:52:35 +010=
0)
>
> ----------------------------------------------------------------
> Various testing fixes:
>
>    - tests/vm updates and clean-ups
>    - tests/vm serial autobuild on host
>    - ensure MacOS builds do "brew update"
>    - ensure we test --static user builds
>    - fix hyperv compile failure
>    - fix missing var warning for OpenBSD (v2)
>
> This brings my testing back to green on all CI services. Please note
> the BSD installs will throw out some warnings during the setup phase.
> They shouldn't re-occur once the images are built.
>

NetBSD vm run seemed to get stuck. Last thing in the log I have is
con recv: Jul  2 19:34:02 localhost savecore: /dev/rld0b: Device not config=
ured
con recv: Starting local daemons:.
con recv: Updating motd.
con recv: Starting powerd.
con recv: Starting sshd.
con recv: Starting inetd.
con recv: Starting cron.
con recv: The following components reported failures:
con recv:     /etc/rc.d/swap2
con recv: See /var/run/rc.log for more information.
con recv: Tue Jul  2 19:34:03 UTC 2019
con recv: NetBSD/amd64 (localhost) (console)
con recv: login:
DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
/home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
SendEnv=3Dno_proxy qemu@127.0.0.1 exit 0
### Installing packages ...
DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
/home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
SendEnv=3Dno_proxy root@127.0.0.1 pkgin update

processing remote summary
(http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.0/All)...
database for http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.0/All
is up-to-date
DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
/home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
SendEnv=3Dno_proxy root@127.0.0.1 pkgin -y install git-base pkgconf xz
python37 bash gmake gsed flex bison gnutls jpeg png SDL2 gtk3+
libxkbcommon

and then nothing more. I might try it again later.

thanks
-- PMM

