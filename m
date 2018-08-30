Received: from eggs.gnu.org ([2001:4830:134:3::10]:34322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1fvN7W-0007ty-0K
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1fvMtq-0008Kq-G7
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:22:17 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:35520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1fvMtq-0008KT-93
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:22:14 -0400
Date: Thu, 30 Aug 2018 16:22:10 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20180830132210.jordqq3yehw7clnb@MacBook-Pro-Roman.local>
References: <20180822103835.26129-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180822103835.26129-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char-pty: remove unnecessary #ifdef
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 22, 2018 at 12:38:35PM +0200, Paolo Bonzini wrote:
> For some reason __APPLE__ was not checked in pty code.  However, the #ifdef
> is redundant: this file is already compiled only if CONFIG_POSIX, same as
> util/qemu-openpty.c which it uses.
> 

Hi Paolo,

Is it possible to apply the patch for master and 3.1 branch?

I'm trying to bring up qemu + libvirt on macOS. If it goes to 3.1, then
libvirt 4.7.0 and QEMU 3.1 are going to be a working solution for
virtualization on macOS.

Lack of pty devices prevents a user from using valid domain xml with
serial console and virsh console command.

--
Thank you,
Roman
