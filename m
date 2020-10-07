Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE22C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E20A212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKqGV2Z9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E20A212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQHPk-0002gc-2V
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 17:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQHOi-00029J-Cc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQHOf-0003gI-8P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 17:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602107691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0i4JXe6ZJjvJFuN7KAh7UnosHSCKAB1uarh4rcPW2NQ=;
 b=WKqGV2Z9PQmwejGXYBMdofJPptn5h/9GMGnEpI6fp62ykq1gYWiwLQPkWC9dWLvGY4Eo/o
 9OkhHIyk0tVh00u9VKceY9oM86J8aY1wudnN7JyFz3+36AHIi71RcApx1wgT5boi4ixQ3w
 McPuu6QMcQCgzVfCPD6nIhkwYQ37B0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-0fslv4bPPuiVJfJRKBvnzA-1; Wed, 07 Oct 2020 17:54:48 -0400
X-MC-Unique: 0fslv4bPPuiVJfJRKBvnzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 062B318A8235;
 Wed,  7 Oct 2020 21:54:47 +0000 (UTC)
Received: from [10.3.113.66] (ovpn-113-66.phx2.redhat.com [10.3.113.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 872335D9D5;
 Wed,  7 Oct 2020 21:54:43 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] nbd: Add new qemu:allocation-depth metacontext
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-5-eblake@redhat.com>
 <1425ef36-614e-f6eb-ff41-90693d017fbb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Autocrypt: addr=eblake@redhat.com; keydata=
 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
Organization: Red Hat, Inc.
Message-ID: <f839054c-70e6-cfe5-0c44-e9a519389d65@redhat.com>
Date: Wed, 7 Oct 2020 16:54:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1425ef36-614e-f6eb-ff41-90693d017fbb@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nlI3DlPDWjcR8u0lNQ9eEgnFKmgPo22Qz"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nlI3DlPDWjcR8u0lNQ9eEgnFKmgPo22Qz
Content-Type: multipart/mixed; boundary="ZEMesiaB4Ptze6UZ08vXfhSjqhg8vr3Kb";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pkrempa@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <f839054c-70e6-cfe5-0c44-e9a519389d65@redhat.com>
Subject: Re: [PATCH v2 4/5] nbd: Add new qemu:allocation-depth metacontext
References: <20200930121105.667049-1-eblake@redhat.com>
 <20200930121105.667049-5-eblake@redhat.com>
 <1425ef36-614e-f6eb-ff41-90693d017fbb@virtuozzo.com>
In-Reply-To: <1425ef36-614e-f6eb-ff41-90693d017fbb@virtuozzo.com>

--ZEMesiaB4Ptze6UZ08vXfhSjqhg8vr3Kb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/7/20 8:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> 30.09.2020 15:11, Eric Blake wrote:
>> 'qemu-img map' provides a way to determine which extents of an image
>> come from the top layer vs. inherited from a backing chain.=C2=A0 This i=
s
>> useful information worth exposing over NBD.=C2=A0 There is a proposal to
>> add a QMP command block-dirty-bitmap-populate which can create a dirty
>> bitmap that reflects allocation information, at which point
>> qemu:dirty-bitmap:NAME can expose that information via the creation of
>> a temporary bitmap, but we can shorten the effort by adding a new
>> qemu:allocation-depth context that does the same thing without an
>> intermediate bitmap (this patch does not eliminate the need for that
>> proposal, as it will have other uses as well).
>>
>> For this patch, I just encoded a tri-state value (unallocated, from
>> this layer, from any of the backing layers); an obvious extension
>> would be to provide the actual depth in bits 31-4 while keeping bits
>> 1-0 as a tri-state (leaving bits 3-2 unused, for ease of reading depth
>> from a hex number).=C2=A0 But this extension would require
>> bdrv_is_allocated_above to return a depth number.
>>
>> Note that this patch does not actually enable any way to request a
>> server to enable this context; that will come in the next patch.
>>

>> +In the allocation depth context, bits 0 and 1 form a tri-state value:
>> +
>> +=C2=A0=C2=A0=C2=A0 bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the e=
xtent is
>> unallocated
>> +=C2=A0=C2=A0=C2=A0 bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allo=
cated in this
>> image
>=20
> Maybe, s/this/the top level/, as, what is "this" for NBD client?

Sure.


>> @@ -864,12 +867,21 @@ static bool nbd_meta_qemu_query(NBDClient
>> *client, NBDExportMetaContexts *meta,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!*query) {

We get here for "qemu:".

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->opt =
=3D=3D NBD_OPT_LIST_META_CONTEXT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta=
->allocation_depth =3D meta->exp->alloc_context;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 meta->bitmap =3D !!meta->exp->export_bitmap;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotia=
te_meta_query_parse("empty");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 if (nbd_strshift(&query, "allocation-depth")) {

We get here for "qemu:allocation-depth", and as you pointed out,
"qemu:allocation-depth-extended".

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_parse("allocation-depth");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nbd_meta_empty_or_patter=
n(client, "", query)) {
>=20
> How much it differs from "if (!*query) {", I don't see...

The nbd_meta_empty_or_pattern returns false for
"qemu:allocation-depth-extended"; it only returns true for
"qemu:allocation-depth".  But, as you pointed out,

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta=
->allocation_depth =3D meta->exp->alloc_context;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0 }
>=20
> why not just
>=20
> =C2=A0if (!strcmp(query, "allocation-depth")) {
> =C2=A0=C2=A0=C2=A0 meta->allocation_depth =3D meta->exp->alloc_context;
> =C2=A0=C2=A0=C2=A0 return true;
> =C2=A0}
>=20
> ?

that does seem shorter.

>=20
> With your code you also parse something like
> "allocation-depth-extended".. Is it on purpose?

The string is parsed, but does not affect meta->XXX, which means nothing
gets advertised to the client.  The trace messages might differ, but
behavior is correct.

>=20
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nbd_strshift(&query, "dirty-bitmap:")=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotia=
te_meta_query_parse("dirty-bitmap:");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!meta->exp->e=
xport_bitmap) {
>=20
>=20
> Also, "trace_nbd_negotiate_meta_query_skip("not dirty-bitmap"); " at
> function end should
> now be something like trace_nbd_negotiate_meta_query_skip("unknown
> context in qemu: namespace");

Good idea.


>> +/* Get allocation depth from the exported device and send it to the
>> client */
>> +static int nbd_co_send_block_alloc(NBDClient *client, uint64_t handle,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverSta=
te *bs, uint64_t
>> offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t lengt=
h, bool dont_fragment,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool last, uin=
t32_t context_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 unsigned int nb_extents =3D dont_fragment ? 1 :
>> NBD_MAX_BLOCK_STATUS_EXTENTS;
>> +=C2=A0=C2=A0=C2=A0 g_autoptr(NBDExtentArray) ea =3D nbd_extent_array_ne=
w(nb_extents);
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D blockalloc_to_extents(bs, offset, length, ea=
);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_co_send_structure=
d_error(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 client, handle, -ret, "can't get block status", errp)=
;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return nbd_co_send_extents(client, handle, ea, last,=
 context_id,
>> errp);
>> +}
>=20
>=20
> The function is a copy of nbd_co_send_block_status()..
>=20
> Probably, we can reuse nbd_co_send_block_status(), and just call
> blockstatus_to_extents()
> or blockalloc_to_extents() depending on context_id parameter.

Nice idea to reduce the duplication.

>=20
> Still, I'm OK with it as is.
>=20

So is that Reviewed-by:, or do I need to post v3 with my tweaks in
response to your comments?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ZEMesiaB4Ptze6UZ08vXfhSjqhg8vr3Kb--

--nlI3DlPDWjcR8u0lNQ9eEgnFKmgPo22Qz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl9+OSIACgkQp6FrSiUn
Q2pfFgf+N8yeRqeSDfGEfannrEtKOqo8Uew2poBVC1OpyqnTEBA/mMERyaxCTjJZ
sldrF9hCKhGtnbKL914dShGjZiy0HD5gdJzuk/1tDaOx7yYDIhe5w1vA6Ha2Cn1A
24QWmAr0HXDGOF+d/1JHWw+Ta5t9XBM8QFbP7rBu4oiGZQ15XsRL/Nu8/whubaF9
6i0nWezGvOqHpIlV9c1B6VriABnnj9TRWrFXdJwVquvPTowpKWv/GiQRSXzP3dAh
o8sIX/e4g5Z5SkicxA2+75nwpe+mKrLuaoIRakA6F7anFX+rWPHp02/ZA70oG1JT
sLRRqUjCgUDR0p5IHEPYPTNtBkFnyQ==
=YOi9
-----END PGP SIGNATURE-----

--nlI3DlPDWjcR8u0lNQ9eEgnFKmgPo22Qz--


