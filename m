Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6481CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2A021872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yf1meyBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2A021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO3Eb-0001Uq-Fy
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 13:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2qY-000373-BX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO2qW-00067U-OE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:53:53 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:40345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO2qW-00067F-Ho
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:53:52 -0400
Received: by mail-oi1-x22e.google.com with SMTP id b25so2046856oib.7
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ly2KrJYeBOECbZkvxbKt/I3fNWJkcLCULL6MIwrPjVM=;
 b=yf1meyBcQLhlm22v1DrMdCmP5JmP9pciORDachE0jEJZA+y/dMkY5EJL5OZEl9I7wb
 APG9mpn71KAWZyqtXxyFkMzwpl6t+3L8lq8mgNx5NtrThLgZFQc+3bH4Lc1oI7QgTdiL
 XcqVM31cez9Dkf46esyLt4O7uspS+/GgRGva/ODmuUFJVyT8esGTEGkSqswr0Elpd0Y+
 23CxPqrZniwTxudgXuI/uENtwDLINAMXkXXVvQt4krztSzBYXOSdRWS9ytmAip6gsDus
 PuB2AF34szy4ygux+7EN44cyb8vG+1lB6KFUR6ML+mqI7vumRCurNu044ls/QgshM0Ru
 tX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ly2KrJYeBOECbZkvxbKt/I3fNWJkcLCULL6MIwrPjVM=;
 b=nvAwYyfAa7zEeyj8oYBC9lF3qj8Ek02bhsxdoc9XXBrT8yRx2jc7jQ8DkAePCq4B1p
 fr/egkGaNnDIK9f7WnxzpjHtKk8ZV2uz9faIquSoM2ZxxdUboitXCQEnrCQf1ajryAz3
 m3AzwfmL7GvteupzthS90meX07Awnu7J7jUPWRrkIrMZgDXG2sshRRaLxA22mL7XULpz
 QRk1QaofUp1KR9gqEd5KxZasBpogIzQ2VDD1lOzpdyVYlzJDatlPPRzlxonYOrClnjbR
 48D89CUi6Ts4tbFsvCQiWu247luNaVWRzruoQ7oov96WSHTzml3ZEnH99Wac1PR9KCBA
 qNMg==
X-Gm-Message-State: APjAAAW613AEMI7MNp69O3I30e2ECK/sFmODdL4M7CwyaMr/OCUYwTks
 6RsjW+3zZpHukXntAFdr7svLAmowTTrNAgxS6AIWVA==
X-Google-Smtp-Source: APXvYqx0vsoa37zR7EsQJRraQqVRguX1dCyNeET+Iok7RqOWaWfqKUk1TRPVpEnoOTsemlpVdY7hCbZ45Mtp6dBxEUo=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr3738319oia.48.1572022431446; 
 Fri, 25 Oct 2019 09:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191025063713.23374-1-alex.bennee@linaro.org>
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 17:53:40 +0100
Message-ID: <CAFEAcA-Sme=XfPdonOa6=1KAFnJcvqyg+PzNiOVpLHDsy4O+gg@mail.gmail.com>
Subject: Re: [PULL v2 00/73] tcg plugins and testing updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 07:37, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 81c1f71eeb874c4cbbb9c5c4d1a1dc0ba7391d=
ff:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2019-10-24 10:43:20 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-plugins-24101=
9-2
>
> for you to fetch changes up to 18900c2d7901680457b51b3ad3f684ef9cba8b64:
>
>   travis.yml: enable linux-gcc-debug-tcg cache (2019-10-24 22:31:29 +0100=
)
>
> ----------------------------------------------------------------
> Core TCG plugin support and testing updates
>
>   - TCG plugin support
>   - netbsd VM autoinstall
>   - various Travis dependency updates
>   - enable tcg debug for check-tcg
>   - additional Xcode build for Cirrus
>   - dependency tweak for gitlab
>

This makes the vm-build-netbsd target stop working:
looking at the log file it seems to try to do an install,
but there's a pkg_add command failure and then it
times out because it expects a menu with an 'Enable sshd'
option and it isn't there:

con recv: >a: Host                      ftp.NetBSD.org
con recv: b: Base directorypub/pkgsrc/packages/NetBSD
con recv:  c: Package directory/amd64/8.1/All
con recv:  d: Userftp
con recv:  e: Password
con recv:  f: Proxy
con recv:  g: Additional packages
con recv:  h: Configure network
con recv:  i: Quit installing binary pkgs
con recv:  x: Install pkgin
con send: x<enter>
con recv:  and update package summary a: Host
ftp.NetBSD.org>x: Install pkgin and update package summary
con recv: Status: RunningCommand: pkg_add
http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.1/All/pkgin
con recv: -----------------------------------------------------------------=
---------------pkg_add:
Can't process http://ftp.NetBSD.org:80/pub/pkgsrc/packages/NetBSD/amd64/8.1=
/All/pkgin*:
Not Found
con recv: pkg_add: no pkg found for
'http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.1/All/pkgin',
sorry.
con recv: pkg_add: 1 package addition failed
con recv: Command failedHit enter to continue
con send: <enter>
con recv: Enabling binary packages with pkgin requires setting up the
repository.  The
con recv:  following are the host, directory, user, and password that
will be used.  If
con recv:  "user" is "ftp", then the password is not needed.
con recv:
con recv: >a: Host                      ftp.NetBSD.org
con recv: b: Base directorypub/pkgsrc/packages/NetBSD
con recv:  c: Package directory/amd64/8.1/All
con recv:  d: Userftp
con recv:  e: Password
con recv:  f: Proxy
con recv:  g: Additional packages
con recv:  h: Configure network
con recv:  i: Quit installing binary pkgs
console: *** read timeout ***
console: waiting for: 'g: Enable sshd'
console: line buffer:

con recv:  x: Install pkgin and update package summary

Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 362, in m=
ain
    return vm.build_image(args.image)
  File "/home/peter.maydell/qemu-netbsd/tests/vm/netbsd", line 173, in
build_image
    self.console_wait_send("g: Enable sshd",           "g\n")
  File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 262,
in console_wait_send
    self.console_wait(wait)
  File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 224,
in console_wait
    chars =3D vm.console_socket.recv(1)
socket.timeout: timed out


I tried a couple of times and it failed the same way both times.


thanks
-- PMM

