Received: from eggs.gnu.org ([2001:4830:134:3::10]:51665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgpZ1-0006Es-Rp
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgpYy-0003Ly-LJ
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cgpYy-0003Lr-F1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:19:48 -0500
Date: Thu, 23 Feb 2017 09:19:43 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170223091943.GA10047@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAJy91Cav17O8N++OzmOJUUeZKa7_tZyRNgQ-KZkwR-wcv1oX=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJy91Cav17O8N++OzmOJUUeZKa7_tZyRNgQ-KZkwR-wcv1oX=Q@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU pipe implementation for Windows(host)
 Linux(guest) interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Feb 23, 2017 at 08:45:17AM +0100, Jiahuan Zhang wrote:
> Dear QEMU developers,
> 
> I am a student working on the host-guest interaction for a Windows Host and
> Linux Quest. Actually, I aim to make a universal pipe implementation for
> any host-guest interaction.

FWIW, there's already two general purpose host<->guest communication
channels for QEMU - virtio-serial (like a traditional serial port
but giving them names & allowing many to be create) and virtio-vsock
(like UNIX domain sockets, but across host/guest - alternatively like
TCP/IP sockets, but without network devices involved)

> I am now using a serial port to redirect to a pipe. This is working with
> LInux host and Linux guest by using "mkfifo" to create the pipe. However, I
> don't know how to create a pipe in Windows for QEMU usage.

IIUC, you don't need to pre-create the pipe on Windows with QEMU chardevs.
It looks like the code takes the filename you set, appends ".pipe" and
then calls CreateNamedPipe to create it pipe.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
