Received: from eggs.gnu.org ([2001:4830:134:3::10]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSSde-0006jM-Jq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSSdd-0007xD-Tn
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:33:30 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:33174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSSdd-0007wj-Np
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:33:29 -0400
Received: by mail-pf0-x22b.google.com with SMTP id e7so118490650pfk.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 11:33:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
	<1499166735-39360-21-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <80ec410f-3a30-5095-f7dd-48bc60510314@twiddle.net>
Date: Tue, 4 Jul 2017 08:33:23 -1000
MIME-Version: 1.0
In-Reply-To: <1499166735-39360-21-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/22] target/i386: add the tcg_enabled()
 in target/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/04/2017 01:12 AM, Paolo Bonzini wrote:
> From: Yang Zhong<yang.zhong@intel.com>
> 
> Add the tcg_enabled() where the x86 target needs to disable
> TCG-specific code.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
> 	v2: do not touch bpt_helper.c, adjust caller in machine.c [Richard]

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
