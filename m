Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60606C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D8C206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D8C206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVahV-0003aQ-6p
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVaOj-0005kI-2p; Mon, 04 May 2020 08:40:37 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVaOh-0005pY-VE; Mon, 04 May 2020 08:40:36 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MoOIi-1ilZPt1tn6-00ooyX; Mon, 04 May 2020 14:40:33 +0200
Subject: Re: [PULL 00/20] Trivial branch for 5.1 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200504115758.283914-1-laurent@vivier.eu>
 <CAFEAcA_FDt+1+ezAyRE-fwdd=VuG5YNThkKiHHTUOYqtRHLoyg@mail.gmail.com>
 <CAFEAcA-V=ZF8rLv82fmj=3NgHcUNvCs_Ddm5k9FnfssgDr8c_w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1db74c14-73d1-5bad-399d-dcf8b9b1465f@vivier.eu>
Date: Mon, 4 May 2020 14:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-V=ZF8rLv82fmj=3NgHcUNvCs_Ddm5k9FnfssgDr8c_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8SyDX1E/g6D/LDQcei/ciZqPR6djVTZBEfcBrTBGa55l64j2Er1
 R4h+IFzHvBDhWXVnF1X17WDLqrXC9zYpAbHxI4fyh/MzqMxn8KcngZAfC52LMvYu+1bUJIc
 aUR3CofvWccBrRY5YE/tPVfTbvFodzxYOdI9MWjQ37XroXijy80b0G3im3KQSJSmJXQcCOs
 q1vmDwWK/ldlapU87CEwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h18ngT07mSA=:7gapVRHyzSSbM1fQLwgzQ7
 VW9WIEr2w1TyhZwAogilEpBzOO5Fy99Ri7E6Md02WI4+3u1kdEIYjQJTsQ9XZV2exY+km/lUa
 CEPG1HpuCEtiwF5/rpxS3LqNErXNBr30zGlunxTFvdi50uen++GGPIC3kjLxIFNrvjgoIF6xv
 V/oF+p1mmtEuVsFYd/byamEOKkb0bX45r8Hy3n4FAo1wVSWh/UCnwzLFWiFNMeie27qCOm8pX
 g6uoAukEXnPiX9Sy9nOKAX8UHgh2fR1sFPpAUBIaiTnUjmkVCN2gRO842F/ZrMBbrGkMT1eyp
 wuVlSIlOOM0dCTsfmVA4Rclnw9SiSsI2TzO7WyJPgQ/7bSpgyHu4S3fNejdiJQESJuqMSFFim
 kONOfxuyhRcbOeSwQuDr7pebPPdXG9b+aB6iHvTtAl1NbNZCeVb5KmIaLzALuGi7OtGDyS1s2
 dNJorny0B1UOfDIFBMaXY6Z2ibC9UIHs5y+AJNBcHD0HGDac+nTsTO1XhNhrYco3vno4CB06Z
 rFlDeWnPpaKhIqWVHkieST/T5RyhEF9OkODN69SxdwGwOM76vgAnyH/WU69+XPiXoTFBFMt3n
 zD0jWib1gCs/JpJjUhfDZOB9oVxh91QAJ/Z6Z1RiKp/sFsoMISa30iwdpvvs3mlC5jJJVb/pR
 +Dr8ijiEA+X2eeGY+mFFx+EhV91q1ogFEXoSKdWSyr7jKPKva51He6yZMZH+fg9U8cioQQSGU
 d8bu6VXCxGCgEP7esPTNNF100ufQqGhl8hywHlQUuOPr24wZOOXdlnPE1Z1ZRRuLy9Eu47rj0
 94SiX59743Xsw9JJiqEgzZBKNHsRpN3zKLcxrHiHgJhawUZ7Oft/cdxad/s7k8VXy0g+5Y8
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:40:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/05/2020 à 14:34, Peter Maydell a écrit :
> On Mon, 4 May 2020 at 13:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 4 May 2020 at 13:05, Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56ce835:
>>>
>>>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into s=
>>> taging (2020-05-03 14:12:56 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request
>>>
>>> for you to fetch changes up to 4341a0106781043a708c061b676312e5bb5d4488:
>>>
>>>   hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning (202=
>>> 0-05-04 12:06:21 +0200)
>>>
>>> ----------------------------------------------------------------
>>> trivial patches (20200504)
>>>
>>> Silent static analyzer warning
>>> Remove dead assignments
>>> Support -chardev serial on macOS
>>> Update MAINTAINERS
>>> Some cosmetic changes
>>
>>
>> Compile failure, OSX:
>> /Users/pm215/src/qemu-for-merges/block/file-posix.c:1620:9: error:
>> unused variable 'ret' [-Werror,-Wunused-variable]
>>     int ret;
>>         ^
>>
> 
> This one also shows up on FreeBSD and OpenBSD (and maybe NetBSD, that
> result hasn't come back yet).

I'm going to update  PATCH 11 to move the "int ret" inside the #ifdef.

Thanks,
Laurent

