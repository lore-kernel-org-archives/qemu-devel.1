Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D517C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDC6222C1
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXJJqMx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDC6222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUakW-0005R4-Sx
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUajl-0004tk-W4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUajk-0000zS-Sm
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:17:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35157
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUajk-0000zE-Og
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573582676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2/ZovviIzkkfEewsct9LqkMLhE+5XYjalRdlwc7ww0=;
 b=HXJJqMx+JBKvHjDp33X4t3tlwjsntO5RiHNXlNzEMBq/fDM3ISibXXRyGPnkyY8LWH+Qgq
 zAuTBdaZ+eaRKGi/ZkMobKpHRPQ16rS9ZzSJb9G75sk9AliLdNNXpnxVLFcbaEXvOzILKd
 OIJzaDv82eSXvWncBt48wgrw8Y5UD/M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-UAtw3J82OiGDQE7jLAXOBg-1; Tue, 12 Nov 2019 13:17:53 -0500
Received: by mail-wr1-f70.google.com with SMTP id p6so12367084wrs.5
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gq84b72rDNoiPX68LycrRbEkr6eNptRDRUN9OfpuE2I=;
 b=B9eapgrlx/B2UKld6OA2Stzcb5HfqxWlk1ENXoErJ65A8QNH24/rVvfqpOCBlFzxS7
 ubWUqc9sQLpMXYYG4hkUK00XMQzp0Jwtosy8dDbHF5xLVWvy9f1WSktPfBauyde8Nx7M
 +Q4hYtXRqlC9xue9E83roE2+PCcRBWb0fmpcqeBbQ3QGKv2u/R7zxqqC+U6eTrz161WN
 QJ3V8jXPkJryySBiekHxz3llG1kn4FvgefIbZq3bPQjvUu6nejv9MJnETuMc4Uyn9BIF
 I0PqGeWcVNIwL5XzrOVpwsOkCH40h4VBOrrFnjuAuU4aIGQiwop+f+Yqnwpv8tIWMdkR
 NW9Q==
X-Gm-Message-State: APjAAAWlt6+1p3YJPptmeN+iKoV4D5A6FZGNhppZUWCq/K+GKfGTEO9I
 rTnerdHhULxP6PvH0YvuY/ctugHNkbMoVNE2wkkx+VCKvt1/WRCm+57LCxru/AxkQ9hbRTK1J25
 Q3kndmxjyk54Dlm8=
X-Received: by 2002:a7b:c858:: with SMTP id c24mr5545854wml.174.1573582671898; 
 Tue, 12 Nov 2019 10:17:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLeVxGWaPbtgUZP71U8IGedFnRk7fCi+yB6A7GXtu3Q41FNgFL6Xbr7sf2x1HhQxGrBPLDjA==
X-Received: by 2002:a7b:c858:: with SMTP id c24mr5545840wml.174.1573582671673; 
 Tue, 12 Nov 2019 10:17:51 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id t1sm27677961wrn.81.2019.11.12.10.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 10:17:51 -0800 (PST)
Subject: Re: [PATCH v7 4/8] Acceptance tests: use relative location for tests
To: Cleber Rosa <crosa@redhat.com>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-5-crosa@redhat.com>
 <adf94475-b241-e8d9-afd6-2b5992d0b9f9@redhat.com>
 <20191111221157.GD19559@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e162f831-fe54-dab0-4bd2-bb25719dac84@redhat.com>
Date: Tue, 12 Nov 2019 19:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191111221157.GD19559@localhost.localdomain>
Content-Language: en-US
X-MC-Unique: UAtw3J82OiGDQE7jLAXOBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/19 11:11 PM, Cleber Rosa wrote:
> On Mon, Nov 04, 2019 at 07:26:23PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> On 11/4/19 4:13 PM, Cleber Rosa wrote:
>>> An Avocado Test ID[1] is composed by a number of components, but it
>>> starts with the Test Name, usually a file system location that was
>>> given to the loader.
>>>
>>> Because the source directory is being given as a prefix to the
>>> "tests/acceptance" directory containing the acceptance tests, the test
>>> names will needlessly include the directory the user is using to host
>>> the QEMU sources (and/or build tree).
>>>
>>> Let's remove the source dir (or a build dir) from the path given to
>>> the test loader.  This should give more constant names, and when using
>>> result servers and databases, it should give the same test names
>>> across executions from different people or from different directories.
>>
>> Can we strip the full path to directory and only keep the filename in th=
e
>> database? (Thinking about out-of-tree tests).
>>
>=20
> Yes, absolutely, but this needs to be done one the Avocado side.  TBH,
> I have ideas to make this go even further, such as:
>=20
>   1) the stripping of the "test_" prefix of the test method
>=20
>   2) replace the full path to a directory with tests for a "test suite"
>      alias (default to the directory name itself)
>=20
>   3) test suite alias will be persisted on test result such as reports
>      or machine, but ommited from the human UI
>=20
>   4) full path to directory, exact version of test files (git hash) will
>      all be metadata and not part of the test ID
>=20
> Roughly speaking, something which is listed like this currently:
>=20
>    $ avocado list tests/acceptance/
>    INSTRUMENTED tests/acceptance/boot_linux_console.py:BootLinuxConsole.t=
est_x86_64_pc
>    ...
>=20
> When executed, would be shown as:
>=20
>    JOB ID     : fb885e9c3e7dc50534ec380a7e988cbf94233f07
>    JOB LOG    : /home/cleber/avocado/job-results/job-2019-11-11T17.07-fb8=
85e9/job.log
>     (1/1) acceptance/boot_linux_console.py:BootLinuxConsole.x86_64_pc: PA=
SS (2.17 s)

For the particular use case of QEMU, we can also strip the "acceptance/"=20
part (and eventually ".py").

>    RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0=
 | CANCEL 0
>    JOB TIME   : 2.35 s
>=20
> How does that sound?
>=20
> - Cleber.
>=20


