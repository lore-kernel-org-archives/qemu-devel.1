Received: from eggs.gnu.org ([2001:4830:134:3::10]:32992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etDQA-0001kC-4n
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etDQ6-0005LW-TD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 09:18:26 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180306140646.GF7139@localhost.localdomain>
References: <cover.1519921268.git.berto@igalia.com>
	<20180306140646.GF7139@localhost.localdomain>
Date: Tue, 06 Mar 2018 15:18:19 +0100
Message-ID: <w51y3j5l238.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/7] Add checks for corruption in the
 snapshot table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 06 Mar 2018 03:06:46 PM CET, Kevin Wolf wrote:
>> So although having a way to repair this kind of corruption would be
>> nice, we should still allow the user to try to open the image and
>> read data from it without requiring a potentially destructive
>> operation first.
>
> Generally speaking, there is also always the option to refuse opening
> a corrupted image read-write, but to allow opening it read-only. This
> would probably still require some checks on use, though (or maybe just
> hiding all snapshots).

You're right. The checks are in this series anyway.

Berto
