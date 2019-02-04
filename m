Received: from eggs.gnu.org ([209.51.188.92]:36124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqhfw-0006zc-AN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqhfv-0000fH-At
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:04:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gqhfv-0000Ln-10
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:04:51 -0500
References: <154917314614.27692.2830748026894633212.malonedeb@soybean.canonical.com>
	<ec5e1ddc-9eac-193e-8937-c4146fe56a8f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <309658bb-925e-5b60-49b3-310ba51b4f13@redhat.com>
Date: Mon, 4 Feb 2019 11:04:10 -0600
MIME-Version: 1.0
In-Reply-To: <ec5e1ddc-9eac-193e-8937-c4146fe56a8f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1814418] [NEW] persistent bitmap will be
 inconsistent when qemu crash,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1814418 <1814418@bugs.launchpad.net>, qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, John Snow <jsnow@redhat.com>

On 2/4/19 8:55 AM, Eric Blake wrote:

> 
> Note that the "format-specific" listing has a "bitmaps" entry resulting
> from Andrey's patch (which shows "auto" as one of the "flags" for any
> persistent bitmap) showing the state of the persistent bitmaps on disk;
> as well as the "dirty-bitmaps" entry that shows the state of the bitmaps
> in memory. Annoyingly, the "dirty-bitmaps" section does NOT state which
> bitmaps are persistent, and if a persistent bitmap has not yet been
> flushed to disk, then there is NO way to quickly determine which bitmaps
> are persistent and which are transient.

I've posted a patch for this side-issue:

https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00759.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
