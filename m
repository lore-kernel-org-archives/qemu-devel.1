Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B614C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842F22076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 20:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzA5M9x7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842F22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYEpB-0002Av-0N
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 16:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYEoM-0001SQ-T5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYEoJ-0005W4-Da
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 16:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604004373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHEABTFTtSR63w7z7oics/LF9jMOQKkql9etv3PC4Z4=;
 b=DzA5M9x7IVE1moPDbuC+9lOGjKe1x/sq9ZLK73IqnA4mcfDJc3DItFUxjwz8YbQWd8Ptnr
 59THLbKJd9DljyUVUhDOVEUR5L0SsYbxQqqmokoYvpwPJcWHgk9s8PAo53mR7oDyvhN2MF
 G9mf6983AcMzo94MDcxfRMnX3Aofgn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-1gRwI2xlPOGe9T9kw7iiGg-1; Thu, 29 Oct 2020 16:46:09 -0400
X-MC-Unique: 1gRwI2xlPOGe9T9kw7iiGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FA6D1006C82
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 20:46:08 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D63A455774;
 Thu, 29 Oct 2020 20:46:01 +0000 (UTC)
Date: Thu, 29 Oct 2020 16:46:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 7/7] tests/acceptance: Add virtiofs_submounts.py
Message-ID: <20201029204601.GM5733@habkost.net>
References: <20201029171744.150726-1-mreitz@redhat.com>
 <20201029171744.150726-8-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029171744.150726-8-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 06:17:44PM +0100, Max Reitz wrote:
> This test invokes several shell scripts to create a random directory
> tree full of submounts, and then check in the VM whether every submount
> has its own ID and the structure looks as expected.
> 
> (Note that the test scripts must be non-executable, so Avocado will not
> try to execute them as if they were tests on their own, too.)
> 
> Because at this commit's date it is unlikely that the Linux kernel on
> the image provided by boot_linux.py supports submounts in virtio-fs, the
> test will be cancelled if no custom Linux binary is provided through the
> vmlinuz parameter.  (The on-image kernel can be used by providing an
> empty string via vmlinuz=.)
> 
> So, invoking the test can be done as follows:
> $ avocado run \
>     tests/acceptance/virtiofs_submounts.py \
>     -p vmlinuz=/path/to/linux/build/arch/x86/boot/bzImage
> 
> This test requires root privileges (through passwordless sudo -n),
> because at this point, virtiofsd requires them.  (If you have a
> timestamp_timeout period for sudoers (e.g. the default of 5 min), you
> can provide this by executing something like "sudo true" before invoking
> Avocado.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/acceptance/virtiofs_submounts.py        | 289 ++++++++++++++++++
>  .../virtiofs_submounts.py.data/cleanup.sh     |  46 +++
>  .../guest-cleanup.sh                          |  30 ++
>  .../virtiofs_submounts.py.data/guest.sh       | 138 +++++++++
>  .../virtiofs_submounts.py.data/host.sh        | 127 ++++++++
>  5 files changed, 630 insertions(+)
>  create mode 100644 tests/acceptance/virtiofs_submounts.py
>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest.sh
>  create mode 100644 tests/acceptance/virtiofs_submounts.py.data/host.sh
> 
> diff --git a/tests/acceptance/virtiofs_submounts.py b/tests/acceptance/virtiofs_submounts.py
> new file mode 100644
> index 0000000000..8b207b3e57
> --- /dev/null
> +++ b/tests/acceptance/virtiofs_submounts.py
> @@ -0,0 +1,289 @@
> +import logging
> +import re
> +import os
> +import subprocess
> +import time
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test, BUILD_DIR
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import ssh
> +
> +from qemu.accel import kvm_available
> +
> +from boot_linux import BootLinux
> +
> +
> +def run_cmd(args):
> +    subp = subprocess.Popen(args,
> +                            stdout=subprocess.PIPE,
> +                            stderr=subprocess.PIPE,
> +                            universal_newlines=True)
> +    stdout, stderr = subp.communicate()
> +    ret = subp.returncode
> +
> +    return (stdout, stderr, ret)
> +
> +def has_passwordless_sudo():
> +    """
> +    This function is for use in a @avocado.skipUnless decorator, e.g.:
> +
> +        @skipUnless(*has_passwordless_sudo())
> +        def test_something_that_needs_sudo(self):
> +            ...
> +    """
> +
> +    _, stderr, exitcode = run_cmd(('sudo', '-n', 'true'))

This seems to break if sudo is not available in the host:

https://gitlab.com/ehabkost/qemu/-/jobs/820072411#L152

0:37:08 ERROR| ERROR 32-tests/acceptance/virtiofs_submounts.py:VirtiofsSubmountsTest.test_pre_virtiofsd_set_up -> TestError: Traceback (most recent call last):
  File "/usr/lib64/python3.6/imp.py", line 235, in load_module
    return load_source(name, filename, file)
  File "/usr/lib64/python3.6/imp.py", line 172, in load_source
    module = _load(spec)
  File "<frozen importlib._bootstrap>", line 684, in _load
  File "<frozen importlib._bootstrap>", line 665, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 678, in exec_module
  File "<frozen importlib._bootstrap>", line 219, in _call_with_frames_removed
  File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.py", line 43, in <module>
    class VirtiofsSubmountsTest(BootLinux):
  File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.py", line 195, in VirtiofsSubmountsTest
    @skipUnless(*has_passwordless_sudo())
  File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.py", line 36, in has_passwordless_sudo
    _, stderr, exitcode = run_cmd(('sudo', '-n', 'true'))
  File "/builds/ehabkost/qemu/build/tests/acceptance/virtiofs_submounts.py", line 21, in run_cmd
    universal_newlines=True)
  File "/usr/lib64/python3.6/subprocess.py", line 729, in __init__
    restore_signals, start_new_session)
  File "/usr/lib64/python3.6/subprocess.py", line 1364, in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: 'sudo': 'sudo'
20:37:08 INFO | 

> +    if exitcode != 0:
> +        return (False, f'Failed to use sudo -n: {stderr.strip()}')
> +    else:
> +        return (True, '')
> +
> +
[...]

-- 
Eduardo


