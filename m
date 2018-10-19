Received: from eggs.gnu.org ([2001:4830:134:3::10]:52527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDX83-0003A1-Vd
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDX7v-0005fL-5h
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:55:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:39660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDX7r-0005JU-1n
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 11:55:47 -0400
Received: by mail-pf1-x42b.google.com with SMTP id c25-v6so16667481pfe.6
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 08:55:43 -0700 (PDT)
References: <38a2dbae-42d8-ab2d-2e21-056794945677@linaro.org>
	<877eiensh4.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <29f04688-085c-1703-1149-3598be36902d@linaro.org>
Date: Fri, 19 Oct 2018 08:55:39 -0700
MIME-Version: 1.0
In-Reply-To: <877eiensh4.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] check-tcg failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 10/19/18 3:25 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On aa64, "cross-compiling" to aa32, with
>>
>> CC=arm-linux-gnueabihf-gcc
> 
> So this is different from ./configure --cross-cc=arch-linux-gnueabihf-

No, that's exactly how I configured.

> In fact looking deeper I'm not sure what HOST_CC is meant to be used
> for. We export it to make but the only place I can find it in the source
> tree is:
> 
> $(feat-dst)gen-features: $(feat-src)gen-features.c
> 	$(call quiet-command,$(HOST_CC) $(QEMU_INCLUDES) -o $@ $<,"CC","$(TARGET_DIR)gen-features")
> 
> As part of s390x - weird.

Because of course gen-features is run on the host to produce gen-features.h, as
part of the build process.  Those are the two lines immediately above those.


r~
