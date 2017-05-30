Received: from eggs.gnu.org ([2001:4830:134:3::10]:51395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFmKh-0007QM-Sc
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dFmKb-00011f-UD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dFmKb-00011a-O6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F8DF3DBD4
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 18:57:24 +0000 (UTC)
Date: Tue, 30 May 2017 19:57:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170530185713.GT2120@work-vm>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	<b7f9de2d-e09c-bcf1-24c8-0d961989cd9c@redhat.com>
	<2687d5d9-9771-97dc-5a32-ac78006472f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2687d5d9-9771-97dc-5a32-ac78006472f1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Yasevich <vyasevic@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, germano@redhat.com, lvivier@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

* Vlad Yasevich (vyasevic@redhat.com) wrote:
> On 05/26/2017 12:03 AM, Jason Wang wrote:
> >=20
> > On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 02:05, Vladislav Yasevich wrot=
e:
> >> Add parameters that control RARP/GARP announcement timeouts.
> >> The parameters structure is added to the QAPI and a qmp command
> >> is added to set/get the parameter data.
> >>
> >> Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>
> >> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
> >=20
> > I think it's better to explain e.g under which condition do we need t=
o tweak such parameters.
> >=20
> > Thanks
> >=20
>=20
> OK.  I'll rip off what dgilbert wrote in his original series for the de=
scription.
>=20
> Dave, if you have any text to add as to why migration might need to twe=
ak this, I'd
> appreciate it.

Pretty much what I originally said;  that the existing values
are arbitrary and fixed, and for systems with complex/sluggish
network reconfiguration systems they can be too slow.

Dave

> Thanks
> -vlad
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
