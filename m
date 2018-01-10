Received: from eggs.gnu.org ([2001:4830:134:3::10]:39897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZCA2-0002Sw-4c
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZC9y-000263-UJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:55:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZC9y-00025L-No
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 03:54:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D07EC00DBAA
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 08:54:57 +0000 (UTC)
Date: Wed, 10 Jan 2018 16:54:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180110085452.GJ5984@xz-mi>
References: <20180105215246.908-1-quintela@redhat.com>
	<20180105215246.908-5-quintela@redhat.com>
	<20180110063022.GC5984@xz-mi> <87r2qyyugr.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2qyyugr.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH v4 04/11] tests: Use consistent names and
 sizes for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

On Wed, Jan 10, 2018 at 09:43:48AM +0100, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Fri, Jan 05, 2018 at 10:52:39PM +0100, Juan Quintela wrote:
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  tests/migration-test.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/tests/migration-test.c b/tests/migration-test.c
> >> index d81f22118b..f469235d0b 100644
> >> --- a/tests/migration-test.c
> >> +++ b/tests/migration-test.c
> >> @@ -440,13 +440,13 @@ static void test_migrate_start(QTestState **from, QTestState **to,
> >>  
> >>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> >>          init_bootfile_x86(bootpath);
> >> -        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
> >> -                                  " -name pcsource,debug-threads=on"
> >> +        cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
> >> +                                  " -name source,debug-threads=on"
> >
> > A pure question: when will the name matter?
> 
> It don't matter, but ARM didn't want to use the pcname, and decided for
> yet a different command line.  I would like to have the same command
> line for all architectures.  At least the less gratuitous differences.
> 
> As you can guess, name don't matter at all., but telling ARNM people to
> be consistent with things that are not consistent .... O:-)

Ah, fine. :)

This test only support x86 and ppc for now, right?

(Btw, AFAIK debug-threads=on is only useful if any of us wants to
 glance at thread names.  In other words, would it be even simpler to
 just remove that "-name" line? :-)

-- 
Peter Xu
