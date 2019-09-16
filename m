Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD3C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70682206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MYZlez+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70682206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nit-0001h6-7i
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i9ngN-0007Do-Bb
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i9ngL-0000AI-Vw
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:52:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i9ngL-00009j-NW
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:52:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id i1so37572627wro.4
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fLz2krgyE9RCrjeEgCSSqB6StrIyTqHMPMLF2GZ8jtU=;
 b=MYZlez+d/vW8vOTQ5vhl1fmoPjP/+sv0LMsbLurfYH+EuEy8mLKBpbvYgFQp3UjsaO
 laOGhf3lKU5XiWZAYwWYSAUQYWoCM0TL1huug8dXupNiGv3s9WZtjSdWuMWQg+n8xejg
 U2TZ6+li8HEekC227Z1Dik7Z96dtuSoyhLVPNX70jC51gESb41ezjN1eV5fyIpZRs8Sf
 Us0yEfkqv0eSsHM45iS+6C0gW08+XcZCjOjdT85ItM0b5gpnMw4FIzxC7hPgHyLWMg0X
 40Mm8GJKWg50TOusLskFeDYg6/Ovlebd+m662yXt+m2MSNZaZazC5cgxCs8voDW6VJne
 HPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fLz2krgyE9RCrjeEgCSSqB6StrIyTqHMPMLF2GZ8jtU=;
 b=bj6lBeUK+rE9AMIlU1xc8EQTZOl0wUHzVkFO0clem1RtAbZKBNN8kxtE0ey0CfR+0L
 sRulBEB7El28x5z1z9iohrW6oJ8WSl1BE3xIfbfklBMYAtfAImR8StRReE3es7mbJKZd
 OEOqkzaI9Ha+0xASnY+axH88g7DTyZmQoiWM8Xc85oMu/b10mWbs4BuKvNxji17d5ALw
 YVVtctEwkCc/zzNDzz9gbY5/vE0QRP5k46j0FsKh21HUaxHgWUnybmpRJ55En1R8RNIs
 ac84Jppl58UI/fUzPGOVbVlQMR56fsRpxHLt75ZV/z0jLW/y7aLoXW8kH9XSEtW2Hf4L
 x+Bw==
X-Gm-Message-State: APjAAAW1lUlPaC+AgXN5dNEEBNRrO0Mroq527CqOVkp0SyPKLWLy8P1n
 gw2FRvU3Ux/pMZDI9ZPhlNdcNA==
X-Google-Smtp-Source: APXvYqwl7O4H+WRA5nfjMGaoMcxeXoGsgnGqeakpGG/dlOGs14isjIxJNy+RZBC0eaMEUhsMQOL39A==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr17350400wrs.229.1568627548184; 
 Mon, 16 Sep 2019 02:52:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s5sm12730178wro.27.2019.09.16.02.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 02:52:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE3A51FF87;
 Mon, 16 Sep 2019 10:52:26 +0100 (BST)
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190916004242.GF2104@umbus.fritz.box>
 <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com>
Date: Mon, 16 Sep 2019 10:52:26 +0100
Message-ID: <87lfuo1sbp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tests/acceptance: Add tests for the
 PReP/40p machine
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Herv?= =?utf-8?Q?=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi David,
>
> On 9/16/19 2:42 AM, David Gibson wrote:
>> On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> Quick tests worth to avoid regressions with the 40p machine.
>>> idea from the "Maintainers, please tell us how to boot your machines"
>>> thread:
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
>>>
>>> v2: Split Travis job, added Herv=C3=A9 R-b tag
>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05896.html
>>>
>>> Regards,
>>>
>>> Phil.
>>
>> I'm guessing you're expecting these to go in via the testing tree, in
>> which case
>>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>
> Thanks, appreciated :)
>
>> Or do you want me to take them via the ppc tree?
>
> I think the 'testing tree' should focus on the CI/testing
> infrastructure, while each subsystem maintainers should care about the
> tests covering their subsystem (the testing tree maintainers might not
> have the required knowledge to be sure a test is correctly implemented).
>
> In this particular case I assume you don't have much knowledge of that
> PPC machine, which is a hobbyist one, but since you are the PPC
> maintainer, I'd rather see this going via your tree :)
>
> Alex/Cleber/Eduardo, any comment on this position?

Once we have a .travis.yml I'm happy with it can go in via another tree
no problem. See other thread....

>
> Thanks,
>
> Phil.
>
>>> Philippe Mathieu-Daud=C3=A9 (6):
>>>   tests/acceptance: Add test that runs NetBSD 4.0 installer on PRep/40p
>>>   tests/acceptance: Test Open Firmware on the PReP/40p
>>>   tests/acceptance: Test OpenBIOS on the PReP/40p
>>>   tests/acceptance: Test Sandalfoot initrd on the PReP/40p
>>>   .travis.yml: Let the avocado job run the 40p tests
>>>   .travis.yml: Split enterprise vs. hobbyist acceptance test job
>>>
>>>  .travis.yml                      |  18 +++-
>>>  MAINTAINERS                      |   1 +
>>>  tests/acceptance/ppc_prep_40p.py | 150 +++++++++++++++++++++++++++++++
>>>  3 files changed, 167 insertions(+), 2 deletions(-)
>>>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>>>
>>


--
Alex Benn=C3=A9e

