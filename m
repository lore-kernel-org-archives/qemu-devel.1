Received: from eggs.gnu.org ([2001:4830:134:3::10]:41023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQDeU-0002Mg-Ol
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQDeT-00088F-SY
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQDeT-000883-MN
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:09:05 -0400
Date: Wed, 28 Jun 2017 22:09:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170628140901.GJ14166@lemon.lan>
References: <20170628124850.12821-1-famz@redhat.com>
	<20170628124850.12821-2-famz@redhat.com>
	<538088ce-7515-f8a0-e4d7-21ec02bd45c9@redhat.com>
	<a9272af6-d6fa-89b0-3e30-35d85f5d3489@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a9272af6-d6fa-89b0-3e30-35d85f5d3489@suse.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] qom: Make link property API public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 06/28 15:36, Andreas F=E4rber wrote:
> The alternative would be moving info qom-tree forward and finally
> deprecating info qtree. There was a patch of mine to make it list
> properties with -v or so, but there were StringOutputVisitor
> dependencies where it got stuck in review.

No objection to enhancing info qom-tree, but also no idea how to help. :)

BTW, will it print much more information than "info qtree"? If so depreca=
ting it
sounds like a bad idea for me. "info qtree" output is already lengthy. As=
 HMP is
for human, it would be nice if the output is easy to extract interesting
information with eyeball, rather than dumping everything.

Fam
