Received: from eggs.gnu.org ([2001:4830:134:3::10]:35411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dxcUi-0001En-Je
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dxcUe-0007hZ-IH
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:21:04 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dxcUe-0007dG-CP
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:21:00 -0400
Received: by mail-pf0-x242.google.com with SMTP id e69so2011824pfg.4
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 10:20:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAP26EVRNVb=Mq=O3s51w7fDhGVmf-e3XFFA73MRzc5b4qKBA4g@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c80d1dff-7329-a174-56bc-5ae3ef822214@twiddle.net>
Date: Thu, 28 Sep 2017 10:20:54 -0700
MIME-Version: 1.0
In-Reply-To: <CAP26EVRNVb=Mq=O3s51w7fDhGVmf-e3XFFA73MRzc5b4qKBA4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86: Correct translation of some rdgsbase
 and wrgsbase encodings
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Todd Eisenberger <teisenbe@google.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/28/2017 10:17 AM, Todd Eisenberger wrote:
> It looks like there was a transcription error when writing this code
> initially.  The code previously only decoded src or dst of rax.  This
> resolves
> https://bugs.launchpad.net/qemu/+bug/1719984.
> 
> Signed-off-by: Todd Eisenberger <teisenbe@google.com>
> ---
>  target/i386/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
