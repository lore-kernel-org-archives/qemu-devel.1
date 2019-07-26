Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C607EC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FDC229F3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 11:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FDC229F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqyj0-0004PP-Q2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 07:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hqyio-0003uQ-Vb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hqyim-0003Zx-Bl
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:49:13 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:45047)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hqyil-0003OX-Vb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 07:49:12 -0400
Received: from player728.ha.ovh.net (unknown [10.109.143.79])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 0440A13B977
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 13:49:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 1ACB8842C53A;
 Fri, 26 Jul 2019 11:49:02 +0000 (UTC)
Date: Fri, 26 Jul 2019 13:49:00 +0200
From: Greg Kurz <groug@kaod.org>
To: sathnaga@linux.vnet.ibm.com
Message-ID: <20190726134900.17445369@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190726071809.32389-1-sathnaga@linux.vnet.ibm.com>
References: <20190726071809.32389-1-sathnaga@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16767464366474893781
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.78.111
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2]
 tests.acceptance.avocado_qemu: Add support for powerpc
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 12:48:09 +0530
sathnaga@linux.vnet.ibm.com wrote:

> From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> 
> Current acceptance test will not run in powerpc Little endian
> environment due the arch name does not match the qemu binary path,
> let's handle it.
> 

They do not match because "arch" as returned by uname() is
something different from the "target" in QEMU. This usually
matches, except with bi-endian architectures like ppc64.
Uname "arch" may be ppc64 or ppc64le but "target" is always
ppc64.

> Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index aee5d820ed..a05f0bb530 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -19,6 +19,7 @@ sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>  
>  from qemu.machine import QEMUMachine
>  
> +

empty line damage

>  def is_readable_executable_file(path):
>      return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>  
> @@ -39,6 +40,9 @@ def pick_default_qemu_bin(arch=None):
>      """
>      if arch is None:
>          arch = os.uname()[4]
> +    # qemu binary path does not match arch for powerpc, handle it
> +    if 'ppc64le' in arch:
> +        arch = 'ppc64'

We also have other bi-endian targets (arm and aarch64). I'm not
sure teaching pick_default_qemu_bin() about all of them is the
way to go.

What about passing the right target in the first place ?

ie, this in patch 2:

+    def test_ppc64le_pseries(self):
+        """
+        :avocado: tags=arch:ppc64

>      qemu_bin_relative_path = os.path.join("%s-softmmu" % arch,
>                                            "qemu-system-%s" % arch)
>      if is_readable_executable_file(qemu_bin_relative_path):


