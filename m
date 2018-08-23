Received: from eggs.gnu.org ([2001:4830:134:3::10]:38197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsqbc-0006oE-81
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsqbY-0002Ul-PG
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:29:00 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1535027120-26187-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 23 Aug 2018 14:25:20 +0200")
References: <1535027120-26187-1-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 23 Aug 2018 16:33:26 +0200
Message-ID: <87ftz5xidl.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests/migration: Enable the migration test
 on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org

Thomas Huth <thuth@redhat.com> wrote:
> We can re-use the s390-ccw bios code to implement a small firmware
> for a s390x guest which prints out the "A" and "B" characters and
> modifies the memory, as required for the migration test.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I have no clue about s390, but for the migration bits:

Reviewed-by: Juan Quintela <quintela@redhat.com>

As you are not touching s390 files, I can integrate it on next migration
pull request.  With Cornelia change, of course.

Thanks a lot.
