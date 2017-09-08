Received: from eggs.gnu.org ([2001:4830:134:3::10]:57995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqLmR-0005Gz-0h
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dqLmN-0001g5-QO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:05:19 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:33335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dqLmN-0001fd-JP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:05:15 -0400
Received: by mail-pf0-x235.google.com with SMTP id y29so4418036pff.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 09:05:15 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<87zia5gv12.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <629373b7-ab89-638b-d566-0b35fcd5bb58@linaro.org>
Date: Fri, 8 Sep 2017 09:05:11 -0700
MIME-Version: 1.0
In-Reply-To: <87zia5gv12.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] TCG vectorization and example
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 09/08/2017 06:49 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> When Alex and I started talking about this topic, this is the direction
>> I was thinking.  The primary difference from Alex's version is that the
>> interface on the target/cpu/ side uses offsets and not a faux temp.  The
>> secondary difference is that, for smaller vector sizes at least, I will
>> expand to inline host vector operations.  The use of explicit offsets
>> aids that.
> <snip>
> 
> OK I think this is a lot more complete than my pass. I'm done with my
> review for now, I look forward to the next version. It looks like most
> of the pre-requisites are merged now?

Yep, all lead-up patches are now in.  Thanks for the review.

As I work on the next version, I'll do aarch64 host as well for comparison.


r~
