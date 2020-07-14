Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F1C433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B71422518
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.gitlab.com header.i=@mg.gitlab.com header.b="e9MalXQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B71422518
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQFW-0000TL-Hh
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1jvQEY-00087d-QO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:04:54 -0400
Received: from do158-143.mg.gitlab.com ([192.237.158.143]:60201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1jvQEN-00034z-2v
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:04:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.gitlab.com;
 q=dns/txt; 
 s=mailo; t=1594753487; h=List-Id: Content-Transfer-Encoding:
 Content-Type: Mime-Version: Subject: Message-ID: Reply-To: From: Date:
 Sender; bh=Utn+n3kFTkJRiRWtls+a4XumN0bpc+7avzf/xE0+P8Q=;
 b=e9MalXQaBFmRMD1ncuIu1diDTPhJQ82T5tXpBtYaINa/ExlFMhNa8CBTgc9YEiHv8YOMGd2+
 sVJAVuP3nOhD4FCtkwfNcWSoLmpvSpbvmSubXP9nTstn6hsDfmjlDvHYFmC3Vf3HeefTyUYF
 NUU/mcsiJznbm63BLEJa2YVbNBU=
X-Mailgun-Sending-Ip: 192.237.158.143
X-Mailgun-Sid: WyI3MWYzYSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOTQ3YjQiXQ==
Received: from mg.gitlab.com (69.90.74.34.bc.googleusercontent.com
 [34.74.90.69]) by smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f0e01b7512812c070836c50 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 14 Jul 2020 19:04:23 GMT
Date: Tue, 14 Jul 2020 19:04:21 +0000
Message-ID: <5f0e01b59e711_2d93fb6ac87b2c854332@sidekiq-catchall-06-sv-gprd.mail>
Subject: QEMU | Pipeline #166549079 has failed for master | aeb07b5f
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_5f0e01b57896e_2d93fb6ac87b2c85425c";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitLab-Project: QEMU
X-GitLab-Project-Id: 11167699
X-GitLab-Project-Path: qemu-project/qemu
X-GitLab-Pipeline-Id: 166549079
X-GitLab-Pipeline-Ref: master
X-GitLab-Pipeline-Status: failed
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
Received-SPF: pass client-ip=192.237.158.143;
 envelope-from=bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com;
 helo=do158-143.mg.gitlab.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 13:31:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, REPLYTO_WITHOUT_TO_CC=1.552,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-to: GitLab <noreply@gitlab.com>, GitLab <gitlab@mg.gitlab.com>
From: GitLab via <qemu-devel@nongnu.org>


----==_mimepart_5f0e01b57896e_2d93fb6ac87b2c85425c
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Your pipeline has failed.

Project: QEMU ( https://gitlab.com/qemu-project/qemu )
Branch: master ( https://gitlab.com/qemu-project/qemu/-/commits/master )

Commit: aeb07b5f ( https://gitlab.com/qemu-project/qemu/-/commit/aeb07b5f=
6e69ce93afea71027325e3e7a22d2149 )
Commit Message: Merge remote-tracking branch 'remotes/alistair/...
Commit Author: Peter Maydell ( https://gitlab.com/pm215 )

Pipeline #166549079 ( https://gitlab.com/qemu-project/qemu/-/pipelines/16=
6549079 ) triggered by Alex Benn=C3=A9e ( https://gitlab.com/stsquad )
had 23 failed builds.

Job #638484602 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484602/ra=
w )

Stage: containers-layer2
Name: mips64-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-mips64-cross', '-f', '/tmp/docker_buildg2vp1ctn/tmp90o0osac.docker'=
, '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildg2vp1ctn'=
]' returned non-zero exit status 1.
section_end:1594753344:step_script
=1B[0Ksection_start:1594753344:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753345:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484604 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484604/ra=
w )

Stage: containers-layer2
Name: mips64el-debian-cross-container
Trace: #4 [1/4] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/4] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-mips64el-cross', '-f', '/tmp/docker_buildupp9934s/tmpf919elpa.docke=
r', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildupp9934=
s']' returned non-zero exit status 1.
section_end:1594753344:step_script
=1B[0Ksection_start:1594753344:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753345:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484619 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484619/ra=
w )

Stage: containers-layer2
Name: sparc64-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-sparc64-cross', '-f', '/tmp/docker_buildj554s3lq/tmp5097c6i3.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildj554s3lq=
']' returned non-zero exit status 1.
section_end:1594753344:step_script
=1B[0Ksection_start:1594753344:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753345:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484600 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484600/ra=
w )

Stage: containers-layer2
Name: m68k-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-m68k-cross', '-f', '/tmp/docker_build0x7sigw2/tmpc719358w.docker', =
'--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build0x7sigw2']'=
 returned non-zero exit status 1.
section_end:1594753343:step_script
=1B[0Ksection_start:1594753343:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753344:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484579 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484579/ra=
w )

Stage: containers-layer2
Name: alpha-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-alpha-cross', '-f', '/tmp/docker_build5ykmue8r/tmpd72jbt73.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build5ykmue8r']=
' returned non-zero exit status 1.
section_end:1594753343:step_script
=1B[0Ksection_start:1594753343:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753343:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484598 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484598/ra=
w )

Stage: containers-layer2
Name: hppa-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-hppa-cross', '-f', '/tmp/docker_buildghkc9567/tmpsd0zrx06.docker', =
'--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildghkc9567']'=
 returned non-zero exit status 1.
section_end:1594753342:step_script
=1B[0Ksection_start:1594753342:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753343:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484590 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484590/ra=
w )

Stage: containers-layer2
Name: arm64-debian-cross-container
Trace: #4 resolve docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.2s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/5] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-arm64-cross', '-f', '/tmp/docker_build41u1d3v3/tmp4pxpshpt.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build41u1d3v3']=
' returned non-zero exit status 1.
section_end:1594753342:step_script
=1B[0Ksection_start:1594753342:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753342:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484587 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484587/ra=
w )

Stage: containers-layer2
Name: amd64-debian-container
Trace: #4 [1/11] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/11] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-amd64', '-f', '/tmp/docker_build2w4799y1/tmp083_s5ub.docker', '--bu=
ild-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build2w4799y1']' retu=
rned non-zero exit status 1.
section_end:1594753341:step_script
=1B[0Ksection_start:1594753341:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753342:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484581 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484581/ra=
w )

Stage: containers-layer2
Name: amd64-debian-cross-container
Trace: #4 [1/4] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/4] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-amd64-cross', '-f', '/tmp/docker_buildlu9qcvmc/tmp61kzz_ph.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildlu9qcvmc']=
' returned non-zero exit status 1.
section_end:1594753341:step_script
=1B[0Ksection_start:1594753341:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753341:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484595 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484595/ra=
w )

Stage: containers-layer2
Name: armel-debian-cross-container
Trace: #4 [1/3] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/3] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-armel-cross', '-f', '/tmp/docker_build7hlot6rx/tmpidpvhy4a.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build7hlot6rx']=
' returned non-zero exit status 1.
section_end:1594753341:step_script
=1B[0Ksection_start:1594753341:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753341:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484614 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484614/ra=
w )

Stage: containers-layer2
Name: riscv64-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-riscv64-cross', '-f', '/tmp/docker_buildhntahobb/tmpyecfh38h.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildhntahobb=
']' returned non-zero exit status 1.
section_end:1594753340:step_script
=1B[0Ksection_start:1594753340:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753340:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484613 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484613/ra=
w )

Stage: containers-layer2
Name: ppc64el-debian-cross-container
Trace: #4 [1/4] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/4] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-ppc64el-cross', '-f', '/tmp/docker_buildl2mtgh41/tmpw8qa1_j7.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildl2mtgh41=
']' returned non-zero exit status 1.
section_end:1594753339:step_script
=1B[0Ksection_start:1594753339:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753339:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484616 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484616/ra=
w )

Stage: containers-layer2
Name: s390x-debian-cross-container
Trace: #4 [1/6] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/6] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-s390x-cross', '-f', '/tmp/docker_build0ho20ina/tmpaaidwr03.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build0ho20ina']=
' returned non-zero exit status 1.
section_end:1594753338:step_script
=1B[0Ksection_start:1594753338:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753339:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484611 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484611/ra=
w )

Stage: containers-layer2
Name: ppc64-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-ppc64-cross', '-f', '/tmp/docker_build88mcjard/tmprshdu25m.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build88mcjard']=
' returned non-zero exit status 1.
section_end:1594753338:step_script
=1B[0Ksection_start:1594753338:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753338:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484576 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484576/ra=
w )

Stage: containers-layer2
Name: amd64-debian9-mxe-container
Trace: #4 [1/4] FROM docker.io/qemu/debian9:latest
#4 resolve docker.io/qemu/debian9:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian9:latest:
------
------
 > [1/4] FROM docker.io/qemu/debian9:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian9-mxe', '-f', '/tmp/docker_build59l6z_ct/tmpmjoroupi.docker', '--bui=
ld-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build59l6z_ct']' retur=
ned non-zero exit status 1.
section_end:1594753337:step_script
=1B[0Ksection_start:1594753337:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753338:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484596 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484596/ra=
w )

Stage: containers-layer2
Name: armhf-debian-cross-container
Trace: #4 resolve docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/5] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-armhf-cross', '-f', '/tmp/docker_build5mlz8o6q/tmpzohewk1u.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build5mlz8o6q']=
' returned non-zero exit status 1.
section_end:1594753337:step_script
=1B[0Ksection_start:1594753337:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753338:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484618 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484618/ra=
w )

Stage: containers-layer2
Name: sh4-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-sh4-cross', '-f', '/tmp/docker_buildtjpta2ah/tmpnud2hz8g.docker', '=
--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildtjpta2ah']' =
returned non-zero exit status 1.
section_end:1594753337:step_script
=1B[0Ksection_start:1594753337:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753338:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484621 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484621/ra=
w )

Stage: containers-layer2
Name: tricore-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian9:latest
#4 resolve docker.io/qemu/debian9:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian9:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian9:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-tricore-cross', '-f', '/tmp/docker_buildsxiaz1l8/tmpx1mbfjdq.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildsxiaz1l8=
']' returned non-zero exit status 1.
section_end:1594753337:step_script
=1B[0Ksection_start:1594753337:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753338:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484584 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484584/ra=
w )

Stage: containers-layer2
Name: amd64-debian-user-cross-container
Trace: #4 [1/3] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/3] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-all-test-cross', '-f', '/tmp/docker_build2vbol8s9/tmpm50i7bh0.docke=
r', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build2vbol8s=
9']' returned non-zero exit status 1.
section_end:1594753337:step_script
=1B[0Ksection_start:1594753337:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753337:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484606 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484606/ra=
w )

Stage: containers-layer2
Name: mips-debian-cross-container
Trace: #4 [1/5] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/5] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-mips-cross', '-f', '/tmp/docker_build6qm9vjas/tmpnygenfen.docker', =
'--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build6qm9vjas']'=
 returned non-zero exit status 1.
section_end:1594753337:step_script
=1B[0Ksection_start:1594753337:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753337:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484607 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484607/ra=
w )

Stage: containers-layer2
Name: mipsel-debian-cross-container
Trace: #4 [1/5] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/5] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-mipsel-cross', '-f', '/tmp/docker_buildk3_mxyrn/tmprp7bgll7.docker'=
, '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildk3_mxyrn'=
]' returned non-zero exit status 1.
section_end:1594753336:step_script
=1B[0Ksection_start:1594753336:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753337:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484609 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484609/ra=
w )

Stage: containers-layer2
Name: powerpc-debian-cross-container
Trace: #4 [1/2] FROM docker.io/qemu/debian10:latest
#4 resolve docker.io/qemu/debian10:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian10:latest:
------
------
 > [1/2] FROM docker.io/qemu/debian10:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-powerpc-cross', '-f', '/tmp/docker_build0y5d3yd6/tmpidxmcwqm.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build0y5d3yd6=
']' returned non-zero exit status 1.
section_end:1594753336:step_script
=1B[0Ksection_start:1594753336:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753337:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #638484592 ( https://gitlab.com/qemu-project/qemu/-/jobs/638484592/ra=
w )

Stage: containers-layer2
Name: arm64-test-debian-cross-container
Trace: #4 resolve docker.io/qemu/debian11:latest
#4 resolve docker.io/qemu/debian11:latest 0.1s done
#4 ERROR: pull access denied, repository does not exist or may require au=
thorization: server message: insufficient_scope: authorization failed
------
 > [internal] load metadata for docker.io/qemu/debian11:latest:
------
------
 > [1/3] FROM docker.io/qemu/debian11:latest:
------
failed to solve with frontend dockerfile.v0: failed to build LLB: failed =
to load cache key: pull access denied, repository does not exist or may r=
equire authorization: server message: insufficient_scope: authorization f=
ailed
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 702, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 698, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 492, in run
    dkr.build_image(tag, docker_dir, dockerfile,
  File "./tests/docker/docker.py", line 347, in build_image
    self._do_check(build_args,
  File "./tests/docker/docker.py", line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.8/subprocess.py", line 364, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu/d=
ebian-arm64-test-cross', '-f', '/tmp/docker_build0exuw2qd/tmp7jgahdu2.doc=
ker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build0exuw=
2qd']' returned non-zero exit status 1.
section_end:1594753319:step_script
=1B[0Ksection_start:1594753319:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594753319:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m


-- =

You're receiving this email because of your account on gitlab.com.




----==_mimepart_5f0e01b57896e_2d93fb6ac87b2c85425c
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://ww=
w.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=3D"http://www.w3.org/1999/xhtml" lang=3D"en" xml:lang=3D"en">=

<head>
<meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type" =
/>
<meta content=3D"width=3Ddevice-width, initial-scale=3D1" name=3D"viewpor=
t" />
<meta content=3D"IE=3Dedge" http-equiv=3D"X-UA-Compatible" />
<title>QEMU | Pipeline #166549079 has failed for master | aeb07b5f</title=
>
<style data-premailer=3D"ignore" type=3D"text/css">
body,table,td,a{-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%}t=
able,td{mso-table-lspace:0pt;mso-table-rspace:0pt}img{-ms-interpolation-m=
ode:bicubic}.hidden{display:none !important;visibility:hidden !important}=
a[x-apple-data-detectors]{color:inherit !important;text-decoration:none !=
important;font-size:inherit !important;font-family:inherit !important;fon=
t-weight:inherit !important;line-height:inherit !important}div[style*=3D'=
margin: 16px 0']{margin:0 !important}@media only screen and (max-width: 6=
39px){body,#body{min-width:320px !important}table.wrapper{width:100% !imp=
ortant;min-width:320px !important}table.wrapper td.wrapper-cell{border-le=
ft:0 !important;border-right:0 !important;border-radius:0 !important;padd=
ing-left:10px !important;padding-right:10px !important}}

</style>

<style>body {
margin: 0 !important; background-color: #fafafa; padding: 0; text-align: =
center; min-width: 640px; width: 100%; height: 100%; font-family: "Helvet=
ica Neue", Helvetica, Arial, sans-serif;
}
</style></head>
<body style=3D"text-align: center; min-width: 640px; width: 100%; height:=
 100%; font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-se=
rif; margin: 0; padding: 0;" bgcolor=3D"#fafafa">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" id=3D"body" style=
=3D"text-align: center; min-width: 640px; width: 100%; margin: 0; padding=
: 0;" bgcolor=3D"#fafafa">
<tbody>
<tr class=3D"line">
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif; height: 4px; font-size: 4px; line-height: 4px;" bgcolor=3D"#6b=
4fbb"></td>
</tr>
<tr class=3D"header">
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif; font-size: 13px; line-height: 1.6; color: #5c5c5c; padding: 25=
px 0;">

<img alt=3D"GitLab" src=3D"https://gitlab.com/assets/mailers/gitlab_heade=
r_logo-153749eaa7ea6fafcb995161abd3247bc4c4500f31498b0c4024f50093983ac0.g=
if" width=3D"55" height=3D"50" />
</td>
</tr>
<tr>
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"wrapper"=
 style=3D"width: 640px; border-collapse: separate; border-spacing: 0; mar=
gin: 0 auto;">
<tbody>
<tr>
<td class=3D"wrapper-cell" style=3D"font-family: &quot;Helvetica Neue&quo=
t;, Helvetica, Arial, sans-serif; border-radius: 3px; overflow: hidden; p=
adding: 18px 25px; border: 1px solid #ededed;" align=3D"left" bgcolor=3D"=
#fff">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"content"=
 style=3D"width: 100%; border-collapse: separate; border-spacing: 0;">
<tbody>
<tr class=3D"alert">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; bo=
rder-radius: 3px; font-size: 14px; line-height: 1.3; overflow: hidden; co=
lor: #ffffff; padding: 10px;" align=3D"center" bgcolor=3D"#d22f57">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse; margin: 0 auto;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #ffffff; padding-right: 5px; line-height: 1;" align=3D"center" valig=
n=3D"middle">
<img alt=3D"&#10006;" height=3D"13" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-inverted-06edddd39ba2a7f9a32f6201e420=
175db85a4b6ac0348203fdc069001b440149.gif" style=3D"display: block;" width=
=3D"13" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #ffffff;" align=3D"center" valign=3D"middle">
Your pipeline has failed.
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr class=3D"spacer">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; he=
ight: 18px; font-size: 18px; line-height: 18px;">
&#160;
</td>
</tr>
<tr class=3D"section">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; bo=
rder-radius: 3px; overflow: hidden; padding: 0 15px; border: 1px solid #e=
deded;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"table-in=
fo" style=3D"width: 100%;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; margin=
: 0; padding: 14px 0;">Project</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 500; color: #333333; width:=
 75%; margin: 0; padding: 14px 0 14px 5px;">
<a class=3D"muted" href=3D"https://gitlab.com/qemu-project" style=3D"colo=
r: #333333; text-decoration: none;">
QEMU
</a>
/
<a class=3D"muted" href=3D"https://gitlab.com/qemu-project/qemu" style=3D=
"color: #333333; text-decoration: none;">
QEMU
</a>
</td>
</tr>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; border=
-top-width: 1px; border-top-color: #ededed; border-top-style: solid; marg=
in: 0; padding: 14px 0;">Branch</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 500; color: #333333; width:=
 75%; border-top-width: 1px; border-top-color: #ededed; border-top-style:=
 solid; margin: 0; padding: 14px 0 14px 5px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px;" valign=3D"middle">
<img alt=3D"" height=3D"13" src=3D"https://gitlab.com/assets/mailers/ci_p=
ipeline_notif_v1/icon-branch-gray-53618a7fc19d4d32ccbabac2f6d59bebe67202a=
9f2f1255e3f72c69756c0dd9c.gif" style=3D"display: block;" width=3D"13" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4;" valign=3D"middle">
<a class=3D"muted" href=3D"https://gitlab.com/qemu-project/qemu/-/commits=
/master" style=3D"color: #333333; text-decoration: none;">
master
</a>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; border=
-top-width: 1px; border-top-color: #ededed; border-top-style: solid; marg=
in: 0; padding: 14px 0;">Commit</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 400; color: #333333; width:=
 75%; border-top-width: 1px; border-top-color: #ededed; border-top-style:=
 solid; margin: 0; padding: 14px 0 14px 5px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px;" valign=3D"middle">
<img alt=3D"" height=3D"13" src=3D"https://gitlab.com/assets/mailers/ci_p=
ipeline_notif_v1/icon-commit-gray-c10243ac24cde64b549aec91de35e6b49c8739b=
506b86472b54614c10d8b4aac.gif" style=3D"display: block;" width=3D"13" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4;" valign=3D"middle">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/aeb07b5f6e69ce93=
afea71027325e3e7a22d2149" style=3D"color: #3777b0; text-decoration: none;=
">
aeb07b5f
</a>
</td>
</tr>
</tbody>
</table>
<div class=3D"commit" style=3D"color: #5c5c5c; font-weight: 300;">
Merge remote-tracking branch 'remotes/alistair/...
</div>
</td>
</tr>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; color: #8c8c8c; font-weight: 300; border=
-top-width: 1px; border-top-color: #ededed; border-top-style: solid; marg=
in: 0; padding: 14px 0;">Commit Author</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; font-weight: 500; color: #333333; width:=
 75%; border-top-width: 1px; border-top-color: #ededed; border-top-style:=
 solid; margin: 0; padding: 14px 0 14px 5px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px;" valign=3D"middle">
<img alt=3D"" class=3D"avatar" height=3D"24" src=3D"https://secure.gravat=
ar.com/avatar/98261ce19b4e9da714d577154686723a?s=3D48&amp;d=3Didenticon" =
style=3D"display: block; border-radius: 12px; margin: -2px 0;" width=3D"2=
4" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4;" valign=3D"middle">
<a class=3D"muted" href=3D"https://gitlab.com/pm215" style=3D"color: #333=
333; text-decoration: none;">
Peter Maydell
</a>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr class=3D"spacer">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; he=
ight: 18px; font-size: 18px; line-height: 18px;">
&#160;
</td>
</tr>
<tr class=3D"pre-section">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #333333; font-size: 15px; font-weight: 400; line-height: 1.4; paddin=
g: 15px 5px 0;" align=3D"center">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse; margin: 0 auto;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; font-weight: 500; line-height: 1.4;" valign=3D"baseline">
Pipeline
<a href=3D"https://gitlab.com/qemu-project/qemu/-/pipelines/166549079" st=
yle=3D"color: #3777b0; text-decoration: none;">
#166549079
</a>
triggered by
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; line-height: 1.4; padding-right: 5px; padding-left: 5px;" =
width=3D"24" valign=3D"middle">
<img alt=3D"" class=3D"avatar" height=3D"24" src=3D"https://secure.gravat=
ar.com/avatar/a7d7f408c0b3370bbbeb98833d6c50e4?s=3D48&amp;d=3Didenticon" =
style=3D"display: block; border-radius: 12px; margin: -2px 0;" width=3D"2=
4" />
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; fo=
nt-size: 15px; font-weight: 500; line-height: 1.4;" valign=3D"baseline">
<a class=3D"muted" href=3D"https://gitlab.com/stsquad" style=3D"color: #3=
33333; text-decoration: none;">
Alex Benn&#233;e
</a>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
<tr>
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; color: #333333; font-size: 14px; font-weight: 400; line-heigh=
t: 1.4; padding: 0 8px 16px;" align=3D"center">
had
23
failed
builds.
</td>
</tr>
<tr class=3D"table-warning">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; bo=
rder-radius: 4px 4px 0 0; overflow: hidden; color: #d22852; font-size: 14=
px; line-height: 1.4; padding: 8px 16px; border-color: #ededed; border-st=
yle: solid; border-width: 1px 1px 0;" align=3D"center" bgcolor=3D"#fdf4f6=
">
Logs may contain sensitive data. Please consider before forwarding this e=
mail.
</td>
</tr>
<tr class=3D"section">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; ov=
erflow: hidden; border-radius: 0 0 4px 4px; padding: 0 16px; border-color=
: #ededed; border-style: solid; border-width: 0 1px 1px;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"builds" =
style=3D"width: 100%; border-collapse: collapse;">
<tbody>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484602" style=3D=
"color: #3777b0; text-decoration: none;">
mips64-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-mips64-cross', '-f', '/tmp/dock=
er_buildg2vp1ctn/tmp90o0osac.docker', '--build-arg', 'BUILDKIT_INLINE_CAC=
HE=3D1', '/tmp/docker_buildg2vp1ctn']' returned non-zero exit status 1.<b=
r /></span><div class=3D"section-start" data-timestamp=3D"1594753344" dat=
a-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l=
-cyan term-bold section section-header js-s-after-script">Running after_s=
cript</span><span class=3D"section section-header js-s-after-script"><br =
/></span><span class=3D"term-fg-l-green term-bold section line js-s-after=
-script">Running after script...</span><span class=3D"section line js-s-a=
fter-script"><br /></span><span class=3D"term-fg-l-green term-bold sectio=
n line js-s-after-script">$ docker logout</span><span class=3D"section li=
ne js-s-after-script"><br />Removing login credentials for https://index.=
docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"afte=
r-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed=
: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484604" style=3D=
"color: #3777b0; text-decoration: none;">
mips64el-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/4] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/4]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-mips64el-cross', '-f', '/tmp/do=
cker_buildupp9934s/tmpf919elpa.docker', '--build-arg', 'BUILDKIT_INLINE_C=
ACHE=3D1', '/tmp/docker_buildupp9934s']' returned non-zero exit status 1.=
<br /></span><div class=3D"section-start" data-timestamp=3D"1594753344" d=
ata-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg=
-l-cyan term-bold section section-header js-s-after-script">Running after=
_script</span><span class=3D"section section-header js-s-after-script"><b=
r /></span><span class=3D"term-fg-l-green term-bold section line js-s-aft=
er-script">Running after script...</span><span class=3D"section line js-s=
-after-script"><br /></span><span class=3D"term-fg-l-green term-bold sect=
ion line js-s-after-script">$ docker logout</span><span class=3D"section =
line js-s-after-script"><br />Removing login credentials for https://inde=
x.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"af=
ter-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job fail=
ed: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484619" style=3D=
"color: #3777b0; text-decoration: none;">
sparc64-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-sparc64-cross', '-f', '/tmp/doc=
ker_buildj554s3lq/tmp5097c6i3.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_buildj554s3lq']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594753344" da=
ta-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-=
l-cyan term-bold section section-header js-s-after-script">Running after_=
script</span><span class=3D"section section-header js-s-after-script"><br=
 /></span><span class=3D"term-fg-l-green term-bold section line js-s-afte=
r-script">Running after script...</span><span class=3D"section line js-s-=
after-script"><br /></span><span class=3D"term-fg-l-green term-bold secti=
on line js-s-after-script">$ docker logout</span><span class=3D"section l=
ine js-s-after-script"><br />Removing login credentials for https://index=
.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"aft=
er-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job faile=
d: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484600" style=3D=
"color: #3777b0; text-decoration: none;">
m68k-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-m68k-cross', '-f', '/tmp/docker=
_build0x7sigw2/tmpc719358w.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=
=3D1', '/tmp/docker_build0x7sigw2']' returned non-zero exit status 1.<br =
/></span><div class=3D"section-start" data-timestamp=3D"1594753343" data-=
section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-c=
yan term-bold section section-header js-s-after-script">Running after_scr=
ipt</span><span class=3D"section section-header js-s-after-script"><br />=
</span><span class=3D"term-fg-l-green term-bold section line js-s-after-s=
cript">Running after script...</span><span class=3D"section line js-s-aft=
er-script"><br /></span><span class=3D"term-fg-l-green term-bold section =
line js-s-after-script">$ docker logout</span><span class=3D"section line=
 js-s-after-script"><br />Removing login credentials for https://index.do=
cker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-=
script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: =
exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484579" style=3D=
"color: #3777b0; text-decoration: none;">
alpha-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-alpha-cross', '-f', '/tmp/docke=
r_build5ykmue8r/tmpd72jbt73.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build5ykmue8r']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594753343" data=
-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-=
cyan term-bold section section-header js-s-after-script">Running after_sc=
ript</span><span class=3D"section section-header js-s-after-script"><br /=
></span><span class=3D"term-fg-l-green term-bold section line js-s-after-=
script">Running after script...</span><span class=3D"section line js-s-af=
ter-script"><br /></span><span class=3D"term-fg-l-green term-bold section=
 line js-s-after-script">$ docker logout</span><span class=3D"section lin=
e js-s-after-script"><br />Removing login credentials for https://index.d=
ocker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after=
-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed:=
 exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484598" style=3D=
"color: #3777b0; text-decoration: none;">
hppa-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-hppa-cross', '-f', '/tmp/docker=
_buildghkc9567/tmpsd0zrx06.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=
=3D1', '/tmp/docker_buildghkc9567']' returned non-zero exit status 1.<br =
/></span><div class=3D"section-start" data-timestamp=3D"1594753342" data-=
section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-c=
yan term-bold section section-header js-s-after-script">Running after_scr=
ipt</span><span class=3D"section section-header js-s-after-script"><br />=
</span><span class=3D"term-fg-l-green term-bold section line js-s-after-s=
cript">Running after script...</span><span class=3D"section line js-s-aft=
er-script"><br /></span><span class=3D"term-fg-l-green term-bold section =
line js-s-after-script">$ docker logout</span><span class=3D"section line=
 js-s-after-script"><br />Removing login credentials for https://index.do=
cker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-=
script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: =
exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484590" style=3D=
"color: #3777b0; text-decoration: none;">
arm64-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 resolv=
e docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian10:=
latest 0.2s done<br />#4 ERROR: pull access denied, repository does not e=
xist or may require authorization: server message: insufficient_scope: au=
thorization failed<br />------<br /> &gt; [internal] load metadata for do=
cker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/5] FR=
OM docker.io/qemu/debian10:latest:<br />------<br />failed to solve with =
frontend dockerfile.v0: failed to build LLB: failed to load cache key: pu=
ll access denied, repository does not exist or may require authorization:=
 server message: insufficient_scope: authorization failed<br />Traceback =
(most recent call last):<br />  File "./tests/docker/docker.py", line 702=
, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/docker=
/docker.py", line 698, in main<br />    return args.cmdobj.run(args, argv=
)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dkr.b=
uild_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/docke=
r.py", line 347, in build_image<br />    self._do_check(build_args,<br />=
  File "./tests/docker/docker.py", line 244, in _do_check<br />    return=
 subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/usr/l=
ib/python3.8/subprocess.py", line 364, in check_call<br />    raise Calle=
dProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Command '=
['docker', 'build', '-t', 'qemu/debian-arm64-cross', '-f', '/tmp/docker_b=
uild41u1d3v3/tmp4pxpshpt.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_build41u1d3v3']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594753342" data-sec=
tion=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-cyan=
 term-bold section section-header js-s-after-script">Running after_script=
</span><span class=3D"section section-header js-s-after-script"><br /></s=
pan><span class=3D"term-fg-l-green term-bold section line js-s-after-scri=
pt">Running after script...</span><span class=3D"section line js-s-after-=
script"><br /></span><span class=3D"term-fg-l-green term-bold section lin=
e js-s-after-script">$ docker logout</span><span class=3D"section line js=
-s-after-script"><br />Removing login credentials for https://index.docke=
r.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-scr=
ipt"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: exi=
t code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484587" style=3D=
"color: #3777b0; text-decoration: none;">
amd64-debian-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/11]=
 FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debia=
n10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does n=
ot exist or may require authorization: server message: insufficient_scope=
: authorization failed<br />------<br /> &gt; [internal] load metadata fo=
r docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/1=
1] FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve =
with frontend dockerfile.v0: failed to build LLB: failed to load cache ke=
y: pull access denied, repository does not exist or may require authoriza=
tion: server message: insufficient_scope: authorization failed<br />Trace=
back (most recent call last):<br />  File "./tests/docker/docker.py", lin=
e 702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/d=
ocker/docker.py", line 698, in main<br />    return args.cmdobj.run(args,=
 argv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    =
dkr.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/=
docker.py", line 347, in build_image<br />    self._do_check(build_args,<=
br />  File "./tests/docker/docker.py", line 244, in _do_check<br />    r=
eturn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/=
usr/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise =
CalledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comm=
and '['docker', 'build', '-t', 'qemu/debian-amd64', '-f', '/tmp/docker_bu=
ild2w4799y1/tmp083_s5ub.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_build2w4799y1']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594753341" data-sec=
tion=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-cyan=
 term-bold section section-header js-s-after-script">Running after_script=
</span><span class=3D"section section-header js-s-after-script"><br /></s=
pan><span class=3D"term-fg-l-green term-bold section line js-s-after-scri=
pt">Running after script...</span><span class=3D"section line js-s-after-=
script"><br /></span><span class=3D"term-fg-l-green term-bold section lin=
e js-s-after-script">$ docker logout</span><span class=3D"section line js=
-s-after-script"><br />Removing login credentials for https://index.docke=
r.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-scr=
ipt"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: exi=
t code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484581" style=3D=
"color: #3777b0; text-decoration: none;">
amd64-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/4] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/4]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-amd64-cross', '-f', '/tmp/docke=
r_buildlu9qcvmc/tmp61kzz_ph.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_buildlu9qcvmc']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594753341" data=
-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-=
cyan term-bold section section-header js-s-after-script">Running after_sc=
ript</span><span class=3D"section section-header js-s-after-script"><br /=
></span><span class=3D"term-fg-l-green term-bold section line js-s-after-=
script">Running after script...</span><span class=3D"section line js-s-af=
ter-script"><br /></span><span class=3D"term-fg-l-green term-bold section=
 line js-s-after-script">$ docker logout</span><span class=3D"section lin=
e js-s-after-script"><br />Removing login credentials for https://index.d=
ocker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after=
-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed:=
 exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484595" style=3D=
"color: #3777b0; text-decoration: none;">
armel-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/3] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/3]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-armel-cross', '-f', '/tmp/docke=
r_build7hlot6rx/tmpidpvhy4a.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build7hlot6rx']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594753341" data=
-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-=
cyan term-bold section section-header js-s-after-script">Running after_sc=
ript</span><span class=3D"section section-header js-s-after-script"><br /=
></span><span class=3D"term-fg-l-green term-bold section line js-s-after-=
script">Running after script...</span><span class=3D"section line js-s-af=
ter-script"><br /></span><span class=3D"term-fg-l-green term-bold section=
 line js-s-after-script">$ docker logout</span><span class=3D"section lin=
e js-s-after-script"><br />Removing login credentials for https://index.d=
ocker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after=
-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed:=
 exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484614" style=3D=
"color: #3777b0; text-decoration: none;">
riscv64-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-riscv64-cross', '-f', '/tmp/doc=
ker_buildhntahobb/tmpyecfh38h.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_buildhntahobb']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594753340" da=
ta-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-=
l-cyan term-bold section section-header js-s-after-script">Running after_=
script</span><span class=3D"section section-header js-s-after-script"><br=
 /></span><span class=3D"term-fg-l-green term-bold section line js-s-afte=
r-script">Running after script...</span><span class=3D"section line js-s-=
after-script"><br /></span><span class=3D"term-fg-l-green term-bold secti=
on line js-s-after-script">$ docker logout</span><span class=3D"section l=
ine js-s-after-script"><br />Removing login credentials for https://index=
.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"aft=
er-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job faile=
d: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484613" style=3D=
"color: #3777b0; text-decoration: none;">
ppc64el-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/4] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/4]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-ppc64el-cross', '-f', '/tmp/doc=
ker_buildl2mtgh41/tmpw8qa1_j7.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_buildl2mtgh41']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594753339" da=
ta-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-=
l-cyan term-bold section section-header js-s-after-script">Running after_=
script</span><span class=3D"section section-header js-s-after-script"><br=
 /></span><span class=3D"term-fg-l-green term-bold section line js-s-afte=
r-script">Running after script...</span><span class=3D"section line js-s-=
after-script"><br /></span><span class=3D"term-fg-l-green term-bold secti=
on line js-s-after-script">$ docker logout</span><span class=3D"section l=
ine js-s-after-script"><br />Removing login credentials for https://index=
.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"aft=
er-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job faile=
d: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484616" style=3D=
"color: #3777b0; text-decoration: none;">
s390x-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/6] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/6]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-s390x-cross', '-f', '/tmp/docke=
r_build0ho20ina/tmpaaidwr03.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build0ho20ina']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594753338" data=
-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-=
cyan term-bold section section-header js-s-after-script">Running after_sc=
ript</span><span class=3D"section section-header js-s-after-script"><br /=
></span><span class=3D"term-fg-l-green term-bold section line js-s-after-=
script">Running after script...</span><span class=3D"section line js-s-af=
ter-script"><br /></span><span class=3D"term-fg-l-green term-bold section=
 line js-s-after-script">$ docker logout</span><span class=3D"section lin=
e js-s-after-script"><br />Removing login credentials for https://index.d=
ocker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after=
-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed:=
 exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484611" style=3D=
"color: #3777b0; text-decoration: none;">
ppc64-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-ppc64-cross', '-f', '/tmp/docke=
r_build88mcjard/tmprshdu25m.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build88mcjard']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594753338" data=
-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-=
cyan term-bold section section-header js-s-after-script">Running after_sc=
ript</span><span class=3D"section section-header js-s-after-script"><br /=
></span><span class=3D"term-fg-l-green term-bold section line js-s-after-=
script">Running after script...</span><span class=3D"section line js-s-af=
ter-script"><br /></span><span class=3D"term-fg-l-green term-bold section=
 line js-s-after-script">$ docker logout</span><span class=3D"section lin=
e js-s-after-script"><br />Removing login credentials for https://index.d=
ocker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after=
-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed:=
 exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484576" style=3D=
"color: #3777b0; text-decoration: none;">
amd64-debian9-mxe-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/4] =
FROM docker.io/qemu/debian9:latest<br />#4 resolve docker.io/qemu/debian9=
:latest 0.1s done<br />#4 ERROR: pull access denied, repository does not =
exist or may require authorization: server message: insufficient_scope: a=
uthorization failed<br />------<br /> &gt; [internal] load metadata for d=
ocker.io/qemu/debian9:latest:<br />------<br />------<br /> &gt; [1/4] FR=
OM docker.io/qemu/debian9:latest:<br />------<br />failed to solve with f=
rontend dockerfile.v0: failed to build LLB: failed to load cache key: pul=
l access denied, repository does not exist or may require authorization: =
server message: insufficient_scope: authorization failed<br />Traceback (=
most recent call last):<br />  File "./tests/docker/docker.py", line 702,=
 in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/docker/=
docker.py", line 698, in main<br />    return args.cmdobj.run(args, argv)=
<br />  File "./tests/docker/docker.py", line 492, in run<br />    dkr.bu=
ild_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/docker=
.py", line 347, in build_image<br />    self._do_check(build_args,<br /> =
 File "./tests/docker/docker.py", line 244, in _do_check<br />    return =
subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/usr/li=
b/python3.8/subprocess.py", line 364, in check_call<br />    raise Called=
ProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Command '[=
'docker', 'build', '-t', 'qemu/debian9-mxe', '-f', '/tmp/docker_build59l6=
z_ct/tmpmjoroupi.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/t=
mp/docker_build59l6z_ct']' returned non-zero exit status 1.<br /></span><=
div class=3D"section-start" data-timestamp=3D"1594753337" data-section=3D=
"after-script" role=3D"button"></div><span class=3D"term-fg-l-cyan term-b=
old section section-header js-s-after-script">Running after_script</span>=
<span class=3D"section section-header js-s-after-script"><br /></span><sp=
an class=3D"term-fg-l-green term-bold section line js-s-after-script">Run=
ning after script...</span><span class=3D"section line js-s-after-script"=
><br /></span><span class=3D"term-fg-l-green term-bold section line js-s-=
after-script">$ docker logout</span><span class=3D"section line js-s-afte=
r-script"><br />Removing login credentials for https://index.docker.io/v1=
/<br /></span><div class=3D"section-end" data-section=3D"after-script"></=
div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: exit code =
1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484596" style=3D=
"color: #3777b0; text-decoration: none;">
armhf-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 resolv=
e docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian10:=
latest 0.1s done<br />#4 ERROR: pull access denied, repository does not e=
xist or may require authorization: server message: insufficient_scope: au=
thorization failed<br />------<br /> &gt; [internal] load metadata for do=
cker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/5] FR=
OM docker.io/qemu/debian10:latest:<br />------<br />failed to solve with =
frontend dockerfile.v0: failed to build LLB: failed to load cache key: pu=
ll access denied, repository does not exist or may require authorization:=
 server message: insufficient_scope: authorization failed<br />Traceback =
(most recent call last):<br />  File "./tests/docker/docker.py", line 702=
, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/docker=
/docker.py", line 698, in main<br />    return args.cmdobj.run(args, argv=
)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dkr.b=
uild_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/docke=
r.py", line 347, in build_image<br />    self._do_check(build_args,<br />=
  File "./tests/docker/docker.py", line 244, in _do_check<br />    return=
 subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/usr/l=
ib/python3.8/subprocess.py", line 364, in check_call<br />    raise Calle=
dProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Command '=
['docker', 'build', '-t', 'qemu/debian-armhf-cross', '-f', '/tmp/docker_b=
uild5mlz8o6q/tmpzohewk1u.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_build5mlz8o6q']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594753337" data-sec=
tion=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-cyan=
 term-bold section section-header js-s-after-script">Running after_script=
</span><span class=3D"section section-header js-s-after-script"><br /></s=
pan><span class=3D"term-fg-l-green term-bold section line js-s-after-scri=
pt">Running after script...</span><span class=3D"section line js-s-after-=
script"><br /></span><span class=3D"term-fg-l-green term-bold section lin=
e js-s-after-script">$ docker logout</span><span class=3D"section line js=
-s-after-script"><br />Removing login credentials for https://index.docke=
r.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-scr=
ipt"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: exi=
t code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484618" style=3D=
"color: #3777b0; text-decoration: none;">
sh4-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-sh4-cross', '-f', '/tmp/docker_=
buildtjpta2ah/tmpnud2hz8g.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_buildtjpta2ah']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594753337" data-sec=
tion=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-cyan=
 term-bold section section-header js-s-after-script">Running after_script=
</span><span class=3D"section section-header js-s-after-script"><br /></s=
pan><span class=3D"term-fg-l-green term-bold section line js-s-after-scri=
pt">Running after script...</span><span class=3D"section line js-s-after-=
script"><br /></span><span class=3D"term-fg-l-green term-bold section lin=
e js-s-after-script">$ docker logout</span><span class=3D"section line js=
-s-after-script"><br />Removing login credentials for https://index.docke=
r.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-scr=
ipt"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: exi=
t code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484621" style=3D=
"color: #3777b0; text-decoration: none;">
tricore-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian9:latest<br />#4 resolve docker.io/qemu/debian9=
:latest 0.1s done<br />#4 ERROR: pull access denied, repository does not =
exist or may require authorization: server message: insufficient_scope: a=
uthorization failed<br />------<br /> &gt; [internal] load metadata for d=
ocker.io/qemu/debian9:latest:<br />------<br />------<br /> &gt; [1/2] FR=
OM docker.io/qemu/debian9:latest:<br />------<br />failed to solve with f=
rontend dockerfile.v0: failed to build LLB: failed to load cache key: pul=
l access denied, repository does not exist or may require authorization: =
server message: insufficient_scope: authorization failed<br />Traceback (=
most recent call last):<br />  File "./tests/docker/docker.py", line 702,=
 in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/docker/=
docker.py", line 698, in main<br />    return args.cmdobj.run(args, argv)=
<br />  File "./tests/docker/docker.py", line 492, in run<br />    dkr.bu=
ild_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/docker=
.py", line 347, in build_image<br />    self._do_check(build_args,<br /> =
 File "./tests/docker/docker.py", line 244, in _do_check<br />    return =
subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/usr/li=
b/python3.8/subprocess.py", line 364, in check_call<br />    raise Called=
ProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Command '[=
'docker', 'build', '-t', 'qemu/debian-tricore-cross', '-f', '/tmp/docker_=
buildsxiaz1l8/tmpx1mbfjdq.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_buildsxiaz1l8']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594753337" data-sec=
tion=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-cyan=
 term-bold section section-header js-s-after-script">Running after_script=
</span><span class=3D"section section-header js-s-after-script"><br /></s=
pan><span class=3D"term-fg-l-green term-bold section line js-s-after-scri=
pt">Running after script...</span><span class=3D"section line js-s-after-=
script"><br /></span><span class=3D"term-fg-l-green term-bold section lin=
e js-s-after-script">$ docker logout</span><span class=3D"section line js=
-s-after-script"><br />Removing login credentials for https://index.docke=
r.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-scr=
ipt"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: exi=
t code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484584" style=3D=
"color: #3777b0; text-decoration: none;">
amd64-debian-user-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/3] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/3]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-all-test-cross', '-f', '/tmp/do=
cker_build2vbol8s9/tmpm50i7bh0.docker', '--build-arg', 'BUILDKIT_INLINE_C=
ACHE=3D1', '/tmp/docker_build2vbol8s9']' returned non-zero exit status 1.=
<br /></span><div class=3D"section-start" data-timestamp=3D"1594753337" d=
ata-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg=
-l-cyan term-bold section section-header js-s-after-script">Running after=
_script</span><span class=3D"section section-header js-s-after-script"><b=
r /></span><span class=3D"term-fg-l-green term-bold section line js-s-aft=
er-script">Running after script...</span><span class=3D"section line js-s=
-after-script"><br /></span><span class=3D"term-fg-l-green term-bold sect=
ion line js-s-after-script">$ docker logout</span><span class=3D"section =
line js-s-after-script"><br />Removing login credentials for https://inde=
x.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"af=
ter-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job fail=
ed: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484606" style=3D=
"color: #3777b0; text-decoration: none;">
mips-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/5] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/5]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-mips-cross', '-f', '/tmp/docker=
_build6qm9vjas/tmpnygenfen.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=
=3D1', '/tmp/docker_build6qm9vjas']' returned non-zero exit status 1.<br =
/></span><div class=3D"section-start" data-timestamp=3D"1594753337" data-=
section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l-c=
yan term-bold section section-header js-s-after-script">Running after_scr=
ipt</span><span class=3D"section section-header js-s-after-script"><br />=
</span><span class=3D"term-fg-l-green term-bold section line js-s-after-s=
cript">Running after script...</span><span class=3D"section line js-s-aft=
er-script"><br /></span><span class=3D"term-fg-l-green term-bold section =
line js-s-after-script">$ docker logout</span><span class=3D"section line=
 js-s-after-script"><br />Removing login credentials for https://index.do=
cker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"after-=
script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed: =
exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484607" style=3D=
"color: #3777b0; text-decoration: none;">
mipsel-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/5] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/5]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-mipsel-cross', '-f', '/tmp/dock=
er_buildk3_mxyrn/tmprp7bgll7.docker', '--build-arg', 'BUILDKIT_INLINE_CAC=
HE=3D1', '/tmp/docker_buildk3_mxyrn']' returned non-zero exit status 1.<b=
r /></span><div class=3D"section-start" data-timestamp=3D"1594753336" dat=
a-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-l=
-cyan term-bold section section-header js-s-after-script">Running after_s=
cript</span><span class=3D"section section-header js-s-after-script"><br =
/></span><span class=3D"term-fg-l-green term-bold section line js-s-after=
-script">Running after script...</span><span class=3D"section line js-s-a=
fter-script"><br /></span><span class=3D"term-fg-l-green term-bold sectio=
n line js-s-after-script">$ docker logout</span><span class=3D"section li=
ne js-s-after-script"><br />Removing login credentials for https://index.=
docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"afte=
r-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job failed=
: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484609" style=3D=
"color: #3777b0; text-decoration: none;">
powerpc-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/2] =
FROM docker.io/qemu/debian10:latest<br />#4 resolve docker.io/qemu/debian=
10:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian10:latest:<br />------<br />------<br /> &gt; [1/2]=
 FROM docker.io/qemu/debian10:latest:<br />------<br />failed to solve wi=
th frontend dockerfile.v0: failed to build LLB: failed to load cache key:=
 pull access denied, repository does not exist or may require authorizati=
on: server message: insufficient_scope: authorization failed<br />Traceba=
ck (most recent call last):<br />  File "./tests/docker/docker.py", line =
702, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/doc=
ker/docker.py", line 698, in main<br />    return args.cmdobj.run(args, a=
rgv)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dk=
r.build_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/do=
cker.py", line 347, in build_image<br />    self._do_check(build_args,<br=
 />  File "./tests/docker/docker.py", line 244, in _do_check<br />    ret=
urn subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/us=
r/lib/python3.8/subprocess.py", line 364, in check_call<br />    raise Ca=
lledProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Comman=
d '['docker', 'build', '-t', 'qemu/debian-powerpc-cross', '-f', '/tmp/doc=
ker_build0y5d3yd6/tmpidxmcwqm.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_build0y5d3yd6']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594753336" da=
ta-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-=
l-cyan term-bold section section-header js-s-after-script">Running after_=
script</span><span class=3D"section section-header js-s-after-script"><br=
 /></span><span class=3D"term-fg-l-green term-bold section line js-s-afte=
r-script">Running after script...</span><span class=3D"section line js-s-=
after-script"><br /></span><span class=3D"term-fg-l-green term-bold secti=
on line js-s-after-script">$ docker logout</span><span class=3D"section l=
ine js-s-after-script"><br />Removing login credentials for https://index=
.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"aft=
er-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job faile=
d: exit code 1<br /></span></pre>
</td>
</tr>
<tr class=3D"build-state">
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px; padding: 16px 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" class=3D"img" sty=
le=3D"border-collapse: collapse;">
<tbody>
<tr>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #d22f57; font-weight: 500; font-size: 16px; padding-right: 8px; line=
-height: 10px;" valign=3D"middle">
<img alt=3D"&#10006;" height=3D"10" src=3D"https://gitlab.com/assets/mail=
ers/ci_pipeline_notif_v1/icon-x-red-67056b7b99899e30453df79abfbe16162f6a2=
6ed789d8236f81afcaea216ffe6.gif" style=3D"display: block;" width=3D"10" /=
>
</td>
<td style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif; co=
lor: #8c8c8c; font-weight: 500; font-size: 14px;" valign=3D"middle">
containers-layer2
</td>
</tr>
</tbody>
</table>
</td>
<td align=3D"right" style=3D"font-family: 'Helvetica Neue',Helvetica,Aria=
l,sans-serif; color: #8c8c8c; font-weight: 500; font-size: 14px; padding:=
 16px 0;">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/638484592" style=3D=
"color: #3777b0; text-decoration: none;">
arm64-test-debian-cross-container
</a>

</td>
</tr>
<tr class=3D"build-log">
<td colspan=3D"2" style=3D"font-family: 'Helvetica Neue',Helvetica,Arial,=
sans-serif; padding: 0 0 16px;">
<pre style=3D"font-family: Monaco,'Lucida Console','Courier New',Courier,=
monospace; background-color: #fafafa; border-radius: 4px; overflow: hidde=
n; white-space: pre-wrap; word-break: break-all; font-size: 13px; line-he=
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 resolv=
e docker.io/qemu/debian11:latest<br />#4 resolve docker.io/qemu/debian11:=
latest 0.1s done<br />#4 ERROR: pull access denied, repository does not e=
xist or may require authorization: server message: insufficient_scope: au=
thorization failed<br />------<br /> &gt; [internal] load metadata for do=
cker.io/qemu/debian11:latest:<br />------<br />------<br /> &gt; [1/3] FR=
OM docker.io/qemu/debian11:latest:<br />------<br />failed to solve with =
frontend dockerfile.v0: failed to build LLB: failed to load cache key: pu=
ll access denied, repository does not exist or may require authorization:=
 server message: insufficient_scope: authorization failed<br />Traceback =
(most recent call last):<br />  File "./tests/docker/docker.py", line 702=
, in &lt;module&gt;<br />    sys.exit(main())<br />  File "./tests/docker=
/docker.py", line 698, in main<br />    return args.cmdobj.run(args, argv=
)<br />  File "./tests/docker/docker.py", line 492, in run<br />    dkr.b=
uild_image(tag, docker_dir, dockerfile,<br />  File "./tests/docker/docke=
r.py", line 347, in build_image<br />    self._do_check(build_args,<br />=
  File "./tests/docker/docker.py", line 244, in _do_check<br />    return=
 subprocess.check_call(self._command + cmd, **kwargs)<br />  File "/usr/l=
ib/python3.8/subprocess.py", line 364, in check_call<br />    raise Calle=
dProcessError(retcode, cmd)<br />subprocess.CalledProcessError: Command '=
['docker', 'build', '-t', 'qemu/debian-arm64-test-cross', '-f', '/tmp/doc=
ker_build0exuw2qd/tmp7jgahdu2.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_build0exuw2qd']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594753319" da=
ta-section=3D"after-script" role=3D"button"></div><span class=3D"term-fg-=
l-cyan term-bold section section-header js-s-after-script">Running after_=
script</span><span class=3D"section section-header js-s-after-script"><br=
 /></span><span class=3D"term-fg-l-green term-bold section line js-s-afte=
r-script">Running after script...</span><span class=3D"section line js-s-=
after-script"><br /></span><span class=3D"term-fg-l-green term-bold secti=
on line js-s-after-script">$ docker logout</span><span class=3D"section l=
ine js-s-after-script"><br />Removing login credentials for https://index=
.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"aft=
er-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job faile=
d: exit code 1<br /></span></pre>
</td>
</tr>
</tbody>
</table>
</td>
</tr>


</tbody>
</table>
</td>
</tr>
</tbody>
</table>
</td>
</tr>

<tr class=3D"footer">
<td style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif; font-size: 13px; line-height: 1.6; color: #5c5c5c; padding: 25=
px 0;">
<img alt=3D"GitLab" height=3D"33" src=3D"https://gitlab.com/assets/mailer=
s/gitlab_footer_logo-078860f148cc9596195e6bb3fa7db31c30538355576c5c3b569c=
414902e3d095.gif" width=3D"90" style=3D"display: block; margin: 0 auto 1e=
m;" />
<div>
You're receiving this email because of your account on gitlab.com. <a cla=
ss=3D"mng-notif-link" href=3D"https://gitlab.com/profile/notifications" s=
tyle=3D"color: #3777b0; text-decoration: none;">Manage all notifications<=
/a> &#183; <a class=3D"help-link" href=3D"https://gitlab.com/help" style=3D=
"color: #3777b0; text-decoration: none;">Help</a>
</div>
</td>
</tr>

<tr>
<td class=3D"footer-message" style=3D"font-family: &quot;Helvetica Neue&q=
uot;, Helvetica, Arial, sans-serif; font-size: 13px; line-height: 1.6; co=
lor: #5c5c5c; padding: 25px 0;">

</td>
</tr>
</tbody>
</table>
</body>
</html>

----==_mimepart_5f0e01b57896e_2d93fb6ac87b2c85425c--

