Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8867FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51682206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTJFkm0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51682206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVMc-0000Ek-Fa
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXVKv-0007Ge-T3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXVKu-00083M-2i
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:08:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXVKt-000839-VT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574276899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mjuiNtqydGvaKIREMD9wsPDNdVzHY4BnklXHOQQxvw=;
 b=VTJFkm0lLhz/CHD+Oolu47dCIS6X+fBnW3Lm77UpNmXabbW9m2bev6p1TtSgvP3VTEOTFr
 j9meL7N/uXa31ceDd/E2IuRpGr6PCbc8hxMZxKIqxoQE+VsObZmCva9EvbgvAJpbBoAOu/
 6quTYZACfGCfILcPo7gCiJSHBLnCynU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-4uzE4Vz2PsW9efyEUr2uCg-1; Wed, 20 Nov 2019 14:08:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D507100550E;
 Wed, 20 Nov 2019 19:08:14 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC61110493BD;
 Wed, 20 Nov 2019 19:08:13 +0000 (UTC)
Subject: Re: [PATCH 1/6] qapi: Tweak "command returns a nice type" check for
 clarity
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191120182551.23795-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e3f3ec9d-d95d-831a-90b4-05f79d1b3ff9@redhat.com>
Date: Wed, 20 Nov 2019 13:08:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120182551.23795-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4uzE4Vz2PsW9efyEUr2uCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: mdroth@linux.vnet.ibm.com, kwolf@pond.sub.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 12:25 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/schema.py | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index cf0045f34e..cfb574c85d 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -711,10 +711,11 @@ class QAPISchemaCommand(QAPISchemaEntity):
>               self.ret_type =3D schema.resolve_type(
>                   self._ret_type_name, self.info, "command's 'returns'")
>               if self.name not in self.info.pragma.returns_whitelist:
> -                if not (isinstance(self.ret_type, QAPISchemaObjectType)
> -                        or (isinstance(self.ret_type, QAPISchemaArrayTyp=
e)
> -                            and isinstance(self.ret_type.element_type,
> -                                           QAPISchemaObjectType))):
> +                typ =3D self.ret_type
> +                if isinstance(typ, QAPISchemaArrayType):
> +                    typ =3D self.ret_type.element_type
> +                    assert typ
> +                if not isinstance(typ, QAPISchemaObjectType):
>                       raise QAPISemError(
>                           self.info,
>                           "command's 'returns' cannot take %s"
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


