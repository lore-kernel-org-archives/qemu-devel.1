Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA7BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C8120723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 08:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C8120723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeajY-0003vi-Oo
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 04:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeaiw-0003D6-Ce
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:50:42 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeaiv-0000ya-63
 for qemu-devel@nongnu.org; Fri, 29 May 2020 04:50:42 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MNfgZ-1jLYnN0uZ1-00P3uY; Fri, 29 May 2020 10:50:38 +0200
Subject: Re: [PATCH 0/2] linux-user: Load a vdso for x86_64
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200519194452.9009-1-richard.henderson@linaro.org>
 <CAFEAcA8q-4o3yWX2kwS1inPiajP1yzc3NOLBjzQUubKzDNGhhw@mail.gmail.com>
 <e985a1cb-e4e3-6faa-f158-5e797d0b5e92@vivier.eu>
 <f46f5f0a-3a56-538a-e703-0a6afb78ae3d@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <069efc7b-9798-0895-22a8-9c72305bd0b7@vivier.eu>
Date: Fri, 29 May 2020 10:50:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f46f5f0a-3a56-538a-e703-0a6afb78ae3d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BziVsQb/cObTecNYUwpQ+UMFY79onjycJTXJG1x5FyRShklqp40
 6e75zSKCwuzMWYBt7VjqNuO3MslTGoUQPoIngGpR+hhOnL6y24uRgsspV0YEqm3SvkyHQ7d
 nRMyogjNjPDMpmwh07sjIKIRYFI1cQXpyL75JEWkl8WCCxw8i1hwMHwST1u4SjwuQqZay3P
 D8+ZigeHj7t1TDVKZTwWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mtrCZHMLKUc=:Baf13r5ruZ/JmCjqlWDKmg
 9OAyKfM+4VBRCavIZDOe3hv5WpVnBOSfThqnk38Kl6l4p1SHNPCqMfeI0dmOQzc38FypCNjxi
 dC0bm1Xwwp1YwD0ifiCE61tMeIz4AKFvY/ox0HO3dF+KV0zpgO60IpZKHkaIPJPAt7UwFhZK6
 d2f0TlCJDd8Ur7ngDSrsdx28Uzd8YLkE68JBuSMbi2eL0Y18CO2Ctr65sRbdaAU/yyCy9XrS0
 BO60tQTEu974ynI9vMc200c+7Rx6HHUpi4mNl2KxuYuqUbTDHv54C0x+/lzIPy0rqRsSlQtS6
 R6l5PiWdRe2B+6qDwhwiK8rOkiVFtWQ4Q7OjGT8FEJuJtBVSF02eg25bhJBxmOJH5O17uEKJ3
 v47JMtZefH/zBWlCcdClwu9aTyPP2TyYRbdInsxuu2h/CWXgUaNJWPMhfy0xibLj3OJBuj7Yi
 756sY/kKX6rt72T2TcChR/ae2i/YEeZGNUfGVTMqufIly/Qx+eerJr60c8S/leCCgsMTmzey0
 9t2VTsCBPse6bshg2vAz+H0HiJja6SSnjGSeNduQpSeyrPrJglzw4n9j4sGyqeExDReukPCu0
 InWNJ6KH+G94X/NOtmVHoTYUK3u8JeVT2V51U6N7JjbfGzjP74zRwF1b0HFctd13eWCv/CIiJ
 Odnp+f1he5iPoPXpWV6czuN3rmrl9ezujaQO1wNa7LaCkjXn0wuGCN9emtwoeUpgrFrYZgDSI
 2s1gxObbjL8oSKi3JRktL6uQKXKZQYz7tn+jQvfSBOH0wEn/ZU5hwmx8rJStVBTloQwPGx4MI
 Qqw2icsZ0nRcTFUR2wC9jhrKIBG0v1th+PgBeXgwnQ8/L7laE8508/2DGiM/0DixXbPOsDz
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 04:50:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/05/2020 à 23:42, Richard Henderson a écrit :
> On 5/28/20 3:32 AM, Laurent Vivier wrote:
>> Le 28/05/2020 à 12:08, Peter Maydell a écrit :
>>> On Tue, 19 May 2020 at 20:45, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>  Makefile                  |   4 +-
>>>>  linux-user/elfload.c      | 203 +++++++++++++++++++++++++++++++++++++-
>>>>  pc-bios/Makefile          |   5 +
>>>>  pc-bios/vdso-linux-x64.S  | 115 +++++++++++++++++++++
>>>>  pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++
>>>>  pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes
>>>
>>> I'm not really a fan of binaries in source control :-(
>>
>> Can't we see that as a firmware or a ROM?
>> It's only 7,4 KB and needs a cross-compilation env to be rebuilt.
>>
>> Do you have another solution?
>>
>> If you don't like this I can remove the series. Let me know.
> 
> I think some more of the questions in the cover letter need answering.  Does
> this patch set not break your own --static chroot tests, for example?

I will test my branch with this series in my --static chroot and remove
the series before the PR.

Thanks,
Laurent

