Received: from eggs.gnu.org ([2001:4830:134:3::10]:47981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cqf7m-0004Nq-0Q
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cqf7i-0007ng-31
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:12:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cqf7h-0007mT-NQ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:12:18 -0400
References: <mvminn3t1fq.fsf@suse.de>
	<a7886994-b4fe-3c6c-40ee-213b36e1e4b4@tuxfamily.org>
	<mvmo9wtsekj.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bec351a6-09c8-21d1-19b5-2cf626a77ee8@vivier.eu>
Date: Wed, 22 Mar 2017 13:12:03 +0100
MIME-Version: 1.0
In-Reply-To: <mvmo9wtsekj.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: Fix m68k_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, Thomas Huth <huth@tuxfamily.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org

Le 22/03/2017 à 13:04, Andreas Schwab a écrit :
> On Mär 22 2017, Thomas Huth <huth@tuxfamily.org> wrote:
> 
>> On 21.03.2017 10:38, Andreas Schwab wrote:
>>> The m68k mask should not remove the low bit of the ELF version field and
>>> should ignore the OS/ABI field.
>>
>> Did you encounter a problem with a real binary here?
> 
> Yes, some binaries are using ELFOSABI_GNU instead of ELFOSABI_SYSV.  All
> other patterns already ignore the OS/ABI field.

Yes, I've also seen this.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
