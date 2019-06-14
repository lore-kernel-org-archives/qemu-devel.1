Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FCDC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE32133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE32133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbo63-0003vJ-Q5
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbns7-0001h2-AO
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbns5-0005XX-RE
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:12:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbns5-0005Wv-JT
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:12:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so2952145wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 08:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fU6fGwyVAjfQlO7fjnezZQptnNMKQPTRAbeFiuykzQs=;
 b=SR49yd3/QMQsK5PQ1XfGRbG9TcIC+j0UF34rI95jZnG+Y02lwsfyKOWBkTQ6HboCk5
 Krm39IOmV7anxV6YBeyydWnXAbmBdb2XYTsLoEkMQSNBk4tnnl93Gphgtw1nORo261O7
 y4GOwRmGFKa/3UXZtZKBcKIKT8HJ1p9kzVXdOSkmZYzPhYQYzy5LpQJUb/NeOCDUivcS
 0xKupwJI6/HSKTyFOEFreVCnRy9m1XkP8RX39IoI0BHLfYfiAqGUKOWqy/PQzlUu+ZIN
 o/lp4myzSmC7CyuOAg3atBhAbTkZuHLJKN7o8QTcyjOhZh4m1AkhQaraJvUlDmNdy02l
 L4qg==
X-Gm-Message-State: APjAAAUINz/KpOlznAJYRJHlAW+z+S8sNSaoRSU8WoLErg+lXOtNBNiB
 ZoSUouq+EhDul3NFrQPi67hSrQ==
X-Google-Smtp-Source: APXvYqwUUpAKr0oPoaxyUPt88NchjBspv25uZiny2nbxVyhfIlJOi9DydpPIVpAr1RbA98ayLSx4/w==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr4792067wru.49.1560525124636; 
 Fri, 14 Jun 2019 08:12:04 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a3sm3138525wmb.35.2019.06.14.08.12.03
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 08:12:04 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 ptoscano@redhat.com
References: <156044303828.5426.699619794825925129@ce79690b2cb9>
 <2376306b-9812-f4e2-883c-55bc818c16be@redhat.com>
 <aee10f02-3ff8-222c-bfd4-833d595aa7e2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <80eff352-8e1f-4451-0cdf-c8808dc033e8@redhat.com>
Date: Fri, 14 Jun 2019 17:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aee10f02-3ff8-222c-bfd4-833d595aa7e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v9] ssh: switch from libssh2 to libssh
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, sw@weilnetz.de,
 rjones@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/19 8:18 PM, Paolo Bonzini wrote:
> On 13/06/19 19:15, Philippe Mathieu-Daudé wrote:
>>
>> On 6/13/19 6:24 PM, no-reply@patchew.org wrote:
>>> === TEST SCRIPT BEGIN ===
>>> #!/bin/bash
>>> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
>>> === TEST SCRIPT END ===
>>
>>> The full log is available at
>>> http://patchew.org/logs/20190613132000.2146-1-ptoscano@redhat.com/testing.asan/?type=message.
>>
>>
>> === OUTPUT BEGIN ===
>>   BUILD   fedora
>> The command '/bin/sh -c dnf install -y $PACKAGES' returned a non-zero
>> code: 1
>> Traceback (most recent call last):
>>   File "./tests/docker/docker.py", line 615, in <module>
>>     sys.exit(main())
>>   File "./tests/docker/docker.py", line 611, in main
>>     return args.cmdobj.run(args, argv)
>>   File "./tests/docker/docker.py", line 413, in run
>>     extra_files_cksum=cksum)
>>   File "./tests/docker/docker.py", line 280, in build_image
>>     quiet=quiet)
>>   File "./tests/docker/docker.py", line 207, in _do_check
>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>   File "/usr/lib64/python2.7/subprocess.py", line 542, in check_call
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker',
>> 'build', '-t', 'qemu:fedora', '-f',
>> '/tmp/docker_buildN2FMKc/tmpz_9Up_.docker', '/tmp/docker_buildN2FMKc']'
>> returned non-zero exit status 1
>> make: *** [docker-image-fedora] Error 1
>>
>> real	3m54.376s
>>
>> Not sure this is a network issue or something else, should we rebuild
>> docker images with V=1 on patchew?
>>
> 
> I restarted the job with V=1.

Thanks!

Patchew did not send update, which means no failure.
Hopefully it updated the same url with the full log.
Indeed the job is successful:


real	30m39.367s
user	0m8.061s
sys	0m5.880s
=== OUTPUT END ===

Test command exited with code: 0

