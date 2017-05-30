Received: from eggs.gnu.org ([2001:4830:134:3::10]:42828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnR6-00045k-5o
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnR2-0006hH-4X
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:08:12 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnR2-0006gk-0D
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:08:08 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so13355546qka.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:08:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-10-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <21a4c6ff-0d5a-25ee-29c0-045b9bbb714e@twiddle.net>
Date: Tue, 30 May 2017 13:08:02 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-10-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/29] target/s390x: implement COMPARE
 AND SIGNAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> +DEF_HELPER_FLAGS_3(keb, TCG_CALL_NO_WG_SE, i32, env, i64, i64)
> +DEF_HELPER_FLAGS_3(kdb, TCG_CALL_NO_WG_SE, i32, env, i64, i64)
> +DEF_HELPER_FLAGS_5(kxb, TCG_CALL_NO_WG_SE, i32, env, i64, i64, i64, i64)

They do have side effects -- recording the exception.


r~
