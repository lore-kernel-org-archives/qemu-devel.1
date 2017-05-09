Received: from eggs.gnu.org ([2001:4830:134:3::10]:51541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CHt-0007ON-3O
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CHs-00061D-CY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:03:17 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CHs-000614-8O
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:03:16 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so1923764qkh.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:03:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-7-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0cf77f1b-9509-2826-35c2-cfeb649d5d67@twiddle.net>
Date: Tue, 9 May 2017 14:03:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-7-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/14] target/sh4: fix BS_EXCP exit
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
> In case of exception, there is no need to call tcg_gen_exit_tb as the
> exception helper won't return.
> 
> Also fix a few cases where BS_BRANCH is called instead of BS_EXCP.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
