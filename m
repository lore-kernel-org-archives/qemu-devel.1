Received: from eggs.gnu.org ([2001:4830:134:3::10]:51620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9b24-000234-Pq
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9b21-0007gO-0H
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9b1y-0007dv-8b
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:17:27 -0400
References: <20181005180201.11387-1-richard.henderson@linaro.org>
	<CAFEAcA8FiKkkXXOyLYC09krStSS-b8zhADs2S39QT18W1JVq+A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <121fb410-0ff9-706e-e912-8d93cc27346f@redhat.com>
Date: Mon, 8 Oct 2018 14:17:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8FiKkkXXOyLYC09krStSS-b8zhADs2S39QT18W1JVq+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] softfloat queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, jeff@codyprime.org, Stefan Hajnoczi <stefanha@redhat.com>

Adding Jeff and Stefan

On 10/8/18 8:47 AM, Peter Maydell wrote:
> On 5 October 2018 at 19:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> The following changes since commit ae7a4c0a4604bcfed40170db6cca576c44d872a2:
>>
>>    Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181004' into staging (2018-10-05 16:05:06 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/rth7680/qemu.git tags/pull-fpu-20181005
>>
>> for you to fetch changes up to 27ae5109a2ba8b6b679cce3e03e16570a34390a0:
>>
>>    softfloat: Specialize udiv_qrnnd for ppc64 (2018-10-05 12:57:41 -0500)
>>
>> ----------------------------------------------------------------
>> Testing infrastructure for softfpu (not run by default).
>> Drop countLeadingZeros.
>> Fix div_floats.
>> Add udiv_qrnnd specializations for x86_64, s390x, ppc64 hosts.
>>
>> ----------------------------------------------------------------
> 
> Applied, thanks.
> 
> I guess we should mirror the new submodules on git.qemu.org.

Yes, that's been our general practice.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
