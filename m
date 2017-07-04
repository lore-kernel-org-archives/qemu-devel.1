Received: from eggs.gnu.org ([2001:4830:134:3::10]:34827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSLhE-0005ee-2R
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSLhA-0008MG-S1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:08:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSLhA-0008LG-Lz
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:08:40 -0400
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-3-git-send-email-pbonzini@redhat.com>
	<20170704083224.GB3135@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf8d39a6-a35a-7d0c-849f-29858739a9cb@redhat.com>
Date: Tue, 4 Jul 2017 13:08:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170704083224.GB3135@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/22] configure: early test for supported
 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com



On 04/07/2017 10:32, Daniel P. Berrange wrote:
>>  if test -z "${target_list+xxx}" ; then
>> -    target_list="$default_target_list"
>> +    for target in $default_target_list; do
>> +        supported_target $target 2>/dev/null && \
>> +            target_list="$target_list $target"
>> +    done
> 
> I'm not sure what the benefit of this change is ?  It is calling
> supported_target but throwing away anything it prints. So if there
> was a mistake in the default target list setup, we'd never see it,
> just silently discard it.

As of this patch there is no benefit, but it is what makes patch 3 drop
non-hardware-accelerated targets for --disable-tcg.

Paolo
