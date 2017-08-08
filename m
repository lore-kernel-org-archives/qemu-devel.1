Received: from eggs.gnu.org ([2001:4830:134:3::10]:39196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1deygl-0005QZ-Q2
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1deygh-0006MP-1U
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1deygg-0006M1-Qq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:12:22 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170804113329.13609-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 4 Aug 2017 12:33:29 +0100")
References: <20170804113329.13609-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 09:12:15 +0200
Message-ID: <87zibacz3k.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for 2.11] vga/migration: Update memory map
 in post_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, jan.kiszka@siemens.com, maxime.coquelin@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> After migration the chain4 alias mapping added by 80763888 (in 2011)
> might be missing, since there's no call to vga_update_memory_access
> in the post_load after the registers are updated.  Add it back.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Interesting looking at vga_update_memory_access() from 80763888 and what
is currently there O:-)
