Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5130CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D54206B2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D54206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMB8-0003Xc-QF
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kOM7M-0008VH-02
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:33:04 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:36385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kOM7I-0003Hc-SL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:33:03 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.132])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 76938616A3EB;
 Fri,  2 Oct 2020 16:32:57 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 2 Oct 2020
 16:32:56 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003d2dc109c-95f3-4a9c-acfa-6851068a12bc,
 0341F95EB5BC96075CB197F7895ABA4104766D23) smtp.auth=groug@kaod.org
Date: Fri, 2 Oct 2020 16:32:55 +0200
From: Greg Kurz <groug@kaod.org>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH v2 11/11] tests/9pfs: add local Tmkdir test
Message-ID: <20201002163255.67087341@bahia.lan>
In-Reply-To: <20201002125614.GA2338114@redhat.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
 <9488e95ff86b6ceea0254dab6a7dff67cbe0bf16.1601639563.git.qemu_oss@crudebyte.com>
 <20201002125614.GA2338114@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 2a408529-895b-47eb-8bd6-5977ebcdb198
X-Ovh-Tracer-Id: 4186377331974576489
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqfedtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgedvvdetjedvvdffvdfgjeetfefhteegfffgudevgfelgefguefgtddvueehudelnecuffhomhgrihhnpehgnhhomhgvrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepvgdrvghmrghnuhgvlhgvghhiuhhsvghpphgvsehgmhgrihhlrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 10:32:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 13:56:14 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Oct 02, 2020 at 01:51:54PM +0200, Christian Schoenebeck wrote:
> > This test case uses the 9pfs 'local' driver to create a directory
> > and then checks if the expected directory was actually created
> > (as real directory) on host side.
> >=20
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  tests/qtest/virtio-9p-test.c | 139 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >=20
> > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > index af7e169d3a..93161a4b35 100644
> > --- a/tests/qtest/virtio-9p-test.c
> > +++ b/tests/qtest/virtio-9p-test.c
> > @@ -18,6 +18,62 @@
> >  #define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
> >  static QGuestAllocator *alloc;
> > =20
> > +/*
> > + * Used to auto generate new fids. Start with arbitrary high value to =
avoid
> > + * collision with hard coded fids in basic test code.
> > + */
> > +static uint32_t fid_generator =3D 1000;
> > +
> > +static uint32_t genfid(void)
> > +{
> > +    return fid_generator++;
> > +}
> > +
> > +/**
> > + * Splits the @a in string by @a delim into individual (non empty) str=
ings
> > + * and outputs them to @a out. The output array @a out is NULL termina=
ted.
> > + *
> > + * Output array @a out must be freed by calling split_free().
> > + *
> > + * @returns number of individual elements in output array @a out (with=
out the
> > + *          final NULL terminating element)
> > + */
> > +static int split(const char *in, const char *delim, char ***out)
> > +{
> > +    int n =3D 0, i =3D 0;
> > +    char *tmp, *p;
> > +
> > +    tmp =3D g_strdup(in);
> > +    for (p =3D strtok(tmp, delim); p !=3D NULL; p =3D strtok(NULL, del=
im)) {
> > +        if (strlen(p) > 0) {
> > +            ++n;
> > +        }
> > +    }
> > +    g_free(tmp);
> > +
> > +    *out =3D g_malloc0(n * sizeof(char *) + 1); /* last element NULL d=
elimiter */
>=20
> Surely this should be  (n + 1) * sizeof(char *), because the last
> element still needs to be large enough to hold a pointer, not a
> single extra byte.
>=20

If you decide to keep this split() function, maybe use g_new0(char *, n + 1=
) ?
This buys you the math and does type checking as an extra.

> > +
> > +    tmp =3D g_strdup(in);
> > +    for (p =3D strtok(tmp, delim); p !=3D NULL; p =3D strtok(NULL, del=
im)) {
> > +        if (strlen(p) > 0) {
> > +            (*out)[i++] =3D g_strdup(p);
> > +        }
> > +    }
> > +    g_free(tmp);
> > +
> > +    return n;
> > +}
>=20
> This seems to largely re-invent g_strsplit=20
>=20
> https://developer.gnome.org/glib/2.62/glib-String-Utility-Functions.html#=
g-strsplit
>=20
> > +
> > +static void split_free(char ***out)
> > +{
> > +    int i;
> > +    for (i =3D 0; (*out)[i]; ++i) {
> > +        g_free((*out)[i]);
> > +    }
> > +    g_free(*out);
> > +    *out =3D NULL;
> > +}
>=20
> And g_strfreev
>=20
>=20
>=20
> Regards,
> Daniel


