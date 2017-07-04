Received: from eggs.gnu.org ([2001:4830:134:3::10]:59806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSScH-00061R-8I
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSScE-00075j-2n
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:32:05 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:33043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSScD-000756-Sv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:32:02 -0400
Received: by mail-pf0-x230.google.com with SMTP id e7so118480078pfk.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 11:32:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
	<1499166735-39360-19-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fc000b4c-0d5a-298e-0d00-a480cbf37587@twiddle.net>
Date: Tue, 4 Jul 2017 08:31:53 -1000
MIME-Version: 1.0
In-Reply-To: <1499166735-39360-19-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/22] target/i386: split cpu_set_mxcsr()
 and make cpu_set_fpuc() inline
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
> Split the cpu_set_mxcsr() and make cpu_set_fpuc() inline with specific
> tcg code.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
> 	v2: renamed tcg_update_mxcsr [Richard],
> 	added missing call to cpu_post_load

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
