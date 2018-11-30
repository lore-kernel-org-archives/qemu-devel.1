Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkFe-0006qd-0r
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkFY-0001yP-I6
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:58:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSkFX-0001y5-LL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:58:36 -0500
References: <20181130144404.GA32091@mswork1>
From: Eric Blake <eblake@redhat.com>
Message-ID: <faae3e4a-bce7-849a-b510-1c94ffb03413@redhat.com>
Date: Fri, 30 Nov 2018 08:58:34 -0600
MIME-Version: 1.0
In-Reply-To: <20181130144404.GA32091@mswork1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Loading snapshot with readonly qcow2 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Spradling <michael@os.amperecomputing.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 11/30/18 8:44 AM, Michael Spradling wrote:
> Hello,
> 
> I would like to resume a snapshot via the command line option -loadvm
> with a read only QCOW2 file.  For my use case, I would ideally like to
> load multiple instances of different snapshots from the same QCOW2 image.
> 
> It seems this is not possible at the moment as when a snapshot is loaded, QEMU
> copies some meta data around in the qcow2 image.
> 
> I have also tried to use the "-snapshot" option, which to my understanding
> creates a new temporary QCOW2 file with a backing file pointing the original
> image passed on the command line.  This also does not work, when looking
> through the source it appears QEMU only supports loading snapshots from writable
> QCOW2 images and doesn't support loading from images in backing files.
> 
> My question is has anyone looked into loading snapshots from a backing
> file?  I have attempted to look through the code and this looks to be
> difficult.  If I attempt to add support for this is there any general
> advice to follow?  Any other ideas?

'qemu-nbd -l' can serve snapshots from a qcow2 file; perhaps that can be 
used to cobble together something that works for your needs?

Sadly, internal snapshots don't get much attention these days, so there 
may well be missing functionality, but no one is really stepping up to 
provide patches.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
