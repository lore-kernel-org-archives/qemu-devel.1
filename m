Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF6C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B637220663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVbYje0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDlZh-0005q3-9q
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDlJA-0008SH-Sv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDlJ9-0000GT-DO
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:41:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDlJ9-0008Ri-6w
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584348070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcPbyZEj5Y8W1NaPHyB7IQq8BPQdn4tOEKQLgVBRDaw=;
 b=RVbYje0jDjFjIayyGpit/mYsHV9mw6YYIMJtmb5O81oukJCk0ZhNOVJ3BbfHIIakT1oaHE
 ehiv3vKsKwRPR5AyvVDyFVvQtNRMEIPWNb9kPd/K9scr1F33o54Y3YYSYwdasOLrjJ1iRY
 1NM+HyaYiEUgGswms9ZqBknr75B6kFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-5eI3eFs5M0uJYh-QT3Djcg-1; Mon, 16 Mar 2020 04:41:08 -0400
X-MC-Unique: 5eI3eFs5M0uJYh-QT3Djcg-1
Received: by mail-wm1-f72.google.com with SMTP id x7so4332084wmi.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 01:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f6r5tI5g6hVVgUnD8hSCZPkOTgjOEG4+iRA+h2GbNnU=;
 b=cpc7kTrvdKdJQDoYqrbRKbMf2RpTZ7f7nQj2B4h3ireSIFc2tqmStngLqVcFUqKvdf
 GjBYVXSvm473Jj66NxbIWXQwRyXk5x0YhObXBJv2qmGtt7TalqPrFS42aHAfd/33ELEc
 W4r/X6DLWoH17ZKgJVF0tJpnNfUKW2AjIPgb4ilQU5Ju7k78IMUZi/IHzhzreqBgQc7f
 8BtETzX4sVfJyeAKN2gWK2npT2RHph2awecNvJGJ2bf08IjMHUe5unqwtfvCMqY1pNMR
 fhUxJT9axdGxwUj31DH1j8vhYu1EEryORZU9jEJWa3+qWPmtRpf9M5sqT0i8MeLN6cbk
 QyMA==
X-Gm-Message-State: ANhLgQ26eOVC3Ioxhshk8hkxUYvcmoE+s1H13sc0sEgSE2OMSLX+6j/H
 hHvbCGDvnIsG4fsaBUECVIcUHl9M/JR6u3Pf4yy1zOTtZdeYDuaHYT1ivXTQi8IaSk11JzGd7xU
 ZpkMSP/ZePorKxlc=
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr26215822wmd.123.1584348067243; 
 Mon, 16 Mar 2020 01:41:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuupDN1VpjLFDPv6tRNWtMdxc/g/cTfsPKJM/g1tZZW+9eY+6l/2DxxQrkjE+E/4R6uTg63XQ==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74mr26215793wmd.123.1584348066981; 
 Mon, 16 Mar 2020 01:41:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.82.39])
 by smtp.gmail.com with ESMTPSA id f12sm5239710wmh.4.2020.03.16.01.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 01:41:06 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix Cooperlake CPU model
To: "Zhang, Cathy" <cathy.zhang@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
 <93c9cc8c-09ec-d13f-f012-edf86fd945ab@redhat.com>
 <759b848d-8261-5997-2e2b-531246bcdf92@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a972442e-2d29-674b-7ad6-2f056330ed84@redhat.com>
Date: Mon, 16 Mar 2020 09:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <759b848d-8261-5997-2e2b-531246bcdf92@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 02:39, Zhang, Cathy wrote:
> On 1/7/2020 9:31 PM, Paolo Bonzini wrote:
>> On 25/12/19 07:30, Xiaoyao Li wrote:
>>> Current Cooperlake CPU model lacks VMX features which are introduced
>>> by Paolo
>>> several months ago, and it also lacks 2 security features in
>>> MSR_IA32_ARCH_CAPABILITIES disclosed recently.
>>>
>>> Xiaoyao Li (2):
>>> =A0=A0 target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITI=
ES
>>> =A0=A0 target/i386: Add missed features to Cooperlake CPU model
>>>
>>> =A0 target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++=
++-
>>> =A0 target/i386/cpu.h | 13 +++++++-----
>>> =A0 2 files changed, 58 insertions(+), 6 deletions(-)
>>>
>> Queued, thanks.
>>
>> Paolo
>=20
> Hi Paolo,
>=20
> Can I ask one question that will you put all the patches for Cooper Lake
> Cpu model into QEMU v5.0-rc0?

These are included already:

commit b952544fe8a061f0c0cccfd50a58220bc6ac94da
Merge: dc65a5bdc9 083b266f69
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Jan 10 17:16:49 2020 +0000

    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging
   =20
    * Compat machines fix (Denis)
    * Command line parsing fixes (Michal, Peter, Xiaoyao)
    * Cooperlake CPU model fixes (Xiaoyao)
    * i386 gdb fix (mkdolata)
    * IOEventHandler cleanup (Philippe)
    * icount fix (Pavel)
    * RR support for random number sources (Pavel)
    * Kconfig fixes (Philippe)
   =20
Paolo


