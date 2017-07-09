Received: from eggs.gnu.org ([2001:4830:134:3::10]:50010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIKa-0008S5-Hi
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIKW-00080g-M6
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:57:24 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:36499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIKW-00080N-FX
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 15:57:20 -0400
Received: by mail-pf0-x232.google.com with SMTP id q86so39500383pfl.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 12:57:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-3-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f08d035-a79c-c4af-4c3a-319542024e25@twiddle.net>
Date: Sun, 9 Jul 2017 09:57:11 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/22] translate-all: remove redundant
 !tcg_enabled check in dump_exec_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> This check is redundant because it is already performed by the only
> caller of dump_exec_info -- the caller was updated by b7da97eef
> ("monitor: Check whether TCG is enabled before running the "info jit"
> code").
> 
> Checking twice wouldn't necessarily be too bad, but here the check also
> returns with tb_lock held. So we can either do the check before tb_lock is
> acquired, or just get rid of it. Given that it is redundant, I am going
> for the latter option.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
