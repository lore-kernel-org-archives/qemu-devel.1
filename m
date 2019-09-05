Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4453C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39012070C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZ+14U5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39012070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5wcE-0000Wq-Sr
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 14:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5wbP-0008WV-HA
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5wbO-0005Uo-6L
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:35:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5wbN-0005Tt-Tk
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 14:35:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so3942837wrd.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dC4Mw/TZ4ztHKH32jlmgRwaCt7AUdVVU8ifgR/j4UQo=;
 b=BZ+14U5a4lxPqmoLyy26CwIKUsUiiQCw5XjPie1OY4abeOO7pVwaT1eT9GBkjHW0MC
 rtZ3hmTsqjEh1M3rUUfmmUhYF3QfztlI021HuTNWMHtG4BKpwITuLo54+lcXS9WKIBIP
 bbyDpTt6cS1w1tmREtZVNz7/tcXFNda6+R11hSL0gEgY84hdTz+KEXkO90ZtIKNgjuNJ
 jAXgv3EI16bBdrFwi4z8kWMwyvIHKzQJa5hpkPUMd/AUUdCeqbSMnwJ/2seisoS2EbjQ
 MxachXFAGQzJ6m6f+0nvkQ+67JRhbwp4uC1hCCnqJliPZefV45yL6CgG2g9fr3OX6FNS
 THYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dC4Mw/TZ4ztHKH32jlmgRwaCt7AUdVVU8ifgR/j4UQo=;
 b=tlnDtyVpz3J5WJcPSo0C6XUZyxGQW0iD0vfg1yYsMOKgTfRo7svUAHKbeBepUo86k+
 0FdQ3dr/Lla4jZbtTayqPPW/9dJnTUf7yI180CSV3c2LBFxaeq2j6Dq2lDTu0Alc3TOt
 sIbHpLiIpHD1WhD9raeNugepgfWBKyDCtJB+15ar7lMTqa4JPX70DznGSFwAY/LXkqq4
 thaC5l3aTQrJnxRGiHHY219KV9IA86dlpIfpwcDF/Heg4bfiwY1o5JVZmMAQZwpkWm0H
 Ws5l9XL1p+pSQsIdYaRNCGrOeD6K1g5GP2TvlZypnJa+G4yULFOi76kKokhJbW6KS02w
 TreA==
X-Gm-Message-State: APjAAAWPAbgRO3EIRK9Wqv3mYb9kMH+ZwnlUiZBJKiHj4Dj0/AI3JD9X
 k0p9eJjuQMOU70H0S5+Jt9SnPg==
X-Google-Smtp-Source: APXvYqyiz8zYZ1LXaJihEGBP7JaiLUGe6I5sHVh23sWSvEhzddb4om41xpBdkJD9OtLKo4Z3ONWUBg==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr3643519wrq.71.1567708524705;
 Thu, 05 Sep 2019 11:35:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm4580173wra.88.2019.09.05.11.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 11:35:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F0B71FF87;
 Thu,  5 Sep 2019 19:35:23 +0100 (BST)
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-3-alex.bennee@linaro.org>
 <a269df37-2452-e703-82dc-a4f2b7f3a2da@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
In-reply-to: <a269df37-2452-e703-82dc-a4f2b7f3a2da@redhat.com>
Date: Thu, 05 Sep 2019 19:35:23 +0100
Message-ID: <871rwu8uc4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 02/42] configure: clean-up container
 cross compile detect
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, qemu-devel@nongnu.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 04.09.19 22:29, Alex Benn=C3=A9e wrote:
>> The introduction of podman support inadvertently broke configure's
>> detect of the container support as the configure probe didn't specify
>> an engine type. To fix this in docker.py:
>>
>>   - only (re)set USE_ENGINE if --engine is specified
>>   - enhance the output so docker is no longer just yes
>>
>> In the configure script we can at least start cleaning up the
>> detecting and naming of variables. To avoid too much churn the
>> conversion of the various make DOCKER_foo variables has been left for
>> future clean-ups.
>
> This is not only a "clean-up" but an actual fix :) (maybe add a Fixes:
> tag).

Done... do I get a Tested-by: ?

>
> This makes it work again for me.
>
> t460s: ~/git/qemu mvc $ tests/docker/docker.py probe
> docker
>
> Thanks!
>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  configure              | 10 +++++-----
>>  tests/docker/docker.py |  7 ++++---
>>  2 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/configure b/configure
>> index 95134c0180b..94845fc5101 100755
>> --- a/configure
>> +++ b/configure
>> @@ -495,7 +495,7 @@ qed=3D"yes"
>>  parallels=3D"yes"
>>  sheepdog=3D"yes"
>>  libxml2=3D""
>> -docker=3D"no"
>> +container=3D"no"
>>  debug_mutex=3D"no"
>>  libpmem=3D""
>>  default_devices=3D"yes"
>> @@ -5894,14 +5894,14 @@ EOF
>>  fi
>>
>>  ##########################################
>> -# Docker and cross-compiler support
>> +# Container based cross-compiler support
>>  #
>>  # This is specifically for building test
>>  # cases for foreign architectures, not
>>  # cross-compiling QEMU itself.
>>
>> -if has "docker"; then
>> -    docker=3D$($python $source_path/tests/docker/docker.py probe)
>> +if has "docker" || has "podman"; then
>> +    container=3D$($python $source_path/tests/docker/docker.py probe)
>>  fi
>>
>>  ##########################################
>> @@ -6474,7 +6474,7 @@ echo "qed support       $qed"
>>  echo "parallels support $parallels"
>>  echo "sheepdog support  $sheepdog"
>>  echo "capstone          $capstone"
>> -echo "docker            $docker"
>> +echo "container support $container"
>>  echo "libpmem support   $libpmem"
>>  echo "libudev           $libudev"
>>  echo "default devices   $default_devices"
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 4bba29e104e..e23209f71ee 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -536,9 +536,9 @@ class ProbeCommand(SubCommand):
>>          try:
>>              docker =3D Docker()
>>              if docker._command[0] =3D=3D "docker":
>> -                print("yes")
>> +                print("docker")
>>              elif docker._command[0] =3D=3D "sudo":
>> -                print("sudo")
>> +                print("sudo docker")
>>              elif docker._command[0] =3D=3D "podman":
>>                  print("podman")
>>          except Exception:
>> @@ -651,7 +651,8 @@ def main():
>>          cmd.args(subp)
>>          subp.set_defaults(cmdobj=3Dcmd)
>>      args, argv =3D parser.parse_known_args()
>> -    USE_ENGINE =3D args.engine
>> +    if args.engine:
>> +        USE_ENGINE =3D args.engine
>>      return args.cmdobj.run(args, argv)
>>
>>
>>


--
Alex Benn=C3=A9e

