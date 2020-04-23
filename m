Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C180C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 21:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6507C2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 21:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aS6x3C3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6507C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRjPc-0001RY-Bl
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 17:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRjOZ-0000t4-P9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRjOX-0001L8-TC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:28:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRjOX-0001KK-BQ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 17:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587677307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaKUjULDJQxShnXsKr2H+9F8TBaTdkaqK6TJoi8KR0U=;
 b=aS6x3C3VvDjatGpO6p175/l9gUcEF0zfnwykfVTPKnl6y1Nb1aQbH+Cga1u4TTwN8qq0oB
 vUAIv0G/QU0axf4v4Nh3jDT1I52cLt+/BlAbcUdGDdETr+JoQwhNg2pmfeaVPzVv2GpcV3
 CP6fRiAD2pRHbhwuifzztxV0Fg5egJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-zlFAatinO8Wt7lkYxM7U_A-1; Thu, 23 Apr 2020 17:28:25 -0400
X-MC-Unique: zlFAatinO8Wt7lkYxM7U_A-1
Received: by mail-wr1-f71.google.com with SMTP id o8so3040075wrm.11
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 14:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dYdrQq1cGRxNO0E3oDY/nwbmZGXB1nzu2PZqEd7Y238=;
 b=VTcx58r2taD5cnGyGZI5nrkOR4BCnCZnXmukfqLauqXgLBJDmTdRyyL3733XqMC85W
 yP3gd/FbdIPbnfECu/v/h5XsaSGtmMTp34yYjsMmu3lj/fTL3u7DivR+qqob27gEAfLt
 fRiT9YTrd2BIiis7wXFMusajwWTOQF354+ZIsIyxtXjEH7RUGtXEu9apaHH6tU0DlBXp
 yKt0gcAmD81mGqEb8OoTbzIVOGLy9KoEt3BUVIWayDJ3gYBpPnG+HTZTK/7SCWJF/qx6
 AHgE5JZwGYk/nkRa1M/chwQeBZIk7ag/kiglqXv7TNy3yewl5Q+SQUESn+GnkEZrSlCD
 27NA==
X-Gm-Message-State: AGi0PuZ8etfCC9F2+7vCCiGKLj5DFOuGImXBFAdnrY4/Yk/HWbCT8mdU
 aQTOL32Ypgi67nw5kDb5TUvq5YLfZ+lZ1G/3u6hePBsa6zvIgo50YvlYFbPfKo/hXyq3FgoxvHS
 7t8CxLUKCieYkmzc=
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr6236715wmj.101.1587677304496; 
 Thu, 23 Apr 2020 14:28:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypI4UYf+3v18HI8ojuM58y6Sz5IuGFgz2iFeNc0yJYgPzVdEuXfd7fAy904+0EVfdZDCGy7Uvg==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr6236685wmj.101.1587677304201; 
 Thu, 23 Apr 2020 14:28:24 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 33sm5666796wrp.5.2020.04.23.14.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 14:28:23 -0700 (PDT)
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
Date: Thu, 23 Apr 2020 23:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200423171322.GJ1077680@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Erik Skultety <eskultet@redhat.com>, Wainer Moschetta <wmoschet@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 7:13 PM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Apr 23, 2020 at 01:04:13PM -0400, Cleber Rosa wrote:
>> ----- Original Message -----
>>> From: "Peter Maydell" <peter.maydell@linaro.org>
>>> To: "Markus Armbruster" <armbru@redhat.com>
>>> Cc: "Fam Zheng" <fam@euphon.net>, "Thomas Huth" <thuth@redhat.com>, "Be=
raldo Leal" <bleal@redhat.com>, "Erik
>>> Skultety" <eskultet@redhat.com>, "Alex Benn=C3=A9e" <alex.bennee@linaro=
.org>, "Wainer Moschetta" <wmoschet@redhat.com>,
>>> "QEMU Developers" <qemu-devel@nongnu.org>, "Wainer dos Santos Moschetta=
" <wainersm@redhat.com>, "Willian Rampazzo"
>>> <wrampazz@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Philippe Math=
ieu-Daud=C3=A9" <philmd@redhat.com>, "Eduardo
>>> Habkost" <ehabkost@redhat.com>
>>> Sent: Tuesday, April 21, 2020 8:53:49 AM
>>> Subject: Re: [PATCH 0/5] QEMU Gating CI
>>>
>>> On Thu, 19 Mar 2020 at 16:33, Markus Armbruster <armbru@redhat.com> wro=
te:
>>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>>> I think we should start by getting the gitlab setup working
>>>>> for the basic "x86 configs" first. Then we can try adding
>>>>> a runner for s390 (that one's logistically easiest because
>>>>> it is a project machine, not one owned by me personally or
>>>>> by Linaro) once the basic framework is working, and expand
>>>>> from there.
>>>>
>>>> Makes sense to me.
>>>>
>>>> Next steps to get this off the ground:
>>>>
>>>> * Red Hat provides runner(s) for x86 stuff we care about.
>>>>
>>>> * If that doesn't cover 'basic "x86 configs" in your judgement, we
>>>>    fill the gaps as described below under "Expand from there".
>>>>
>>>> * Add an s390 runner using the project machine you mentioned.
>>>>
>>>> * Expand from there: identify the remaining gaps, map them to people /
>>>>    organizations interested in them, and solicit contributions from th=
ese
>>>>    guys.
>>>>
>>>> A note on contributions: we need both hardware and people.  By people =
I
>>>> mean maintainers for the infrastructure, the tools and all the runners=
.
>>>> Cleber & team are willing to serve for the infrastructure, the tools a=
nd
>>>> the Red Hat runners.
>>>
>>> So, with 5.0 nearly out the door it seems like a good time to check
>>> in on this thread again to ask where we are progress-wise with this.
>>> My impression is that this patchset provides most of the scripting
>>> and config side of the first step, so what we need is for RH to provide
>>> an x86 runner machine and tell the gitlab CI it exists. I appreciate
>>> that the whole coronavirus and working-from-home situation will have
>>> upended everybody's plans, especially when actual hardware might
>>> be involved, but how's it going ?
>>>
>>
>> Hi Peter,
>>
>> You hit the nail in the head here.  We were affected indeed with our abi=
lity
>> to move some machines from one lab to another (across the country), but =
we're
>> actively working on it.
>=20
> For x86, do we really need to be using custom runners ?
>=20
> With GitLab if someone forks the repo to their personal namespace, they
> cannot use any custom runners setup by the origin project. So if we use
> custom runners for x86, people forking won't be able to run the GitLab
> CI jobs.
>=20
> As a sub-system maintainer I wouldn't like this, because I ideally want
> to be able to run the same jobs on my staging tree, that Peter will run
> at merge time for the PULL request I send.
>=20
> Thus my strong preference would be to use the GitLab runners in every
> scenario where they are viable to use. Only use custom runners in the
> cases where GitLab runners are clearly inadequate for our needs.
>=20
> Based on what we've setup in GitLab for libvirt,  the shared runners
> they have work fine for x86. Just need the environments you are testing
> to be provided as Docker containers (you can actually build and cache
> the container images during your CI job too).  IOW, any Linux distro
> build and test jobs should be able to use shared runners on x86, and
> likewise mingw builds. Custom runners should only be needed if the
> jobs need todo *BSD / macOS builds, and/or have access to specific
> hardware devices for some reason.

Thanks to insist with that point Daniel. I'd rather see every=20
configuration reproducible, so if we loose a hardware sponsor, we can=20
find another one and start another runner.
Also note, if it is not easy to reproduce a runner, it will be very hard=20
to debug a reported build/test error.

A non-reproducible runner can not be used as gating, because if they=20
fail it is not acceptable to lock the project development process.


In some cases custom runners are acceptable. These runners won't be=20
"gating" but can post informative log and status.

[*] Specific hardware that is not easily available.

- Alistair at last KVM forum talked about a RISCV board
   (to test host TCG)
- Aleksandar said at last KVM forum Wavecomp could plug a CI20 MIPS
   (to test host TCG)
- Lemote seems interested to setup some Loongson MIPSr6 board
   (to test interaction with KVM)

[*] To run code requiring accepting License Agreements

[*] To run non Free / Open Source code


Owner of these runners take the responsibility to provide enough=20
time/information about reported bugs, or to debug them themselves.


Now the problem is GitLab runner is not natively available on the=20
architectures listed in this mail, so custom setup is required. A dumb=20
script running ssh to a machine also works (tested) but lot of manual=20
tuning/maintenance expected.


