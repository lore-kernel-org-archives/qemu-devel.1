Received: from eggs.gnu.org ([2001:4830:134:3::10]:41261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbN5c-0000oU-Vj
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbN5Z-0004jY-RB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:31:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fbN5Z-0004gG-Ld
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:31:41 -0400
References: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
	<20180704194327.GJ914@localhost.localdomain>
	<20180706084313.GB28022@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6bac7b6-58b5-6cad-d4c8-01a104465e29@redhat.com>
Date: Fri, 6 Jul 2018 11:31:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180706084313.GB28022@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: Add support to get/set/migrate MSR
 (33H)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Jingqi Liu <jingqi.liu@intel.com>, wei.w.wang@intel.com, mtosatti@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net

On 06/07/2018 10:43, Daniel P. Berrang=C3=A9 wrote:
>> Based on the Linux patch at [1], guests may try to detect the
>> feature by writing to the MSR unconditionally.
>>
>> If this happens, KVM needs to provide a mechanism to
>> enable/disable the MSR emulation.  Otherwise users will end up
>> with VMs that can't be migrated to older hosts even if they are
>> using older machine-types.
> Is there really no CPUID flag that can be used to detect the feature ?
> Unconditionally probing for existance of arbitrary MSRs seems to be
> just re-inventing CPUID feature detection, but worse because as you
> say we need to now invent a way to control existance of individual
> MSRs too :-(

Now that I know that no silicon exists for this feature, the solution is
simple.  The feature will be rejected until a CPUID bit exists.

Paolo
