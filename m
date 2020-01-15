Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC8C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41EE214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41EE214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlqa-0001Tp-8t
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1irlNV-000470-4z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arnd@arndb.de>) id 1irlNU-0006PO-0J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:18:45 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:54369)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arnd@arndb.de>) id 1irlNT-0006Ok-NS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:18:43 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M5x9B-1ikJGU0fYx-007Uc5 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020
 17:18:41 +0100
Received: by mail-qt1-f171.google.com with SMTP id d18so16218181qtj.10
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 08:18:40 -0800 (PST)
X-Gm-Message-State: APjAAAXFiXiU6mugc+AL4Va4xEmqQZUmVSGB2RrlADfol2Bhj3+HpslM
 oxtzgACQVxx1gGa+W0HVG3TrX+YYFMpMQP32ESk=
X-Google-Smtp-Source: APXvYqybpDh5/Db2ZQpe0RYQyp8rWxu8RfxnsSIo+8WV60Od78UfPRpVScjMTrP+LjE22inNyPe0V5Tvsgk+iij7zBY=
X-Received: by 2002:ac8:709a:: with SMTP id y26mr4315649qto.304.1579105119852; 
 Wed, 15 Jan 2020 08:18:39 -0800 (PST)
MIME-Version: 1.0
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
In-Reply-To: <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Jan 2020 17:18:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
Message-ID: <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7xjCVA8t3THif4cGsGZKG+GOAV0YydVOW+uffGNaJ50Urjj9q6l
 G4INPc/5925G74JEeuq+JMTwBXwC3x+u/cSfCXoh8HlohItJBdK2hT9q4AsMc79zvYUjsSm
 /vdA/j2VnrfvgURINXizs9Fr3gMD26Ao3+7t330ysZmrr8HevKfDE42MSRZWRjHQM6Aagu1
 r/H6fxg0xA22rYVf7DLBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sIP5IADuAXM=:s11myjbi2Y4ivuTWHpjtTx
 o5aLmR6oFqe91YNpbvcKzgFkpzl+HHARi8poQY1tguFx3lniLKFDPcPjOfwyoUYg4aS7LAJVm
 fO6XzT4tp+f/m/Kee/da8xQc1iEPqc41sZExtdkwx6H1of7gklAjFQmOX1wWmyfFzp20goApI
 3GH1jz07IjEVk3UWyGRFkMUJTm/vD5TEcVM1kUDBiKCw/5oh4rspid8tQT8F6B16e1tru8UZ0
 xcnabzrhb1vAX6xiN3cB86i9Vo+D8jGkjqr4WPrAlvOCkV1YPmHQDYb2CAzrbBV3d/LPgIFoX
 24k4yi3xknL6fMCjIRXdzuWsfs2LriTyFelgW3ItU4vbjdT6FbN03EecHyfFfx7g478THNc6k
 IS59JYlBp6FVuqBRmtP/7eV8vWNhJrnYB0N8xRlpGu4bw04q1mTOOfCf/XmQto+zBzmUiZAuX
 UYSradSmhR7fqUNqkX0UlPNPDgMFwsPTMOd0HaDRVoS8vRMAsbKoKZagsU9oj7KQ2zSS5dlt+
 OeOye8mkxp6FHpFJJeYC+2IN7jzWuDcR2kdzwIKqz2AA6Yc+S1P2bYNCFxWKaXOYcGHa+yGzF
 HMg1GTU21TFhH0cdqyBM5TaE4k/k7vRPhYYMqFzajkLBanavroPeqqkSoHTlI84wcb4fe2y55
 1sJAq3N9a9Zjo18xKEZgxsdu/AbKAuOByN74uzl9tVvFiQ6+8vSglfsWR/voykHcDSop5eWrD
 ntwl3cEnSFtEs5DRcniHZhFXeBc6YHu5Mt2Ju+ymSdCYltlpOKjdVH8RB6GH/9UGptD1lg21e
 N37bkGNI1mvmbkSHf31y/O9235Lvbtsp32YHVACuOCNDRj54W7sfbADnuCQHisM2VVEhd3llL
 VwKYA53M1U+3WolV8O/Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 amarkovic@wavecomp.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:
>
> This patch implements functionality of following ioctl:
>
> SNDRV_TIMER_IOCTL_TREAD - Setting enhanced time read
>
>     Sets enhanced time read which is used for reading time with timestamps
>     and events. The third ioctl's argument is a pointer to an 'int'. Enhanced
>     reading is set if the third argument is different than 0, otherwise normal
>     time reading is set.
>
> Implementation notes:
>
>     Because the implemented ioctl has 'int' as its third argument, the
>     implementation was straightforward.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>

I think this one is wrong when you go between 32-bit and 64-bit
targets, and it gets worse with the kernel patches that just got
merged for linux-5.5, which extends the behavior to deal with
64-bit time_t on 32-bit architectures.

Please have a look at
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=80fe7430c70859

       Arnd

