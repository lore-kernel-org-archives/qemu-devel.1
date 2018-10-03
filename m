Received: from eggs.gnu.org ([2001:4830:134:3::10]:57953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7kb2-0003ui-8x
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7kax-0002v7-8w
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:06:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7kax-0002uv-0P
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:05:55 -0400
References: <20181002212921.30982-1-cota@braap.org>
	<20181002212921.30982-3-cota@braap.org> <87h8i3l75j.fsf@linaro.org>
	<a01a9547-d182-daaf-724a-5a836dd9ff02@redhat.com>
	<20181003154844.GA27366@flamenco>
	<91494a20-1090-3e3f-e099-ed06bd6e0e51@redhat.com>
	<20181003170219.GA9925@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d966f99b-4a37-4a00-0267-50adabb3675f@redhat.com>
Date: Wed, 3 Oct 2018 19:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181003170219.GA9925@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 03/10/2018 19:02, Emilio G. Cota wrote:
>> For reads I agree, but you may actually get a torn read if the writer
>> doesn't use atomic_set.
>
> But you cannot get a torn read if all reads that don't hold the lock
> are coming from the same thread that performed the write.

Ah, so you are relying on copy_tlb_helper(_locked) being invoked only
from the vCPU thread (as opposed to someone else doing tlb_flush)?
Maybe it's worth adding a comment if that's what I missed.

Paolo
