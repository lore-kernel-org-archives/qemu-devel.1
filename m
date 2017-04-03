Received: from eggs.gnu.org ([2001:4830:134:3::10]:50112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv5Od-0004xZ-T4
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv5Ob-0004j9-2P
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:04:03 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cv5Oa-0004iJ-TO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:04:01 -0400
Received: by mail-wr0-x235.google.com with SMTP id l43so179922106wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 10:04:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6b326dd-fbc6-250d-26a2-4483db009b7d@redhat.com>
Date: Mon, 3 Apr 2017 19:03:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170403124524.10824-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/9] MTTCG and record/replay fixes
 for rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, dovgaluk@ispras.ru, rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com



On 03/04/2017 14:45, Alex Bennée wrote:
>   cpus: check cpu->running in cpu_get_icount_raw()
> 
>   I'm not sure the race happens and once outside of cpu->running the
>   icount counters should be zero. However it seems a sensible
>   precaution.

Yeah, I think this is unnecessary with patch 7's new assertions.

> I think the cpus: patches should probably go into the next
> pull-request while we see if we can come up with a better final
> solution for fixing record/replay. However given how long this
> regression has run during the release candidate process I wanted to
> update everyone on the current status and get feedback ASAP.

I agree.  I'm not sure exactly how the final race happens, but if it
causes divergence it would be caught later by the record/replay
mechanism, I think.

Paolo
