Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FD8C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 20:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAF120772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiRJL1Kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAF120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJjsr-0005Ef-DK
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 16:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJjs6-0004Ve-Dm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJjs4-000630-97
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:21:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJjs4-00062N-0g
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 16:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585772514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIp9BafTzAsDGak8gdB3jk9ZgkaHUGmzEQB9ijKNXus=;
 b=BiRJL1Kdajwr5ZZJoKfGVMRrHV4J1YCUBaG8LbiOhi3n5ncy7CD5jXzIMGz7w/DyLyLDwY
 +lpA0qw9dK9/Gl9f6yFwNHBrFn1ZXpIoZSMfNHIg5DeRCkvbbyCC4gJrQ7uvJW/XMPe6Os
 BWhJaDmx7wC2wwx5gsXL4NVKJvMC2Vk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-BbhcDMQiOvaCAGyY1lVlNA-1; Wed, 01 Apr 2020 16:21:50 -0400
X-MC-Unique: BbhcDMQiOvaCAGyY1lVlNA-1
Received: by mail-wr1-f69.google.com with SMTP id e10so389700wru.6
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 13:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7iwXGglBforhD2fw1QD00rK/Vb1KppGNyJfxXZ2aXck=;
 b=Ykkao9PBjK9VqdcfKC54jHFauQK/Kp5rBv8uJi4W17IpQzG87DWK95g74GbY4keSyC
 UHdchO63h1lZSqItwJbb7eq4HhjZhLQn4C29KIMqrFHC6Llx0rjEIJcIT5XE6bOpSp7S
 ZKmv5WVZyvwOCajnD4fpHnvwB5WxLu9U+TZ1m5IIfyirVHhP6mwfj9DPQSD6dsGu73vw
 s5rLl31eBCpNqBVaONfS/ogOUNgW9qu9SCJ4YdM8sWkZRDftHWy9WUGWQQL/ENF5oZKD
 WlPtCt8BGTldaX5MGrfdrXH5L/Em44/KMY+maFMRu1vtGOvai/f79HiJydrd7Sy1pZY2
 rpPw==
X-Gm-Message-State: AGi0PubHNeJ+sI8ooVvt83huSRfeov2VbHqcu9HAHJrN+VY06BWtWf1d
 iRfIQmMC+UTdXPOVpzK/MVmR7YnMZilk29NbFPXAFWir8LL5G2ZeYZH+WykNYW1yUdBEItNTRo3
 J/UPv2afmUXOQRu0=
X-Received: by 2002:a1c:9e16:: with SMTP id h22mr132600wme.27.1585772509555;
 Wed, 01 Apr 2020 13:21:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypLQckxYapIctL6kUOTvfJkZbalBYQHa3UEXWuI5z8nzJgqayUmim43LLATZZFHn8ug6qBf1uw==
X-Received: by 2002:a1c:9e16:: with SMTP id h22mr132567wme.27.1585772509211;
 Wed, 01 Apr 2020 13:21:49 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y15sm4196617wrh.50.2020.04.01.13.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 13:21:48 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: Willian Rampazzo <wrampazz@redhat.com>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
 <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
 <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <96219ba3-c114-0cec-8ace-bc19b254077a@redhat.com>
Date: Wed, 1 Apr 2020 22:21:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKJDGDaE_OjqigaxXSJRkv7wfouLV-tsDQaXnWJXpn4F8DkPwQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/1/20 7:43 PM, Willian Rampazzo wrote:
> On Tue, Mar 31, 2020 at 5:07 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> <snip>
>>
>> First job failed by timeout, 2nd succeeded:
>> https://travis-ci.org/github/philmd/qemu/jobs/669265466
>>
>> However "Ran for 46 min 48 sec"
>>
>>   From the log:
>>
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_ma=
lta_5KEc_cpio
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_ma=
lta_5KEc_cpio
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_initrd
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_initrd
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_sd
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_sd
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_bionic
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_uboot_netbsd9
>> Fetching asset from
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_uboot_netbsd9
>> Fetching asset from
>> tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_net=
bsd
>> ...
>>    (13/82)
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_ma=
lta_5KEc_cpio:
>>    SKIP: untrusted code
>>    (24/82)
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_bionic:
>>    SKIP: storage limited
>> ...
>>    (25/82)
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangep=
i_uboot_netbsd9:
>>    SKIP: storage limited
>> ...
>>    (63/82)
>> tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_net=
bsd:
>>    SKIP: Running on Travis-CI
>>
>> Is it possible that we are now fetching assets for tests we are not
>> running? In particular the one marked @skip because the downloading time
>> was too long on Travis?
>=20
> Yes, your assumption is correct, this execution of Avocado downloaded
> assets for tests that were skipped. Let me try to explain how the
> asset feature works today on Avocado.
>=20
> Avocado has two basic ways to work with assets:
>=20
> 1. Parse limited use cases of `fetch_asset` call in the test file and
> execute them. This operation can happen in two different scenarios.
> First, when using the command line `avocado assets fetch <test_file>`.

Odd, with avocado-framework=3D=3D76.0 I get:

https://travis-ci.org/github/philmd/qemu/jobs/669851870#L4908

Traceback (most recent call last):
   File "/usr/lib/python3.6/runpy.py", line 193, in _run_module_as_main
     "__main__", mod_spec)
   File "/usr/lib/python3.6/runpy.py", line 85, in _run_code
     exec(code, run_globals)
   File=20
"/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6zsite-package=
s/avocado/__main__.py",=20
line 11, in <module>
     sys.exit(main.run())
   File=20
"/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-package=
s/avocado/core/app.py",=20
line 91, in run
     return method(self.parser.config)
   File=20
"/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-package=
s/avocado/plugins/assets.py",=20
line 291, in run
     success, fail =3D fetch_assets(test_file)
   File=20
"/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-package=
s/avocado/plugins/assets.py",=20
line 200, in fetch_assets
     handler =3D FetchAssetHandler(test_file, klass, method)
   File=20
"/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-package=
s/avocado/plugins/assets.py",=20
line 65, in __init__
     self.visit(self.tree)
   File "/usr/lib/python3.6/ast.py", line 253, in visit
     return visitor(node)
   File "/usr/lib/python3.6/ast.py", line 261, in generic_visit
     self.visit(item)
   File "/usr/lib/python3.6/ast.py", line 253, in visit
     return visitor(node)
   File=20
"/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-package=
s/avocado/plugins/assets.py",=20
line 139, in visit_ClassDef
     self.generic_visit(node)
   File "/usr/lib/python3.6/ast.py", line 261, in generic_visit
     self.visit(item)
   File "/usr/lib/python3.6/ast.py", line 253, in visit
     return visitor(node)
   File=20
"/home/travis/build/philmd/qemu/build/tests/venv/lib/python3.6/site-package=
s/avocado/plugins/assets.py",=20
line 171, in visit_Assign
     self.asgmts[cur_klass][cur_method][name] =3D node.value.s
KeyError: 'launch_and_wait'
/home/travis/build/philmd/qemu/tests/Makefile.include:910: recipe for=20
target 'fetch-acceptance-assets' failed

This launch_and_wait comes from:

tests/acceptance/boot_linux.py:88:    def launch_and_wait(self):

> In this case, it is a standalone execution of each fetch call and the
> test is not executed at all. Second, by running the test. The, enabled
> by default, plugin FetchAssetJob will do the same operation of parsing
> the test file and executing occurrences of `fetch_asset` call before
> the tests start to run. Again, the fetch time is not computed in the
> job time.
>=20
> 2. Execute the `fetch_asset` call from each test during the test
> execution. In this case, the FetchAssetJob plugin should be disabled.
> The fetch time is added to the job time as the asset download occurs
> during the test execution.
>=20
> The acceptance tests which make use of `fetch_asset` are all using the
> first method with FetchAssetJob plugin enabled. As Avocado is parsing
> the test file before it starts to run the tests, it is not aware of
> possible skips that may occur during a test execution due to possible
> dynamic dependency.
>=20
> This is not the desired behavior, as you mentioned, Avocado is
> downloading an asset that will not be used because its test will be
> skipped. To minimize the damage on the download side, the Travis job
> is holding the avocado cache. It means the download should happen just
> once. This does not minimize the damage to space usage.
>=20
> One possible workaround here is to temporarily disable the
> FetchAssetJob plugin, now that the needed assets are on Travis Avocado
> cache. The downside is that when an asset is not available in the
> cache, it will be downloaded during the test execution and the
> download time will be added to the job time. I don't know if it is
> possible to manually remove an asset from Travis Avocado cache. If so,
> this can be done for the tests that should be skipped because of space
> usage.
>=20
> We have been trying to make the Asset feature as flexible as possible
> to accommodate the use cases we have been identifying. Thanks for
> reporting this!
>=20
>>
>> RESULTS    : PASS 65 | ERROR 0 | FAIL 0 | SKIP 14 | WARN 0 | INTERRUPT 0
>> | CANCEL 3
>> JOB TIME   : 1480.72 s
>>
>> Does this "JOB TIME" sums the 'Fetching asset' part?
>=20
> Answered in the comments above.

Thanks for the big clear explanation :)

Phil.


