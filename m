Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F47C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D96520874
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezJm0Mhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D96520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvvZ-0003P0-UU
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqvtx-0001kG-W7
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:53:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37211
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqvtw-0006xY-2K
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593683583;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fOS70vTE/5jJLbFydnuPVEQjKO2smlw2qJiaGQgRvfM=;
 b=ezJm0MhwR/CsaN3LVJIl7nQWP6W+hXOBHgmVZ3jBtcBrtjgiqQvukg223BT8Z7gr+RQp/w
 pRRg5Jd6Uba0WN2ngepoKj+M22t9hbvzrXBs2dg8TUQToQ5L6tN7b9owofoyBETE4mTIek
 bbMLKFnX/Va9kEwZTEj6FjY0Z5wAGnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Ui7I75oyNtqGMpRNmhL4cg-1; Thu, 02 Jul 2020 05:52:57 -0400
X-MC-Unique: Ui7I75oyNtqGMpRNmhL4cg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B1931005513;
 Thu,  2 Jul 2020 09:52:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 733EB7788D;
 Thu,  2 Jul 2020 09:52:55 +0000 (UTC)
Date: Thu, 2 Jul 2020 10:52:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] configure: add support for Control-Flow Integrity
Message-ID: <20200702095252.GF1888119@redhat.com>
References: <20200702054948.10257-1-dbuono@linux.vnet.ibm.com>
 <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200702054948.10257-3-dbuono@linux.vnet.ibm.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 01:49:48AM -0400, Daniele Buono wrote:
> This patch adds a flag to enable/disable control flow integrity checks
> on indirect function calls. This feature is only provided by LLVM/Clang
> v3.9 or higher, and only allows indirect function calls to functions
> with compatible signatures.
> 
> We also add an option to enable a debugging version of cfi, with verbose
> output in case of a CFI violation.
> 
> CFI on indirect function calls does not support calls to functions in
> shared libraries (since they were not known at compile time), and such
> calls are forbidden. QEMU relies on dlopen/dlsym when using modules,
> so we make modules incompatible with CFI.
> 
> We introduce a blacklist file, to disable CFI checks in a limited number
> of TCG functions.
> 
> The feature relies on link-time optimization (lto), which requires the
> use of the gold linker, and the LLVM versions of ar, ranlib and nm.
> This patch take care of checking that all the compiler toolchain
> dependencies are met.
> 
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  cfi-blacklist.txt |  27 +++++++
>  configure         | 177 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 cfi-blacklist.txt
> 
> diff --git a/cfi-blacklist.txt b/cfi-blacklist.txt
> new file mode 100644
> index 0000000000..bf804431a5
> --- /dev/null
> +++ b/cfi-blacklist.txt
> @@ -0,0 +1,27 @@
> +# List of functions that should not be compiled with Control-Flow Integrity
> +
> +[cfi-icall]
> +# TCG creates binary blobs at runtime, with the transformed code.
> +# When it's time to execute it, the code is called with an indirect function
> +# call. Since such function did not exist at compile time, the runtime has no
> +# way to verify its signature. Disable CFI checks in the function that calls
> +# the binary blob
> +fun:cpu_tb_exec
> +
> +# TCI (Tiny Compiler Interpreter) is an interpreter for TCG pseudo code.
> +# One possible operation in the pseudo code is a call to binary code.
> +# Therefore, disable CFI checks in the interpreter function
> +fun:tcg_qemu_tb_exec
> +
> +# TCG Plugins Callback Functions. The mechanism rely on opening external
> +# shared libraries at runtime and get pointers to functions in such libraries
> +# Since these pointers are external to the QEMU binary, the runtime cannot
> +# verify their signature. Disable CFI Checks in all the functions that use
> +# such pointers.
> +fun:plugin_vcpu_cb__simple
> +fun:plugin_cb__simple
> +fun:plugin_cb__udata
> +fun:qemu_plugin_tb_trans_cb
> +fun:qemu_plugin_vcpu_syscall
> +fun:qemu_plugin_vcpu_syscall_ret
> +fun:plugin_load

The need to maintain this list of functions makes me feel very
uneasy.

How can we have any confidence that this list of functions is
accurate ? How will maintainers ensure that they correctly update
it as they are writing/changing code, and how will they test the
result ?

It feels like it has the same general maint problem as the original
seccomp code we used, where we were never confident we had added
the right exceptions to let QEMU run without crashing when users
tickled some feature we forgot about.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


