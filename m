Received: from eggs.gnu.org ([2001:4830:134:3::10]:34310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKEs-0002IB-CT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSKEr-0008EN-KS
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSKEr-0008Dy-Ec
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:35:21 -0400
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-15-git-send-email-pbonzini@redhat.com>
	<96ae487f-40a9-f5b3-888f-955395a0210a@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <690c4ab1-ac86-4717-2728-ad9b906e45a3@redhat.com>
Date: Tue, 4 Jul 2017 11:35:17 +0200
MIME-Version: 1.0
In-Reply-To: <96ae487f-40a9-f5b3-888f-955395a0210a@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/22] tcg: add CONFIG_TCG guards in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com



On 03/07/2017 22:10, Richard Henderson wrote:
> On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
>> --- a/include/exec/helper-proto.h
>> +++ b/include/exec/helper-proto.h
>> @@ -28,7 +28,9 @@ dh_ctype(ret) HELPER(name) (dh_ctype(t1),
>> dh_ctype(t2), dh_ctype(t3), \
>>     #include "helper.h"
>>   #include "trace/generated-helpers.h"
>> +#ifdef CONFIG_TCG
>>   #include "tcg-runtime.h"
>> +#endif
> 
> Do we really want to define any of the helpers if !CONFIG_TCG?
> Perhaps it's the user of this header that needs adjustment.

Indeed, this hunk is not needed anymore after my other cleanups.

Paolo
