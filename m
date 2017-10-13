Received: from eggs.gnu.org ([2001:4830:134:3::10]:41487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e34RX-00042R-NA
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e34RU-0003Dh-JH
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:12:19 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:51686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e34RU-00039q-CR
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 14:12:16 -0400
Received: by mail-pf0-x230.google.com with SMTP id n14so10993858pfh.8
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 11:12:14 -0700 (PDT)
References: <20171012143548.18581-1-pbonzini@redhat.com>
	<20171012143548.18581-3-pbonzini@redhat.com>
	<449dd7e8-42cd-fd4a-da2b-35f22552bc39@linaro.org>
	<f5592714-d129-9580-57d7-06de323503d8@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ccd1f71a-9920-7e14-2d4c-d38a3eab159a@linaro.org>
Date: Fri, 13 Oct 2017 11:12:10 -0700
MIME-Version: 1.0
In-Reply-To: <f5592714-d129-9580-57d7-06de323503d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/i386: trap on instructions
 longer than >15 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 10/12/2017 02:43 PM, Paolo Bonzini wrote:
>> Any particular reason to use sigsetjmp(x, 0) instead of setjmp(x)?
>> Certainly there are no signal frames that the longjmp will pass...
> 
> sigsetjmp is used to _not_ save the signal mask.  On OS X setjmp saves
> the signal mask by default, which is slower.

Oh, bizarro.  Thanks,


r~
