Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8802173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8802173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0wCg-0004n1-Uo
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0wBx-0004OM-GA
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0wBw-0004ES-DG
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0wBw-0004EJ-64
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:08:28 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4FB1AC057FA6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 23:08:27 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g2so2381138wmk.5
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mgp4ZrOkcIefKcc+7jypXDU7eEhXx20zGEsTQHZ9zWM=;
 b=qOZGuNLwc0VI9XXvrspkGSySmseDZkLuts9Pl3QzbD7bsbmcf3lmWRV7O6f40xe63E
 ozmEHcq+Y2YNO/jWrK1rYs+yki3gJr/46hj9MhWB02AiSamdmJXCA6//xPvP+H42TwXL
 Rd8hr/LpY8j/Ea5wfb+PVf14UlhxlIwW+f0J0q4+pnbcLpOYsIixNKh/EVb1Y6n36/d8
 wPxjGwSCE8e2hNlnOjfdNBi5TFiJxUBFRxNsN1RroWHVleuA3E+yfBwtCnsIsZGgSj+d
 mLJxCehO+4geRaeXu+U/WsSpXZq0amdBh7NUCbi6Masn3x/G0z4mb3AsSexoLVlouHIv
 GR4w==
X-Gm-Message-State: APjAAAXjyzLV5qk+jmIbxMlD7iOZS8C8BlbHNwcSN/ZXxq/QErXextuy
 FJkeiNuMjfqE2yPhtXg4cWCUQgQ9dv8J8pc3oi/gKvhAbIK5sryB+NybcFz1+Zl99FKiwr550xT
 zFq+MvLKDJ8bnXTE=
X-Received: by 2002:a1c:c018:: with SMTP id q24mr1306496wmf.162.1566515306123; 
 Thu, 22 Aug 2019 16:08:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0XHA4edve92ySiXaQR7/2mJd0RcbyRqP0joHRlXgEUolQIAjbg+Czb+ZAGTHrteOJAD32FQ==
X-Received: by 2002:a1c:c018:: with SMTP id q24mr1306489wmf.162.1566515305965; 
 Thu, 22 Aug 2019 16:08:25 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id b136sm2589422wme.18.2019.08.22.16.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 16:08:25 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <3be10e98-f2db-60e1-d846-40c16c70da7b@redhat.com>
 <CAL1e-=jfrNAoAOXMf_84Ou47qQSq8ECxZ+VAiBDFG7cCmQPeFQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d7a2c3cd-8424-4ede-55f7-a9159944f717@redhat.com>
Date: Fri, 23 Aug 2019 01:08:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jfrNAoAOXMf_84Ou47qQSq8ECxZ+VAiBDFG7cCmQPeFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] contrib/gitdm: Add group map for RT-RK?
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 1:05 AM, Aleksandar Markovic wrote:
> 23.08.2019. 00.47, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com
> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> Hi Aleksandar,
>>
>> I noticed this list of contributors:
>>
>> Aleksandar Markovic <aleksandar.markovic@rt-rk.com
> <mailto:aleksandar.markovic@rt-rk.com>>
>> Dejan Jovicevic <dejan.jovicevic@rt-rk.com
> <mailto:dejan.jovicevic@rt-rk.com>>
>> Lena Djokic <Lena.Djokic@rt-rk.com <mailto:Lena.Djokic@rt-rk.com>>
>> Mateja Marjanovic <mateja.marjanovic@rt-rk.com
> <mailto:mateja.marjanovic@rt-rk.com>>
>> Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com
> <mailto:Mateja.Marjanovic@rt-rk.com>>
>> Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com
> <mailto:Milos.Stojanovic@rt-rk.com>>
>> Petar Jovanovic <petar.jovanovic@rt-rk.com
> <mailto:petar.jovanovic@rt-rk.com>>
>> Stefan Brankovic <stefan.brankovic@rt-rk.com
> <mailto:stefan.brankovic@rt-rk.com>>
>>
>> I see most of the commits are MIPS related (a few are PPC).
>>
>> Should we add these emails to contrib/gitdm/group-map-wavecomp or shou=
ld
>> we rather add a new group-map file for this company?
>>
>=20
> The most appropriate and simplest approach would be to add a line in
> qemu/contrib/gitdm/domain-map for company RT-RK.

This one my first thought :)

Thanks!

Phil.

