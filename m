Received: from eggs.gnu.org ([2001:4830:134:3::10]:43587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBRvY-0000ho-H1
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 17:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBRvV-0006w2-Da
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 17:26:12 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:36712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBRvV-0006vd-6Q
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 17:26:09 -0400
Received: by mail-pf0-x22c.google.com with SMTP id g14so16309780pfh.3
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 14:26:09 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-44-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84e43559-54ee-315b-24c9-c7e62e5a6d64@linaro.org>
Date: Wed, 25 Apr 2018 11:26:02 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-44-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 05:24 AM, Alex Bennée wrote:
> +run-%: %
> +	$(call quiet-command, $(QEMU) $< > $<.out, "TEST", "$< on $(TARGET_NAME)")

I've just had an x86_64 guest test run for 70 minutes.  We need to limit the
amount of time spent here in some way, with excessive time reported as test
failure.

One potential way would be to add "ulimit -t $TIMEOUT" to the subshell before
running qemu.  A default TIMEOUT might be e.g. 15 seconds.  I'm not sure what
we should expect for the largest test on the smallest hosts...


r~
