Received: from eggs.gnu.org ([2001:4830:134:3::10]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWfEv-0004zy-PB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gWfEt-0001KT-RD
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:26:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gWfEt-0001J7-B5
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:26:07 -0500
Date: Tue, 11 Dec 2018 10:25:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181211102558.GE2734@work-vm>
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181210173151.16629-4-dgilbert@redhat.com>
	<b2ca83a1-6515-e291-fd7c-ea08ae93e6e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ca83a1-6515-e291-fd7c-ea08ae93e6e0@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/7] virtio-fs: Add cache BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, sweil@redhat.com, swhiteho@redhat.com, stefanha@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu

* Eric Blake (eblake@redhat.com) wrote:
> On 12/10/18 11:31 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add a cache BAR into which files will be directly mapped.
> > The size cacn be set with the cache-size= property, e.g.
> 
> s/cacn/can/

Thanks, fixed.

> >     -device vhost-user-fs-pci,chardev=char0,tag=myfs,cache-size=16G
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
