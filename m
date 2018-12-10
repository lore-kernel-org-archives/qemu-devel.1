Received: from eggs.gnu.org ([2001:4830:134:3::10]:45086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWSqx-0000mi-Jl
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWSqu-0005tF-EX
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:12:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gWSqu-0005t6-86
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:12:32 -0500
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181210173151.16629-8-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a893ff17-9bfe-b541-75c9-6d4bd34176db@redhat.com>
Date: Mon, 10 Dec 2018 15:12:27 -0600
MIME-Version: 1.0
In-Reply-To: <20181210173151.16629-8-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 7/7] virtio-fs: Allow mapping of journal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

On 12/10/18 11:31 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The 'journal' is a shared block of RAM between QEMU and it's

s/it's/its/ (here, you want possessive)

> fuse daemon.  It's typically a shmfs file and it's specified as:

whereas here, both uses of "it's" are correct as contractions for "it 
is" (although I might use just "is" instead of "it's" for that last 
instance).

> 
> -device
> vhost-user-fs-pci,chardev=char0,tag=myfs,cache-size=1G,versiontable=/dev/shm/mdvt1,journal=/dev/shm/journal1
> 
> It gets mapped into the PCI bar after the version table.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
