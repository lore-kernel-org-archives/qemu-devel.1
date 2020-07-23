Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA49C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35CC920768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGaeYHPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35CC920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaS9-0000yy-Fv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jyaQk-0007gg-Ns
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:34:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58858
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1jyaQj-0004XE-1J
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595507671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGFdkiMMnv21p2XxDrboBs5BPcRmdQ3tPRBFMi7QLtg=;
 b=gGaeYHPf+aWzIUsSIuuvwv2IurPOYda4eH/z6ltcU7Ng2qjI3NW9680oLqOHoIsRNVWHyb
 vpOzeB9XQD8PXhKsuNK7CHtnLGocsdqirT6VmWhNkiIL2pYrnUsAH8Z2ZMotCUPdwHe0g9
 h9CyWJg68V5MaogtCP4L1IzsPJqgo9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-qCr4MufyN6aUt01YqomHXA-1; Thu, 23 Jul 2020 08:33:21 -0400
X-MC-Unique: qCr4MufyN6aUt01YqomHXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBAA0189CEE2;
 Thu, 23 Jul 2020 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-96.gru2.redhat.com
 [10.97.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE5EF756A0;
 Thu, 23 Jul 2020 12:33:07 +0000 (UTC)
Subject: Re: [PATCH 3/4] tests/acceptance: Disable the rx sash and arm
 cubieboard replay test on Gitlab
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200723122800.723-1-thuth@redhat.com>
 <20200723122800.723-4-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <aee2cb74-1e6c-7c5b-f09e-c8cd5e532383@redhat.com>
Date: Thu, 23 Jul 2020 09:33:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200723122800.723-4-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wainersm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=wainersm@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 7/23/20 9:27 AM, Thomas Huth wrote:
> These tests always time out on Gitlab, not sure what's happening here.
> Let's disable them until somebody has enough spare time to debug the
> issues.

It's fair to me.

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/acceptance/machine_rx_gdbsim.py | 4 ++++
>   tests/acceptance/replay_kernel.py     | 1 +
>   2 files changed, 5 insertions(+)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/machine_rx_gdbsim.py b/tests/acceptance/machine_rx_gdbsim.py
> index bff63e421d..0c72506028 100644
> --- a/tests/acceptance/machine_rx_gdbsim.py
> +++ b/tests/acceptance/machine_rx_gdbsim.py
> @@ -8,6 +8,9 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> +import os
> +
> +from avocado import skipIf
>   from avocado_qemu import Test
>   from avocado_qemu import exec_command_and_wait_for_pattern
>   from avocado_qemu import wait_for_console_pattern
> @@ -42,6 +45,7 @@ class RxGdbSimMachine(Test):
>           # FIXME limit baudrate on chardev, else we type too fast
>           #exec_command_and_wait_for_pattern(self, 'version', gcc_version)
>   
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>       def test_linux_sash(self):
>           """
>           Boots a Linux kernel and checks that the console is operational.
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
> index 62d2db8c64..b79fc8daf8 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -126,6 +126,7 @@ class ReplayKernel(LinuxKernelTest):
>   
>           self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
>   
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>       def test_arm_cubieboard_initrd(self):
>           """
>           :avocado: tags=arch:arm


