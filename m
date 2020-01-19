Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8712C33CB7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8611A205F4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 11:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ+4gWQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8611A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1it8eI-0008Q0-Mh
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 06:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8dV-0007tg-OH
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8dU-0004iZ-Dw
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 06:20:57 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1it8dR-0004gb-Go; Sun, 19 Jan 2020 06:20:53 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so26664487wru.3;
 Sun, 19 Jan 2020 03:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z8F/Xiqx2dBHiolY1H5OIrLdryFgwrL0HpyGQNTEs/4=;
 b=KQ+4gWQurOcCKF+3v+tPhN+ul4aKWOyGMKGRa2clprj2IJQSR5gyjbjEl0BDfO/2iM
 mO9oJdry2c4rdENap+OsV95CpFJW5eUeT/ZMbJ608dQHvTIPPmcUGrzODNrednYr/y3Q
 Iud4uhYfCmv2oBWxGlYnUOaugeL0m+/e9pINscoJ/VXGLRwhlpQTmCHzaUepDi6AydzC
 MFCWh7/wfgC8xvOxOIs9ZfqyvIAHv45u+5jse6ehnTcMC4L+lld+X7Bz8R1cCg7CRogP
 ytm9xn0Bivkx1tV8tQiVrs2zZeRhe3hjuEqg18gNTbzibN3Mq0rmP1anoHqm8EsX0F7p
 QkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=z8F/Xiqx2dBHiolY1H5OIrLdryFgwrL0HpyGQNTEs/4=;
 b=eqMdj5cfWLoh9BBg/p3JTQsbcXA8DeGT4hjyjdeaT5xZcOTCbistiJrD7G/UOgeOnl
 Z5X8Lye+nVFLaAG46bfEV/Z8HBdcH5Cy5qs9JcckXTF87Tv/6pbfJfUomfDWRh8/QMpY
 eFnn+vwucIBF43tPwPQh2VX4EhtwYjX4Jg4fO43vkiDUsR3fOsM5ZXxKZqSqgv66Qg75
 P/lNWIFygCnTokGNWjR1brg3mBiXx6O0h0riAA9u7FjPZFWHdXqVw3yKTvNM4mE7OP5p
 PLYd451LLSe9NPykYLd5HWhqbwK03Hqhrf0vAeKuEwSyg0eTCDp1DEnPJD4ZxH3a9bXi
 V57g==
X-Gm-Message-State: APjAAAVeFuuDcwr8A9Jat5mQiWeyuVgQPcu0Jdt185Eabc3ldeNawuo3
 9EkElEKL6DBLl8gPw3SZ/Co=
X-Google-Smtp-Source: APXvYqxjKZGTfg4sPqeA1ftDdiHCdFlSQ2Eg9jnZBT2jX5ElrUtJdn991iKqW67i7LkKBiOP1PnO2A==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr12867350wrt.15.1579432852346; 
 Sun, 19 Jan 2020 03:20:52 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id v14sm42410102wrm.28.2020.01.19.03.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Jan 2020 03:20:51 -0800 (PST)
Subject: Re: [PATCH 4/4] .travis.yml: Allow untrusted code and large files
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200118191623.32549-1-f4bug@amsat.org>
 <20200118191623.32549-5-f4bug@amsat.org>
 <CAPan3WpLXi+23k7JDidmGRefz-rwxwaJmh-rRXO125zh422zpw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <13c731e7-fb67-3c10-65b7-de84aea007ab@amsat.org>
Date: Sun, 19 Jan 2020 12:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3WpLXi+23k7JDidmGRefz-rwxwaJmh-rRXO125zh422zpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 1:28 AM, Niek Linnenbank wrote:
> Hi Philippe,
> 
> For some reason, I can't apply this patch with git am:
> 
> Applying: .travis.yml: Allow untrusted code and large files
> error: patch failed: .travis.yml:260
> error: .travis.yml: patch does not apply
> Patch failed at 0001 .travis.yml: Allow untrusted code and large files
> Use 'git am --show-current-patch' to see the failed patch
> 
> I didn't change the .travis.yml file. I'm using latest master from
> commit 7fb38daf256bd1bcbcb5ea556422283d0d55a1b1

I described on the series cover but forgot to remember it here too,
this is because this series is based on your v3:

 Based-on: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 "Add Allwinner H3 SoC and Orange Pi PC Machine" v3
 https://www.mail-archive.com/qemu-devel@nongnu.org/msg669328.html

I'll respin a v2 of this single patch, don't worry.

Regards,

Phil.

> Regards,
> Niek
> 
> On Sat, Jan 18, 2020 at 8:16 PM Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     As Travis CI runs our tests in a disposable environment, we don't
>     care much if the binaries are trusted. The more we test the better.
> 
>     Also, as of this commmit, the smallest available announced [1] is
>     "approx 18GB", plenty of space to run our acceptance tests.
> 
>     Enable the proper environment variables to allow Avocado download
>     from untrusted sources, and to download large files.
> 
>     Note: As of this commit, all our tests "Ran for 17 min 7 sec"
>     before succeeding, see [2].
> 
>     [1]
>     https://docs.travis-ci.com/user/reference/overview/#virtualisation-environment-vs-operating-system
>     [2] https://travis-ci.org/philmd/qemu/jobs/638823612#L3817
> 
>     Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     ---
>      .travis.yml | 2 ++
>      1 file changed, 2 insertions(+)
> 
>     diff --git a/.travis.yml b/.travis.yml
>     index 638fba4799..b8b9df65a6 100644
>     --- a/.travis.yml
>     +++ b/.travis.yml
>     @@ -260,6 +260,8 @@ matrix:
> 
>          # Acceptance (Functional) tests
>          - env:
>     +        - AVOCADO_ALLOW_LARGE_STORAGE="yes"
>     +        - AVOCADO_ALLOW_UNTRUSTED_CODE="sure"
>              - CONFIG="--python=/usr/bin/python3
>     --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>              - TEST_CMD="make check-acceptance"
>            after_failure:
>     -- 
>     2.21.1
> 
> 
> 
> -- 
> Niek Linnenbank
> 

