Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNFsW-0005wR-J6
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNFsT-0006el-Fl
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:32:08 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNFsT-0006eZ-3Q
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 06:32:05 -0500
Received: by mail-wr1-x441.google.com with SMTP id b13so20811890wrx.6
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 03:32:04 -0800 (PST)
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
Date: Thu, 15 Nov 2018 12:32:00 +0100
MIME-Version: 1.0
In-Reply-To: <20181114010014.GA19024@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 11/14/18 2:00 AM, Emilio G. Cota wrote:
> The following might be related: I'm seeing segfaults with -smp 8
> and beyond when doing bootup+shutdown of an aarch64 guest on
> an x86-64 host.

I'm not seeing that.  Anything else special on the command-line?
Are the segv in the code_gen_buffer or elsewhere?


r~
