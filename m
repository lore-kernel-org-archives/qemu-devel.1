Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD58C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 22:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2252070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 22:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2252070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heRjf-0007BP-Nt
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 18:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1heRhN-0005qn-PD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1heRhM-0007RU-EE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1heRhM-0007Ni-5S
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:07:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5C28C05D3E4;
 Fri, 21 Jun 2019 22:07:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-204.rdu2.redhat.com
 [10.10.120.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03E4A5D9E5;
 Fri, 21 Jun 2019 22:07:50 +0000 (UTC)
Date: Fri, 21 Jun 2019 18:07:48 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <20190621220748.GA1044@localhost.localdomain>
References: <20190621153806.13489-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621153806.13489-1-wainersm@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 21 Jun 2019 22:07:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] tests/acceptance: Handle machine type
 for ARM target
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 11:38:06AM -0400, Wainer dos Santos Moschetta wrote:
> Hi all,
> 
> I'm still unsure this is the best solution. I tend to think that
> any arch-independent test case (i.e. not tagged 'arch') should
> be skipped on all arches except for x86_64. Opening up for
> discussion though.
>

I'm confused... if you're calling a test case "arch-independent", why
should it be skipped on all but one arch?  Anyway, I don't think we
should define such a broad policy... This line of thought is very
x86_64 centric, and quite honestly, doesn't map to QEMU's goals.

I agree that we're being a bit "disonest" by not assuring that tests
we send will work on all targets... but at least we're having that
discussion.  The next step would be to start triaging and discussing
wether it's worth running those against other targets, considering
the cost and benefits.

> Note: It was decided that ARM targets should not default to any
> machine type: https://www.mail-archive.com/qemu-devel@nongnu.org/msg625999.html
> 
> -- 8< --
> Some tests are meant arch-independent and as such they don't set
> the machine type (i.e. relying to defaults) on launched VMs. The arm
> targets, however, don't provide any default machine so tests fail.
> 
> This patch adds a logic on the base Test class so that machine type
> is set to 'virt' when:
>    a) The test case doesn't have arch:aarch64 or arch:arm tag. Here
>       I assume that if the test was tagged for a specific arch then
>       the writer took care of setting a machine type.
>    b) The target binary arch is any of aarch64 or arm. Note:
>       self.target_arch can end up None if qemu_bin is passed by
>       Avocado parameter and the filename doesn't match expected
>       format. In this case the test will fail.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 2b236a1cf0..fb3e0dc2bc 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -9,6 +9,7 @@
>  # later.  See the COPYING file in the top-level directory.
>  
>  import os
> +import re
>  import sys
>  import uuid
>  
> @@ -65,10 +66,21 @@ class Test(avocado.Test):
>          if self.qemu_bin is None:
>              self.cancel("No QEMU binary defined or found in the source tree")
>  
> +        m = re.match('qemu-system-(.*)', self.qemu_bin.split('/').pop())
> +        if m:
> +            self.target_arch = m.group(1)
> +        else:
> +            self.target_arch = None
> +

The "arch" tag and parameter are actually related to the target that
should be used.  I don't see the need for a "target_arch" based on
that.

>      def _new_vm(self, *args):
>          vm = QEMUMachine(self.qemu_bin)
>          if args:
>              vm.add_args(*args)
> +        # Handle lack of default machine type on some targets.
> +        # Assume that arch tagged tests have machine type set properly.
> +        if self.tags.get('arch') is None and \
> +           self.target_arch in ('aarch64', 'arm'):
> +            vm.set_machine('virt')

This (considering it deals with "arch" instead of "target_arch") is
one of the very important points to be determined.  How much wrapping
around different QEMU behavior on different targets/machines/devices
should we do?  This will possibly be case-by-case discussions with
different outcomes, but hopefully we can come up with a general
direction.

Thanks,
- Cleber.

>          return vm
>  
>      @property
> -- 
> 2.18.1
> 

