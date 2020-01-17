Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC2FC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1497F2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iz5c45di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1497F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUMK-0003AY-78
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isULQ-0002e4-SC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isULM-00082C-Sl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:19:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isULM-00081U-P9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579277971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmfSCC+apAth1xPBud/fK6zE9Q0C7fTAZ0qRQnhDUI4=;
 b=Iz5c45di6STE/1ymElABRpLTSPLGuWoG3KLFAwph0FrapcRON3AOUsj8tIvZlj2KpG1apW
 Ze8elsqymHx/Dv5pqcBDGHveLcTc43S0zqaaZzhpjQALV31UIpny5L2TIh19NBoHANyw/C
 DDeZjK3xdhlEEG9fSY5pacu2Q9QKAiQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-cXIXtyscPJuN8GL6uLLeAg-1; Fri, 17 Jan 2020 11:19:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so10650089wrx.22
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 08:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7YGCLk5IBNN82Ugjk/TwDJUuzb/yZPzOfikAJ/kVErU=;
 b=VIIPrc126gy8pLL9yjQPFMImWJVc2Lubt7Uw4h0FmN6sS2cxg8TPrp146Lp8XNJyc2
 i9Q67Lpc5lIOnyLKWadUy95VmXqWL47RR2LQ5ohuG8QU598S+U15A+YfufW/xqzL5b+S
 1bWvCuHeSpXbiIwKoRfhKgxHTfY5BL0UkpQrmA+H+Qv+gsqnHk7f/ZIDGKJDcg/MWZdt
 /bdRjgXsUMjOQu19UL5inWxaFBMkr+4Gjq4KSVe8b4+kwiYAH8m07wHJvXTJNfQtl0e1
 Qu/1Xep4KMY53vro1aYpbdR36PhC79S1RskVmeqRY4m90aFJ3c9ej780c96/M0TmzdFl
 BjgQ==
X-Gm-Message-State: APjAAAVAq1Gmz4/wYTqkR9OernE+enQwgCACX88J73LlBI5eO4uYFwuI
 dmP+srET4qFjOGeUFWuB0Qd6ptuGXyTwUZHPH0NO514R94KtNjZUk2GhJxN+6V8rarePDmDQg48
 is4oTsNp9IYJJqMY=
X-Received: by 2002:adf:f20b:: with SMTP id p11mr3706130wro.195.1579277968366; 
 Fri, 17 Jan 2020 08:19:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhtGXWdsvh6HyliCn8ifLIb6AYiF/a70RfgRTtsW+bCwPuFCCX7pv3DpK4bVVOriVFq+Foyg==
X-Received: by 2002:adf:f20b:: with SMTP id p11mr3706096wro.195.1579277968102; 
 Fri, 17 Jan 2020 08:19:28 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 2sm33720283wrq.31.2020.01.17.08.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 08:19:27 -0800 (PST)
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
To: Igor Mammedov <imammedo@redhat.com>
References: <157912207219.8290.12574147223674937177@37313f22b938>
 <b81ad35f-73d0-a333-d0fe-758e64242ca2@redhat.com>
 <20200117170340.7e91ff8c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8ca4cae4-8399-73df-c3f3-78ee857ec954@redhat.com>
Date: Fri, 17 Jan 2020 17:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117170340.7e91ff8c@redhat.com>
Content-Language: en-US
X-MC-Unique: cXIXtyscPJuN8GL6uLLeAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: no-reply@patchew.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 5:03 PM, Igor Mammedov wrote:
> On Thu, 16 Jan 2020 16:43:07 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/15/20 10:01 PM, no-reply@patchew.org wrote:
>>> Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-email=
-imammedo@redhat.com/
>>>
>>>
>>>
>>> Hi,
>>>
>>> This series failed the docker-quick@centos7 build test. Please find the=
 testing commands and
>>> their output below. If you have Docker installed, you can probably repr=
oduce it
>>> locally.
>>>
>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>> #!/bin/bash
>>> make docker-image-centos7 V=3D1 NETWORK=3D1
>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>=20
> it doesn't work on my host, since it tries to use /tmp for building an im=
age
> and fails with no space.
> is there any way to point it to some other place?

What is failing? Building the docker image, or building QEMU withing the=20
docker container?


