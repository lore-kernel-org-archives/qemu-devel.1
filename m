Received: from eggs.gnu.org ([2001:4830:134:3::10]:51043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dRziS-0004D5-Hm
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dRziQ-0004RC-Gp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:40:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dRziQ-0004Q0-AT
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:40:30 -0400
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-2-git-send-email-yang.zhong@intel.com>
	<20170703102043.GE5663@redhat.com>
	<68cbc479-3707-cdab-4dcd-d055b02ede7d@redhat.com>
	<20170703103340.GF5663@redhat.com>
	<650bf1e9-ba8c-c7a5-9e48-94dc970523d6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c1b1bc60-fcd1-1054-e150-2358bfb6154e@redhat.com>
Date: Mon, 3 Jul 2017 13:40:25 +0200
MIME-Version: 1.0
In-Reply-To: <650bf1e9-ba8c-c7a5-9e48-94dc970523d6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/15] configure: add the disable-tcg
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, rth@twiddle.net, anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On 03.07.2017 12:55, Paolo Bonzini wrote:
> 
> 
> On 03/07/2017 12:33, Daniel P. Berrange wrote:
>>> i386-softmmu and x86_64-softmmu are singled out here, because they're
>>> the only targets where --disable-tcg compiles.  For the others, more
>>> work is needed (see patches 6-15 in Yang Zhong's series).
>>
>> Even with that, you still can't disable TCG if building on a non-x86
>> host, since that'd leave you with no available CPU at all. So the
>> code still needs refactoring to check architectures properly.
> 
> It would leave you with a tools-only build; whether that's a good idea,
> it's another story.  I think it's acceptable, but others may disagree.

I think this is OK for the first version. We still can refine the checks
later if we then think that there is a need for it.

 Thomas
