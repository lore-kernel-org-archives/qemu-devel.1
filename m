Received: from eggs.gnu.org ([2001:4830:134:3::10]:44090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsAnA-0007wE-Nj
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsAn7-0004rw-IK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:36 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:47572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsAn7-0004rJ-Cf
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:45:33 -0400
Received: by mail-pg0-x22f.google.com with SMTP id d8so1389246pgt.4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:45:33 -0700 (PDT)
References: <20170911204936.5020-1-f4bug@amsat.org>
	<CAFEAcA_61iw+u7aMp+vA-CNpmAPjvJ_ynUfHu8Y+p8jmgvbcdw@mail.gmail.com>
	<4eddca72-c75e-0cbc-e07d-280c1cd0f095@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5dac3293-15ec-95e7-e8e7-4a16fb2dcfc4@linaro.org>
Date: Wed, 13 Sep 2017 09:45:29 -0700
MIME-Version: 1.0
In-Reply-To: <4eddca72-c75e-0cbc-e07d-280c1cd0f095@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: disable atomic write check on
 ppc32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 09/12/2017 02:04 PM, Paolo Bonzini wrote:
> I wonder if QEMU_BUILD_BUG_ON (at least in atomics) should not use a
> static assertion, but rather the 'error ("MESSAGE")' attribute instead.
> This way, if the code is dead it does not cause a build failure.

I think that would be an excellent idea.


r~
