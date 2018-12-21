Received: from eggs.gnu.org ([2001:4830:134:3::10]:35353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaMLP-0001QM-Hy
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaMLM-0005Fc-D9
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:04:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gaMLM-0005F6-4p
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:04:04 -0500
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
	<1545265096.44118.3.camel@linux.intel.com>
	<e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
	<1545310252.44118.5.camel@linux.intel.com>
	<5ee7dd18-e70c-e654-25ee-e700a8174ee9@redhat.com>
	<1545401072.44118.7.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd0addb6-9d5f-b4dc-8cd9-f2d096ccd16c@redhat.com>
Date: Fri, 21 Dec 2018 16:03:55 +0100
MIME-Version: 1.0
In-Reply-To: <1545401072.44118.7.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Robert Hoo <robert.hu@linux.intel.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, kai.huang@intel.com, luwei.kang@intel.com
Cc: robert.hu@intel.com, thomas.lendacky@amd.com, ehabkost@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On 21/12/18 15:04, Robert Hoo wrote:
>> So this series is correct and I will follow up with one for INTEL_PT;
>> however, this begs the question of how the patches are being tested.
>
> My apologies for carelessness.

No problem.  In the future please check that "-cpu Icelake-Client"
doesn't have warnings such as

qemu-system-x86_64: warning: host doesn't support requested feature:
CPUID.07H:EBX.intel-pt [bit 25]

when run on an Icelake-Client host.

> I've seen you patch for INTEL_PT. So am I going to resend these 2
> patches and Cc qemu-stable? or simply reply these 2 patches adding
> qemu-stable in Cc list?

I can take care of that, thanks.

Paolo
