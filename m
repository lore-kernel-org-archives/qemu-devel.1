Received: from eggs.gnu.org ([2001:4830:134:3::10]:36978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS692-0007vx-Vs
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS692-0000j5-16
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:00:09 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:35858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS691-0000iF-UD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:00:07 -0500
Received: by mail-yw0-x241.google.com with SMTP id l75so4233927ywb.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 10:00:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-4-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f289e9fe-f874-3e33-36b3-a81930a7443c@twiddle.net>
Date: Fri, 13 Jan 2017 10:00:04 -0800
MIME-Version: 1.0
In-Reply-To: <1484311923-28637-4-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target-m68k: manage pre-dec et
 post-inc in CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/13/2017 04:52 AM, Laurent Vivier wrote:
> In these cases we must update the address register after
> the operation.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
