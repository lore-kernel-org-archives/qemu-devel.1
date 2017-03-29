Received: from eggs.gnu.org ([2001:4830:134:3::10]:51803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctGvl-0004EO-Ih
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctGvg-00045x-Kt
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ctGvg-00045q-Ey
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:58:40 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F8A83710D5
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 16:58:39 +0000 (UTC)
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<fddf5055-c458-3893-9a18-5b0701e5431a@redhat.com>
	<3044459b-65a3-ca78-c009-15de9823704a@redhat.com>
	<20170329164646.GD2501@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0eebf55d-aeb9-5426-001d-175b0cbfc60c@redhat.com>
Date: Wed, 29 Mar 2017 18:58:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170329164646.GD2501@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Deprecating old machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>



On 29/03/2017 18:46, Dr. David Alan Gilbert wrote:
>> By the way, what about old machine types like "pc-0.10" ? Do we want t=
o
>> carry them along forever (e.g. since it is not too complicated to
>> maintain?), or shall we get rid of those one day (e.g. with QEMU 3.0),=
 too?
> It seems reasonable to slowly deprecate them.
> I'm just not sure how slowly.

Some data:

- dropping 0.12, 0.13 _and_ isapc would let us kill the code for
rombar=3D0 (i.e. where QEMU copies ROM BARs directly to low memory).

- the oldest versions in use are probably 0.12 (CentOS 6) and 1.0
(Ubuntu 12.04)

- migration from old versions is broken in various ways from at least
QEMU 1.2 and older.

Paolo
