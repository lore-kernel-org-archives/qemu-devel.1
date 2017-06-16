Received: from eggs.gnu.org ([2001:4830:134:3::10]:47909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLtay-0008JG-8A
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLtax-0003QL-89
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:55:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLtax-0003Oe-2V
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:55:35 -0400
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
	<b2343916-49d4-5c18-8b2f-f3538839b46e@redhat.com>
	<76504ef2-8dd0-ecbc-6e25-55be6abcb14a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d873cf2-11cd-1a2c-30e9-07d506685d37@redhat.com>
Date: Fri, 16 Jun 2017 17:55:30 +0200
MIME-Version: 1.0
In-Reply-To: <76504ef2-8dd0-ecbc-6e25-55be6abcb14a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Poison some more target-specific
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 16/06/2017 17:21, Thomas Huth wrote:
>> Why do you say they can't be moved?  They can, and your series should
>> change nothing about it, thanks to what you're doing now with
>> CONFIG_KVM_IS_POSSIBLE (which was also done before with NEED_CPU_H).
> numa.c and balloon.c both use ram_addr_t (numa.c uses it directly, and
> balloon.c indirectly via the QEMUBalloonEvent typedef from the header).
> And ram_addr_t is currently target-specific - it depends on
> CONFIG_XEN_BACKEND. So this could break in certain subtle cases, e.g.
> when compiling on a 32-bit host with XEN enabled.

Can ram_addr_t be poisoned on target-independent files?

Paolo
