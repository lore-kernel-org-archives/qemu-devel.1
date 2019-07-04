Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E00AC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC772064A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 07:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQMa9Yv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC772064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hivqf-0001ob-4c
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 03:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hivo3-0000fa-S3
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hivnx-00009A-2i
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:05:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hivnu-00006P-Ta
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 03:05:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so4577517wma.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fSmyWV3zPqJMQF3LVv32DlZrnItpDQxMmvFeCWANWBE=;
 b=iQMa9Yv04Sp6CP5MOPGaiA/n/hOboFT03v42Jax7selcJ5fA/SjpXBoKBezHUTaqVv
 MegrZ7kVaZnwmdg2ESF7B9EHxOzqQ1V37fpIg+XdfYSISdDUv5yptEcV8CpD613ejfC8
 PUKwlAbq4c5sdLNXGkEkEx1iqQElpyBxzuWscZbHCwc52Wf5RiTuSY70ir6V7ijyNafA
 /ZHTBDonZ45PnAEyiPwsy5SDfU/KQsQ7pZzd9Ux0pW5cWRs349WI6ORq5HlUhno/dTpj
 M9PFsZu+m+UZ19H3ImvE1JPBXivyb0F07x9Ogpk527aPCoMa1HMs+o+OlEjax/6ExQ5T
 wBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fSmyWV3zPqJMQF3LVv32DlZrnItpDQxMmvFeCWANWBE=;
 b=alIaHR5nskuzzQBA/gTpEAIeXVw84QDsKf4k2L1bXxFBkd4rOTqGw0yD2qZKc0YBN9
 Epdiyc4tpPpkRtOhjdUInHnNEiNObQed381KJ+9P/jQHc6sidXChE/J0v1DdmveFRzh3
 +j2Lhjvaq5yi7Y32IVzdGIN+poCHqk1Ky88kwkQdrdCVzAapjZcj8JguLyzrWvFe80Aq
 s+fpCu3YZfBwMJt7GRODkqwg9l5GCG2GADUO4VcDE7QHmZC0zA60eefLUXBoLT29gDEF
 qOFANyNi+z9fXxLGUq9lZDHAXMP2gvSX4Jo5Gm0rba6rPQ4oP9hKKWAbB7WM7MaqvohP
 un2g==
X-Gm-Message-State: APjAAAUt9XjfHzWU3qa03mohY0dGTqAybleCqXyw1kenS7sJAZkr3Ioi
 lE54ex//TE23JR6QrQow+jWmEA==
X-Google-Smtp-Source: APXvYqxxdgRVNRatHZVpLbWW4IyIAuW+MZR9/zOFAP+fB8/RNeMuv7g3UX/9xoNiDOTBtaBGNFxSAg==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr11568257wmh.68.1562223911183; 
 Thu, 04 Jul 2019 00:05:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 5sm4326377wmi.22.2019.07.04.00.05.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 00:05:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA3791FF87;
 Thu,  4 Jul 2019 08:05:09 +0100 (BST)
References: <20190702102505.32044-1-alex.bennee@linaro.org>
 <CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com>
 <87wogzr01h.fsf@zen.linaroharston>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <87wogzr01h.fsf@zen.linaroharston>
Date: Thu, 04 Jul 2019 08:05:09 +0100
Message-ID: <87imsiwa8q.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Tue, 2 Jul 2019 at 11:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>>
>>> The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246=
b7c6:
>>>
>>>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pu=
ll-request' into staging (2019-07-01 17:40:32 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/stsquad/qemu.git tags/pull-testing-next-020719-2
>>>
>>> for you to fetch changes up to 83fb8fd71de2f80afd4ec83761357d5f0dacd9c9:
>>>
>>>   migration: move port_attr inside CONFIG_LINUX (2019-07-02 07:52:35 +0=
100)
>>>
>>> ----------------------------------------------------------------
>>> Various testing fixes:
>>>
>>>    - tests/vm updates and clean-ups
>>>    - tests/vm serial autobuild on host
>>>    - ensure MacOS builds do "brew update"
>>>    - ensure we test --static user builds
>>>    - fix hyperv compile failure
>>>    - fix missing var warning for OpenBSD (v2)
>>>
>>> This brings my testing back to green on all CI services. Please note
>>> the BSD installs will throw out some warnings during the setup phase.
>>> They shouldn't re-occur once the images are built.
>>>
>>
>> NetBSD vm run seemed to get stuck. Last thing in the log I have is
>> con recv: Jul  2 19:34:02 localhost savecore: /dev/rld0b: Device not con=
figured
>> con recv: Starting local daemons:.
>> con recv: Updating motd.
>> con recv: Starting powerd.
>> con recv: Starting sshd.
>> con recv: Starting inetd.
>> con recv: Starting cron.
>> con recv: The following components reported failures:
>> con recv:     /etc/rc.d/swap2
>> con recv: See /var/run/rc.log for more information.
>> con recv: Tue Jul  2 19:34:03 UTC 2019
>> con recv: NetBSD/amd64 (localhost) (console)
>> con recv: login:
>> DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
>> UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
>> /home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
>> SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
>> SendEnv=3Dno_proxy qemu@127.0.0.1 exit 0
>> ### Installing packages ...
>> DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
>> UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
>> /home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
>> SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
>> SendEnv=3Dno_proxy root@127.0.0.1 pkgin update
>>
>> processing remote summary
>> (http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.0/All)...
>> database for http://ftp.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/8.0/=
All
>> is up-to-date
>> DEBUG:root:ssh_cmd: ssh -q -t -o StrictHostKeyChecking=3Dno -o
>> UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D1 -p 33857 -i
>> /home/peter.maydell/qemu-netbsd/build/vm-test-9eyth5v7.tmp/id_rsa -o
>> SendEnv=3Dhttps_proxy -o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o
>> SendEnv=3Dno_proxy root@127.0.0.1 pkgin -y install git-base pkgconf xz
>> python37 bash gmake gsed flex bison gnutls jpeg png SDL2 gtk3+
>> libxkbcommon
>>
>> and then nothing more. I might try it again later.
>
> Mines currently slowly working it's way through the install I don't know
> if the server is slow or netbsd is just idling too much but it is
> getting through it.

FWIW it did complete and now runs fine.

--
Alex Benn=C3=A9e

