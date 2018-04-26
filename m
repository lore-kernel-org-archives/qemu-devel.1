Received: from eggs.gnu.org ([2001:4830:134:3::10]:52127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBdEy-0005Wp-27
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBdEv-0003Um-Fd
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:31:00 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:46148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBdEv-0003UQ-8r
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:30:57 -0400
Received: by mail-wr0-x236.google.com with SMTP id d1-v6so56005100wrj.13
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 02:30:57 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-44-alex.bennee@linaro.org>
	<84e43559-54ee-315b-24c9-c7e62e5a6d64@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <84e43559-54ee-315b-24c9-c7e62e5a6d64@linaro.org>
Date: Thu, 26 Apr 2018 10:30:54 +0100
Message-ID: <87604el3g1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 43/46] tests/tcg/Makefile: update to be
 called from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/24/2018 05:24 AM, Alex Benn=C3=A9e wrote:
>> +run-%: %
>> +	$(call quiet-command, $(QEMU) $< > $<.out, "TEST", "$< on $(TARGET_NAM=
E)")
>
> I've just had an x86_64 guest test run for 70 minutes.  We need to limit =
the
> amount of time spent here in some way, with excessive time reported as te=
st
> failure.
>
> One potential way would be to add "ulimit -t $TIMEOUT" to the subshell be=
fore
> running qemu.  A default TIMEOUT might be e.g. 15 seconds.  I'm not sure =
what
> we should expect for the largest test on the smallest hosts...

Sounds reasonable - test-i386-fprem is probably the longest - I'm not
sure it needs to be so exhaustive.

>
>
> r~


--
Alex Benn=C3=A9e
