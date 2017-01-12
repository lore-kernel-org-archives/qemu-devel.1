Received: from eggs.gnu.org ([2001:4830:134:3::10]:53170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRgzv-0006Jb-QU
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRgzs-0000TB-Lw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:09:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRgzs-0000Sn-Fy
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:09:00 -0500
Date: Thu, 12 Jan 2017 17:08:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112165908-mutt-send-email-mst@kernel.org>
References: <1479108340-3453-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1479108340-3453-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170110194722-mutt-send-email-mst@kernel.org>
	<c54d2492-e501-73c7-dea9-25e719c1669d@redhat.com>
	<8760lludir.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760lludir.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7 03/10] pci: Convert msix_init() to Error
 and fix callers to check it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Dmitry Fleytman <dmitry@daynix.com>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Jan 11, 2017 at 10:55:24AM +0100, Markus Armbruster wrote:
> I guess some of the later patches are follow-up cleanups that could be
> merged separately.  Might require reordering, then re-review.  But would
> this really be worth the trouble?  Merging through another tree is no
> pixie dust for quality.  If we can get the review and testing we need
> only by merging every shard through the exact right tree, we're doing it
> wrong.

Well I'm just looking for a way to merge something minimal so I can stop
spending time on this.

-- 
MST
