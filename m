Received: from eggs.gnu.org ([2001:4830:134:3::10]:52019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e6wie-0002bB-Sh
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 06:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e6wib-0000Na-PA
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 06:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e6wib-0000N8-G2
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 06:45:57 -0400
Date: Tue, 24 Oct 2017 11:45:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171024104552.GC3780@work-vm>
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QMP, HMP: introduce 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

* Vadim Galitsyn (vadim.galitsyn@profitbricks.com) wrote:
> Hi Guys,
>=20
> This thread is a continuation of discussion started in
> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03182.html.
>=20
> This series introduces =E2=80=98writeconfig=E2=80=99 command support fo=
r QMP and HMP monitors. This functionality might be useful for live migra=
tion for cases when guest configuration was modified in runtime (for exam=
ple as a result of hot- plug/unplug operations) and actual Qemu command l=
ine no longer reflects setup exposed to guest.
>=20
> Original series has =E2=80=98qemu_opts=E2=80=99 patch as well (http://l=
ists.nongnu.org/archive/html/qemu-devel/2017-02/msg03183.html) because HM=
P=E2=80=99s =E2=80=98object_add=E2=80=99 result was not reflected in =E2=80=
=98writeconfig=E2=80=99 output. Later I found that QMP=E2=80=99s =E2=80=98=
object-add=E2=80=99 has the same issue. Anyway, I don=E2=80=99t include =E2=
=80=98qemu_opts=E2=80=99 patches here because Markus mentioned (here http=
://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03476.html) that t=
his functionality is going to be reworked in some future and such patches=
 might collide with the rework process.
>=20
> Markus, could you please post if you have an update on this topic? Curr=
ent =E2=80=98master=E2=80=99 branch (9993c82dc2f5ce58b41d708b765e1a717ad4=
281d) still has the issue.
>=20
> Also, Markus mentioned that once configuration was changed during live =
migration -- it might be an issue because =E2=80=98writeconfig=E2=80=99 d=
ata became outdated (and might be make sense to think about to embed this=
 data into migration stream itself). In the same time David said that thi=
s is another problem which is unrelated to this patch series. What is you=
r current opinion on this topic? Can we consider these patches to be incl=
uded into =E2=80=98master=E2=80=99 taking into account that not all confi=
guration is dumped by =E2=80=98writeconfig=E2=80=99 (=E2=80=98object_add=E2=
=80=99 problem), but this can be fixed later?

I don't see anything wrong with having a 'writeconfig' command - we
already have the command line equivalent - that is assuming hotplug
etc all cause the values written to be correct.

The data becoming outdated doesn't sound like a big issue to me;
it's the management layer that's doing any hotplugs, it can reissue
another 'writeconfig' command.

Dave

>=20
> Best regards,
> Vadim
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
