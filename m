Received: from eggs.gnu.org ([2001:4830:134:3::10]:58296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNyNj-0000Yx-Qe
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNyNg-00047E-Ng
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNyNg-00046t-H3
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:26:28 -0400
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-2-git-send-email-yang.zhong@intel.com>
	<2c901b45-afb8-d807-19e9-14befbfdc3fd@redhat.com>
	<1082632418.11149315.1498112575500.JavaMail.zimbra@redhat.com>
	<666c9b73-843f-3669-fe1d-69b5082b2757@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8515dc9c-f632-cefa-fdf2-9fcbc8f962de@redhat.com>
Date: Thu, 22 Jun 2017 11:26:20 +0200
MIME-Version: 1.0
In-Reply-To: <666c9b73-843f-3669-fe1d-69b5082b2757@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/15] configure: add the disable-tcg option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, anthony xu <anthony.xu@intel.com>, qemu-devel@nongnu.org, a rigo <a.rigo@virtualopensystems.com>



On 22/06/2017 08:33, Thomas Huth wrote:
> On 22.06.2017 08:22, Paolo Bonzini wrote:
>>
>>> On 21.06.2017 12:19, Yang Zhong wrote:
>>>> Add the disable-tcg option into configure and echo CONFIG_TCG=y into
>>>> $config_target_mak. The default tcg is enabled for all build. If tcg
>>>> is disabled in the build, only i386|x86_64 softmmu option can be disabled,
>>>> other softmmu of tagets and users build defaultly enabled the tcg.
>>> Why do you want to limit this disablement to x86 only? There are also
>>> other architectures that support KVM (ARM, PPC, MIPS), so disabling TCG
>>> might be possible there, too. So I think it might be better to check
>>> whether KVM is possible instead.
>>
>> You need to be careful and not use any helper from e.g. KVM or migration
>> code.  So I would be very surprised if any other architecture compiles
>> with --disable-tcg.
> 
> OK, fair, but we finally might want to get there, so I think we should
> allow the parameter in the configure script for other architectures,
> too, and then fix the bugs once we can try it out.

I think it's the other way round---when someone wants to fix it, they
should add their architecture to the list of targets that support
--disable-tcg.  "./configure <anything>", as a goal, should fail
immediately if make won't succeed; compilation errors are always a worse
experience.

Paolo
