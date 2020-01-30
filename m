Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3FBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AB1206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ou1woc+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AB1206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix9sX-0007vl-LC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ix9ru-0007Um-5U
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ix9rt-0004Wo-8K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:28:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52486
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ix9rt-0004VG-4Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580390904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gi0GyAIxk31s+dvqPeZtjTuKzlOpQIc5baPDvK9nkwc=;
 b=Ou1woc+cl5DjTUDPhNb9APrGso44tlkDedGyWXU/hgz78c4KB1Q/5NGC632lsaz8BVaA/p
 QNSbQt9dnRk3HtQSkhczNkmkHReE5nYnq8mmCy1CTcx95PA3GA15QeaWAyLQWbiO8gc1dj
 TmnAWBHBJxgG5iiTMo6uHWi4EdLqPnw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-S-r-PxXJOzitHq6fLJ8HcQ-1; Thu, 30 Jan 2020 08:28:22 -0500
Received: by mail-wr1-f70.google.com with SMTP id o6so1707620wrp.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7QFFPNbnKLEreY2WQ7DQVzQBzRZi4xGmGfmbnXyyPgI=;
 b=ZCW12jXgNfh0e9Ca+keKNJ5+6xvNeYojW4/Ue8OnP14OCyl7Ifo2RBqtKs3kzcbHvw
 ESUTV6bKwNkEELpOK2vXX9Be6SNXsS4eV1X4lPZd4v+XZGqHt9JNZPMrFUR+w1ju8UmZ
 70tzg3ZBVzVyrTI63/1T316w9DVqeiT35guxoxV94vwvx9WIShqLVnUEYubGW3MfPdPO
 r36THtB+B9h6JYpEBj0y+xVeBwIiQ4nc0JneIz4Vvnjf2TDHrk1qTuODR4ajFBjuGDDa
 Tyr66CaVRpoMSHxh3A00ob9GssG8Fks8pHa3uOpLpNCPKcaAFy5zDjW/7I/eQWGA3zY1
 qP4Q==
X-Gm-Message-State: APjAAAW+SAaRSmlj7opeajm2FAOxICUPUL7QBDZaKZxhpBk8cbn06tJv
 rv5YWPzqYW2s2asWcgzUrJryzGvtcdJ02fjPGWb8hKzP5G1YDyOgMe1ozpo3ufeM/maSRdORqDI
 ZWNF6pXdAcSle2Ms=
X-Received: by 2002:a1c:740a:: with SMTP id p10mr5743554wmc.65.1580390901378; 
 Thu, 30 Jan 2020 05:28:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvhbQd8dKe4/FI03r5y9drjiobFPjjKq1psPIrZSlFBlsYia13saDz6K9N+BiTxKOzoUk7QA==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr5743525wmc.65.1580390901127; 
 Thu, 30 Jan 2020 05:28:21 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id a13sm7415831wrp.93.2020.01.30.05.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 05:28:20 -0800 (PST)
Subject: Re: [PATCH v2 04/29] tests/acceptance: Use 'version-min' tag to
 verify QEMU binary version
To: Cornelia Huck <cohuck@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-5-philmd@redhat.com>
 <20200130132625.533fb4ca.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ee877d12-c0a4-4f82-5d59-2e0235158479@redhat.com>
Date: Thu, 30 Jan 2020 14:28:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130132625.533fb4ca.cohuck@redhat.com>
Content-Language: en-US
X-MC-Unique: S-r-PxXJOzitHq6fLJ8HcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 1:26 PM, Cornelia Huck wrote:
> On Wed, 29 Jan 2020 22:23:20 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Introduce the 'version-min' tag.
>> Tests can set it to the minimum version of QEMU they require.
>> If QEMU is older, the tests will be cancelled (skipped):
>>
>>    $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_model_v=
ersions.py
>>     (01/11) X86CPUModelAliases.test_4_0_alias_compatibility: CANCEL: Tes=
t expects version '4.1' but QEMU binary is '3.1.1' (0.10 s)
>>     (02/11) X86CPUModelAliases.test_4_1_alias: CANCEL: Test expects vers=
ion '4.1' but QEMU binary is '3.1.1' (0.10 s)
>>     (03/11) X86CPUModelAliases.test_none_alias: CANCEL: Test expects ver=
sion '4.1' but QEMU binary is '3.1.1' (0.10 s)
>>     ...
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/acceptance/avocado_qemu/__init__.py | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>=20
> Hm... this might cause headaches if someone tries to backport tests on
> distro versions; but we probably won't be able to test for the feature
> in many cases anyway?
>=20

Are you saying a distro version might not match upstream version when a=20
feature is introduced? Isn't it the point of versioning? If you are=20
thinking of some case you point me at it so I can improve this patch?

Thanks,

Phil.


