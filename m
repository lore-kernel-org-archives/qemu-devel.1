Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94145C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A412206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A412206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPA1G-0006MA-Hl
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jP9z3-0005N4-U9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jP9yv-0003FM-GM
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:15:30 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55679)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jP9yv-0003Dk-7W
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:15:25 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MMoT4-1jhvHp3zl6-00InZm; Thu, 16 Apr 2020 21:15:22 +0200
Subject: Re: [PULL 0/1] Linux user for 5.0 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200416152829.790561-1-laurent@vivier.eu>
 <CAFEAcA9J=H7RMEEY5BmL=2ObKJDzMQQeWvbUnYYJfxFsntbP6w@mail.gmail.com>
 <2ee4258c-cb88-cdd7-78c2-4f5ac4b008ae@vivier.eu>
 <CAFEAcA-UWSJDvq5xmn2GTKY2zAgenkM7whdvn6FiY1+pUKBhcA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <90666b58-6e4e-8f4a-c27a-eed2ce2a73a3@vivier.eu>
Date: Thu, 16 Apr 2020 21:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UWSJDvq5xmn2GTKY2zAgenkM7whdvn6FiY1+pUKBhcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QI3prh46gufMz8X90tc1DirRpeVBxGUoeZ2OyIcKQP5yQ4KdD7b
 LMG20vSUl0k+LhHtc499aE7eUFlmRNP9pgmhjNgNzfcRN8cnpa7FA548fkx9l8fv9s3PQr0
 x4oeQfIQnMDRMGNseNPBcHEo2C/WzCRnwbk0cWxwtjY2Rqi574YRl5A/kmBMiWRl/wpQf0N
 ZsOXs/buXPO/UcQ4DKHvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G1YXO2dwRpo=:tA1GC9+xuwFtlb1UiKJirP
 pqul3L0tTr6GU1OsEED0ggM6IetNeyL+E5mV5zMhN6YTnxd7nQRRySFl+OBfeDgHRncs+UMff
 LAFkdB/wYGqiC1Tdng+oMiPsVfqBsQqTwrIGk3X5Joi6UfFSLVQbE0EqLN1RJbP+JwKr8PTKX
 DhgvtX/LyyzXBulC/WJdZTb1c5pPpqCuT3YnUUiWGN+Gv3vk2jVZNA6PCiyv0WqiS7QDzISBk
 Fbf/QmmF1/4DAee12niucjES1Gv1eOjkLm4hsvNcjNYu8YvnNbLHG9YXILR4x6UhD6nLzn6JP
 GFMTyROJQZFkNbz54w4+psdlFKWEOOPsPiJyLkqmWrJJaU7pr/eXtxggmvqnsYIu3g4OCwORX
 f4ihdX5pOmtGDccJ6S2bOQQHi1bzk3uynR3D0h4D4Nz0OXt++T4mMjH7eqWfKVhmCyu8aybMR
 d16h1pKvww/emPK2BuF2LmUktDlEsdq3w1fCqqHfQ8aJJci+QXN5jv8yEzk5etlcka4yZQpkt
 T9Zb19ebSJTXam1TL3W/GJNyA9jUhJ3C9JeM51SOl5+O2D6lTxWSPZiQXHyzbGmHwmoc12kFe
 bH+ldR5URFvFFi5H3l4QLhvPmg15PxHhPt0mXJGXXwzgLcZy/x0eGXNAdS4BGs9oVeWL6Z4jS
 tQeJA8yEtoVPuZFEP16GDuK/qx5RAkL2/yhNmLUCGTnXkWQbw88byUFTS5aEPWVs8oBngJwKl
 TiD5oMkoPXz0warKaPIt2BcGoV3PEzzqVvfLklilGefZ014J1YRWOOMzvvXEzzDMf3W+To5le
 3BOpRKiRUAqhpAAhVkZY0CMI8FsLKB2Q7ReZ5vKnrf0xSLORe6by2h1MiKMCDNvjFr0sGtQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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

Le 16/04/2020 à 21:08, Peter Maydell a écrit :
> On Thu, 16 Apr 2020 at 18:16, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 16/04/2020 à 18:03, Peter Maydell a écrit :
>>> On Thu, 16 Apr 2020 at 16:29, Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8995472:
>>>>
>>>>   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>>>>
>>>> for you to fetch changes up to 386d38656889a40d29b514ee6f34997ca18f741e:
>>>>
>>>>   linux-user/syscall.c: add target-to-host mapping for epoll_create1() (2020-04-16 09:24:22 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> Fix epoll_create1() for qemu-alpha
>>>>
>>>> ----------------------------------------------------------------
>>>
>>> How critical is this bug fix? After rc3, I really don't want
>>> to have to create an rc4 unless it's unavoidable...
>>
>> See the launchpad bug (https://bugs.gentoo.org/717548): on alpha, it
>> prevents the use of python3 in gentoo chroot, and thus we can't use
>> emerge to install packages. It also impacts cmake on debian (see
>> https://bugs.launchpad.net/bugs/1860553).
>>
>> But it's not a regression, so up to you to reject it. It appears now
>> because most of the distro have switched from python2 to python3.
>>
>> It's a low risk change, only in linux-user and for archs that have a
>> different EPOLL_CLOEXEC value.
> 
> Thanks for the explanation. I think that I'll put it to one
> side and if we need an rc4 for some other reason it can go in,
> but it's not sufficiently major to merit an rc4 by itself.
> 

Thank you, I agree.

Laurent


