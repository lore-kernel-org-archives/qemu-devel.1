Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5l61-0005lO-1l
	for qemu-devel@nongnu.org; Tue, 02 May 2017 23:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5l60-0003fs-9F
	for qemu-devel@nongnu.org; Tue, 02 May 2017 23:36:57 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5l60-0003fi-3n
	for qemu-devel@nongnu.org; Tue, 02 May 2017 23:36:56 -0400
Received: by mail-qt0-x241.google.com with SMTP id c45so23136775qtb.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 20:36:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Message-ID: <6d583a19-0134-3332-e116-dba4ed2e758e@twiddle.net>
Date: Tue, 2 May 2017 20:36:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/25] tcg cross-tb optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

On 05/02/2017 12:22 PM, Richard Henderson wrote:
> Changes since v5:
...
>    * Alpha frontend patch rewritten; the former patch appears to
>      drop clock interrupts, not exiting the kernel's idle loop.
>      I never *really* figured out why, since both patches seem
>      to annotate the same TBs in the same way.

There's definitely something odd going on.

With a rebuild from scratch, the same symptoms have re-appeared for Alpha.  So 
it really had nothing to do with the original patch.  I'm at a bit of a loss...


r~
