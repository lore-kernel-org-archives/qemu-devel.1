Received: from eggs.gnu.org ([2001:4830:134:3::10]:52438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvqNA-0001AD-Qx
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvqN5-0005pE-Sr
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cvqN5-0005p7-Mq
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:13:35 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170405190024.27581-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Wed, 5 Apr 2017 20:00:22 +0100")
References: <20170405190024.27581-1-dgilbert@redhat.com>
	<20170405190024.27581-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 05 Apr 2017 21:13:33 +0200
Message-ID: <871st64qhu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] migration/i386: Remove old
 non-softfloat 64bit FP support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Long long ago, we used to support storing the x86 FP registers in
> a 64bit format.
>
> Then c31da136a0bf8caad70c348f5ffc283206e9c7fc in v0.14-rc0 removed
> the last support for writing that in the migration format.
> Even before that, it was only used if you had softfloat disabled
>  (i.e. !USE_X86LDOUBLE) so in practice use of it in even earlier
> qemu is unlikely for most users.
>
> Kill it off, it's complicated, and possibly broken.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Nice work.

It was a hack when I did it.  I *think* that I was byte-by-byte
compatible with the C functions, but I was pretty sure that they didn't
worked even then.

Reviewed-by: Juan Quintela <quintela@redhat.com>
