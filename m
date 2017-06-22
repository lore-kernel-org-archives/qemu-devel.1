Received: from eggs.gnu.org ([2001:4830:134:3::10]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNtbk-0001Mw-TX
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 00:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNtbh-00059A-8p
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 00:20:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNtbh-00058F-3a
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 00:20:37 -0400
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-2-git-send-email-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2c901b45-afb8-d807-19e9-14befbfdc3fd@redhat.com>
Date: Thu, 22 Jun 2017 06:20:30 +0200
MIME-Version: 1.0
In-Reply-To: <1498040401-16361-2-git-send-email-yang.zhong@intel.com>
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
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On 21.06.2017 12:19, Yang Zhong wrote:
> Add the disable-tcg option into configure and echo CONFIG_TCG=y into
> $config_target_mak. The default tcg is enabled for all build. If tcg
> is disabled in the build, only i386|x86_64 softmmu option can be disabled,
> other softmmu of tagets and users build defaultly enabled the tcg.
Why do you want to limit this disablement to x86 only? There are also
other architectures that support KVM (ARM, PPC, MIPS), so disabling TCG
might be possible there, too. So I think it might be better to check
whether KVM is possible instead.

 Thomas
