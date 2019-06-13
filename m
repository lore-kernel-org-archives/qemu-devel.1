Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D55C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D441920679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D441920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUOY-0007um-Mo
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hbUJ3-0005lW-R5
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 14:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hbUJ2-0006dc-Gw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 14:18:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hbUJ2-0006LW-Ab
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 14:18:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16so2661891wrl.11
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 11:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YDFCxWuIYxNmY+Puw1BZ72LJIxYtre6TZRodphQ/A1M=;
 b=X1er/t+phRHXeHpyCbvAjkr2WfUd8WIeZNwsxLvutsDkzNRKOwXocCz34iMKAbPxf9
 93rl+qpAU121DHzDhbzHMHLvl9wLEz9wL6q3Qut2r6sgDdcC3N2So6VUSo6RV2WTe8V1
 gDklFK9VHkkiQVxLyx8hlZzArQ7cm/DPt1T56PP3pJ74226+kS4+mnbhWvqxkqKaXJs5
 Kwnv1Is9VQw0+LIejnzitWuo765oA09GJHeKKfvRYXfrODCmweNG/Fii6PTQFTIPQ7+D
 pJx9pd3Jldz9+pDSGfrBM+Bk3ip8yc/lmLmRm1q2pV1eESCLwrmPPe/i5xc4a5mGilW2
 39Jw==
X-Gm-Message-State: APjAAAXmvrzp9PMYlBroEWu4wQAyzyXRuX94s5DC7yF900b5/W36ZkWN
 l1RDYu1Rx4widLYc4TEdgBG4IQ==
X-Google-Smtp-Source: APXvYqwRE8V1omwn8K0T/WTwWG3nKehKanUejALeMuFWEHIOV6iZiPxWj1dn4sihOmKtOGcBOqbSnw==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr44738518wrp.293.1560449896810; 
 Thu, 13 Jun 2019 11:18:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0?
 ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id o13sm212190wra.92.2019.06.13.11.18.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 11:18:16 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, ptoscano@redhat.com
References: <156044303828.5426.699619794825925129@ce79690b2cb9>
 <2376306b-9812-f4e2-883c-55bc818c16be@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aee10f02-3ff8-222c-bfd4-833d595aa7e2@redhat.com>
Date: Thu, 13 Jun 2019 20:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2376306b-9812-f4e2-883c-55bc818c16be@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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

On 13/06/19 19:15, Philippe Mathieu-Daudé wrote:
> 
> On 6/13/19 6:24 PM, no-reply@patchew.org wrote:
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
>> === TEST SCRIPT END ===
> 
>> The full log is available at
>> http://patchew.org/logs/20190613132000.2146-1-ptoscano@redhat.com/testing.asan/?type=message.
> 
> 
> === OUTPUT BEGIN ===
>   BUILD   fedora
> The command '/bin/sh -c dnf install -y $PACKAGES' returned a non-zero
> code: 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 615, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 611, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 413, in run
>     extra_files_cksum=cksum)
>   File "./tests/docker/docker.py", line 280, in build_image
>     quiet=quiet)
>   File "./tests/docker/docker.py", line 207, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 542, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker',
> 'build', '-t', 'qemu:fedora', '-f',
> '/tmp/docker_buildN2FMKc/tmpz_9Up_.docker', '/tmp/docker_buildN2FMKc']'
> returned non-zero exit status 1
> make: *** [docker-image-fedora] Error 1
> 
> real	3m54.376s
> 
> Not sure this is a network issue or something else, should we rebuild
> docker images with V=1 on patchew?
> 

I restarted the job with V=1.

Paolo

