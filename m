Received: from eggs.gnu.org ([2001:4830:134:3::10]:59468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpZx9-0008K7-KW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpZx5-00027x-6V
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:01:11 -0400
Date: Wed, 6 Sep 2017 15:00:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906130041.GI3753@dhcp-200-186.str.redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
	<fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/3] block-jobs: Optionally
 unregister live block operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, mrezanin@redhat.com

Am 30.08.2017 um 19:01 hat Jeff Cody geschrieben:
> From: Jeffrey Cody <jcody@redhat.com>
> 
> If configured without live block operations enabled, unregister the
> live block operation commands.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

How sure are we that libvirt will like a qemu that advertises these
commands in the schema, but doesn't actually provide them?

Kevin
