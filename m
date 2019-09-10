Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3DDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90635207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90635207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7e4c-00077O-Ok
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7e3V-0006Wj-Ul
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7e3U-0008IP-R8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:11:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7e3U-0008Gy-Ix
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:11:28 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D917C049D59
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 11:11:26 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o11so8822785wrq.22
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 04:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vCT1/K0KX6wizVJCxffZSUa1l50pmrEiaOOuX2xyTxM=;
 b=tDqystNIUo1gYb7ux6vKAkBpb/2IF05TlY627j12iv7vv8YYAJ4ZlJpSZOjvZv7vgU
 oghqMWM1nm1Zf6o1McG8U+bUUNgbcYAZzJ6CNBjH6ouFGwGrbwq9NAzr8qyvhNNPErAD
 tbHr95v48ZjG9qDHrYkWNoQTh44HtGYZCPubHFzjehS5Joonlmq29tBsAignsI1nvZq2
 fhvP+UukeWFfJos0+Yi3j+Oj7ebJFAUH2CUyfylWNfH0P43jTIM4z9VWuEGNyC0Ohy1i
 5AB9MWwb3Ovx1/fmk7UlUKzFD0VVmShOvjq261LLlgTC8ohuZkvh7wk5Ga93+U48m81Q
 t/yg==
X-Gm-Message-State: APjAAAXJBwkD8AB4+OCYI6m/3+lQBZHN4o66yuoUQhGMuQCzXAAwAL53
 PsRq9tmBq5PvfvjTRkLs0NQdLyTxfFLZdqk8HAw/KrN8AXriOwwpuOIFiXokWcA8SWHHJMvJI/R
 WDsoz2jEUPO2JGtc=
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr26773963wrw.304.1568113884964; 
 Tue, 10 Sep 2019 04:11:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxE+OR3290/lybedZQUlSDOOn9rgRybP4Sc4MqpuzbRsL+iH0zB8tI64ZkzhHkHlGMerGTWlw==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr26773940wrw.304.1568113884741; 
 Tue, 10 Sep 2019 04:11:24 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id w12sm26053244wrg.47.2019.09.10.04.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2019 04:11:24 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
 <20190910084349.28817-45-alex.bennee@linaro.org>
 <20190910090743.GC8583@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d413b58e-dbf6-8746-ac1c-781c67bbb54c@redhat.com>
Date: Tue, 10 Sep 2019 13:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190910090743.GC8583@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 44/45] Fedora images: use URLs from stable
 "archives.fedoraproject.org"
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
Cc: Yash Mankad <ymankad@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 11:07 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Sep 10, 2019 at 09:43:48AM +0100, Alex Benn=C3=A9e wrote:
>> From: Cleber Rosa <crosa@redhat.com>
>>
>> The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
>> from tests/acceptance/linux_initrd.py, is currently failing to fetch
>> the "vmlinuz" file.  The reason for the failure is that the Fedora
>> project retires older versions from the "dl.fedoraproject.org" URL,
>> and keeps them in "archives.fedoraproject.org".  As an added note,
>> that test uses a Fedora 28 image, because of the specific Linux kernel
>> version requirements of the test.
>>
>> For the sake of stability, let's use URLs from the archived and
>> supposedely ever stable URLs.  The good news is that the currently
>> supported versions are also hosted on the later.  This change limits
>> itself to change the URLs, while keeping the fetched files the same
>> (as can be evidenced by the unchanged hashes).
>=20
> FWIW, I commented on the oiriginal patch before seeing this PR.
> I don't think we should be using the archive URL for anything
> which still exists on download.fedoraproject.org as that's placing
> undesirable load on the Fedora master servers, instead of using its
> primary CDN via the mirror services.

- qemu-doc.texi

This documentation is used by distributions and can stay installed for
ages. I have no idea how often users copy/paste the doc to use it, but
at least the documentation urls will stay working.

- tests/acceptance/boot_linux_console.py
- tests/acceptance/linux_initrd.py

These are cached for local user, and with the addition of '.travis.yml:
Cache Avocado cache' in this series, these are now also cached on Travis =
CI.

- tests/vm/fedora

This one I don't know, you might be right.

Regards,

Phil.

