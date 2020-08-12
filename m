Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EF5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED9A20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED9A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5w6O-0007rF-KS
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k5w5f-0006zE-Fq; Wed, 12 Aug 2020 15:07:11 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:36523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k5w5c-0006rP-Ll; Wed, 12 Aug 2020 15:07:11 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.11])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 30F604FE123D;
 Wed, 12 Aug 2020 21:06:56 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 21:06:55 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003ceda069f-adbd-4d04-9f7a-698b066a9725,
 5D8978200EFCA383678890EAFADA58C33821F723) smtp.auth=groug@kaod.org
Date: Wed, 12 Aug 2020 21:06:54 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 2/2] spapr/nvram: Error out if NVRAM cannot contain
 all -prom-env data
Message-ID: <20200812210654.6ee82d66@bahia.lan>
In-Reply-To: <a3b37d03-b8e5-fc1c-7988-4f71cb19c090@vivier.eu>
References: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
 <159725213748.104309.14834084670144632611.stgit@bahia.lan>
 <a3b37d03-b8e5-fc1c-7988-4f71cb19c090@vivier.eu>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 9845a9f6-6119-4f2b-8a21-e6932799b723
X-Ovh-Tracer-Id: 4453778557291960681
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrledvgddufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:06:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 19:29:26 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 12/08/2020 =C3=A0 19:08, Greg Kurz a =C3=A9crit=C2=A0:
> > Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> > support the -prom-env parameter"), pseries machines can pre-initialize
> > the "system" partition in the NVRAM with the data passed to all -prom-e=
nv
> > parameters on the QEMU command line.
> >=20
> > In this cases it is assumed that all the data fits in 64 KiB, but the u=
ser
> > can easily pass more and crash QEMU:
> >=20
> > $ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
> >   echo -n " -prom-env "$(for ((y=3D0;y<1024;y++)); do echo -n x ; done)=
 ; \
> >   done) # this requires ~128 Kib
> > malloc(): corrupted top size
> > Aborted (core dumped)
> >=20
> > Call chrp_nvram_create_system_partition() first, with its recently added
> > parameter dry_run set to true, in order to know the required size and f=
ail
> > gracefully if it's too small.
>=20
> Why do you need the dry_run parameter?
> Can't you fail on the normal case?
>=20

Not sure what the "normal case" stands for... but basically, only
chrp_nvram_create_system_partition() knows the exact size of the
partition (ie. size of the header + size of all prom-env strings
including the terminal nul + padding to the upper 16-byte aligment).

Another solution could be to pass the buffer size and errp to
chrp_nvram_create_system_partition() and chrp_nvram_set_var(),
and let chrp_nvram_set_var() check it won't memcpy() past the
buffer. But this is more code and since this is also used by
other machine types, I chose to go for the dry_run parameter.

Should I improve the changelog to make this clearer or are
you thinking to something else ?

> Thanks,
> Laurent
>=20
> >=20
> > Reported-by: John Snow <jsnow@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/nvram/spapr_nvram.c |   15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> > index 992b818d34e7..c29d797ae1f0 100644
> > --- a/hw/nvram/spapr_nvram.c
> > +++ b/hw/nvram/spapr_nvram.c
> > @@ -145,6 +145,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, Spapr=
MachineState *spapr,
> > =20
> >  static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(dev);
> >      int ret;
> > =20
> > @@ -187,6 +188,20 @@ static void spapr_nvram_realize(SpaprVioDevice *de=
v, Error **errp)
> >              return;
> >          }
> >      } else if (nb_prom_envs > 0) {
> > +        int len =3D chrp_nvram_create_system_partition(nvram->buf,
> > +                                                     MIN_NVRAM_SIZE / =
4,
> > +                                                     true);
> > +
> > +        /* Check the partition is large enough for all the -prom-env d=
ata */
> > +        if (nvram->size < len) {
> > +            error_setg(errp, "-prom-env data requires %d bytes but spa=
pr-nvram "
> > +                       "is only %d bytes in size", len, nvram->size);
> > +            error_append_hint(errp,
> > +                              "Try to pass %d less bytes to -prom-env.=
\n",
> > +                              len - nvram->size);
> > +            return;
> > +        }
> > +
> >          /* Create a system partition to pass the -prom-env variables */
> >          chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE =
/ 4,
> >                                             false);
> >=20
> >=20
>=20


