Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14805CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC60B20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC60B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWYV-0005N7-TF
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMWXN-00048F-WC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMWXM-0004sc-Ge
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMWXM-0004s2-87
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:11:48 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0CB084628B
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 12:11:47 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id l184so3332799wmf.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M5SpeuuCQINsLA9WQGd4DtSNXQxXQZycAl7A+RJ2VbU=;
 b=LcsP+XckUAoZQmwc0CgHA/9xsxPnrb/aOIpBuuhwch5HfTPIFlu1S3atKN0UPk8z/x
 pGGuyqfzNp3ouCQcSjyjH0gGJz/PKQydK7KXB0U/YW6WQstlgZ8IwJtzc+XQ3kHkcCT0
 lAQMAO6wD4+6+fletGUxuMedPzTgF9/X7MWXTHvmuXyOFuaepbGCYU6h4WRMAUwiWGA/
 T6ae9fSrjybcjQG0/VijnZPKMQ9Wc+PvmBpPP61gqJoSmBlLpYypGKuplHp9eQ0od6DD
 UkQWTO1IGLu9NmkE9SrJuIPavr/FP2PIlgEeT34F20H3D5AtQaaWsNYYTLudfKrUgGhR
 3qww==
X-Gm-Message-State: APjAAAXiIo+iFyP/pRNQsxOu8+8k9WBz/00CEeAjOBikPThQj6fXayWD
 8g2d5FfFEzGMU4IQa+YUtkSrYa/IMjMuj4w2fhT9kNAVEMMqulF6KachuNGi/+F6PVZJSW3hjYr
 niQHzlbViFyh3yEE=
X-Received: by 2002:a1c:7305:: with SMTP id d5mr18615877wmb.84.1571659905636; 
 Mon, 21 Oct 2019 05:11:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuGsFUtRpRH4Q/bhRLR04GbC7qTk7xbznBgFw7P9Ma8n0HeWMEtV5aCrDFw6/Ei2F4KwvusA==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr18615830wmb.84.1571659905273; 
 Mon, 21 Oct 2019 05:11:45 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id 36sm17412745wrp.30.2019.10.21.05.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 05:11:44 -0700 (PDT)
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
 <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
 <20191008214907.GA28137@localhost.localdomain>
 <CAFEAcA9DzeObmtsc2VJmw=1yruANZ6ajY2SG0cAPdehkeRN3wA@mail.gmail.com>
 <20191009190743.GA6019@localhost.localdomain>
 <d2011e56-8c5f-9f57-04eb-16581866fd48@redhat.com>
Message-ID: <54e2ef65-2c7f-3d2b-be1d-15d47c807443@redhat.com>
Date: Mon, 21 Oct 2019 14:11:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d2011e56-8c5f-9f57-04eb-16581866fd48@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Basse?= <contact@fredericb.info>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>, Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Sven Schnelle <svens@stackframe.org>, Guenter Roeck <linux@roeck-us.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/19 3:43 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/9/19 9:07 PM, Cleber Rosa wrote:
>> On Wed, Oct 09, 2019 at 02:38:02PM +0100, Peter Maydell wrote:
>>> On Tue, 8 Oct 2019 at 22:49, Cleber Rosa <crosa@redhat.com> wrote:
>>>> On Mon, Oct 07, 2019 at 05:28:49PM +0100, Peter Maydell wrote:
>  >>>
>  >>>> Do our other acceptance tests download random third-party
>  >>>> (ie "not a well-known distro") binaries for the tests ?
>  >>>> It seems a bit hazardous for reproducability and trustability
>  >>>> reasons...
> [...]
>>>> I find it hard to judge precisely how much of a third-party some of
>>>> these are.=C2=A0 I remember Philippe mentioning that one of them, I =
guess
>>>> the images used on linux_ssh_mips_malta.py, were "as official as it
>>>> gets" (my words, from my often misleading memory).
>>>>
>>>> Reproducibility is definitely an issue, in the sense given that some
>>>> of these can indeed go away, but as long as they're available the ha=
sh
>>>> recorded in the test should guarantee that we're running the same
>>>> images.
>=20
> So this thread is a follow up on:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg546430.html
>=20
> For Open Source software I can understand we want to be able to rebuild=
=20
> them, and should provide a link about how to rebuild.
>=20
> I don't want to rebuild images myself, I want to focus on testing QEMU.=
=20
> I tried once to build a MIPSsim kernel and it was a total nightmare:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04071.html
> (Thomas Huth eventually succeeded using buildroot).
>=20
>>>> Do you think we should do something different here?
>>>
>>> I'm not sure, which is why I asked whether this new test
>>> was in line with what we've done previously. Since these
>>> are just test cases and we don't redistribute them to
>>> other people there's less of a traceability/reproducibility
>>> worry, and if we check hashes on download that cuts off
>>> a lot of "fail to notice if the image changes for some
>>> reason" possible problems.
>>
>> Yep, because I have no clue how to do improve on this (redistributing
>> the binaries is definitely not on the improvement side, and neither
>> is not testing some machine types), the current approach seems good.
>=20
> QEMU machines are not restricted to running Linux or other Open Source=20
> software. It seems important to be able to test for regressions with=20
> closed-source code too, because it usually has been well tested on real=
=20
> hardware.
>=20
> I just posted a firmware test:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg651012.html
>=20
> I could find it stored compressed and uuencoded on the Wayback Machine.
> Since I don't want to abuse from this amazing service, and other script=
=20
> to decode/uncompress it, I stored it on a new repository with its SHA-1
> (the default hash used by Avocado):
> https://github.com/philmd/qemu-testing-blob/tree/master/hppa/hp9000/712
>=20
> Is this acceptable? Incorrect?

I'v been wondering about this during the week-end. If this is=20
problematic to add the tests in the QEMU repository, we can add the=20
tests in another repository. The problem will be to keep it sync with=20
QEMU. If we add it as a QEMU submodule, it is the same as continuing=20
adding the tests in the main tree.

Avocado don't have problem browsing tests in various directories, the=20
problem is we need to import avocado_qemu=20
(tests/acceptance/avocado_qemu) which imports QEMUMachine from qemu.machi=
ne.

Cleber, we once talked about having the main repository producing=20
python-qemu and python-qemu-acceptance-testing packages. How do you want=20
to proceed? Extract theses files from the main repo and have it consumes=20
the packages? I'm afraid that doesn't scale properly with distributions.
Also, updating them to improve the testing will be slow/painful.

I now realize this is probably not the clever path to continue, but I'm=20
currently out of ideas to unblock the testing process.

Peter what do you think, do you think of other alternatives we can=20
investigate?

Thanks,

Phil.

> Regarding Avocado tests, maybe we can simply add a "untrusted" or=20
> "closedsource" tag, so people willing to test untrusted binaries could=20
> still run the tests using 'avocado --tag untrusted_software', and we=20
> could skip these tests by default.
>=20
> I am very interested because I already experimented with:
>=20
> - AIX on PReP/40p
> - some RTOS on Canon PowerShot A1100
> - VxWorks on MIPS and SPARC
> - closed-source bootloader for Raspi3/4
>=20
> Regards,
>=20
> Phil.

