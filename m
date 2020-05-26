Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EEFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D92207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpRJsGoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D92207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdgTo-0007RT-Jb
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdgT6-0006sN-I2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:46:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1jdgT5-0001ID-Cl
 for qemu-devel@nongnu.org; Tue, 26 May 2020 16:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590525994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UpCwNOagiz32ixkmyHuLbge60IjA4Cz2pewqgkGiSAk=;
 b=CpRJsGoJLzLW/h6VHdLjeJpKIBnC4LTR6dpXQbIA+Ctd7TsbkYSaVKtsml9nJWgizDzt6z
 AWpYJcTNnhip+GiX5uUXqMTOTozuDC7yyazAyL5VxewxD0tsskuTefvj5ibMQF5e/1ZocC
 cfW+MaB+QPEX8xd45dqwlduP7aVTylw=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-k0BVj4tGNWSPKoyCwjerHg-1; Tue, 26 May 2020 16:46:26 -0400
X-MC-Unique: k0BVj4tGNWSPKoyCwjerHg-1
Received: by mail-vk1-f198.google.com with SMTP id n1so8447551vke.6
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 13:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UpCwNOagiz32ixkmyHuLbge60IjA4Cz2pewqgkGiSAk=;
 b=AtzKSWdbyN/ezkYtnvIC0q8aOMNPAfzSdD9BkBu6YVn0UBzjCb9PMcqAYmtsdvXwDg
 RBfe0v0NOLRkUdQ2kINe8Argt36c2sshjxwqkGLsOg+DDDOiQ/Bp4TUMziI+H8HDwzap
 ng/DOmHaCaSiJ383+U9WMrrYUFYb15DU70/M+aKnsN4lu3n3KU41dNJjOeH9IviRmYCY
 NV9uKhE8bHiMQXvx7dlEZBdqlGTqnr9pYoHk+D+U9y6/6sSLLAC7HGtySE4UmR9BnaKU
 TV9s02AVwF+JcMoxfNDLDc8AwT2/qEurv6/JS0KS+GY4Xh5WXVU/zqRxLc0bQxl+6EGn
 scEw==
X-Gm-Message-State: AOAM532rpOtaU/neDqcxIz1HYL10ydIR21v7wABBNFices3UA8fedBO7
 GFzgpGaSNVRFUxQj3MIC909T3DKVFRWkPAdcO0IRibZFDe5b+/cbbpxl13KBxywWCffPF/VBUkU
 tcDcLohXKvrCAwsj7swkYTDJNhySfL5M=
X-Received: by 2002:a05:6102:ce:: with SMTP id
 u14mr2377351vsp.48.1590525985273; 
 Tue, 26 May 2020 13:46:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzjEzuvT/CjYYGpIzfBvpacWkjXQiYNEQESu9oZPvKU+N8j4q5IKBmpgLIi2UY08f1QnPK90gnXP11aglpzDs=
X-Received: by 2002:a05:6102:ce:: with SMTP id
 u14mr2377321vsp.48.1590525984908; 
 Tue, 26 May 2020 13:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <159040554265.2615.8993443700754452381.stgit@pasha-ThinkPad-X280>
 <159040555391.2615.4700513751491354604.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159040555391.2615.4700513751491354604.stgit@pasha-ThinkPad-X280>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 26 May 2020 17:46:14 -0300
Message-ID: <CAKJDGDbOFCdscO5ro9ZRNuHGL=zdmMHoB0dQJ-Qu9MeAzRM+0Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] tests/acceptance: add base class record/replay kernel
 tests
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, Cleber Rosa Junior <crosa@redhat.com>,
 pbonzini@redhat.com, Philippe Mathieu Daude <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 8:22 AM Pavel Dovgalyuk
<Pavel.Dovgaluk@gmail.com> wrote:
>
> This patch adds a base for testing kernel boot recording and replaying.
> Each test has the phase of recording and phase of replaying.
> Virtual machines just boot the kernel and do not interact with
> the network.
> Structure and image links for the tests are borrowed from boot_linux_console.py
> Testing controls the message pattern at the end of the kernel
> boot for both record and replay modes. In replay mode QEMU is also
> intended to finish the execution automatically.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  MAINTAINERS                       |    1
>  tests/acceptance/replay_kernel.py |   80 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 tests/acceptance/replay_kernel.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47ef3139e6..e9a9ce4f66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2497,6 +2497,7 @@ F: net/filter-replay.c
>  F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
> +F: tests/acceptance/replay_kernel.py
>
>  IOVA Tree
>  M: Peter Xu <peterx@redhat.com>
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> new file mode 100644
> index 0000000000..3208179789
> --- /dev/null
> +++ b/tests/acceptance/replay_kernel.py
> @@ -0,0 +1,80 @@
> +# Record/replay test that boots a Linux kernel
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import gzip
> +
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import process
> +from avocado.utils import archive
> +
> +class ReplayKernel(Test):
> +    """
> +    Boots a Linux kernel in record mode and checks that the console
> +    is operational and the kernel command line is properly passed
> +    from QEMU to the kernel.
> +    Then replays the same scenario and verifies, that QEMU correctly
> +    terminates.
> +    """

The best to do here, IMHO, is to split the BootLinuxConsole class on
boot_linux_console.py into two classes, one with the necessary
utilities inheriting from Test and the second with the tests itself,
inheriting from the first. After that you can also inherit from the
first class in the boot_linux_console.py here and avoid code
duplication.

> +
> +    timeout = 90
> +
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +
> +    def wait_for_console_pattern(self, success_message, vm):
> +        wait_for_console_pattern(self, success_message,
> +                                 failure_message='Kernel panic - not syncing',
> +                                 vm=vm)
> +
> +    def extract_from_deb(self, deb, path):
> +        """
> +        Extracts a file from a deb package into the test workdir
> +
> +        :param deb: path to the deb archive
> +        :param path: path within the deb archive of the file to be extracted
> +        :returns: path of the extracted file
> +        """
> +        cwd = os.getcwd()
> +        os.chdir(self.workdir)
> +        file_path = process.run("ar t %s" % deb).stdout_text.split()[2]
> +        process.run("ar x %s %s" % (deb, file_path))
> +        archive.extract(file_path, self.workdir)
> +        os.chdir(cwd)
> +        # Return complete path to extracted file.  Because callers to
> +        # extract_from_deb() specify 'path' with a leading slash, it is
> +        # necessary to use os.path.relpath() as otherwise os.path.join()
> +        # interprets it as an absolute path and drops the self.workdir part.
> +        return os.path.normpath(os.path.join(self.workdir,
> +                                             os.path.relpath(path, '/')))
> +
> +    def run_vm(self, kernel_path, kernel_command_line, console_pattern, record, shift, args):
> +        vm = self.get_vm()
> +        vm.set_console()
> +        if record:
> +            mode = 'record'
> +        else:
> +            mode = 'replay'
> +        vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s' %
> +                    (shift, mode, os.path.join(self.workdir, 'replay.bin')),
> +                    '-kernel', kernel_path,
> +                    '-append', kernel_command_line,
> +                    '-net', 'none',
> +                    *args)
> +        vm.launch()
> +        self.wait_for_console_pattern(console_pattern, vm)
> +        if record:
> +            vm.shutdown()
> +        else:
> +            vm.wait()
> +
> +    def run_rr(self, kernel_path, kernel_command_line, console_pattern, shift=7, args=()):

Same comment from patch file 9, here you can use the default value of
args as None and handle it in the run_vm method. It is usually
recommended to use a None value for default arguments in Python
instead of an empty structure.

> +        self.run_vm(kernel_path, kernel_command_line, console_pattern, True, shift, args)
> +        self.run_vm(kernel_path, kernel_command_line, console_pattern, False, shift, args)
>
>


