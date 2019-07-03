Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DDFC06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8B2218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgOzH06Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8B2218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiakM-0001ww-1j
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48775)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hiagc-0000HO-Pg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hiagb-0006k7-Bz
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:32:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hiagb-0006eY-3w
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:32:17 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so1248355wme.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iJusIeBo3PgQo5lnRIvGUEsBR8ktZnvm+YjDIWu5+kc=;
 b=VgOzH06YHKpfXu2dF8+JINksWix+lcw4PHmmvDxmRAZAXqWwqXdFk6aKGUyhW2fMzI
 4B3fJtIQZIm94cc+EsZXVRFJEtSGbef72JC8W3MszQ819e0m5CrLMtQxuv4AbTwd1B/x
 bVxpk+sY3k8DJbQXZ+FSHz4YiJgx+m86a6KJo8m9xDNhJEOVG0q+LX0Q+eG+bgqV6Ip5
 aXZC9rx9wAuxhZyBn4nGCe37NvIFed+5zVI664v2RXRXjZJ49U7a+86fCZtQVH+qnA4W
 ABPW31dwGUjSZIWor9vO4SUYUqmYBEpODsHxUdtkDfMf63qSVlNScnBJwNuxh42vAgpL
 ai6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iJusIeBo3PgQo5lnRIvGUEsBR8ktZnvm+YjDIWu5+kc=;
 b=dg/qQU9s9a0Mfi7jB4udT/8SvYNVQOad9/RGqkWqq5uxGvw9RepsBRcD85LZOJW78J
 ED1DR8tIE70ED7l+3QrzH0fgltOyrVti2oiT1kFb0di+61oOGpy7J2eCsN3p5ynShM3H
 G7cIOEeWg6iP2ZI1LkhoCUKSMyV1+Z0rRIZEZH34rXM2qoGLDkJVbNOOW5Vgs/N4VJag
 N6aeq4CPSVQ8HRRdxh0xHphETVaNL2D0nGswHq3wKiFDT9CULloL8yqig70Zo3eKZQpY
 0+xcJI/Krxl0Eoka0rQu2XbXbiC6kIjkxZqincig9f5Mb8qzHRtlhpTcY0rf5lxs2bUe
 6BsA==
X-Gm-Message-State: APjAAAUnQbZ6sYOBCJooSNAWSgrjBZzm7ASEWYaIHoILO3B2ohTNsWDR
 i1AG+UsYBdReKbOC57XkftZs6A==
X-Google-Smtp-Source: APXvYqxJYe6X7FatSKG1q9x1CF6v5F+5sERIuKTAcu1L6a/P56e/tmS+kFq2Y0ph8wkjTibg8q+T6g==
X-Received: by 2002:a1c:1a88:: with SMTP id a130mr6934195wma.149.1562142731675; 
 Wed, 03 Jul 2019 01:32:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b203sm1836583wmd.41.2019.07.03.01.32.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:32:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ADF801FF87;
 Wed,  3 Jul 2019 09:32:10 +0100 (BST)
References: <20190702102505.32044-1-alex.bennee@linaro.org>
 <CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com>
Date: Wed, 03 Jul 2019 09:32:10 +0100
Message-ID: <87wogzr01h.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 2 Jul 2019 at 11:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b=
7c6:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pul=
l-request' into staging (2019-07-01 17:40:32 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-next-020719-2
>>
>> for you to fetch changes up to 83fb8fd71de2f80afd4ec83761357d5f0dacd9c9:
>>
>>   migration: move port_attr inside CONFIG_LINUX (2019-07-02 07:52:35 +01=
00)
>>
>> ----------------------------------------------------------------
>> Various testing fixes:
>>
>>    - tests/vm updates and clean-ups
>>    - tests/vm serial autobuild on host
>>    - ensure MacOS builds do "brew update"
>>    - ensure we test --static user builds
>>    - fix hyperv compile failure
>>    - fix missing var warning for OpenBSD (v2)
>>
>> This brings my testing back to green on all CI services. Please note
>> the BSD installs will throw out some warnings during the setup phase.
>> They shouldn't re-occur once the images are built.
>>
>
> NetBSD vm run seemed to get stuck. Last thing in the log I have is
> con recv: Jul  2 19:34:02 localhost savecore: /dev/rld0b: Device not conf=
igured
> con recv: Starting local daemons:.
> con recv: Updating motd.
> con recv: Starting powerd.
> con recv: Starting sshd.
> con recv: Starting inetd.
> con recv: Starting cron.
> con recv: The following components reported failures:
> con recv:     /etc/rc.d/swap2
> con recv: See /var/run/rc.log for more information.
> con recv: Tue Jul  2 19:34:03 UTC 2019
> con recv: NetBSD/amd64 (localhost) (console)
> con recv: login:
> DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
> UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
> /home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
> SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
> SendEnv=3Dno_proxy qemu@127.0.0.1 exit 0
> ### Installing packages ...
> DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
> UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
> /home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
> SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
> SendEnv=3Dno_proxy root@127.0.0.1 pkgin update
>
> processing remote summary
> (http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.0/All)...
> database for http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.0/A=
ll
> is up-to-date
> DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
> UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
> /home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
> SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
> SendEnv=3Dno_proxy root@127.0.0.1 pkgin -y install git-base pkgconf xz
> python37 bash gmake gsed flex bison gnutls jpeg png SDL2 gtk3+
> libxkbcommon
>
> and then nothing more. I might try it again later.

Mines currently slowly working it's way through the install I don't know
if the server is slow or netbsd is just idling too much but it is
getting through it.

--
Alex Benn=C3=A9e

