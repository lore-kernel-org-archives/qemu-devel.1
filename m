Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A32AC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DF021874
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DF021874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Npt-0006BI-Lk
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3NkK-0000kP-NC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3NkI-0002uv-Fo
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3NkI-0002uR-6l
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:58:02 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DF4389AC4
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:58:01 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id v4so1411644wmh.9
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H04R+1xO77L7IUYF2HZ4jY3ilsAS00sUi6DGpqZdS+k=;
 b=szB7EpTXG6EBFLzLQzHaZ2Gjz2FLNvuPAWHnLD2CvZNgOaix7c5nzkIYtNEOLLMv6m
 Td/1fQY05537+SnS6ut+oX6sF3+zPRk8vGFZzOFIQhVXkuakf5w6v0Tt7TiqPQSZWipJ
 WATUdx3D6e+oiYq9J75uop0UWFPmg9LcwX6tfaHbqWggmnVTuZF73tVhufnoeiEkTOpw
 RxHPgt52G0Ov3WgyLYY+HZPq1vnjP43LWhfxMTD03LrFxmfrXEBjhVauGvwGEQqM4SiW
 Bs+oQXTyT5nqr/1FC9breX7Ck5UCB6Jm7vOygT1CvwftlHtl33d/ffGF5u9Gv9gZNwsk
 VuFg==
X-Gm-Message-State: APjAAAUv3mA89c76rdSRs0HYMWUWHIpds/xX39v8d0hMVB+WrjF/uXQh
 ijZfQwwtFnVpN9L6fRlmpTSaZCZCmZ5tuWCNxEtVU99d5+sXGz5IgC9qHleHRmPFcRY79uLhW1Q
 kQ1CNx0K4A6VPP5c=
X-Received: by 2002:a5d:66d1:: with SMTP id k17mr1710691wrw.308.1567097879747; 
 Thu, 29 Aug 2019 09:57:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgmzTr9mBHNEPBi+fsEerDM8PfcNgLdxF3x9l4fqazP1ljDj5vodEs5pJk5gBe6bmucAIxeA==
X-Received: by 2002:a5d:66d1:: with SMTP id k17mr1710682wrw.308.1567097879591; 
 Thu, 29 Aug 2019 09:57:59 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u6sm2425204wmm.26.2019.08.29.09.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:57:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190828165307.18321-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <212d7178-1995-db25-73df-0868f0831163@redhat.com>
Date: Thu, 29 Aug 2019 18:57:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 0/9] arm semih-hosting cleanups and
 other misc cleanups
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

On 8/28/19 6:52 PM, Alex Benn=C3=A9e wrote:
> Hi Peter,
>=20
> Here are the ARM semi-hosting cleanup patches and a small selection of
> miscellaneous TCG clean-ups. If your happy taking them all through
> your tree please do otherwise I'll poke Richard. I'm just trying to
> reduce the delta for my next iteration of the plugin series.
>=20
> The following patches need review
>    04 - target arm remove run time semihosting checks
>    05 - includes remove stale smp max _cpus externs
>=20
> The first is the result of review comments, moving CONFIG_TCG ifdefs
> around and the second is pretty trivial.
>=20
> Alex Benn=C3=A9e (7):
>   target/arm: handle M-profile semihosting at translate time
>   target/arm: handle A-profile T32 semihosting at translate time
>   target/arm: handle A-profile A32 semihosting at translate time
>   target/arm: remove run time semihosting checks
>   includes: remove stale [smp|max]_cpus externs
>   accel/stubs: reduce headers from tcg-stub
>   include/exec/cpu-defs.h: fix typo
>=20
> Emilio G. Cota (2):
>   tcg/README: fix typo s/afterwise/afterwards/
>   atomic_template: fix indentation in GEN_ATOMIC_HELPER

Thanks for cleaning this!

Series except patch #8 which you dropped:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

