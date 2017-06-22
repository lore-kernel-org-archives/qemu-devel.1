Received: from eggs.gnu.org ([2001:4830:134:3::10]:51723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNvW9-0001Pz-Uz
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNvW6-00063G-RR
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:23:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNvW6-00061M-Lo
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:22:58 -0400
Date: Thu, 22 Jun 2017 02:22:55 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1082632418.11149315.1498112575500.JavaMail.zimbra@redhat.com>
In-Reply-To: <2c901b45-afb8-d807-19e9-14befbfdc3fd@redhat.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-2-git-send-email-yang.zhong@intel.com>
	<2c901b45-afb8-d807-19e9-14befbfdc3fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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


> On 21.06.2017 12:19, Yang Zhong wrote:
> > Add the disable-tcg option into configure and echo CONFIG_TCG=y into
> > $config_target_mak. The default tcg is enabled for all build. If tcg
> > is disabled in the build, only i386|x86_64 softmmu option can be disabled,
> > other softmmu of tagets and users build defaultly enabled the tcg.
> Why do you want to limit this disablement to x86 only? There are also
> other architectures that support KVM (ARM, PPC, MIPS), so disabling TCG
> might be possible there, too. So I think it might be better to check
> whether KVM is possible instead.

You need to be careful and not use any helper from e.g. KVM or migration
code.  So I would be very surprised if any other architecture compiles
with --disable-tcg.

Paolo
