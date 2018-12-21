Received: from eggs.gnu.org ([2001:4830:134:3::10]:44582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaEHe-0004zc-Sl
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaEHa-0006Uo-VG
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:27:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gaEHa-0006Ti-Ok
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:27:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so4022633wrr.0
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 22:27:38 -0800 (PST)
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
	<1545265096.44118.3.camel@linux.intel.com>
	<e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
	<1545310252.44118.5.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ee7dd18-e70c-e654-25ee-e700a8174ee9@redhat.com>
Date: Fri, 21 Dec 2018 07:27:36 +0100
MIME-Version: 1.0
In-Reply-To: <1545310252.44118.5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: remove the new CPUID 'PCONFIG'
 from Icelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: thomas.lendacky@amd.com, ehabkost@redhat.com, qemu-devel@nongnu.org, robert.hu@intel.com, rth@twiddle.net

On 20/12/18 13:50, Robert Hoo wrote:
> On Thu, 2018-12-20 at 13:38 +0100, Paolo Bonzini wrote:
>> On 20/12/18 01:18, Robert Hoo wrote:
>>> I think the sooner, the better. Take the time window that Icelake
>>> CPU
>>> model has just shipped with QEMU 3.1.0 and is not publicly/widely
>>> used
>>> yet.
>>
>> We should still leave it in the 3.1 machine types.  I've just sent a
>> patch to do the same with MPX.
>>
> I took a look your patch of "Disable MPX support on named CPU models".
> Seems you do the same as I do to PCONFIG. So you agree with my above
> patch?:-)
> 
> I won't object that keep it in 3.1 machine type as you do to MPX.

Sorry Robert, I changed my mind.  If no hypervisor exists that enables
PCONFIG for guests (using the PCONFIG_ENABLE processor control),
effectively no one can ever have used it.  We should disable it in all
machine types and Cc qemu-stable.

In fact, the same is true for INTEL_PT, which is not supported by any
released kernel version and, even is going to be available only with a
module parameter when it will be.

This is not the same as MPX, which did work even though nobody was
probably using it.

So this series is correct and I will follow up with one for INTEL_PT;
however, this begs the question of how the patches are being tested.

Paolo
