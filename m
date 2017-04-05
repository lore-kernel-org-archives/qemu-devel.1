Received: from eggs.gnu.org ([2001:4830:134:3::10]:56355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvqcc-0006c7-Nd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvqcY-0004g3-Qa
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cvqcY-0004fy-Kz
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:29:34 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170405190024.27581-4-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Wed, 5 Apr 2017 20:00:24 +0100")
References: <20170405190024.27581-1-dgilbert@redhat.com>
	<20170405190024.27581-4-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 05 Apr 2017 21:29:32 +0200
Message-ID: <87shlm3b6r.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] migration/i386: Remove support for
 pre-0.12 formats
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
> Remove support for versions of the CPU state prior to 11
> which is the version used in qemu 0.12 - you'd be pretty
> lucky if you got a migration stream to work from anything
> that old anyway.  This doesn't affect the machine type
> definition in any way.
>
> My main reason for doing this is the hack for sysenter_esp/eip
> that uses .get/.put's in state versions less than 7 (that's
> prior to somewhere before 0.10).
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
