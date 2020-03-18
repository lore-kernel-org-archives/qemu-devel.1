Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D61AC5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B6120770
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ9hmOTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B6120770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWRt-0001Y4-Bd
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jEWR3-00016h-Cm
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jEWR1-00015d-Rq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:00:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jEWR1-0000yi-NT
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584529226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XYb3HI7zD6mZDL1h2ysEyurazsxOSWJDpj4aaHSNrc=;
 b=HQ9hmOTNRdW1XYmXNFbxGBfDXnkvn+54ny/qqLkbIDJSurC6oWHVvnLEhrlWXmm5kgMfrO
 0mPx7aRkJxc0l3R37ktBFy6CpclMm9yA0WQ3GUSznJDxDTr82m1+oALM0i1j2ZBP5RMt6/
 JAz1Yo2LNnlbVBbdBT27Nym8D/5k+Ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-2jF2fm-vOymVg2Z2eR73hg-1; Wed, 18 Mar 2020 07:00:24 -0400
X-MC-Unique: 2jF2fm-vOymVg2Z2eR73hg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC633800D53;
 Wed, 18 Mar 2020 11:00:23 +0000 (UTC)
Received: from work-vm (ovpn-115-3.ams2.redhat.com [10.36.115.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6550C5D9E2;
 Wed, 18 Mar 2020 11:00:19 +0000 (UTC)
Date: Wed, 18 Mar 2020 11:00:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 6/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC
 macro
Message-ID: <20200318110011.GG2850@work-vm>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-7-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200318091525.27044-7-yuri.benditovich@daynix.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: yan@daynix.com, jasowang@redhat.com, quintela@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yuri Benditovich (yuri.benditovich@daynix.com) wrote:
> Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is
> 16-bit field.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/migration/vmstate.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 30667631bc..baaefb6b9b 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -432,6 +432,16 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
>  }
> =20
> +#define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version=
, _info, _type) {\
> +    .name       =3D (stringify(_field)),                               \
> +    .version_id =3D (_version),                                        \
> +    .num_offset =3D vmstate_offset_value(_state, _field_num, uint16_t),\
> +    .info       =3D &(_info),                                          \
> +    .size       =3D sizeof(_type),                                     \
> +    .flags      =3D VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
> +    .offset     =3D vmstate_offset_pointer(_state, _field, _type),     \
> +}
> +

Once you agree attribution with mst,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _versio=
n, _info, _type) {\
>      .name       =3D (stringify(_field)),                               \
>      .version_id =3D (_version),                                        \
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


