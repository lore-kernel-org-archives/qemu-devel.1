Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F50C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55E9207CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNqTwDk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55E9207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbzV-0005Im-Vc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1jZby9-0003MU-3h
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:09:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jtomko@redhat.com>) id 1jZby8-0003g3-AE
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5WhTMCSgQetjcqmeAkk2nkZ0Rv6tw23z91aheqnL+Ao=;
 b=NNqTwDk+iGUaqY8HeYW+77iZDFeqoFVJz8Zs/iUvTgUs4aHqgMho/xr4Fwhm0UHyByKBdJ
 0gcIzB9blnSdtgYpcxOL7FtM2a3UWUPFmo57vs4gUXxeSU0vZ/SCSMJ8u6wyMQh0Anf6Sj
 fiDVse3oK/a3GVPB8Tg7zHc5epyuSNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-2VID3QzdN5OrR6GsBbzyPQ-1; Fri, 15 May 2020 11:08:35 -0400
X-MC-Unique: 2VID3QzdN5OrR6GsBbzyPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4BC080183C
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 15:08:34 +0000 (UTC)
Received: from lpt (unknown [10.40.208.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B8D75D9D7;
 Fri, 15 May 2020 15:08:27 +0000 (UTC)
Date: Fri, 15 May 2020 17:08:23 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 11/13] audio: deprecate -soundhw pcspk
Message-ID: <20200515150823.GA738369@lpt>
References: <20200515143528.13591-1-kraxel@redhat.com>
 <20200515143528.13591-12-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200515143528.13591-12-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jtomko@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Friday in 2020, Gerd Hoffmann wrote:
>Add deprecation message to the audio init function.
>
>Factor out audio initialization and call that from
>both audio init and realize, so setting audiodev via
>-global is enough to properly initialize pcspk.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> hw/audio/pcspk.c | 24 +++++++++++++++++++++---
> 1 file changed, 21 insertions(+), 3 deletions(-)
>
>@@ -236,9 +245,18 @@ static const TypeInfo pcspk_info =3D {
>     .class_init     =3D pcspk_class_initfn,
> };
>
>+static int pcspk_audio_init_soundhw(ISABus *bus)
>+{
>+    PCSpkState *s =3D pcspk_state;
>+
>+    warn_report("'-soundhw pcspk' is deprecated, "
>+                "please set a backend using '-global isa-pcspk.audiodev=
=3D<name>' instead");
>+    return pcspk_audio_init(s);

-soundhw pcspk is the only soundhw device present in libvirt git.

Is there a way to probe for this change via QMP?

Jano

>+}
>+
> static void pcspk_register(void)
> {
>     type_register_static(&pcspk_info);
>-    isa_register_soundhw("pcspk", "PC speaker", pcspk_audio_init);
>+    isa_register_soundhw("pcspk", "PC speaker", pcspk_audio_init_soundhw)=
;
> }
> type_init(pcspk_register)
>--=20
>2.18.4
>

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl6+sGQACgkQ+YPwO/Ma
t53d9AgAmCVDuH6nF9kjLgLDUH8+RKWVjwdBd+zJtLv+TAghXqM7aMceWQjRw0b3
spaq0wDYyzwoQ+rDGn48sJdxUqRz5S6BeB1Oa7/YGH1TPFO8TfUs0Vbcyy8DaxdQ
w9EChvQe0SqQuw0GNSg1eEPImfbt0jpCmZDG9fCeX9u2YqIRUE2Hbs/zqh1BIW4D
3jYjz+cfs+T7YKZNEw+nyx+Aa7wGNDdOb+6jY+b2LP0AE2wPTzztfCMsHutKhs+3
Jh6y03NVoqnHtUpyxqAWIUzZHRMe9had1+MprPxkon7G706q63cd8vus9PFzo4ge
0SSosXzLSiYUrOn5X4m6HLKr/R89Eg==
=D3fa
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


