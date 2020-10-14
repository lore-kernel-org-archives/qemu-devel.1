Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7CCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C772173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNVtPZ9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C772173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSk0z-0007hN-Kg
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjla-0004SZ-LE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSjlX-0005l1-8R
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602693395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5e/jt0kLRZivZIlgzPUDj7tiFcw7yAgrGC3dJngtudQ=;
 b=FNVtPZ9rhbGZVr42BVtBpxUEmQoC4z6hnSJU6tn5E7fBYZnkf62/ezu6w0/wkiG7mSJ+dd
 M+r+50rPopzJRwC0W0NQ7FULbB/xs94CKG8G8fVgcq2PX+orCo5LsSQ52GN5HybikRxE7I
 UVccED7FX++6xPyHwqe2t5HTGByq+ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-LMLj6m_FPSu4h7E9T0j7Yg-1; Wed, 14 Oct 2020 12:36:32 -0400
X-MC-Unique: LMLj6m_FPSu4h7E9T0j7Yg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5748C805F07;
 Wed, 14 Oct 2020 16:36:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F2225578D;
 Wed, 14 Oct 2020 16:36:22 +0000 (UTC)
Subject: Re: [PATCH v11 04/13] copy-on-read: pass overlay base node name to
 COR driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
 <89965a42-cee0-a98c-f97a-a03b5d834418@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <f6b0534d-9771-9d13-2898-1f2073677107@redhat.com>
Date: Wed, 14 Oct 2020 18:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <89965a42-cee0-a98c-f97a-a03b5d834418@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gML6HNWJFvzumPyut2egZVwdfDVmhJ0pl"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gML6HNWJFvzumPyut2egZVwdfDVmhJ0pl
Content-Type: multipart/mixed; boundary="4WK4O6Bc5sNaJWZ7158uQ33wG7C93ovtn"

--4WK4O6Bc5sNaJWZ7158uQ33wG7C93ovtn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.20 18:08, Andrey Shinkevich wrote:
> On 14.10.2020 14:09, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>> We are going to use the COR-filter for a block-stream job.
>>> To limit COR operations by the base node in the backing chain during
>>> stream job, pass the name of overlay base node to the copy-on-read
>>> driver as base node itself may change due to possible concurrent jobs.
>>> The rest of the functionality will be implemented in the patch that
>>> follows.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>> =C2=A0 block/copy-on-read.c | 14 ++++++++++++++
>>> =C2=A0 1 file changed, 14 insertions(+)
>>
>> Is there a reason why you didn=E2=80=99t add this option to QAPI (as par=
t of a
>> yet-to-be-created BlockdevOptionsCor)?=C2=A0 Because I=E2=80=99d really =
like it there.
>>
>=20
> I agree that passing a base overlay under the base option looks clumsy.
> We could pass the base node name and find its overlay ourselves here in
> cor_open(). In that case, we can use the existing QAPI.

Sounds more complicated than to just split off BlockdevOptionsCor (from
BlockdevOptionsGenericFormat, like e.g. BlockdevOptionsRaw does it).

> The reason I used the existing QAPI is to make it easier for a user to
> operate with the traditional options and to keep things simple. So, the
> user shouldn't think what overlay or above-base node to pass.

Well, they don=E2=80=99t have to pass anything if they don=E2=80=99t need a=
 bottom node.
 So unless they want to use a bottom/base-overlay node, it won=E2=80=99t be=
come
more complicated.

> If we introduce the specific BlockdevOptionsCor, what other options may
> come with?

Nothing yet, I think.

>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index bcccf0f..c578b1b 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -24,19 +24,24 @@
>>> =C2=A0 #include "block/block_int.h"
>>> =C2=A0 #include "qemu/module.h"
>>> =C2=A0 #include "qapi/error.h"
>>> +#include "qapi/qmp/qerror.h"
>>> =C2=A0 #include "qapi/qmp/qdict.h"
>>> =C2=A0 #include "block/copy-on-read.h"
>>> =C2=A0 =C2=A0 =C2=A0 typedef struct BDRVStateCOR {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool active;
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay;
>>> =C2=A0 } BDRVStateCOR;
>>> =C2=A0 =C2=A0 =C2=A0 static int cor_open(BlockDriverState *bs, QDict *o=
ptions, int
>>> flags,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *base_overlay =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVStateCOR *state =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 /* We need the base overlay node rather than the ba=
se itself */
>>> +=C2=A0=C2=A0=C2=A0 const char *base_overlay_node =3D qdict_get_try_str=
(options, "base");
>>
>> Shouldn=E2=80=99t it be called base-overlay or above-base then?
>>
>=20
> The base_overlay identifier is used below as the pointer to BS. The
> base_overlay_node stands for the name of the node. I used that
> identifier to differ between the types. And the above_base has another
> meaning per block/stream.c - it can be a temporary filter with a JSON-nam=
e.

Yes, agreed; I=E2=80=99m not talking about the variable identifier though. =
 I=E2=80=99m
talking about the option name, which in this version is just =E2=80=9Cbase=
=E2=80=9D.
(And whenever that option is used, once here, once later in
block/stream.c, there is an explanatory comment why we don=E2=80=99t pass t=
he
base node through it, but the first overlay above the base.  Which makes
me believe perhaps it shouldn=E2=80=99t be called =E2=80=9Cbase=E2=80=9D.)

>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->file =3D bdrv_open_child(NULL=
, options, "file", bs,
>>> &child_of_bds,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_CHILD_FILTERED |
>>> BDRV_CHILD_PRIMARY,
>>> @@ -52,7 +57,16 @@ static int cor_open(BlockDriverState *bs, QDict
>>> *options, int flags,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((BDRV_REQ_FUA |=
 BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bs->file->bs->supported_zero_flags);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (base_overlay_node) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_del(options, "base");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_overlay =3D bdrv_looku=
p_bs(NULL, base_overlay_node, errp);
>>
>> I think this is a use-after-free.=C2=A0 The storage @base_overlay_node p=
oints
>> to belongs to a QString, which is referenced only by @options; so
>> deleting that element of @options should free that string.
>>
>> Max
>>
>=20
> I will swap those two function calls (bdrv_lookup_bs(); qdict_del();).
> Thank you.

Don=E2=80=99t forget that the error_setg() below also makes use of it:

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!base_overlay) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
or_setg(errp, QERR_BASE_NOT_FOUND, base_overlay_node);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }

Max


--4WK4O6Bc5sNaJWZ7158uQ33wG7C93ovtn--

--gML6HNWJFvzumPyut2egZVwdfDVmhJ0pl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+HKQQACgkQ9AfbAGHV
z0BW6gf+IgoWxieB0QUsh+it325/yKqdIRu+jBX+Se5HTl649z6M4lMRVv+NkZ32
sbR5CFTSXTsW44HVNG7rnje8p1zzUapc+xGlsG5tVCHAvI/MYpflKRQ+EML8WqcO
HKk/R36+7c6GMLm8fYMunL5PhtNz5U2H2GjGxkoWFhdG1suQnCml/JZFmRYiAy5j
kq6iqiMIS4Pmf4qcTjzn5Isp9JmsftrggIxg+zFLJWLrjmQQKsNOxAZoFuQTqmgf
VnrgR+gHttWq+A9KJlPstXAH1G3PfU55SNQeoDBmT9tQquc4PcHe1DEXkMkNx8xA
rsSzxvGdtj/GRQHmPpcwlBM0TShFQw==
=C0LI
-----END PGP SIGNATURE-----

--gML6HNWJFvzumPyut2egZVwdfDVmhJ0pl--


