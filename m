Received: from eggs.gnu.org ([209.51.188.92]:33700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkEuy-0006sh-2W
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:09:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gkEuu-0000eo-1y
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:09:37 -0500
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <584b60bb-e5cd-6678-0988-a9ee825d0064@redhat.com>
Date: Thu, 17 Jan 2019 16:09:20 -0500
MIME-Version: 1.0
In-Reply-To: <91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com



On 1/9/19 2:21 PM, Eric Blake wrote:
> Why are we restricting things to only export disabled bitmaps?

Late reply, but the original thought almost surely was that we would
only be exporting bitmaps for fleecing use, which should have a
non-changing bitmap attached to it.

Just some error checking to make sure the user didn't accidentally use
the live copy attached to the active disk image, versus the one prepared
for this purpose.

If that's not true anymore, that's fine if the NBD server can handle the
bits changing while it responds to requests... especially if a client
wants to just watch the bitmap change live and query sectors every now
and again, but it's a different use case from the one fairly targeted
one we were pursuing at the time.

--js
