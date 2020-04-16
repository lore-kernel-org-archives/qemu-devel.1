Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B829C2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B5E2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B5E2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP895-0004KY-Ht
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 13:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jP88Q-0003ur-5t
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jP88P-00039W-00
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:17:06 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jP88O-00035S-NB
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:17:04 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1ZUb-1jNlDq2iE7-0039N6; Thu, 16 Apr 2020 19:16:53 +0200
Subject: Re: [PULL 0/1] Linux user for 5.0 patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200416152829.790561-1-laurent@vivier.eu>
 <CAFEAcA9J=H7RMEEY5BmL=2ObKJDzMQQeWvbUnYYJfxFsntbP6w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2ee4258c-cb88-cdd7-78c2-4f5ac4b008ae@vivier.eu>
Date: Thu, 16 Apr 2020 19:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9J=H7RMEEY5BmL=2ObKJDzMQQeWvbUnYYJfxFsntbP6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i5xv7ba61anQ6asSyQrdnrwnEMuRqy4iBchzcfWQTn6llBK/oCX
 np6TuYNvlpIZgkNtjY9P0cnNDTqA5go+bsFkUOvb4yt2D+X0px2zwlYBjg+CVSz8dQwHniD
 piJ9A1yf2J5e3kcgl1/RoXOC4HOh7ea6Kmb5NiakNkjpra7k7YKEOG8PT+tqhp4+xWC6jbJ
 BulN37Uw9cIVIU8D3Yb8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PS6cHoyzpFw=:09a2pg++2Jo4VsD2jIJO8i
 T/FmRbpSzEekb0ZwOBUUcp4AIGt3Qycj/kyzdqFMDP50OKa6X9FmOfwYxl561/dUl9K8Oz2SW
 ahsiSXPFmuoXBWB/0wFRAFjHr8+COX1A0OfU9yqQJNQPcxjWzx33NIwCZiVaHUTxL4//0l001
 Xgsmp0zAfI+gN3G8cgAH529PtaiAGECe9wX6IVBGCjktuSutBMgy1kL1rXglcIj076E9hgxoV
 q7hndDu0f9OMOuQD7dbqIvjiKtNijpfywtOx9sFkO2LGrF8AetlxYnIXVwHEmVyvqLxtS5YiF
 N/Dm6yHGpeXsoMWLlC1xxRHu35pAbEqJMrxcjF+j9bXQ1a+1IiEdzBfHcIhgsrXK2zFTn5Fhl
 d5l4zeTHH6EpF9s7t4bpdPWnv6m5WGUkhB1zJrCkYF93gle12K73tVlKmeIDDLzCPsuq7C7PW
 VSRnWJj4oeGE37ijZ5zL9H1Y7j+7ASoUKJhCngJ8v3U1dMc61qHJlYn16Y6F68rJXStPr/MKa
 KAFhO6gZ8FOAq31QNK4XkZN0OjYazfObGMf6ulRhVgTBn3IqfEowT2PDe+fwgcwajtlc5ylsi
 Wu7EU6Bcj+DP6hv4zQ5IW7Q76uFI2NzBlrQVV+R25IpTlno2yzPgbRrlTQqUcDxYMNXkSZ6Uv
 n4eE3Te6qnmnMoGCM076Bs2W3m1jJOZ3toSYDXntWt2aqTX+v1PE2FkTcumAeKM7yyd2drWDg
 knNPScdK6CIDhkadaNOVRU+wUtNLPal6pH+RGxY30bk3hHO+OkiEsSelVthtdyvzYbfQ58u69
 Yhh81y+gA181z6kt8Rl1bmElUIYHrfriGfYZnFZf1jcZjXiudg+5O+c6KVnedu+6FFXaXle
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

Le 16/04/2020 à 18:03, Peter Maydell a écrit :
> On Thu, 16 Apr 2020 at 16:29, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8995472:
>>
>>   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>>
>> for you to fetch changes up to 386d38656889a40d29b514ee6f34997ca18f741e:
>>
>>   linux-user/syscall.c: add target-to-host mapping for epoll_create1() (2020-04-16 09:24:22 +0200)
>>
>> ----------------------------------------------------------------
>> Fix epoll_create1() for qemu-alpha
>>
>> ----------------------------------------------------------------
> 
> How critical is this bug fix? After rc3, I really don't want
> to have to create an rc4 unless it's unavoidable...

See the launchpad bug (https://bugs.gentoo.org/717548): on alpha, it
prevents the use of python3 in gentoo chroot, and thus we can't use
emerge to install packages. It also impacts cmake on debian (see
https://bugs.launchpad.net/bugs/1860553).

But it's not a regression, so up to you to reject it. It appears now
because most of the distro have switched from python2 to python3.

It's a low risk change, only in linux-user and for archs that have a
different EPOLL_CLOEXEC value.

Thanks,
Laurent



