Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14526C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2B32076E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 07:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2B32076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9aK-00019T-De
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 03:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kR9Zh-0000j6-3E
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:45:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:42636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kR9Ze-0005ZC-3y
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:45:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kR9ZZ-0001wt-W3
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:45:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F17E12E80DE
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:45:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2020 07:36:17 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1897783@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=cleber.gnu@gmail.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cleber-gnu philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <160140299141.23116.14910893698614529826.malonedeb@wampee.canonical.com>
Message-ID: <90377288-f072-daee-c638-373382ff5efb@redhat.com>
Subject: [Bug 1897783] Re: [PATCH 1/3] Acceptance tests: bump pycdlib version
 for easier installation
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="781851f4dc11c93bc506eb54e6a0d35c919a1ce6"; Instance="production"
X-Launchpad-Hash: 86b1671ec8ec6f8b579f68c129119da61fbee51c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:45:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1897783 <1897783@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20201010073617.lOIVC865SP2vrFLhO5igMQUgx0OHiRnMH_p41poa9fg@z>

On 10/9/20 10:55 PM, Cleber Rosa wrote:
> On with certain versions of "pip", package installations will attempt
> to create wheels.  And, on environments without a "complete" Python
> installation (as described in the acceptance tests requirements docs),
> that will fail.
> =

> pycdlib, starting with version 1.11.0, is now being made available
> as wheels, so its instalation on those constrained environments is
> now possible.
> =

> Cc: Bug 1897783 <1897783@bugs.launchpad.net>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880189

This BZ is different. The correct URL is:
https://bugs.launchpad.net/qemu/+bug/1897783

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 036691c922..a1c631fa59 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -2,4 +2,4 @@
>   # in the tests/venv Python virtual environment. For more info,
>   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>   avocado-framework=3D=3D81.0
> -pycdlib=3D=3D1.9.0
> +pycdlib=3D=3D1.11.0
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1897783

Title:
  avocado tests not running on aarch64 host

Status in QEMU:
  New

Bug description:
  $ lsb_release -a
  No LSB modules are available.
  Distributor ID: Ubuntu
  Description:    Ubuntu 20.04.1 LTS
  Release:        20.04
  Codename:       focal

  $ make check-venv
    VENV    /home/phil/qemu/build/tests/venv
    PIP     /home/phil/qemu/tests/requirements.txt
    ERROR: Command errored out with exit status 1:
     command: /home/phil/qemu/build/tests/venv/bin/python -u -c 'import sys=
, setuptools, tokenize; sys.argv[0] =3D '"'"'/tmp/pip-install-w1h2bh4a/pycd=
lib/setup.py'"'"'; __file__=3D'"'"'/tmp/pip-install-w1h2bh4a/pycdlib/setup.=
py'"'"';f=3Dgetattr(tokenize, '"'"'open'"'"', open)(__file__);code=3Df.read=
().replace('"'"'\r\n'"'"', '"'"'\n'"'"');f.close();exec(compile(code, __fil=
e__, '"'"'exec'"'"'))' bdist_wheel -d /tmp/pip-wheel-ic25ctcg
         cwd: /tmp/pip-install-w1h2bh4a/pycdlib/
    Complete output (6 lines):
    usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...]
       or: setup.py --help [cmd1 cmd2 ...]
       or: setup.py --help-commands
       or: setup.py cmd --help
    =

    error: invalid command 'bdist_wheel'
    ----------------------------------------
    ERROR: Failed building wheel for pycdlib
  $

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1897783/+subscriptions

