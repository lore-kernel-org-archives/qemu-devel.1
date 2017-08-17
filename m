Received: from eggs.gnu.org ([2001:4830:134:3::10]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diNw2-0007vD-8C
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1diNvy-0006Cm-VJ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:46:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1diNvy-0006Am-Ox
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:46:14 -0400
References: <20170815170051.127257-1-brijesh.singh@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <276d5c64-7ef3-127b-b2f4-e5f7b3a5aab4@redhat.com>
Date: Thu, 17 Aug 2017 18:45:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170815170051.127257-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] target-i386/cpu: Add new EPYC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>

On 15/08/2017 19:00, Brijesh Singh wrote:
> 
> The following features bits have been added/removed compare to Opteron_G5
> 
> Added: monitor, movbe, rdrand, mmxext, ffxsr, rdtscp, cr8legacy, osvw,
>        fsgsbase, bmi1, avx2, smep, bmi2, rdseed, adx, smap, clfshopt, sha
>        xsaveopt, xsavec, xgetbv1, arat
> 
> Removed: xop, fma4, tbm

Interesting, why were these removed?

Do we want to add "topoext" support too?  What about mwaitx?

Thanks,

Paolo
