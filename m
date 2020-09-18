Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C71C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE0320789
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fb06HV1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE0320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIV4-0002C3-0R
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJIKG-0007vO-Ip
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:29:30 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:43585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kJIKE-0004X9-7V
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:29:28 -0400
Received: by mail-ua1-x943.google.com with SMTP id v5so1984913uau.10
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sFJHbyUj6uuBk8ba6cqOJ304O4LOCReKl4ZHNukt8IY=;
 b=Fb06HV1uVXs2vE2Fx5IxJDQu8FLrSWl9wM1lhp/gYXFkOL3pf4z+wRx+FR23prZZVm
 NTjbMpF8zo5/3MC5nqLANiKSk8Ur/4aZq9VmUTjAGH1QK0vvKhzlMrZAjJuuAfj3wZg5
 A0FgCblPL8/WlFeh/RodWsEI1oieeSPVwMfMxe59tK2p6t2p8NMEIyBeEwub5Tn+bDun
 soLKjmS+9Ecn2ibFw7dwzwpR0utabw+zaPaVI70YA2BCijmoWVoioJ3veDsnKhRonU/4
 YOi3L9MKdDbFlvEhb9MJvpC5nqUqBz1Fz/uC4Fav+pW0IW1o9o1TpqvqAl+As/f41Q7/
 QOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sFJHbyUj6uuBk8ba6cqOJ304O4LOCReKl4ZHNukt8IY=;
 b=efdGnOAAPDx91rLONq1pSXonI6O6St1cyyq17XkL0WP95Mc42w8UGD2cHHhIwpnsgh
 xulS9mirG7U31uTBysdqYSjWBF1njJvc9psYAmGxjBF+BWbBJyKB+CtFtjZiRoEOYDo7
 HpQQDJO7FomAe0lCpjM1EudB0d7j4SKNTPdBdI+f9yAYcrTAlLlX+aqyipewxMb2SLBL
 P3/Kj13D884rGkEEOowJKagK/DBjVeZlgRRBGEKQv0bd2/BD5x35ok7A9uSAcEVhIsBV
 5M2ET++FqcNprFSeOn1856mPpXJ6n1wm6q17zM1iwNtEq0A8w1lWQwBkfcDTNf2cCxB/
 P4JA==
X-Gm-Message-State: AOAM531GKwBLRa9l3+rPBmZLtLcq3s6Nk5QEzZ/5dZqxOr0svPcYXNCp
 zDA5bOCz40e4BFUtgbPgpjuSJXA8tuWkTzx1D8Q4wg==
X-Google-Smtp-Source: ABdhPJyCqhik262ehepGLVVREzw0oimXj+8PGEwamh2z1f5ab7syLeoutEXqCYkwvA985v5rhEgVUrBDb/F1uDSi3hc=
X-Received: by 2002:ab0:2904:: with SMTP id v4mr18637006uap.15.1600442960499; 
 Fri, 18 Sep 2020 08:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200918142344.150749-1-f4bug@amsat.org>
 <55648bee-46e6-4055-104d-0c82e8fcfe64@amsat.org>
In-Reply-To: <55648bee-46e6-4055-104d-0c82e8fcfe64@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 18 Sep 2020 08:29:09 -0700
Message-ID: <CAFQmdRZxuHimdZtqwq=Vzoy7iwg2SiNgGTDQwH9oPXGheH6+EA@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: Reduce quanta-gsj U-boot+Linux test time
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x943.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 7:27 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 9/18/20 4:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > The 'arm_quanta_gsj_initrd' test is timeouting on GitLab CI:
> > https://gitlab.com/philmd/qemu/-/jobs/745483978#L846
> >
> > Use the same trick from the 'arm_quanta_gsj' test to reduce the
> > systemd services started and get quicker to the shell prompt.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  tests/acceptance/boot_linux_console.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> > index 4a366ce93e4..7748febbf54 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -638,6 +638,9 @@ def test_arm_quanta_gsj_initrd(self):
> >
> >          self.vm.set_console()
> >          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > +                               'initcall_blacklist=3Dnpcm_i2c_bus_driv=
er_init '
> > +                               'systemd.mask=3Dsystemd-random-seed.ser=
vice '
> > +                               'systemd.mask=3Ddropbearkey.service '
> >                                 'console=3DttyS0,115200n8 '
> >                                 'earlycon=3Duart8250,mmio32,0xf0001000'=
)
> >          self.vm.add_args('-kernel', kernel_path,
> >
>
> Bah unfortunately this is still not enough :(

Right, this patch modifies the initrd test, but that's not the one
that timed out.

(10/40) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_qu=
anta_gsj:
 INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred:
Timeout reached\nOriginal status: ERROR\n{'name':
'10-tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_quanta=
_gsj',
'logdir': '/builds/philmd/qemu/build/tests/results/job-2020-09-18T13.41-b9.=
..
(90.81 s)
 (11/40) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_q=
uanta_gsj_initrd:
 PASS (27.00 s)

Havard

