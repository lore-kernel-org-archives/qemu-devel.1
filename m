Received: from eggs.gnu.org ([2001:4830:134:3::10]:56722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoavV-00072e-W0
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoauU-0005VT-Pl
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:23:41 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:47059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eoauU-0005U9-4J
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:22:38 -0500
Received: by mail-pf0-x241.google.com with SMTP id z24so1122407pfh.13
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 12:22:38 -0800 (PST)
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-20-richard.henderson@linaro.org>
	<ddb804a5-6c00-57c3-03ef-d77daedda511@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75fc3d37-b450-a61a-d7cc-a0052b1ad18b@linaro.org>
Date: Wed, 21 Feb 2018 12:22:34 -0800
MIME-Version: 1.0
In-Reply-To: <ddb804a5-6c00-57c3-03ef-d77daedda511@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 19/20] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 02/20/2018 08:44 AM, Max Reitz wrote:
> This patch makes make check with clang -m32 fail for me.  (Interestingly
> enough, though, clang -m64 and gcc -m32 work fine.)

What's really interesting is that gcc -m32 should *not* have worked, but does.
I'm not sure why.  The assert is for the missing constraints for INDEX_op_dup2_vec.

Will fix.


r~
