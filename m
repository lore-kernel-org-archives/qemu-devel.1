Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2531EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 18:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E879D20578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 18:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epGHjtly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E879D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyi9-0006Il-3d
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 14:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jIyhK-0005iq-Vg
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jIyhJ-00070m-3A
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:59:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jIyhI-0006zJ-Rz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585591179;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KMJT51Vy848FO3khVgwHzQ4S2vj82zvBimdRS6J0bw=;
 b=epGHjtly4Q0IGNdakoH3+5mg42CWQYGjYRAg5I4ESfTf+QnvwGiKpLScwQLGdGetNnvaMs
 mmLXEgvrugReb3A2rr/Et+5IEw9c2nqAgjkrGcsQlJ8aN7MDxjxo6f7WRMIY4EeL/4ekuZ
 DzSJyyGMc2cFOMMoHUedeXcBmpSLDAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-1-hDkezOMNuR0ILMm9CQkw-1; Mon, 30 Mar 2020 13:59:32 -0400
X-MC-Unique: 1-hDkezOMNuR0ILMm9CQkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10D098017CE
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 17:59:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5B165DA66;
 Mon, 30 Mar 2020 17:59:27 +0000 (UTC)
Date: Mon, 30 Mar 2020 18:59:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] docs/devel/migration: start a debugging section
Message-ID: <20200330175924.GW236854@redhat.com>
References: <20200330174852.456148-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200330174852.456148-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 07:48:52PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Explain how to use analyze-migration.py, this may help.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/migration.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index e88918f7639..2eb08624fc3 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -50,6 +50,26 @@ All these migration protocols use the same infrastruct=
ure to
>  save/restore state devices.  This infrastructure is shared with the
>  savevm/loadvm functionality.
> =20
> +Debugging
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The migration stream can be analyzed thanks to `scripts/analyze_migratio=
n.py`.
> +
> +Example usage:
> +
> +.. code-block:: shell
> +
> +  $ qemu-system-x86_64
> +   (qemu) migrate "exec:cat > mig"
> +  $ ./scripts/analyze_migration.py -f mig
> +  {
> +    "ram (3)": {
> +        "section sizes": {
> +            "pc.ram": "0x0000000008000000",
> +  ...
> +
> +See also ``analyze_migration.py -h`` help for more options.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Side note: who else loves the fact that we have both spellings
of analyse - 'z' and 's' in the scripts directory. We ought to
pick one :-)

Another side note - could analyze_migration be used as the basis
for doing compatibility testing of migration support between QEMU
versions ?

eg, we can have a pair of files  "foo.argv" and "foo.migration"
containing the QEMU argv to run, and the corresponding output
expected from "analyze_migration.py" (perhaps we certain bits like
precise register values scrubbed).  On each release commit a new
pairs to git for new machine types, with various interesting argv,
and then we can validate that all future versions of QEMU produce
the same output & thus remain migration compatible ?  This feels
like this kind of approach could have caught the regression today
with the duplicated  serial device migration output sections.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


