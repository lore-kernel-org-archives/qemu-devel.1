Received: from eggs.gnu.org ([2001:4830:134:3::10]:57578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBFfx-0003JO-J8
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBFfu-0001PE-ES
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:16:45 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:56430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dBFfu-0001Ov-9I
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:16:42 -0400
Date: Thu, 18 May 2017 09:01:32 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170518070132.57bvuwgmuv3sgdwx@aurel32.net>
References: <1495035337-13337-1-git-send-email-thuth@redhat.com>
	<0721f18a-fc66-0be3-7462-76eb60de7f55@redhat.com>
	<394772e4-949a-b92f-6879-7b9e343e10d3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <394772e4-949a-b92f-6879-7b9e343e10d3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] target/s390x/cpu_models: Set some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, mmarek@suse.com, mbenes@suse.cz

On 2017-05-18 03:55, Thomas Huth wrote:
> On 17.05.2017 18:49, David Hildenbrand wrote:
> > On 17.05.2017 17:35, Thomas Huth wrote:
> > 2. I would recommend to not enable STFLE for now. Why?
> > 
> > It is/was an indication that the system is running on a z9 (and
> > implicitly has the basic features). This was not only done because
> > people were lazy, but because this bit was implicitly connected to other
> > machine properties.
> 
> Uh, that's ugly!
> 
> > One popular example is the "DAT-enhancement facility 2". It introduced
> > the "LOAD PAGE TABLE ENTRY ADDRESS" instruction, but no facility bit was
> > introduced. SO there is no way to check if the instruction is available
> > and actually working.
> 
> Does the Linux kernel use this instruction at all? I just grep'ed
> through the kernel sources and did not find it. If the Linux kernel does
> not use it, I think we should ignore this interdependency and just
> provide the STFLE feature bit to the guest - since recent Linux kernels
> depend on it.
> 
> > Please note that we added a feature representation for this facility,
> > because this would allow us later on to at least model removal of such a
> > facility (if HW actually would drop it) on a CPU model level.
> 
> What about STFLE bit 78, according to my version of the POP, it says:
> 
> "The enhanced-DAT facility 2 is installed in the
>  z/Architecture architectural mode."

No that is different. IBM has chosen very confusing names for the DAT
related facilities:
- DAT-Enhancement Facility 1 => bits 3, 4 & 5
- DAT-Enhancement Facility 2 
- Enhanced-DAT Facility 1    => bit 8
- Enhanced-DAT Facility 2    => bit 78

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
