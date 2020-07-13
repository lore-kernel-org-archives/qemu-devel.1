Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D886C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2352206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.gitlab.com header.i=@mg.gitlab.com header.b="qJ5nc3Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2352206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juyvW-00040H-V9
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 09:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1juyuV-00036k-Sw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:54:23 -0400
Received: from do158-143.mg.gitlab.com ([192.237.158.143]:60050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com>)
 id 1juyuN-00044I-BM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 09:54:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.gitlab.com;
 q=dns/txt; 
 s=mailo; t=1594648457; h=List-Id: Content-Transfer-Encoding:
 Content-Type: Mime-Version: Subject: Message-ID: Reply-To: From: Date:
 Sender; bh=giY8udK7Si9RMX1T73FtBxypUEbuKpFucuENIPQCodg=;
 b=qJ5nc3LbMmVtwfF0SwXcYKftXAG45kZ+fmu0qO9beEhQd25ASpQrnEYbq6Qv5k+DBGnkWgOF
 3ovFqM8ZSYpJhO4Kw28bGXvA2KXAIKnkXF5Jwqq9BZaQxBez8a/8STrcnR5/Xi8OvDHCpiNG
 YBI+rSlpz4ewLeaYG5/1DocEcPo=
X-Mailgun-Sending-Ip: 192.237.158.143
X-Mailgun-Sid: WyI3MWYzYSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOTQ3YjQiXQ==
Received: from mg.gitlab.com (65.90.74.34.bc.googleusercontent.com
 [34.74.90.65]) by smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f0c678403c8596cdb3b1e15 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 13 Jul 2020 13:54:12 GMT
Date: Mon, 13 Jul 2020 13:54:12 +0000
Message-ID: <5f0c67848619_736d3fc7580005b4234498@sidekiq-catchall-05-sv-gprd.mail>
Subject: QEMU | Pipeline #166006796 has failed for master | 00ce6c36
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_5f0c6783d5c29_736d3fc7580005b423437a";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitLab-Project: QEMU
X-GitLab-Project-Id: 11167699
X-GitLab-Project-Path: qemu-project/qemu
X-GitLab-Pipeline-Id: 166006796
X-GitLab-Pipeline-Ref: master
X-GitLab-Pipeline-Status: failed
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
Received-SPF: pass client-ip=192.237.158.143;
 envelope-from=bounce+2dc402.947b4-qemu-devel=nongnu.org@mg.gitlab.com;
 helo=do158-143.mg.gitlab.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 04:41:16
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


----==_mimepart_5f0c6783d5c29_736d3fc7580005b423437a
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Your pipeline has failed.

Project: QEMU ( https://gitlab.com/qemu-project/qemu )
Branch: master ( https://gitlab.com/qemu-project/qemu/-/commits/master )

Commit: 00ce6c36 ( https://gitlab.com/qemu-project/qemu/-/commit/00ce6c36=
b35e0eb8cc5d68a28f288a6335848813 )
Commit Message: Merge remote-tracking branch 'remotes/huth-gitl...
Commit Author: Peter Maydell ( https://gitlab.com/pm215 )

Pipeline #166006796 ( https://gitlab.com/qemu-project/qemu/-/pipelines/16=
6006796 ) triggered by Alex Benn=C3=A9e ( https://gitlab.com/stsquad )
had 23 failed builds.

Job #636033158 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033158/ra=
w )

Stage: containers-layer2
Name: m68k-debian-cross-container

Job #636033184 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033184/ra=
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
ebian-sh4-cross', '-f', '/tmp/docker_buildi1fp25p6/tmp7d_axquy.docker', '=
--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildi1fp25p6']' =
returned non-zero exit status 1.
section_end:1594648444:step_script
=1B[0Ksection_start:1594648444:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648445:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033187 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033187/ra=
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
ebian-sparc64-cross', '-f', '/tmp/docker_build65zmghm4/tmpkelob784.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build65zmghm4=
']' returned non-zero exit status 1.
section_end:1594648442:step_script
=1B[0Ksection_start:1594648442:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648443:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033159 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033159/ra=
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
ebian-mips64-cross', '-f', '/tmp/docker_build9pw5uiyd/tmpedgewyge.docker'=
, '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build9pw5uiyd'=
]' returned non-zero exit status 1.
section_end:1594648441:step_script
=1B[0Ksection_start:1594648441:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648442:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033143 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033143/ra=
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
ebian-all-test-cross', '-f', '/tmp/docker_builda4vdri0n/tmp2w6apee7.docke=
r', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_builda4vdri0=
n']' returned non-zero exit status 1.
section_end:1594648441:step_script
=1B[0Ksection_start:1594648441:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648442:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033182 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033182/ra=
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
ebian-s390x-cross', '-f', '/tmp/docker_build3f3g9amq/tmpsnoczxpu.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build3f3g9amq']=
' returned non-zero exit status 1.
section_end:1594648441:step_script
=1B[0Ksection_start:1594648441:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648442:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033139 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033139/ra=
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
ebian-alpha-cross', '-f', '/tmp/docker_buildc6vvw4nr/tmpl8ghl2g6.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildc6vvw4nr']=
' returned non-zero exit status 1.
section_end:1594648440:step_script
=1B[0Ksection_start:1594648440:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648441:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033140 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033140/ra=
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
ebian-amd64-cross', '-f', '/tmp/docker_buildnaxy2jjd/tmp1oyi7c8b.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildnaxy2jjd']=
' returned non-zero exit status 1.
section_end:1594648440:step_script
=1B[0Ksection_start:1594648440:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648441:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033171 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033171/ra=
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
ebian-powerpc-cross', '-f', '/tmp/docker_buildjb5qvl7_/tmpyz22dp_a.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildjb5qvl7_=
']' returned non-zero exit status 1.
section_end:1594648440:step_script
=1B[0Ksection_start:1594648440:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648441:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033176 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033176/ra=
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
ebian-ppc64el-cross', '-f', '/tmp/docker_buildobc_le9x/tmpjuqm_iqv.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildobc_le9x=
']' returned non-zero exit status 1.
section_end:1594648439:step_script
=1B[0Ksection_start:1594648439:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648439:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033154 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033154/ra=
w )

Stage: containers-layer2
Name: armhf-debian-cross-container
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
ebian-armhf-cross', '-f', '/tmp/docker_build43pomvtd/tmpwre4i8x5.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build43pomvtd']=
' returned non-zero exit status 1.
section_end:1594648438:step_script
=1B[0Ksection_start:1594648438:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648439:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033152 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033152/ra=
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
ebian-armel-cross', '-f', '/tmp/docker_build726k8jfb/tmp6_q7fvv2.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build726k8jfb']=
' returned non-zero exit status 1.
section_end:1594648435:step_script
=1B[0Ksection_start:1594648435:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648436:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033168 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033168/ra=
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
ebian-mipsel-cross', '-f', '/tmp/docker_build1xdrlxyh/tmp32lw60m6.docker'=
, '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build1xdrlxyh'=
]' returned non-zero exit status 1.
section_end:1594648435:step_script
=1B[0Ksection_start:1594648435:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648436:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033164 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033164/ra=
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
ebian-mips-cross', '-f', '/tmp/docker_build3cvomsqq/tmpj1drldas.docker', =
'--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build3cvomsqq']'=
 returned non-zero exit status 1.
section_end:1594648435:step_script
=1B[0Ksection_start:1594648435:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648436:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033145 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033145/ra=
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
ebian-amd64', '-f', '/tmp/docker_buildt7gkt0_6/tmp7t0x71j1.docker', '--bu=
ild-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildt7gkt0_6']' retu=
rned non-zero exit status 1.
section_end:1594648434:step_script
=1B[0Ksection_start:1594648434:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648435:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033162 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033162/ra=
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
ebian-mips64el-cross', '-f', '/tmp/docker_buildmsuklps6/tmpypb8lvam.docke=
r', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildmsuklps=
6']' returned non-zero exit status 1.
section_end:1594648434:step_script
=1B[0Ksection_start:1594648434:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648434:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033157 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033157/ra=
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
ebian-hppa-cross', '-f', '/tmp/docker_buildp4o5g80_/tmpgwp1zja0.docker', =
'--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildp4o5g80_']'=
 returned non-zero exit status 1.
section_end:1594648434:step_script
=1B[0Ksection_start:1594648434:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648435:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033180 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033180/ra=
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
ebian-riscv64-cross', '-f', '/tmp/docker_buildfuao90br/tmpj9i77zbd.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildfuao90br=
']' returned non-zero exit status 1.
section_end:1594648433:step_script
=1B[0Ksection_start:1594648433:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648434:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033149 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033149/ra=
w )

Stage: containers-layer2
Name: arm64-debian-cross-container
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
ebian-arm64-cross', '-f', '/tmp/docker_buildvxnwyagu/tmp6_bhj99t.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildvxnwyagu']=
' returned non-zero exit status 1.
section_end:1594648432:step_script
=1B[0Ksection_start:1594648432:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648432:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033174 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033174/ra=
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
ebian-ppc64-cross', '-f', '/tmp/docker_build0bj2wb44/tmpbrk6kcej.docker',=
 '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build0bj2wb44']=
' returned non-zero exit status 1.
section_end:1594648431:step_script
=1B[0Ksection_start:1594648431:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648432:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033190 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033190/ra=
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
ebian-tricore-cross', '-f', '/tmp/docker_buildhkt9t6ke/tmpqss9f95g.docker=
', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_buildhkt9t6ke=
']' returned non-zero exit status 1.
section_end:1594648431:step_script
=1B[0Ksection_start:1594648431:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648431:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033132 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033132/ra=
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
ebian9-mxe', '-f', '/tmp/docker_build_1l8ccgv/tmpkln72sxx.docker', '--bui=
ld-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build_1l8ccgv']' retur=
ned non-zero exit status 1.
section_end:1594648430:step_script
=1B[0Ksection_start:1594648430:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648431:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m

Job #636033151 ( https://gitlab.com/qemu-project/qemu/-/jobs/636033151/ra=
w )

Stage: containers-layer2
Name: arm64-test-debian-cross-container
Trace: #4 [1/3] FROM docker.io/qemu/debian11:latest
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
ebian-arm64-test-cross', '-f', '/tmp/docker_build061bcvnv/tmpf2iumhuv.doc=
ker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/tmp/docker_build061bc=
vnv']' returned non-zero exit status 1.
section_end:1594648423:step_script
=1B[0Ksection_start:1594648423:after_script
=1B[0K=1B[0K=1B[36;1mRunning after_script=1B[0;m
=1B[0;m=1B[32;1mRunning after script...=1B[0;m
=1B[32;1m$ docker logout=1B[0;m
Removing login credentials for https://index.docker.io/v1/
section_end:1594648424:after_script
=1B[0K=1B[31;1mERROR: Job failed: exit code 1
=1B[0;m


-- =

You're receiving this email because of your account on gitlab.com.




----==_mimepart_5f0c6783d5c29_736d3fc7580005b423437a
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
<title>QEMU | Pipeline #166006796 has failed for master | 00ce6c36</title=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/00ce6c36b35e0eb8=
cc5d68a28f288a6335848813" style=3D"color: #3777b0; text-decoration: none;=
">
00ce6c36
</a>
</td>
</tr>
</tbody>
</table>
<div class=3D"commit" style=3D"color: #5c5c5c; font-weight: 300;">
Merge remote-tracking branch 'remotes/huth-gitl...
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/pipelines/166006796" st=
yle=3D"color: #3777b0; text-decoration: none;">
#166006796
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033158" style=3D=
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
_buildh56qq8cc/tmp3eknjxuy.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=
=3D1', '/tmp/docker_buildh56qq8cc']' returned non-zero exit status 1.<br =
/></span><div class=3D"section-start" data-timestamp=3D"1594648444" data-=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033184" style=3D=
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
buildi1fp25p6/tmp7d_axquy.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_buildi1fp25p6']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594648444" data-sec=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033187" style=3D=
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
ker_build65zmghm4/tmpkelob784.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_build65zmghm4']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594648442" da=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033159" style=3D=
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
er_build9pw5uiyd/tmpedgewyge.docker', '--build-arg', 'BUILDKIT_INLINE_CAC=
HE=3D1', '/tmp/docker_build9pw5uiyd']' returned non-zero exit status 1.<b=
r /></span><div class=3D"section-start" data-timestamp=3D"1594648441" dat=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033143" style=3D=
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
cker_builda4vdri0n/tmp2w6apee7.docker', '--build-arg', 'BUILDKIT_INLINE_C=
ACHE=3D1', '/tmp/docker_builda4vdri0n']' returned non-zero exit status 1.=
<br /></span><div class=3D"section-start" data-timestamp=3D"1594648441" d=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033182" style=3D=
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
r_build3f3g9amq/tmpsnoczxpu.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build3f3g9amq']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594648441" data=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033139" style=3D=
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
r_buildc6vvw4nr/tmpl8ghl2g6.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_buildc6vvw4nr']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594648440" data=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033140" style=3D=
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
r_buildnaxy2jjd/tmp1oyi7c8b.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_buildnaxy2jjd']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594648440" data=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033171" style=3D=
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
ker_buildjb5qvl7_/tmpyz22dp_a.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_buildjb5qvl7_']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594648440" da=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033176" style=3D=
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
ker_buildobc_le9x/tmpjuqm_iqv.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_buildobc_le9x']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594648439" da=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033154" style=3D=
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
d '['docker', 'build', '-t', 'qemu/debian-armhf-cross', '-f', '/tmp/docke=
r_build43pomvtd/tmpwre4i8x5.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build43pomvtd']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594648438" data=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033152" style=3D=
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
r_build726k8jfb/tmp6_q7fvv2.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build726k8jfb']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594648435" data=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033168" style=3D=
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
er_build1xdrlxyh/tmp32lw60m6.docker', '--build-arg', 'BUILDKIT_INLINE_CAC=
HE=3D1', '/tmp/docker_build1xdrlxyh']' returned non-zero exit status 1.<b=
r /></span><div class=3D"section-start" data-timestamp=3D"1594648435" dat=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033164" style=3D=
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
_build3cvomsqq/tmpj1drldas.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=
=3D1', '/tmp/docker_build3cvomsqq']' returned non-zero exit status 1.<br =
/></span><div class=3D"section-start" data-timestamp=3D"1594648435" data-=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033145" style=3D=
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
ildt7gkt0_6/tmp7t0x71j1.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_buildt7gkt0_6']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594648434" data-sec=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033162" style=3D=
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
cker_buildmsuklps6/tmpypb8lvam.docker', '--build-arg', 'BUILDKIT_INLINE_C=
ACHE=3D1', '/tmp/docker_buildmsuklps6']' returned non-zero exit status 1.=
<br /></span><div class=3D"section-start" data-timestamp=3D"1594648434" d=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033157" style=3D=
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
_buildp4o5g80_/tmpgwp1zja0.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=
=3D1', '/tmp/docker_buildp4o5g80_']' returned non-zero exit status 1.<br =
/></span><div class=3D"section-start" data-timestamp=3D"1594648434" data-=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033180" style=3D=
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
ker_buildfuao90br/tmpj9i77zbd.docker', '--build-arg', 'BUILDKIT_INLINE_CA=
CHE=3D1', '/tmp/docker_buildfuao90br']' returned non-zero exit status 1.<=
br /></span><div class=3D"section-start" data-timestamp=3D"1594648433" da=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033149" style=3D=
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
d '['docker', 'build', '-t', 'qemu/debian-arm64-cross', '-f', '/tmp/docke=
r_buildvxnwyagu/tmp6_bhj99t.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_buildvxnwyagu']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594648432" data=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033174" style=3D=
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
r_build0bj2wb44/tmpbrk6kcej.docker', '--build-arg', 'BUILDKIT_INLINE_CACH=
E=3D1', '/tmp/docker_build0bj2wb44']' returned non-zero exit status 1.<br=
 /></span><div class=3D"section-start" data-timestamp=3D"1594648431" data=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033190" style=3D=
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
buildhkt9t6ke/tmpqss9f95g.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D=
1', '/tmp/docker_buildhkt9t6ke']' returned non-zero exit status 1.<br /><=
/span><div class=3D"section-start" data-timestamp=3D"1594648431" data-sec=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033132" style=3D=
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
'docker', 'build', '-t', 'qemu/debian9-mxe', '-f', '/tmp/docker_build_1l8=
ccgv/tmpkln72sxx.docker', '--build-arg', 'BUILDKIT_INLINE_CACHE=3D1', '/t=
mp/docker_build_1l8ccgv']' returned non-zero exit status 1.<br /></span><=
div class=3D"section-start" data-timestamp=3D"1594648430" data-section=3D=
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
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/636033151" style=3D=
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
ight: 1.4; color: #333333; margin: 0; padding: 16px 8px;"><span>#4 [1/3] =
FROM docker.io/qemu/debian11:latest<br />#4 resolve docker.io/qemu/debian=
11:latest 0.1s done<br />#4 ERROR: pull access denied, repository does no=
t exist or may require authorization: server message: insufficient_scope:=
 authorization failed<br />------<br /> &gt; [internal] load metadata for=
 docker.io/qemu/debian11:latest:<br />------<br />------<br /> &gt; [1/3]=
 FROM docker.io/qemu/debian11:latest:<br />------<br />failed to solve wi=
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
d '['docker', 'build', '-t', 'qemu/debian-arm64-test-cross', '-f', '/tmp/=
docker_build061bcvnv/tmpf2iumhuv.docker', '--build-arg', 'BUILDKIT_INLINE=
_CACHE=3D1', '/tmp/docker_build061bcvnv']' returned non-zero exit status =
1.<br /></span><div class=3D"section-start" data-timestamp=3D"1594648423"=
 data-section=3D"after-script" role=3D"button"></div><span class=3D"term-=
fg-l-cyan term-bold section section-header js-s-after-script">Running aft=
er_script</span><span class=3D"section section-header js-s-after-script">=
<br /></span><span class=3D"term-fg-l-green term-bold section line js-s-a=
fter-script">Running after script...</span><span class=3D"section line js=
-s-after-script"><br /></span><span class=3D"term-fg-l-green term-bold se=
ction line js-s-after-script">$ docker logout</span><span class=3D"sectio=
n line js-s-after-script"><br />Removing login credentials for https://in=
dex.docker.io/v1/<br /></span><div class=3D"section-end" data-section=3D"=
after-script"></div><span class=3D"term-fg-l-red term-bold">ERROR: Job fa=
iled: exit code 1<br /></span></pre>
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

----==_mimepart_5f0c6783d5c29_736d3fc7580005b423437a--

