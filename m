Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28EEC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F2D20659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F2D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIrUg-0006wJ-P9
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIrTh-0005tA-GN
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIrTg-0005Wv-5B
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIrTf-0005Vu-Sp
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:44:52 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D73B5C04B31E
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 09:44:50 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t11so4095002wro.10
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 02:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hUt4mOswGsivDmiDYCy9bZmIUfvq8tHvXgwKBx4k9Tc=;
 b=YlJp7YfbEoywpUoDV6LVDNDsPPmON5CA0N7oXUEaEyqfWLnhNbZTygVICJcIwsYM4Q
 xMyziLW4XdaTxWyxu4y0wAu1FXJxh//GbjRGwiTxd5wx854awdeWr2f5SojV2XWHKvy3
 bn0sCA4ryT7WFMPO1zb41kYZzMKnYvP1Lbq9I8PQredHZxFxzK5jWyMO51wWAKvTpN6r
 oZ/Qmg0bC9BGoEFSl6DlC2ad4ViX2BbVrGHMS3EtJ+cUbce6zWw8xHTeRsQmPLGmT/WI
 4CNlJCaQAmZVOkVGWDUwqnJygp4XD/VCwGGL75rJ0jhQl39zmB/CXO1CQA0dNwCjX8yu
 uicA==
X-Gm-Message-State: APjAAAWm9huhWx0iSMI9gMkXDCoWJFh1VLv9OJlpSr7e5ivUjBeIuuZ5
 2QbNBaPuRAYydck8kpRp72BcJO6AHPTwu6swOO207isY1UicQQq4HLgzTloNTwzLctIn3zUKN0F
 unfDI8yK47AC8c2E=
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr2546979wml.95.1570787089471; 
 Fri, 11 Oct 2019 02:44:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSDP9Ho+cgUtbTm+vhYLSAwza+bVsppxdErgMXZEjF0xzZnebtUDr86NKCzSGjQkm3pXt3OQ==
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr2546958wml.95.1570787089160; 
 Fri, 11 Oct 2019 02:44:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id z22sm8269148wmf.2.2019.10.11.02.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 02:44:48 -0700 (PDT)
Subject: Sphinx UnpicklingError (was Re: [Patchew-devel] Fwd: Re: [PATCH v4]
 migration: Support gtree migration)
To: Auger Eric <eric.auger@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <23e242c0-83d4-512e-eb42-3cf24d6c21ea@redhat.com>
 <4ae9a7e2-6446-29cc-a1b6-2d614cf3fa05@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f706cb24-6eae-db2b-beb8-5b01eb1562b6@redhat.com>
Date: Fri, 11 Oct 2019 11:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4ae9a7e2-6446-29cc-a1b6-2d614cf3fa05@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter, this UnpicklingError from Sphinx seems to be caused by building
manuals in parallel.  Can you take a look?

Thanks,

Paolo

On 11/10/19 07:20, Auger Eric wrote:
> Hi,
> 
> This failure looks unrelated to this series; and the above script
> succeeds on my side.
> 
> Best Regards
> 
> Eric
> 
> 
> -------- Forwarded Message --------
> Subject: Re: [PATCH v4] migration: Support gtree migration
> Date: Fri, 11 Oct 2019 07:19:29 +0200
> From: Auger Eric <eric.auger@redhat.com>
> To: qemu-devel@nongnu.org, no-reply@patchew.org
> CC: quintela@redhat.com, peterx@redhat.com, dgilbert@redhat.com,
> eric.auger.pro@gmail.com
> 
> Hi,
> 
> On 10/11/19 1:51 AM, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20191010205242.711-1-eric.auger@redhat.com/
>>
>>
>>
>> Hi,
>>
>> This series failed the docker-mingw@fedora build test. Please find the testing commands and
>> their output below. If you have Docker installed, you can probably reproduce it
>> locally.
>>
>> === TEST SCRIPT BEGIN ===
>> #! /bin/bash
>> export ARCH=x86_64
>> make docker-image-fedora V=1 NETWORK=1
>> time make docker-test-mingw@fedora J=14 NETWORK=1
>> === TEST SCRIPT END ===
>>
>>   CC      block/nbd.o
>>   CC      block/sheepdog.o
>>   CC      block/accounting.o
>> make: *** [Makefile:994: docs/interop/index.html] Error 2
> 
> 
>> make: *** Deleting file 'docs/interop/index.html'
>> make: *** Waiting for unfinished jobs....
>> Traceback (most recent call last):
>> ---
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=b0665a6b133e47c781238452d53aabf1', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-f9u21j2v/src/docker-src.2019-10-10-19.48.45.2708:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit status 2.
>> filter=--filter=label=com.qemu.instance.uuid=b0665a6b133e47c781238452d53aabf1
>> make[1]: *** [docker-run] Error 1
>> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-f9u21j2v/src'
>> make: *** [docker-run-test-mingw@fedora] Error 2
>>
>> real    2m25.181s
>> user    0m7.455s
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20191010205242.711-1-eric.auger@redhat.com/testing.docker-mingw@fedora/?type=message.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
>>
> 
> _______________________________________________
> Patchew-devel mailing list
> Patchew-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/patchew-devel
> 


