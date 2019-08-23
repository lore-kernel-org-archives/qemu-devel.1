Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4367FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FE822CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FE822CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i193C-0002VT-AX
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i18pT-0007B3-6x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i18pQ-0005Fm-8L
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i18pQ-0005FM-0n
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:38:04 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28E127FDFD
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 12:38:03 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id d65so4303131wmd.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PRL/FSVEo0YfzA9EGloXDSoUR/S1PFJDhLfEHy07+zA=;
 b=buIj6q7BSXvgbHv2QTuqEksqEIbTwr41ftA5EchHnq2x3qxw4pAzQUa4KnZbT9gPBj
 EyMHrQKCwzwrwT6zRAQGhbtjBoSAP7Bzk70Fe1oEKCf++rv40XQ52Hu8+w3+m+2bkjA+
 pt9SnxJe0wth3a4N4FG3wVRar1dBV/N+2oG38itBquj8d3D7rWYdSxqu45frJTKTfQmd
 wm3ZgIk/PttgjGAxtuRzJytN2KWsvvI6zBSYEr7cShQx4lfkf0gErqIWbKCSwdRpvh81
 Ou7eZ9bqMMnIeYNXqBMnL2FcvJiEIa0YzDr87sm9TyyUpYiQ8BdYa2+jz4q59cNmH17G
 NsCQ==
X-Gm-Message-State: APjAAAVej0ylLOeIHsO4qyL8kIub0+oHm4MaQaDAu5pS/1NRUPwsEDdF
 ghagbvHggsKP5qBhyY/Uf7CsgnblGXyyGKYVqhsoLDhOcSK6nft9Iswk2ZTpLV8FRkvALqfl9bc
 us3Ar6Vlg8po22A0=
X-Received: by 2002:a05:600c:2111:: with SMTP id
 u17mr5282567wml.64.1566563881631; 
 Fri, 23 Aug 2019 05:38:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEo8du5YX9gfDSM/kyJluKNmwys5YqKM/HPVBjNjxYmbJOiDmr2jY3sYX6pu8yF7nGbOq7PA==
X-Received: by 2002:a05:600c:2111:: with SMTP id
 u17mr5282537wml.64.1566563881231; 
 Fri, 23 Aug 2019 05:38:01 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t13sm3292287wrr.0.2019.08.23.05.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 05:38:00 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190822230916.576-1-philmd@redhat.com>
 <20190822230916.576-4-philmd@redhat.com>
 <CAL1e-=hypCsXVMhU5nC8O7JuDHN89huaMSe5RrJ27YB9W+AK_g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <304fdaf2-7106-2333-9caf-85fbe940df8d@redhat.com>
Date: Fri, 23 Aug 2019 14:37:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hypCsXVMhU5nC8O7JuDHN89huaMSe5RrJ27YB9W+AK_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] mailmap: Add many entries to improve
 'git shortlog' statistics
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 11:44 AM, Aleksandar Markovic wrote:
> 23.08.2019. 01.10, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com
> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> All of these emails have a least 1 commit with utf8/latin1 encoding
>> issue, or one with no author name.
>> When there are multiple commits, keep the author name the most used.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> <mailto:philmd@redhat.com>>
>> ---
>=20
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
>=20
> Out of the scope of this patch, what about the cases like Mateja
> Marjanovic, who contributed with both Mateja.Marjanovic@rt-rk.com
> <mailto:Mateja.Marjanovic@rt-rk.com> and mateja.marjanovic@rt-rk.com
> <mailto:mateja.marjanovic@rt-rk.com> ?

GIT-SHORTLOG(1) manpage is not clear about how it handles email casing.

Anyhow, this last section only clean the author name (utf8/latin1
encoding issue), there is no change in the email.

So in Mateja case, since the author name is the same, it is fine:

  Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
  Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Thank you for your review!

Phil.

