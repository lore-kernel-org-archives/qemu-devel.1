Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFADC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212DD2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212DD2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHVcd-0004Zl-LL
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 12:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHVbb-00046u-C0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHVba-0007yY-8P
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:43:43 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHVbZ-0007t9-Vd
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:43:42 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Md6V3-1jrOFe2DxL-00aESB; Thu, 26 Mar 2020 17:43:29 +0100
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200326072352.2056553-1-laurent@vivier.eu>
 <CAFEAcA92zU5Dy9mZNTv1KtO_ApVRXvdxBZh1wsNGEyWAxAeLKQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PULL 0/6] Linux user for 5.0 patches
Message-ID: <8a0be652-78fd-a016-dde1-3cd0f6769a9d@vivier.eu>
Date: Thu, 26 Mar 2020 17:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92zU5Dy9mZNTv1KtO_ApVRXvdxBZh1wsNGEyWAxAeLKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wfetdi529IzObSjk6I3Sa+A/mrCWhClYLCM1xba7cIsDrw3EyYp
 QIpuHn4XNdRFBu41ConLF5T+oakvcnX27AabpEGZ0Y+hkLqxclKjYKBSluZSvxwtrr7QpkV
 eLVsdChwkcNIi1k0t+bu712pjrelSfvbP6kFfCmqYWgCYWR7x2IZKN8wpNc3sLEcz6LQQpc
 ePhkd6y7adSAenOvOmXwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hecaleSEvIw=:1LXbedxvvGB5KYI/UHVYDB
 NaH4GNya5xTln3f6BkXw41EkeCHkjI0BqwJdx/8W2hjurC/KT6xxx0kyKsjx5OnF4zYpgA0uf
 cAJ10qpp2ngH6hGis8Iu6u5Y3gCb/dgMUgU/XhAmJIpxke4bybroSMtQuLt9+OKV3c2ookh7A
 7f1pC0mk7NsUPPE9deKP6Z6Jnad/yPplZ6VhD9T+E16XfaVw0tpUvqx59a/ypK/0Bjn4o0rMs
 l3+Sx/ZDoegLlVshvIA2SmCDEhdm1PC6WfnMWPnXsSE0hnk4tvQ0oAHMX2lcSGzlg5z3EBUCv
 RZw/VwDT/EHOgrt/FxEVq+vzzlzkIjvN9MasF60xkNxDBME+D4E7J53WbMdyqnnkQ4L1kr5oK
 JIMgr7UWe6gHGh2aVqLkNTN4PfJephMto7fvtbwRMC8wbTPSLgIJWGh3wltGCOSrcLqD0KsMW
 IuBHDWWDXhbwTtwezkr5YcF91OBH8dILx3F16+dJ8CWtXEjZ2+GnaYVARqVufdcFAUqOKlj+i
 ez34IOjmLHCn59naDRxr592pLULpUvDH+kH6VtmYoN1soxfiQmUk6izyUDwOBP0QUbU/ih1pM
 Ud0E5j/vanLi2AHCylmViNI7Xk1Bla2yRGyXY81V7Z93gA3h60ToGz1z212vkvVCsbT9i1pcE
 Xjuz5ycI9G9EtO505a3jmOLPNLa6B6MZpFfQQUqUoYYguhyLKngm9wDUqxHjKJQ5bFfZM7AET
 Dv2kQVNR8lR0vSEuHii27t0IvgX8+drAQiZg69B/BhZc2/8w+l9BT6IMAfvgcXoDqBRRAO+pd
 s0pONhNM1M8V8z3oiOf4fos9GbQUinf+hU+iptYobAmmUKpRwQXubZIKgJTabbyFF2u1RXX
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/03/2020 à 16:42, Peter Maydell a écrit :
> On Thu, 26 Mar 2020 at 07:24, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 736cf607e40674776d752acc201f565723e86045:
>>
>>   Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>>
>> for you to fetch changes up to a52f5f87bece827a338d6eb3332e3def86fb9c33:
>>
>>   linux-user: Flush out implementation of gettimeofday (2020-03-26 08:08:54 +0100)
>>
>> ----------------------------------------------------------------
>> Emulate x86_64 vsyscalls
>> Fix syscall_nr.h cleanup
>>
>> ----------------------------------------------------------------
> 
> Still fails :-(

I would say it was expected...

I think your build dir is corrupted by a previous build.

You should have old .o file without .d file, and thus the .o file is not
refreshed (check the date of cpu_loop.o). We cannot cleanup that before
starting the build. The purpose of the cleanup in configure was to avoid
this kind of problem but I did it badly.

If you want to check incremental build, cleanup your build dir, checkout
v4.20 or master, build it, and then build the PR branch. it will work:
it's tested.

If you build 4.2.0, then master and then PR, the build dir will be
corrupted by the build of master that removes the .d files without
removing the .o files. So when you build the PR, cpu_loop.o  file
remains and is not rebuild with the new values in cpu.h.

We can't do anything to avoid that now, except removing all .o files
under *-linux-user...

Sorry for the mess...

Thanks,
Laurent



