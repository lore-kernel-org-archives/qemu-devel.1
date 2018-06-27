Received: from eggs.gnu.org ([2001:4830:134:3::10]:36454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYAsT-0004WE-QC
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYAsP-00071J-Ut
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:52:57 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:35694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYAsP-00070I-Gn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:52:53 -0400
Received: by mail-pl0-x244.google.com with SMTP id k1-v6so1079606plt.2
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 06:52:53 -0700 (PDT)
References: <20180626161921.27941-1-richard.henderson@linaro.org>
	<20180626161921.27941-2-richard.henderson@linaro.org>
	<20180627090917.GI14434@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75d315ee-dd6e-e68d-68c1-ed30508dabab@linaro.org>
Date: Wed, 27 Jun 2018 06:52:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180627090917.GI14434@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/13] target/ppc: Add do_unaligned_access
 hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/27/2018 02:09 AM, David Gibson wrote:
> On Tue, Jun 26, 2018 at 09:19:09AM -0700, Richard Henderson wrote:
>> This allows faults from MO_ALIGN to have the same effect
>> as from gen_check_align.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> So, most powerpc cpus can handle most unaligned accesses without an
> exception.  I'm assuming this series won't preclude that?

Correct.  This hook will only fire when using MO_ALIGN to
request an alignment check.


r~
