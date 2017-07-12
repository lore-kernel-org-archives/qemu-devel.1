Received: from eggs.gnu.org ([2001:4830:134:3::10]:34113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVLP5-0000Y5-DA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVLP2-0004eY-9B
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:26:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVLP2-0004eP-4k
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:26:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id c20so2927545qte.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 10:26:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-20-git-send-email-cota@braap.org>
	<8737a18wzf.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9d22af0e-e87f-4f6c-2369-5affe7e1d468@twiddle.net>
Date: Wed, 12 Jul 2017 07:25:14 -1000
MIME-Version: 1.0
In-Reply-To: <8737a18wzf.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/22] tcg: introduce tcg_context_clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 07/12/2017 06:02 AM, Alex Bennée wrote:
> Why a copy approach as opposed to a plain tcg_context_new() with the
> appropriate init cleanup.

We need the globals that were set up by the target/foo/translate.c code to be 
the same for each thread.  That's what makes it easier to copy the struct.


r~
