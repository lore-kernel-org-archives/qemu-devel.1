Received: from eggs.gnu.org ([2001:4830:134:3::10]:50206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBQba-00048E-ES
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBQbZ-0002z9-Hn
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:56:58 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:33084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dBQbZ-0002y5-C2
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:56:57 -0400
Date: Thu, 18 May 2017 20:56:41 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170518185641.udlg66nqgvmebsmt@aurel32.net>
References: <1495107549-6097-1-git-send-email-thuth@redhat.com>
	<20170518132020.o6bi2eb7x2vierlc@aurel32.net>
	<103cd6bc-4240-7158-b275-9006979a48e8@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103cd6bc-4240-7158-b275-9006979a48e8@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 2017-05-18 08:42, Richard Henderson wrote:
> On 05/18/2017 06:20 AM, Aurelien Jarno wrote:
> > > +DEF_HELPER_FLAGS_2(testblock, TCG_CALL_NO_WG, i32, env, i64)
> > As the helper does not read any values from the global, you can even use
> > TCG_CALL_NO_RWG.
> > 
> 
> By throwing an exception, we imply a read of all values along the exception path.
> 

You are indeed correct, sorry about the wrong comment.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
