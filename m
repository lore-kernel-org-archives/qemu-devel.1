Received: from eggs.gnu.org ([2001:4830:134:3::10]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWSol-0008Dv-H4
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWSoi-0005Be-2q
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gWSog-00058S-6r
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:10:14 -0500
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181210173151.16629-4-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2ca83a1-6515-e291-fd7c-ea08ae93e6e0@redhat.com>
Date: Mon, 10 Dec 2018 15:10:00 -0600
MIME-Version: 1.0
In-Reply-To: <20181210173151.16629-4-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/7] virtio-fs: Add cache BAR
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
> Add a cache BAR into which files will be directly mapped.
> The size cacn be set with the cache-size= property, e.g.

s/cacn/can/

>     -device vhost-user-fs-pci,chardev=char0,tag=myfs,cache-size=16G
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
