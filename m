Received: from eggs.gnu.org ([2001:4830:134:3::10]:53819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQy0Q-0004G4-A2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQy0P-0006AP-8N
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:43:22 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQy0P-0006A7-2G
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:43:21 -0400
Received: by mail-pl0-x242.google.com with SMTP id b14-v6so6489980pls.5
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 09:43:20 -0700 (PDT)
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<d9298b1e-d600-879b-b19d-0e38e15dbbd6@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d817a6f-a963-148f-bb8d-f62b8f7c0207@linaro.org>
Date: Thu, 7 Jun 2018 09:43:17 -0700
MIME-Version: 1.0
In-Reply-To: <d9298b1e-d600-879b-b19d-0e38e15dbbd6@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

On 06/07/2018 01:01 AM, Laurent Vivier wrote:
>> Your script doesn't work outside debian, lacking debootstrap.
>> At the moment, I can't build on debian *at all*.  Some bit of the build
>> infrastructure is off and QEMU_FULL_VERSION gets incorrectly defined.  I have
>> no idea how or why it is different than Fedora.
> 
> I had this problem on Fedora building in a separate directory, "make
> distclean" at the top source directory fixed the problem for me.

Thanks.  I had never seen this failure mode before.


r~
