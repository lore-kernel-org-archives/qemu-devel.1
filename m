Received: from eggs.gnu.org ([2001:4830:134:3::10]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cmLrO-0007An-1M
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cmLrL-0005LT-Ea
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:49:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cmLrL-0005Kk-8I
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 09:49:35 -0500
Date: Fri, 10 Mar 2017 15:49:28 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170310144928.h5ozia5cybxstuwc@eukaryote>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
	<7829c1dc-9138-c784-dcc5-3c46ec9b5c05@innervision.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7829c1dc-9138-c784-dcc5-3c46ec9b5c05@innervision.pl>
Subject: Re: [Qemu-devel] external snapshots freezes block device since qemu
 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Piotr Rybicki <piotr.rybicki@innervision.pl>
Cc: qemu-devel@nongnu.org

On Thu, Mar 09, 2017 at 11:11:09AM +0100, Piotr Rybicki wrote:
> Hello there.
> 
> I discovered, that since qemu 2.8 , external snapshots (very similar to:
> http://wiki.libvirt.org/page/Live-disk-backup-with-active-blockcommit),

When I wrote this Wiki page, I tested it only with regular QCOW2 files
on EXT4 file system.

> freezes block device after:
> 
> # virsh blockcommit (...)
> 
> There is no error message after completion of the command above.
> I'm using gluster + ZFS fuse mount as a storage for a VM on gentoo.
> libvirt debug showed nothing helpful.
> With qemu <2.8 -: snapshots are working as expected.
> 
> Is this a known issue?
> Is it qemu or libvirt ?
> 
> If it helps, how can i diagnose this further?a

To see what libvirt is sending to QEMU, you can enable the debug log
filters, which can give some clue:

- In /etc/libvirt/libvirtd.conf, set these config attributes

    log_filters="1:libvirt 1:qemu 1:conf 1:security 3:event 3:json 3:file 3:object 1:util"
    log_outputs="1:file:/var/log/libvirt/libvirtd.log"

- Restart libvirtd:

    $ systemctl restart libvirtd

- Perform your `blockcommit` test.

PS: A gentle reminder -- when reporting upstream, you'll likely better
help if you at least test with the latest releases (libvirt-3.1.0, and
QEMU 2.8), if not from Git.

[...]

-- 
/kashyap
