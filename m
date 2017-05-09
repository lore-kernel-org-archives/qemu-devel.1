Received: from eggs.gnu.org ([2001:4830:134:3::10]:52144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CLO-0000Ni-3p
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CLN-00075Y-C7
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:06:54 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CLN-000759-6y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:06:53 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so1643799qte.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:06:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-8-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f88d7b2f-c9c5-1156-fd3c-218fefb50b30@twiddle.net>
Date: Tue, 9 May 2017 14:06:49 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-8-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/14] target/sh4: only save flags state
 at the end of the TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> There is no need to save flags when entering and exiting the delay slot.
> They can be saved only when reaching the end of the TB. If the TB is
> interrupted before by an exception, they will be restored using
> restore_state_to_opc.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 69 ++++++++++++++++++++++++--------------------------
>   1 file changed, 33 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
