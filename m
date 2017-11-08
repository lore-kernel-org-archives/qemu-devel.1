Received: from eggs.gnu.org ([2001:4830:134:3::10]:48060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCLvO-0005NL-RH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eCLvK-0004Pd-US
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:41:30 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:43722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eCLvK-0004PA-Mv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 03:41:26 -0500
Received: by mail-lf0-x244.google.com with SMTP id a16so2182741lfk.0
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 00:41:26 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1510079118-3923-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <98692fd0-2048-ce69-3fc2-8b7f44417bfa@twiddle.net>
Date: Wed, 8 Nov 2017 09:41:20 +0100
MIME-Version: 1.0
In-Reply-To: <1510079118-3923-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] linux-user: Fix calculation of
 auxv length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 11/07/2017 07:25 PM, Peter Maydell wrote:
> In commit 7c4ee5bcc82e643 we changed the order in which we construct
> the AUXV, but forgot to adjust the calculation of the length. The
> result is that we set info->auxv_len to a bogus and negative value,
> and then later on the code in open_self_auxv() gets confused and
> ends up presenting the guest with an empty file.
> 
> Since we now have to calculate the auxv length up-front as part
> of figuring out how much we're going to put on the stack, set
> info->auxv_len then; this allows us to assert that we put the
> same number of entries into auxv as we pre-calculated, rather
> than merely having a comment saying we need to do that.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1728116
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/elfload.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
