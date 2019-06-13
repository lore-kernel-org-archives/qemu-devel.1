Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C27C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F82C20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F82C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUSa-0001jE-LM
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbTSL-0002Gr-BT
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbTKU-0005lU-NS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:16:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55718)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbTKU-0005ik-FV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 13:16:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so11000174wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 10:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1wwPMaN7qDc/Xn3Ps4ha5ptywxM9Zpl+qUpNjyZcxFw=;
 b=CSv9SgkUd112/KrnQTQ5xTM50chfxbtkfkCFScVFF0UqJOYNGs38Ql/NnvMIl7E2bJ
 JgBXn2tWy2mdIt0+RT6W9jNviSqs+9Lm2wDadRkCO2DvHYRA2rj4ThAFnuc6f4pYSAE2
 M91scZHOB2thosgng8Wf9vsogWvXropYp1pzAXZiOO+h98O8h9275YyaJ9+BzRddLnTq
 QuFUkwtamolqu2fKZ3vKO0S8wPviTNYsy7D2zvUDHXaX8jU3CIfZAi/qjqLdnxue8aU4
 apMDEBMBWO6bzETgBf7HD6H73JqXh/ulS72M0yiKGE7cWWEkxFSFj5PxBiaNOZtQLB/x
 I/+g==
X-Gm-Message-State: APjAAAXerV/+eiDbEyR52tYE03Fi8FIocZPd4jTKY/xAeCZrbjCX6Qn+
 U+PKJCDU7V0zGJ5yLkuqbbACYQ==
X-Google-Smtp-Source: APXvYqzaR2m1kDOfEECi6/9t6Ot4jZL9TS9CaYaxg1HcrUn1loO2j0m4QyE1Qhxl9vytLylLg7ow5w==
X-Received: by 2002:a1c:2e09:: with SMTP id u9mr4630964wmu.137.1560446161047; 
 Thu, 13 Jun 2019 10:16:01 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x129sm435538wmg.44.2019.06.13.10.16.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 10:16:00 -0700 (PDT)
To: qemu-devel@nongnu.org, ptoscano@redhat.com
References: <156044303828.5426.699619794825925129@ce79690b2cb9>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2376306b-9812-f4e2-883c-55bc818c16be@redhat.com>
Date: Thu, 13 Jun 2019 19:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <156044303828.5426.699619794825925129@ce79690b2cb9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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
 rjones@redhat.com, mreitz@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6/13/19 6:24 PM, no-reply@patchew.org wrote:
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===

> The full log is available at
> http://patchew.org/logs/20190613132000.2146-1-ptoscano@redhat.com/testing.asan/?type=message.


=== OUTPUT BEGIN ===
  BUILD   fedora
The command '/bin/sh -c dnf install -y $PACKAGES' returned a non-zero
code: 1
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 615, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 611, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 413, in run
    extra_files_cksum=cksum)
  File "./tests/docker/docker.py", line 280, in build_image
    quiet=quiet)
  File "./tests/docker/docker.py", line 207, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib64/python2.7/subprocess.py", line 542, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['sudo', '-n', 'docker',
'build', '-t', 'qemu:fedora', '-f',
'/tmp/docker_buildN2FMKc/tmpz_9Up_.docker', '/tmp/docker_buildN2FMKc']'
returned non-zero exit status 1
make: *** [docker-image-fedora] Error 1

real	3m54.376s

Not sure this is a network issue or something else, should we rebuild
docker images with V=1 on patchew?

