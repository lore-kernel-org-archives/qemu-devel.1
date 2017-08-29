Received: from eggs.gnu.org ([2001:4830:134:3::10]:34265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdRN-0008JC-Uk
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdRJ-0004TM-Tb
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:08:13 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmdRJ-0004Ss-Mk
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:08:09 -0400
Received: by mail-wm0-x229.google.com with SMTP id y71so17697173wmd.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 03:08:09 -0700 (PDT)
Date: Tue, 29 Aug 2017 11:08:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829100806.GO25960@stefanha-x1.localdomain>
References: <8c62454c-828b-0f16-76dd-227d9c52af1d@erigones.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c62454c-828b-0f16-76dd-227d9c52af1d@erigones.com>
Subject: Re: [Qemu-devel] wrong ioctl error handling on dirty pages sync?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?B?SuFu?= Poctavek <jan.poctavek@erigones.com>
Cc: qemu-devel@nongnu.org

On Fri, Aug 25, 2017 at 01:42:55PM +0200, Ján Poctavek wrote:
> Hi guys,
> 
> Maybe it is just my lack of understanding, this seems like a bug to me:
> 
> To get list of dirty pages, qemu calls kvm_vm_ioctl() with
> KVM_GET_DIRTY_LOG:
> https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L494
> 
> and considers the ioctl call failed when -1 is returned.
> 
> But the kvm_vm_ioctl() itself returns -errno, not the -1 on error:
> https://github.com/qemu/qemu/blob/v2.10.0-rc4/accel/kvm/kvm-all.c#L2142
> 
> Thanks in advance for sheding some light into this for me.

Looks like a bug to me.  Do you want to send a patch?

Guidelines on how to submit a patch are here:
http://wiki.qemu.org/Contribute/SubmitAPatch

Stefan
