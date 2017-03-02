Received: from eggs.gnu.org ([2001:4830:134:3::10]:51174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjQhn-0005fO-KT
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjQhk-0006OI-FE
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:23:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjQhk-0006NS-9v
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:23:36 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53F4FC081F53
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 13:23:36 +0000 (UTC)
Date: Thu, 2 Mar 2017 13:23:28 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170302132328.GC11445@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170302123746.9694-1-berrange@redhat.com>
	<20170302123746.9694-3-berrange@redhat.com>
	<5991e348-68f5-23f6-ef69-4fbc3c3c62b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5991e348-68f5-23f6-ef69-4fbc3c3c62b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] migration: always report tls-creds
 & tls-hostname migrate parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Ferlan <jferlan@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

On Thu, Mar 02, 2017 at 08:19:29AM -0500, John Ferlan wrote:
> 
> 
> On 03/02/2017 07:37 AM, Daniel P. Berrange wrote:
> > Currently the query-migrate-parameters command will omit reporting
> > of the tls-creds & tls-hostname parameters if their value is NULL.
> > This makes it impossible for an app to detect if these parameters
> > are supported by QEMU, without trying to actually set them and
> > catching the error. Since the code is treating "" and NULL as
> > equivalent, we can simply always report these values and give them
> > a value of "". This allows apps like libvirt to detect the fact
> > that these parameters are supported by QEMU.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  migration/migration.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> 
> Should the query-migrate-parameters description in qapi-schema.json also
> be updated?  Anywhere else I haven't found yet either...

That's just a code example, the actual parameters are documented against
the MigrationParameters struct definition. That said, we might as well
update the example too.

> Naively asking - would the plan be to also get these changes accepted
> for previous releases w/ tls-creds/hostname support? (2.7, 2.8). Mostly
> curious - not that it matters since the query will tell me the answer.

QEMU only maintains one stable branch, but I think we could add these
to 2.8

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
