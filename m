Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0097BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF6C20848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBZzQdph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF6C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDxO-0001bU-B3
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJDwS-0000Lg-KA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJDwR-0004OT-F1
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:16:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJDwR-0004Nt-Bm
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585649778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+S9nmA3GWMm9t8Wv/AWFj6p/spbVK3eprLoqdUMXkc=;
 b=cBZzQdph0mtFgkmiZDOMhKZz0nf+WoUvBl9aYyur2qj1izvPI7+tNuraJ5QI/wKqkC91gs
 8+5y+May3Pb0nMQ4I6Rc389gixVSBIUYTUSIK/wFOnx4Uk2d8Ph0G2pnoMav1HzzESfLSV
 J+1fB+i01H53LVmfGKRCAENb6cfIycY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-qWWOM4mNOjOm2bXAifR6iQ-1; Tue, 31 Mar 2020 06:16:16 -0400
X-MC-Unique: qWWOM4mNOjOm2bXAifR6iQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA65149C3;
 Tue, 31 Mar 2020 10:16:15 +0000 (UTC)
Received: from gondolin (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AACC1001B09;
 Tue, 31 Mar 2020 10:16:11 +0000 (UTC)
Date: Tue, 31 Mar 2020 12:16:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Add stsi 3.2.2 tests
Message-ID: <20200331121600.11858d5c.cohuck@redhat.com>
In-Reply-To: <107d86c4-fa6d-2e6f-6050-5ad6018a5be8@linux.ibm.com>
References: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
 <20200331071456.3302-1-frankja@linux.ibm.com>
 <20200331113535.6bbd434d.cohuck@redhat.com>
 <107d86c4-fa6d-2e6f-6050-5ad6018a5be8@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/sGcdEYlkEUDEIT=XBfrZYPD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/sGcdEYlkEUDEIT=XBfrZYPD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Mar 2020 11:46:53 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/31/20 11:35 AM, Cornelia Huck wrote:
> > On Tue, 31 Mar 2020 03:14:56 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
> >> a bit more thorough. =20
> >=20
> > s/thorough/thoroughly/ ?
> >  =20
> >>
> >> In this test we set a custom name and uuid through the QEMU command
> >> line. Both parameters will be passed to the guest on a stsi subcode
> >> 3.2.2 call and will then be checked.
> >>
> >> We also compare the configured cpu numbers against the smp reported
> >> numbers and if the reserved + configured add up to the total number
> >> reported.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>
> >> * Tabify on struct
> >> * Moved prefix_push up a bit
> >> * Replaced returns with goto out to pop prefix
> >>
> >> ---
> >>  s390x/stsi.c        | 73 ++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  s390x/unittests.cfg |  1 +
> >>  2 files changed, 74 insertions(+)
> >> =20
> >=20
> > (...)
> >  =20
> >> +static void test_3_2_2(void)
> >> +{
> >> +=09int rc;
> >> +=09/* EBCDIC for "kvm-unit" */
> >> +=09const uint8_t vm_name[] =3D { 0x92, 0xa5, 0x94, 0x60, 0xa4, 0x95, =
0x89,
> >> +=09=09=09=09    0xa3 };
> >> +=09const uint8_t uuid[] =3D { 0x0f, 0xb8, 0x4a, 0x86, 0x72, 0x7c,
> >> +=09=09=09=09 0x11, 0xea, 0xbc, 0x55, 0x02, 0x42, 0xac, 0x13,
> >> +=09=09=09=09 0x00, 0x03 };
> >> +=09/* EBCDIC for "KVM/" */
> >> +=09const uint8_t cpi_kvm[] =3D { 0xd2, 0xe5, 0xd4, 0x61 };
> >> +=09const char *vm_name_ext =3D "kvm-unit-test";
> >> +=09struct stsi_322 *data =3D (void *)pagebuf;
> >> +
> >> +=09report_prefix_push("3.2.2");
> >> +
> >> +=09/* Is the function code available at all? */
> >> +=09if (stsi_get_fc(pagebuf) < 3) {
> >> +=09=09report_skip("Running under lpar, no level 3 to test.");
> >> +=09=09goto out;
> >> +=09}
> >> +
> >> +=09rc =3D stsi(pagebuf, 3, 2, 2);
> >> +=09report(!rc, "call");
> >> +
> >> +=09/* For now we concentrate on KVM/QEMU */
> >> +=09if (memcmp(&data->vm[0].cpi, cpi_kvm, sizeof(cpi_kvm))) {
> >> +=09=09report_skip("Not running under KVM/QEMU.");
> >> +=09=09goto out;
> >> +=09}
> >> +
> >> +=09report(!memcmp(data->vm[0].uuid, uuid, sizeof(uuid)), "uuid");
> >> +=09report(data->vm[0].conf_cpus =3D=3D smp_query_num_cpus(), "cpu # c=
onfigured");
> >> +=09report(data->vm[0].total_cpus =3D=3D
> >> +=09       data->vm[0].reserved_cpus + data->vm[0].conf_cpus,
> >> +=09       "cpu # total =3D=3D conf + reserved");
> >> +=09report(data->vm[0].standby_cpus =3D=3D 0, "cpu # standby");
> >> +=09report(!memcmp(data->vm[0].name, vm_name, sizeof(data->vm[0].name)=
),
> >> +=09       "VM name =3D=3D kvm-unit-test");
> >> +
> >> +=09if (data->vm[0].ext_name_encoding !=3D 2) {
> >> +=09=09report_skip("Extended VM names are not UTF-8."); =20
> >=20
> > Do we expect this to be anything other than UTF-8? =20
>=20
> With the current QEMU no.

I don't really see a reason to change this in QEMU, though; and as you
check already whether we're running under QEMU, maybe make this a
failure?

> When I find time to test this under z/VM (as a guest 2, no KVM) maybe.

Would it make sense to check (different) expected values for z/VM and
QEMU, then?

>=20
> >  =20
> >> +=09=09goto out;
> >> +=09}
> >> +=09report(!memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext=
)),
> >> +=09=09       "ext VM name =3D=3D kvm-unit-test");
> >> +
> >> +out:
> >> +=09report_prefix_pop();
> >> +}
> >> +
> >>  int main(void)
> >>  {
> >>  =09report_prefix_push("stsi");
> >>  =09test_priv();
> >>  =09test_specs();
> >>  =09test_fc();
> >> +=09test_3_2_2();
> >>  =09return report_summary();
> >>  } =20
> >=20
> > (...)
> >  =20
>=20
>=20


--Sig_/sGcdEYlkEUDEIT=XBfrZYPD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl6DGGAACgkQ3s9rk8bw
L6/6wQ/6Anbqcc18jWV98soydbovc7Q66oZV+bv/jyQQL6z/sVgUBRndQKXcuiUM
K+lDXFJAyP6uLNWDxLL91GhlDQnkKWyoVM/UrLJD4WI4vHDKGyIjx7cQ52h45Ye5
UXTUfdFsJuanUXfatxLmiuOxLX1BncFKr64heLaGE6SIA4B3H0IAEoNJhb92IBmR
KoY4clibUCXHAksJd3Os76cbiwK9yen4pRjlZxVY8HcCaDEarHZpsMlTHmHD91do
spaXxMpqQX/lh7zlSVG1LgNSqbCBpP6EyCwrNuhLvJcaiO1bXMAXTkNtspOdwn/T
CUNmt1yYSVvPlkUC0/22vOBf05jo5QFr5cQiOUUG9qCDPX/k7MJUQYE0zOw9hdRd
tqij3N8jXArrjVOW0/mRGBgjC6iThPEfnhZSS3tGk8JJINDK1fhlwLtx9B2+N3z/
gVi7iT9kO1+xtSzPmuEsaYVuwg4daK7CnCeY7YnIc3S2JAp9mOMbnexRFZVvR5m8
pDQRGS/wzE2zzFrJ8A1Rlcg+7X3tpAgHVtkygxN+K44OU1Xz5K68ALBXgdqMPQ/M
c3RyE9k5wZll2hzjPgA5FEsJZUlo/8UmIEGZftX5Nw1OYujb/+0rSH6Hd41qxuDf
A17+UDvhE2D1Xte2qOxZPKcMWacNtje1F6nP9hrZ/cnH5lqytf4=
=cEtM
-----END PGP SIGNATURE-----

--Sig_/sGcdEYlkEUDEIT=XBfrZYPD--


