Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AADC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C56C22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs2zPDov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C56C22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvcD-0006RL-GM
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvV4-0007y6-BI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:33:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kZvV2-0004GJ-I0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604406799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0gXt/ZbFWV9PSzArMUYxTSO8ipj8NlxHLdneFdM8iY=;
 b=Xs2zPDovqZFsrmEcEXBEdOt86e9kx8cKPShHXJwxKZIShd0Oc3WWQltvl/M2JsyTyCBRKg
 NHYjna+Ef8RTSwCeEOHkheHwXmuCuhBhwauvePwGAH865+QJP5aveLJ0EBd8Xuv5eiqp2W
 0DGCQ6ev/8RmatfUYW6JNTIWVuYzWKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-Oja1SMTmP6K9E8scsLDgyg-1; Tue, 03 Nov 2020 07:33:18 -0500
X-MC-Unique: Oja1SMTmP6K9E8scsLDgyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F10F66408A
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 12:33:16 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50C1D55763;
 Tue,  3 Nov 2020 12:33:15 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:33:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 01/20] qom: Add prefix to error message inside
 object_property_parse()
Message-ID: <20201103133313.46130994@redhat.com>
In-Reply-To: <20201030202131.796967-2-ehabkost@redhat.com>
References: <20201030202131.796967-1-ehabkost@redhat.com>
 <20201030202131.796967-2-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 16:21:12 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Make object_property_parse() automatically add a error message
> prefix mentioning the QOM type and property name when
> encountering errors.
>=20
> As we have a large number of functions that add their own
> "Property '...'" to the error messages, add a temporary check for
> existing prefixes before prepending our own.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  qom/object.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/qom/object.c b/qom/object.c
> index 20726e4584..6fb1657724 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1635,9 +1635,20 @@ int object_property_get_enum(Object *obj, const ch=
ar *name,
>  bool object_property_parse(Object *obj, const char *name,
>                             const char *string, Error **errp)
>  {
> +    ERRP_GUARD();
>      Visitor *v =3D string_input_visitor_new(string);
>      bool ok =3D object_property_set(obj, name, v, errp);
> =20
> +    if (!ok) {
> +        /*
> +         * Temporary check for existing prefix, until all error reportin=
g
> +         * functions remove their own prefix.
> +         */
> +        if (!g_str_has_prefix(error_get_pretty(*errp), "Property '")) {
> +            error_prepend(errp, "Property '%s.%s' can't take value '%s':=
 ",
> +                        object_get_typename(obj), name, string);
> +        }
> +    }
>      visit_free(v);
>      return ok;
>  }


