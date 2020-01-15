Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE96EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71382187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71382187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroif-0000CO-Pm
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arnd@arndb.de>) id 1irohr-0007wI-SO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arnd@arndb.de>) id 1iroho-0005ea-1V
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:51:59 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:46305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arnd@arndb.de>) id 1irohn-0005do-P6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:51:55 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQdI8-1j3JPT4C18-00NjGi for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020
 20:51:54 +0100
Received: by mail-qk1-f172.google.com with SMTP id z76so16878925qka.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:51:53 -0800 (PST)
X-Gm-Message-State: APjAAAXbzcxO/mfpU1+aEnvnN4WTsaoB+4t3PNfRGQdszB/fRGrrD+Pc
 ++JHqtgndn/mkqPlyZNI0Sz78Msb1Cx6FAtJCnk=
X-Google-Smtp-Source: APXvYqzjf4XvyloOxlvpfsbN9zEoivGnfwTXgDIvHxbwLHz4X8wjNjXCPgymm8pmS4v/zKVhhIX7/21yXIXb0Wklns4=
X-Received: by 2002:a37:2f02:: with SMTP id v2mr28691998qkh.3.1579117912698;
 Wed, 15 Jan 2020 11:51:52 -0800 (PST)
MIME-Version: 1.0
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-9-git-send-email-Filip.Bozuta@rt-rk.com>
 <CAK8P3a187rPhma7Q6o+hCF3h0=5MLZwh49+JqKt6BvVsAB1efQ@mail.gmail.com>
 <ceaf44c0-fd6c-c280-7f95-7bc133553089@vivier.eu>
 <CAK8P3a36KqWD4fKBLDpFhJg079bNdJDSDUAP2Zu_i1+H62Q6ZQ@mail.gmail.com>
 <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
In-Reply-To: <518d717d-9f1e-e00e-f2a9-df8861241d1c@rt-rk.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Jan 2020 20:51:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a10N3PCkN2mUk7qLTrz6iaO8CYZjGFLWntzwc4L4n_JXw@mail.gmail.com>
Message-ID: <CAK8P3a10N3PCkN2mUk7qLTrz6iaO8CYZjGFLWntzwc4L4n_JXw@mail.gmail.com>
Subject: Re: [PATCH 08/12] linux-user: Add support for setting alsa timer
 enhanced read using ioctl
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ArrVC6qXYjde3SZ9bZAq2CIiNPakTDVLoeilBVkr7dSyetITBLD
 RjO8NZK118td/cszgH4lxmTqKcAJzSRbLDSetAlw6EgELlZQ/sOqhJMkwtUNzhLXgJKp15x
 Z4aWe3YfERsLcuPV8P1JqtxxZPzKkO60j5p24FExLbgQwVgZkP7Aa52jeHcNp3g3pPoxj/f
 NxtF7n3JgMsM0DF0jyChw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KI3/+PvDZfg=:yEnq2W8iJJE5DTEAb2EHzs
 D+w9OdGfGDzkHCervzujL0kMvq7rsgidbxX/J4dvSZDMyFLN/Bha4NQ2CiNSeiZ8M0SZYCOeZ
 X+iFNhX6MmcREmDeQx1wqPGRx0INxp9QXtp8g62EGilSkiuXZpaq5LN3z7g/Z/p+8o/wtK02Y
 XxvDJTzzjDgsG3NxvAGuqXKF2nEVwcpG2Dkyau5hU5wwWuoe8mX7TOOmvjSNWQGmzETu1dalM
 mr5bMRyptJZl598q+hc2bG8M6s6tyNXoBeLaK+MGQWzezYrM9qfZS02MBcLD3lFevkC+S5mgU
 K0+mD6ig3SAB5YU9t58YwfDZwX+y89FFIy0Zv3wX3UWk89FpB/3nmLcytZTnwYFnd56rc5uZl
 Mwc5osUfSWG3WRt2PWG/+8iB0cMXGh6lu1U8ojSuKlcRdqczKqt15/rXdNf9Xc4qFc5Mbrd+e
 VvHkhjBGKCmtmHx34yHmP72x4llEmqT2GeZ8m1Dt8Z+gEsOLA1Kai4pRMAhUU+m6+7IEpU0cY
 rmFUsjjgwjekNW6qztaLW9yMA5Wz1YZhDjR81KKJ1U9X8KwjwPv5qhKm7lwR3Pe0X7TBblyxh
 2RfnulHl8DDzleAVN5jQXLktaKqYfJRqScJc25APeOUDPqvLYQXCcKOOQ+2/RHdabVWq2LixH
 2fjpBpSXS7nFWMf2QGKBUDB7uDogriiEqhTCWDgATvIjo2ULVCMcKcbfterIdgBPoshutGHS5
 1rNkWdDyFSJleibGxEbCrwzoTfduMaR/k9Ot3bSsye84jCj6e3kJQ11B1KkFe3+R2IkCwbBOW
 YJL57e0mB8hGA09beeAFVf4tuTGD9SCTcd12vM+filGlzbJiOphxUeLZiVzMXhRMzDlPZ46/3
 3dc3eolvHKEfwShtmOgg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, amarkovic@wavecomp.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 8:17 PM Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote=
:
> On 15.1.20. 17:37, Arnd Bergmann wrote:
> > On Wed, Jan 15, 2020 at 5:32 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >> Le 15/01/2020 =C3=A0 17:18, Arnd Bergmann a =C3=A9crit :
> >>> On Wed, Jan 15, 2020 at 4:53 PM Filip Bozuta <Filip.Bozuta@rt-rk.com>=
 wrote:
> >> Do the kernel patches add new ioctl numbers to differentiate 32bit and
> >> 64bit time_t?
> >
> > Yes, though SNDRV_TIMER_IOCTL_TREAD is worse: the ioctl argument
> > is a pure 'int' that decides what format you get when you 'read' from t=
he
> > same file descriptor.
> >
> > For emulating 64-bit on 32-bit kernels, you have to use the new
> > SNDRV_TIMER_IOCTL_TREAD64, and for emulating 32-bit on
> > 64-bit kernels, you probably have to return -ENOTTY to
> > SNDRV_TIMER_IOCTL_TREAD_OLD unless you also want to
> > emulate the read() behavior.
> > When a 32-bit process calls SNDRV_TIMER_IOCTL_TREAD64,
> > you can translate that into the 64-bit
> > SNDRV_TIMER_IOCTL_TREAD_OLD.

>
> Thank you for bringing this up to my attention. Unfortunately i have
> some duties of academic nature in next month so i won't have much time
> fix this bug. I will try to fix this as soon as possible.

One more thing: I just realized it gets worse when emulating cross-endian,
as then even without calling SNDRV_TIMER_IOCTL_TREAD, reading
data from /dev/snd/timer requires byteswapping the two words.

     Arnd

