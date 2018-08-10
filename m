Received: from eggs.gnu.org ([2001:4830:134:3::10]:53492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fo7CA-0008WV-To
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fo7C6-0003eT-SO
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:11:10 -0400
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <10c38e2f-53b6-ab7b-bab8-1b0baf6baecf@redhat.com>
Date: Fri, 10 Aug 2018 15:11:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Some improvements in z/Arch
 instructions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org

On 10.08.2018 05:01, Pavel Zbitskiy wrote:
> Found while attempting to run an old tool in qemu.
> 
> * BAL and BALR:    Added.
> * CSST:            Qemu crashed after an accidental jump to garbage.
> * IPM:             A tool produced an incorrect output.
> * EX TRT/TRTR:     A tool ran quite slow.
> * PACK:            A tool produced an incorrect output.
> * CVB, CVBY, CVBG: Added.
> 
> Changes since v1:
> * Tests.
> * Call pc_to_link_info() instead of op_bas().
> * Clarified CSST commit message.
> * Rewrote IPM using extract/deposit.
> * Clarified PACK commit message.
> * Do not use LowCore for CONFIG_USER_ONLY.
> * Reduce duplication in CVB code.

Thanks for looking into this and also for providing test cases!

-- 

Thanks,

David / dhildenb
