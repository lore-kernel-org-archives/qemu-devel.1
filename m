Received: from eggs.gnu.org ([2001:4830:134:3::10]:40549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWRM6-0001ba-LQ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cWRM5-00011i-Pt
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:27:34 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cWRM5-00011P-Lu
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:27:33 -0500
Received: by mail-qt0-x244.google.com with SMTP id l7so32449142qtd.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:27:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170113215720.29598-1-shorne@gmail.com>
	<20170113220252.GE25986@lianli.shorne-pla.net>
	<CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
	<20170125123430.GG7836@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <39f927aa-26fe-0e43-7c6b-efe1b70bc5fa@twiddle.net>
Date: Wed, 25 Jan 2017 09:27:29 -0800
MIME-Version: 1.0
In-Reply-To: <20170125123430.GG7836@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On 01/25/2017 04:34 AM, Stafford Horne wrote:
> Hmm, I just tried your qemu branch and mine:
> 
>   git@github.com:stffrdhrn/qemu.git or1k-fix-sigill
> 
> Both of them were able to boot fine.
> 
> The opencores,or1200-rtlsvn481 cpu node is in the or1ksim device tree
> definition.  Are you sure your kernel config has this in it?
> 
>   CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"
> 
> Could you send your kernel config?
> 
> I have attached mine, just in case.  For next-20170124

Curious.  The entire diff between our configs is just

--- ../or-config        2017-01-24 09:14:51.918059107 -0800
+++ .config     2017-01-25 09:18:14.153999754 -0800
@@ -18,7 +18,7 @@
 #
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-CONFIG_CROSS_COMPILE="or1k-linux-musl-"
+CONFIG_CROSS_COMPILE="or1k-musl-linux-"
 # CONFIG_COMPILE_TEST is not set
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y

So you're saying you *do* get serial port output?

Perhaps you can just send me your kernel...


r~
