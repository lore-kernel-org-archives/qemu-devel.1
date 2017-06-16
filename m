Received: from eggs.gnu.org ([2001:4830:134:3::10]:40118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLy8S-0006aT-Vm
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLy8P-0008Jc-26
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:46:28 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:35218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLy8O-0008JL-RE
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:46:24 -0400
Received: by mail-qk0-x235.google.com with SMTP id a199so365438qkb.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 13:46:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-2-rth@twiddle.net>
	<20170616201921.GB27617@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a8369650-5ac5-8425-4c9b-cc07a0a552b9@twiddle.net>
Date: Fri, 16 Jun 2017 13:46:20 -0700
MIME-Version: 1.0
In-Reply-To: <20170616201921.GB27617@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] tcg: Refactor helper_lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com

On 06/16/2017 01:19 PM, Emilio G. Cota wrote:
> While booting debian-arm I'm measuring (see below) a hit rate in the
> high 90's for the htable lookups here, so adding an 'unlikely()'
> hint would be a good idea.

GCC already predicts null pointers unlikely.
We get identical code with and without the hint.


r~
