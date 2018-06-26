Received: from eggs.gnu.org ([2001:4830:134:3::10]:37743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXk9H-0003TF-RW
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXk9E-0000ps-9s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:20:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fXk9E-0000pk-36
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:20:28 -0400
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
	<1529897961-134132-2-git-send-email-robert.hu@linux.intel.com>
	<03c394d5-6099-2f59-2dbf-c92b54281e91@redhat.com>
	<1530003511.22880.5.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3ffd8fc-e352-5719-0b46-c25697c4be02@redhat.com>
Date: Tue, 26 Jun 2018 11:20:23 +0200
MIME-Version: 1.0
In-Reply-To: <1530003511.22880.5.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com

On 26/06/2018 10:58, Robert Hoo wrote:
>> This is not needed, because pred_cmd is write only and arch_capabilities
>> is read only.  The guest cannot modify any of them.
>>
> Thanks Paolo. Yes, indeed unnecessary.
> I looked into the
> 336996-Speculative-Execution-Side-Channel-Mitigations.pdf again, looks
> like the vmstate_spec_ctrl is similar to pred_cmd, wirte only. Shall I
> remove it as well in v2 patch?

No, spec_ctrl is read-write.

Paolo
