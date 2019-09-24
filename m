Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD9C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20CB214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20CB214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCn7a-0005qH-Ju
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCmkJ-0006Ph-1K
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCmkH-0008S7-KP
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCmkH-0008Rt-FQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:28:53 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70B5E61D25
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:28:52 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id r21so193870wme.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u34+nYWV7mjyL83tYY3SBkBCSHfmr4/0yuzhRqpY+/U=;
 b=C6fT1oSp35sbF4bXTO8SA75/4qrZmOqvaCI73becdokijr1B0YrPoyWCqqoHaZGvr9
 ZdOrDNFuHCPmjlOBIrocyjFQ8Q2gq2o5InrY8yQcfiU34NOpAIxRyT/vOrRX3Prv9bWe
 LYlIR8MUyI0v/8Msx59sD1GqsiTUYOa35bR5456ry48E2jFHZFWDkGa8xZtmTRL9FyTp
 ZTzRJ5lK5I2/t08Eybiu0VdnpYWToVGyuK+QG6z9uApFWMVGvjr4qqoXUQ/+Tvz5SA6S
 3KZMY3wlHntSaq2o9jOaVKG8PgSy9sDzWqRPM6V2hOGPskvT4qK7QhynEg8EN2EwqIAN
 rYcg==
X-Gm-Message-State: APjAAAWU2toKRiVkt/A7AN7/B3PKqiAhOcOb1cPK+du/T3YgfQ70xGSr
 3TsZ85QyjAtMBPvq3K5U2GzU6eorQ1SaXsMa2CF3tzZIIw0FS0ZxM0zayvtjM3i1gzZ3pbXWcAd
 YnH73jaDghMf5ydY=
X-Received: by 2002:adf:f708:: with SMTP id r8mr2841707wrp.187.1569338930955; 
 Tue, 24 Sep 2019 08:28:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQSUn+XtPrMw8u3vvNWkU9tlKiZ9m/5P70EhI5jPlhgCTC7UmvM2HAjarNvrgcAk7ogV+CWQ==
X-Received: by 2002:adf:f708:: with SMTP id r8mr2841680wrp.187.1569338930741; 
 Tue, 24 Sep 2019 08:28:50 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id y14sm3130854wrd.84.2019.09.24.08.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 08:28:49 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] edk2 build scripts: eliminate python 2 dependency
To: John Snow <jsnow@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20190920083808.21399-1-lersek@redhat.com>
 <364077b0-455a-b65a-dbc8-a8b0409c287e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3cfa97be-ab31-ece1-40e0-af6f5b07b574@redhat.com>
Date: Tue, 24 Sep 2019 17:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <364077b0-455a-b65a-dbc8-a8b0409c287e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 6:06 PM, John Snow wrote:
> On 9/20/19 4:38 AM, Laszlo Ersek wrote:
>> v1 URL:
>> http://mid.mail-archive.com/20190918171141.15957-1-lersek@redhat.com
>>
>> Updates are noted on each patch.
>>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> Thanks
>> Laszlo
>>
>> Laszlo Ersek (2):
>>   edk2 build scripts: honor external BaseTools flags with
>>     uefi-test-tools
>>   edk2 build scripts: work around TianoCore#1607 without forcing Pytho=
n
>>     2
>>
>>  roms/Makefile                  |  1 +
>>  roms/edk2-build.sh             |  4 ++--
>>  roms/edk2-funcs.sh             | 17 +++++++++++++++++
>>  tests/uefi-test-tools/Makefile |  5 ++++-
>>  tests/uefi-test-tools/build.sh |  6 ++++--
>>  5 files changed, 28 insertions(+), 5 deletions(-)
>>
>=20
> Thank you again!
>=20
> I'm sure we'll find all of the rough spots during the rc process, so I
> am quite content for now.
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

Thanks, queued on edk2-next.

