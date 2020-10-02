Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFDFC47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16DD206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="kWfOaxra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16DD206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLMq-0005ZY-UF
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kOLJE-0000n1-0N
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:41:16 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kOLJA-0005jd-Sl
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=pQz2p5aMOsy0CxuslkGmV4Q2ICnerhthHFI0q2WeWbI=; b=kWfOaxraSt/ZzhKT2jlogoHMT+
 kN2UjLQ93lQ8Avle0XiAC8vxs9KFN5NFCBYsnlrxPZrAcpbFIi/u1G/Yo4moDBFbiWrJKaLikq1fc
 zU3w0iK9xB5sIHtYngdgEef6bFWFjkbWPbsmVmcLqvsd3sRTgES48tS5YxlXSRTK5Vhp+jqV1C6Ul
 EUlCOBiP3sbMBGwr5HApSwPLnOr0nbw+b3d7eEB6n/VMiolmxEIhhcNDnPTVanVTCgjy8VEnR7jsl
 VaLDkrmimcdKl4hMySWXrNACxzDqwfK4Fy8JT5UY43ZQJd+bVRfbP2vPqsYVbGA+W55bFOXchsTEb
 5BGp40GA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/11] tests/9pfs: add local Tmkdir test
Date: Fri, 02 Oct 2020 15:41:07 +0200
Message-ID: <2826440.YJNrgBH8pc@silver>
In-Reply-To: <20201002125614.GA2338114@redhat.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
 <9488e95ff86b6ceea0254dab6a7dff67cbe0bf16.1601639563.git.qemu_oss@crudebyte.com>
 <20201002125614.GA2338114@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 08:18:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 2. Oktober 2020 14:56:14 CEST Daniel P. Berrang=E9 wrote:
> On Fri, Oct 02, 2020 at 01:51:54PM +0200, Christian Schoenebeck wrote:
> > This test case uses the 9pfs 'local' driver to create a directory
> > and then checks if the expected directory was actually created
> > (as real directory) on host side.
> >=20
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >=20
> >  tests/qtest/virtio-9p-test.c | 139 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >=20
> > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > index af7e169d3a..93161a4b35 100644
> > --- a/tests/qtest/virtio-9p-test.c
> > +++ b/tests/qtest/virtio-9p-test.c
> > @@ -18,6 +18,62 @@
> >=20
> >  #define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
> >  static QGuestAllocator *alloc;
> >=20
> > +/*
> > + * Used to auto generate new fids. Start with arbitrary high value to
> > avoid + * collision with hard coded fids in basic test code.
> > + */
> > +static uint32_t fid_generator =3D 1000;
> > +
> > +static uint32_t genfid(void)
> > +{
> > +    return fid_generator++;
> > +}
> > +
> > +/**
> > + * Splits the @a in string by @a delim into individual (non empty)
> > strings
> > + * and outputs them to @a out. The output array @a out is NULL
> > terminated.
> > + *
> > + * Output array @a out must be freed by calling split_free().
> > + *
> > + * @returns number of individual elements in output array @a out (with=
out
> > the + *          final NULL terminating element)
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
> > +    *out =3D g_malloc0(n * sizeof(char *) + 1); /* last element NULL
> > delimiter */
> Surely this should be  (n + 1) * sizeof(char *), because the last
> element still needs to be large enough to hold a pointer, not a
> single extra byte.

Right, good catch!

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
> This seems to largely re-invent g_strsplit
>=20
> https://developer.gnome.org/glib/2.62/glib-String-Utility-Functions.html#=
g-s
> trsplit

Yes, except that g_strsplit() outputs empty array elements as well. That's =
not=20
desired/working for this patch.

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

Best regards,
Christian Schoenebeck



