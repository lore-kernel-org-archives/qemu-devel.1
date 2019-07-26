Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB2C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162DF2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162DF2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr3eX-0006nX-2l
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50245)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hr3eI-00069D-T2
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hr3eG-0000my-19
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:04:53 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:59610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hr3eC-0000hi-Ip
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:04:50 -0400
Received: from player794.ha.ovh.net (unknown [10.108.54.59])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id D4A4B1A5F08
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 19:04:45 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player794.ha.ovh.net (Postfix) with ESMTPSA id 9B67585432D6;
 Fri, 26 Jul 2019 17:04:37 +0000 (UTC)
Date: Fri, 26 Jul 2019 19:04:10 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190726190410.6c882fcd@bahia.lan>
In-Reply-To: <b52e6301-fd01-7a37-974b-d8e062af9490@redhat.com>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415228410.1064338.4486161194061636096.stgit@bahia.lan>
 <b52e6301-fd01-7a37-974b-d8e062af9490@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 3651574874277779747
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.53.149
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr/pci: Free MSIs during reset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-stable <qemu-stable@nongnu.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 18:17:57 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Cc'ing qemu-stable@
>=20

This patch relies on the previous one, otherwise g_hash_table_remove_all() =
will
just g_free() the spapr_pci_msi structures, but it will not tear down the M=
SIs
in the interrupt controller.

Also, this bug is so old that I'm not sure it qualifies for stable.

> On 7/26/19 4:44 PM, Greg Kurz wrote:
> > When the machine is reset, the MSI bitmap is cleared but the allocated
> > MSIs are not freed. Some operating systems, such as AIX, can detect the
> > previous configuration and assert.
> >=20
> > Empty the MSI cache, this performs the needed cleanup.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_pci.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index bc22568bfa71..e45507bf2b53 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -2078,6 +2078,8 @@ static void spapr_phb_reset(DeviceState *qdev)
> >      if (spapr_phb_eeh_available(SPAPR_PCI_HOST_BRIDGE(qdev))) {
> >          spapr_phb_vfio_reset(qdev);
> >      }
> > +
> > +    g_hash_table_remove_all(sphb->msi);
>=20
> It is not clear to my why spapr_phb_unrealize() doesn't require the same
> call, but this is not related to this patch.
>=20

Because spapr_phb_unrealize() does this:

    if (sphb->msi) {
        g_hash_table_unref(sphb->msi);
        sphb->msi =3D NULL;
    }

and

https://developer.gnome.org/glib/stable/glib-Hash-Tables.html#g-hash-table-=
unref

g_hash_table_unref ()

void
g_hash_table_unref (GHashTable *hash_table);

Atomically decrements the reference count of hash_table by one. If the refe=
rence
count drops to 0, all keys and values will be destroyed, and all memory all=
ocated
by the hash table is released. This function is MT-safe and may be called f=
rom any
thread.

If I have to re-post, I can make it clear with a comment.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> >  }
> > =20
> >  static Property spapr_phb_properties[] =3D {
> >=20
> >=20


