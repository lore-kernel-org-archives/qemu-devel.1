Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA6DC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A56223D1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A56223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptim-0007bO-9O
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hptiM-0006Mi-9m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hptiK-0000An-RG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:16:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hptiK-00009Y-6R
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:16:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so30993247wmd.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 05:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DlOYqzW0k3BUVnMxhodAYKxDtUvQAseHKHTg4GjOCas=;
 b=GtSVve19Y0w3asheY0NoRAUOVrqCCI2fZMTaMCws0jazUEcKq7zkCuoqmF4WMixXZt
 emAyuYYJuV8VgsxOEMgrQBdUWCQdix5NYSQhHEgvVPBQkgUqYYe6zSLeJ1L1y4js2/+s
 LOC6bQqxdLF5mqhSEwtzJrCjvcCa2+suCK9yDgt2yumvn39xCPiXAk/9zRXqISoxDcyc
 cOrHN5kOz1imovkPUd6Ll3U1ir5Cz4Vy+zJZThfXTYz8sC2QNhjz/5mH9oOOWy7N7GSK
 z9t54d1x0kXL+XqM/K5hXFadvj/ANVw34F2gTEdkgPbUiWWaR34agXQbvPavPKnfdXzO
 Aqrg==
X-Gm-Message-State: APjAAAVHvKUELkVI9ntDbYPdpcUFnQF9t7HQ9p5gtsvjXqaVF1OQcsDn
 Qcdih3Ld3eNSk7AkynCRi8XG+16R5ZY=
X-Google-Smtp-Source: APXvYqzejRUleLJqVxl/shySFplGqQs6A/7gxUBT6PLWhPiW7Bydkpu9/r19F+o6oKSACq3/Ej7iUQ==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr64007658wmi.122.1563884174929; 
 Tue, 23 Jul 2019 05:16:14 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id j6sm62871990wrx.46.2019.07.23.05.16.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 05:16:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
 <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
 <87imrt0y9a.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <451b91c6-3a4d-afb4-30f1-595fcc7e5f65@redhat.com>
Date: Tue, 23 Jul 2019 14:16:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87imrt0y9a.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL for 4.1-rc2 00/23] testing updates (green
 CI!)
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/19 1:46 PM, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Tue, 23 Jul 2019 at 11:36, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:
>>>
>>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/stsquad/qemu.git tags/pull-testing-230719-1
>>>
>>> for you to fetch changes up to 2e3b8743cd66f1d0fbc83051b0b6b072a97460cc:
>>>
>>>   gitlab-ci: Remove qcow2 tests that are handled by "make check" already (2019-07-23 11:33:15 +0100)
>>>
>>> ----------------------------------------------------------------
>>> Final testing updates:
>>>
>>>   - docker sphinx updates
>>>   - windows build re-enabled in CI
>>>   - travis_retry for make check
>>>   - quick iotests enabled for make check
>>>   - build fixes
>>>
>>> ----------------------------------------------------------------
>>
>> 'make check-tcg' fails (x86-64 host):
>>
>> make: Entering directory
>> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>>   BUILD   debian10
>> The command '/bin/sh -c DEBIAN_FRONTEND=noninteractive eatmydata
>> apt install -y --no-install-recommends         bison
>> build-essential         ca-certificates         clang         flex
>>     gettext         git         pkg-config         psmisc
>> python         python3-sphinx         texinfo         $(apt-get -s
>> build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)' returned
>> a non-zero code: 100
>> Traceback (most recent call last):
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 615, in <module>
>>     sys.exit(main())
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 611, in main
>>     return args.cmdobj.run(args, argv)
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 413, in run
>>     extra_files_cksum=cksum)
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 280, in build_image
>>     quiet=quiet)
>>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
>> line 207, in _do_check
>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>   File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
>> 'qemu:debian10', '-f', '/tmp/docker_buildBgZdCD/tmp6MJLiZ.docker',
>> '/tmp/docker_buildBgZdCD']' returned non-zero exit status 100
>> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
>> recipe for target 'docker-image-debian10' failed

Yes, we should definitively improve this error report.

>> make: *** [docker-image-debian10] Error 1
>> make: Leaving directory
>> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
> 
> Odd. Does:
> 
>   make docker-image-debian10 V=1
> 
> fail for you? Can you retry with:
> 
>   make docker-image-debian10 V=1 NOCACHE=1

Should we use a stable tag for the stable release? Such:

-- >8 --
diff --git a/tests/docker/dockerfiles/debian10.docker
b/tests/docker/dockerfiles/debian10.docker
index aeeb151b52..0f2800377d 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -7,7 +7,7 @@
 # On its own you can't build much but the docker-foo-cross targets
 # build on top of the base debian image.
 #
-FROM debian:buster-slim
+FROM debian:buster-20190708-slim

 # Duplicate deb line as deb-src
---

>>
>> I also got a failure with openbsd which seems to be when
>> the tests run check-block.sh:
>>
>> /home/qemu/qemu-test.Dy1Aj3/src/tests/check-block.sh
>>   TEST    iotest-qcow2: 001
>>   TEST    iotest-qcow2: 002
>>   TEST    iotest-qcow2: 003
>>   TEST    iotest-qcow2: 004
>>   TEST    iotest-qcow2: 005 [not run]
>>   TEST    iotest-qcow2: 007 [fail]
>> QEMU          --
>> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
>> -nodefaults -machine virt,accel=qtest
>> QEMU_IMG      --
>> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-img"
>> QEMU_IO       --
>> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-io"
>> --cache writeback -f qcow2
>> QEMU_NBD      --
>> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-nbd"
>> IMGFMT        -- qcow2 (compat=1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- OpenBSD/amd64 openbsd 6.5
>> TEST_DIR      -- /home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/scratch
>> SOCKET_SCM_HELPER --
>>
>> --- /home/qemu/qemu-test.Dy1Aj3/src/tests/qemu-iotests/007.out  Tue
>> Jul 23 10:49:15 2019
>> +++ /home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/007.out.bad
>>  Tue Jul 23 11:10:21 2019
>> @@ -2,16 +2,7 @@
>>
>>  creating image
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>> -savevm 1
>> -savevm 2
>> -savevm 3
>> -savevm 4
>> -savevm 5
>> -savevm 6
>> -savevm 7
>> -savevm 8
>> -savevm 9
>> -savevm 10
>> +./007: line 51: seq: command not found
>>
>> [and some other failures]
>>
>> I see Thomas Huth has a patch on-list for that, but this
>> didn't manifest as a problem before this pullreq.
> 
> OK, I'll add it and rebuild the PR.

But Thomas got another error later...

> 
> Have you noticed any issues with check-acceptance?
> 
>>
>> thanks
>> -- PMM
> 
> 
> --
> Alex Bennée
> 

