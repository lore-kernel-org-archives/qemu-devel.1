Received: from eggs.gnu.org ([2001:4830:134:3::10]:57371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUXju-0001Ks-4p
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUXjp-0007Tu-8L
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:24:34 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUXjp-0007TX-1Q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:24:29 -0400
Received: by mail-wr0-f180.google.com with SMTP id 77so136505865wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 05:24:28 -0700 (PDT)
References: <20170628050003.1809-1-bobby.prani@gmail.com>
	<20170628050003.1809-3-bobby.prani@gmail.com>
	<87van0a9t6.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1363d99f-efc5-027b-95cb-2405db45bc8a@redhat.com>
Date: Mon, 10 Jul 2017 14:24:26 +0200
MIME-Version: 1.0
In-Reply-To: <87van0a9t6.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] [TEST] Collect TLB and victim TLB
 hit/miss stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net

On 10/07/2017 12:03, Alex Bennée wrote:
>> +extern bool enable_instrumentation;
>> +
> Is there a better place for this than a static global? I was pondering
> tcg_ctx but that's not really visible to the runtime. Making it part of
> the TB flags might be useful for only instrumenting certain segments of
> the code but I suspect I'm bike-shedding at this point.

Why not use tracepoints?  This seems to be a natural candidate for
systemtap-like tracing scripts.

Paolo
