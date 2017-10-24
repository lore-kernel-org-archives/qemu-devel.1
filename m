Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e753b-00017v-9I
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e753W-0003Db-9b
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:40:11 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e753W-0003Cz-2C
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 15:40:06 -0400
Received: by mail-wm0-x242.google.com with SMTP id 78so15618501wmb.1
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 12:40:05 -0700 (PDT)
References: <20171022004621.28372-1-richard.henderson@linaro.org>
	<20171022004621.28372-12-richard.henderson@linaro.org>
	<14d023ad-e635-3a56-533b-2575a03266c4@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4880c661-9e6e-e31c-c0cc-810e67d8efea@linaro.org>
Date: Tue, 24 Oct 2017 21:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <14d023ad-e635-3a56-533b-2575a03266c4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 11/11] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 10/24/2017 06:45 PM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 10/21/2017 09:46 PM, Richard Henderson wrote:
>> Do not require the submodule, but use it if present.  Allow the
>> command-line to override system or git submodule either way.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  Makefile    | 13 +++++++++++++
>>  .gitmodules |  3 +++
>>  capstone    |  1 +
>>  configure   | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
>>  4 files changed, 66 insertions(+), 11 deletions(-)
>>  create mode 160000 capstone
>>
>> diff --git a/Makefile b/Makefile
>> index 9372742f86..beecc85bee 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -383,6 +383,19 @@ subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
>>  dtc/%: .git-submodule-status
>>  	mkdir -p $@
>>  
>> +# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
>> +# Not overriding CFLAGS leads to mis-matches between compilation modes.
>> +# Therefore we replicate some of the logic in the sub-makefile.
> 
> I'm having plenty of "missing-prototypes" warnings:

Yes, we use lots of -Wfoo that upstream Capstone does not.  I do strip -Werror,
so at least it builds.  Are you suggesting that I drop most of our extra -Wfoo?

I suppose that's reasonable.  We don't want our developers worrying about
warnings coming from upstream code.  If in fact you believe that most of our
developers won't just install libcapstone-dev and be done?


r~
