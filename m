Received: from eggs.gnu.org ([2001:4830:134:3::10]:50114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJuzT-0001wL-FH
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJuzS-0003qf-H4
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:05:15 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
Date: Sat, 19 May 2018 08:05:06 +0200
In-Reply-To: <20180518174133.GC25013@localhost.localdomain> (Eduardo Habkost's
	message of "Fri, 18 May 2018 14:41:33 -0300")
Message-ID: <87bmdc18q5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

Eduardo Habkost <ehabkost@redhat.com> writes:

[...]
> About being more expressive than just a single list of key,value
> pairs, I don't see any evidence of that being necessary for the
> problems we're trying to address.

Short history of a configuration format you might have encountered:

1. A couple of (key, value) is all we ne need for the problems we're
trying to address.  (v0.4, 2003)

2.1. I got this one special snowflake problem where I actually need a few
related values.  Fortunately, this little ad hoc parser can take apart
the key's single value easily.  (ca. v0.8, 2005)

...

2.n. Snowflakes are surprisingly common, but fortunately one more little
ad hoc parser can't hurt.

3. Umm, this is getting messy.  Let's have proper infrastructure for
two-level keys.  Surely two levels are all we ne need for the problems
we're trying to address.  Fortunately, we can bolt them on without too
much trouble.  (v0.12, 2009)

4. Err, trees, I'm afraid we actually need trees.  Fortunately, we can
hack them into the existing two-level infrastructure without too much
trouble.  (v1.3, 2013)

5. You are in a maze of twisting little passages, all different.
(today)


How confident are we a single list of (key, value) is really all we're
going to need?

Even if we think it is, would it be possible to provide for a future
extension to trees at next to no cost?
