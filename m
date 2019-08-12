Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24894C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC092208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC092208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9lt-00052Q-8k
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45556)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hx9lT-0004cj-Sl
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hx9lS-0002DK-PA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:49:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hx9lS-0002Cm-Iu
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:49:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so11665764wmg.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/DczUw0gsOmtob0YpEtg39kTykZCpZfiA6JO3HmNHbw=;
 b=g2nfjoWnBgwugoXL8ZXvFEPzkSWmHH5a9XtOoJFEkHCXd+6MlEQBIbIwpFXQ9YtjqG
 wTa6g57PfHRCEBx3a4aeytH3pDbAvrs2z3fc1p42wNlkkHkpc7KquFMMfGUlsKNkSmt1
 b6hb51ywy327OaeEn9euyqs60QFZeh9deQYpcgOiRLFbqPoTwoMbitWCSiNVcUAcx6cB
 JPh31/DCsnD/UHg8g6/XGaZ/B2u9LXALXTZtGT/WPdUue34PAcoCfSCe2RU7nw/6eRmf
 xz6Nk4NtcM8IQno67oIM65/LYB6Rlsxm3RfZk2BJrr7yzAuMZxJdJDZBCMsP7j/R2xK+
 pXUw==
X-Gm-Message-State: APjAAAWt6JPwjmCzgRSevY073d03FZDc5d9wxDnWnWLV0/aQBVCqXUaJ
 PtBQYriQRlqeEd4+Zq5n2yTo9Bxhp44=
X-Google-Smtp-Source: APXvYqwy9F8YQ9GerswfbhUifmEYgLBcRgi5gQ7lWhPJoDzNuwG010jN5mWlQf+8Ic6jIUZbsndkGw==
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr26381736wme.99.1565614169286; 
 Mon, 12 Aug 2019 05:49:29 -0700 (PDT)
Received: from [192.168.1.37] (225.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.225])
 by smtp.gmail.com with ESMTPSA id c15sm52395118wrb.80.2019.08.12.05.49.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 05:49:28 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-21-armbru@redhat.com>
 <c76aaebc-d4bf-cb25-fe27-7a9c9ba644c9@redhat.com>
 <87k1bmpn7y.fsf@dusky.pond.sub.org> <87zhkigwhd.fsf@linaro.org>
 <87r25ske6e.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5227e25b-655c-b44e-85a4-e218abdad5f5@redhat.com>
Date: Mon, 12 Aug 2019 14:49:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87r25ske6e.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 20/29] Include qemu/main-loop.h less
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 9:34 PM, Markus Armbruster wrote:
> 
> My failure:
> 
> $ make -C bld docker-test-build
> make: Entering directory '/work/armbru/qemu/bld'
>   BUILD   centos7
> make[1]: Entering directory '/work/armbru/qemu/bld'
>   GEN     /work/armbru/qemu/bld/docker-src.2019-08-10-07.29.32.8915/qemu.tar
>   COPY    RUNNER
>     RUN test-build in qemu:centos7
> [...]
> make[1]: Leaving directory '/work/armbru/qemu/bld'
>   BUILD   debian9
>   BUILD   debian-amd64
> make[1]: Entering directory '/work/armbru/qemu/bld'
>   GEN     /work/armbru/qemu/bld/docker-src.2019-08-10-07.30.18.17180/qemu.tar
>   COPY    RUNNER
>     RUN test-build in qemu:debian-amd64
> [...]
> install -c -m 0644 /tmp/qemu-test/build/trace-events-all "/tmp/qemu-test/build/=destdir/tmp/qemu-test/install/share/qemu/trace-events-all"
> Error in atexit._run_exitfuncs:
> Traceback (most recent call last):
>   File "/usr/lib64/python2.7/atexit.py", line 24, in _run_exitfuncs
>     func(*targs, **kargs)
>   File "/work/armbru/qemu/tests/docker/docker.py", line 234, in _kill_instances
>     return self._do_kill_instances(True)
>   File "/work/armbru/qemu/tests/docker/docker.py", line 213, in _do_kill_instances
>     for i in self._output(cmd).split():
>   File "/work/armbru/qemu/tests/docker/docker.py", line 239, in _output
>     **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 223, in check_output
>     raise CalledProcessError(retcode, cmd, output=output)
> CalledProcessError: Command '['sudo', 'docker', 'ps', '-q']' returned non-zero exit status 1
> Error in sys.exitfunc:
> Traceback (most recent call last):
>   File "/usr/lib64/python2.7/atexit.py", line 24, in _run_exitfuncs
>     func(*targs, **kargs)
>   File "/work/armbru/qemu/tests/docker/docker.py", line 234, in _kill_instances
>     return self._do_kill_instances(True)
>   File "/work/armbru/qemu/tests/docker/docker.py", line 213, in _do_kill_instances
>     for i in self._output(cmd).split():
>   File "/work/armbru/qemu/tests/docker/docker.py", line 239, in _output
>     **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 223, in check_output
>     raise CalledProcessError(retcode, cmd, output=output)
> subprocess.CalledProcessError: Command '['sudo', 'docker', 'ps', '-q']' returned non-zero exit status 1
>     CLEANUP /work/armbru/qemu/bld/docker-src.2019-08-10-07.30.18.17180 
> make[1]: Leaving directory '/work/armbru/qemu/bld'
>   BUILD   debian-arm64-cross
> Traceback (most recent call last):
>   File "/work/armbru/qemu/tests/docker/docker.py", line 615, in <module>
>     sys.exit(main())
>   File "/work/armbru/qemu/tests/docker/docker.py", line 611, in main
>     return args.cmdobj.run(args, argv)
>   File "/work/armbru/qemu/tests/docker/docker.py", line 366, in run
>     dkr = Docker()
>   File "/work/armbru/qemu/tests/docker/docker.py", line 193, in __init__
>     self._command = _guess_docker_command()
>   File "/work/armbru/qemu/tests/docker/docker.py", line 65, in _guess_docker_command
>     commands_txt)
> Exception: Cannot find working docker command. Tried:
>   docker
>   sudo docker
> make: *** [/work/armbru/qemu/tests/docker/Makefile.include:53: docker-image-debian-arm64-cross] Error 1
> make: Leaving directory '/work/armbru/qemu/bld'
> 
> There are a few SELinux gripes in my logs, like this one:
> 
> type=AVC msg=audit(1565418107.93:125036): avc:  denied  { module_request } for  pid=19599 comm="configure" kmod="binfmt-464c" scontext=system_u:system_r:container_t:s0:c611,c653 tcontext=system_u:system_r:kernel_t:s0 tclass=system permissive=0

I can not reproduce using 'make -j1' on:

$ lsb_release -a
LSB Version:    :core-4.1-amd64:core-4.1-noarch
Description:    Fedora release 29 (Twenty Nine)

I dunno about SELinux, however I have something similar using 'make -j4'.

"Similar" because I'm not sure this is the same error since the failing
command is not reported.

Are you building with -j[N] using N>1 ?

