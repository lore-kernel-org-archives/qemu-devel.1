Received: from eggs.gnu.org ([2001:4830:134:3::10]:36237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fb1y3-0008KH-Ac
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fb1y0-0001zC-8Q
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:58:31 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fb1y0-0001sH-20
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:58:28 -0400
Received: by mail-wm0-x244.google.com with SMTP id s14-v6so10144012wmc.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 03:58:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1530709942-87947-1-git-send-email-jingqi.liu@intel.com>
	<cfe2a879-d038-f80f-cbec-ae247afde702@redhat.com>
	<20180704175234.GX7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ae5043f-78ec-bc54-8b13-119111e62101@redhat.com>
Date: Thu, 5 Jul 2018 12:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180704175234.GX7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: x86: Add support for -machine
 split-lock-ac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Jingqi Liu <jingqi.liu@intel.com>, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, wei.w.wang@intel.com, "Hu, Robert" <robert.hu@intel.com>

On 04/07/2018 19:52, Eduardo Habkost wrote:
>> (Robert, does IceLake have this feature?  If so, we cannot create the
>> CPU model until everything is in place).
> I don't think we need to block the CPU model because QEMU+KVM
> doesn't support some features yet, as long as kernel versions
> capable of running the 3.0 version of IceLake-Server will be also
> capable of running the 3.1 version of IceLake-Server.
> 
> Now, if that condition won't be true and we have some IceLake
> features that will added only to more recent kernels, it might be
> a good idea to hold the inclusion of the CPU model until
> everything is in place.
> 
> 

Yeah, the reason for that is to wait for the kernel side of the
implementation.

Paolo
