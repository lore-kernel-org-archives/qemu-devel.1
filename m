Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF8C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0322073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhiHWfmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0322073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIya4-0000Gl-F6
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jIyYM-00065y-EP
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jIyYL-000318-BI
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:50:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jIyYL-00030u-6M
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585590624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RG/V3JYOMDkYQlsKT0w0240bFCeW3cpzFFEas6F/7Ms=;
 b=WhiHWfmcPLupKR9qFrY6CPaEmbtsc0IpCLbQkqtCH0CjxuuYk245ZgQYv89nzUtSbS1/8H
 a63nWQiXGWGyWdihhH9LrUCYxyJLF6hlkN9j38LDi1iC04wq8m5c8GkbSdcHEsW9wak6aG
 gShEi/zyi9oD0ygFxinhjbEcGRohhUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-TYuTy7iYPQW8ufhmqzoPeg-1; Mon, 30 Mar 2020 13:50:23 -0400
X-MC-Unique: TYuTy7iYPQW8ufhmqzoPeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5769518B5FBD
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 17:50:22 +0000 (UTC)
Received: from work-vm (ovpn-114-162.ams2.redhat.com [10.36.114.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D92B5C1B5;
 Mon, 30 Mar 2020 17:50:18 +0000 (UTC)
Date: Mon, 30 Mar 2020 18:50:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] docs/devel/migration: start a debugging section
Message-ID: <20200330175016.GD2843@work-vm>
References: <20200330174852.456148-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200330174852.456148-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Explain how to use analyze-migration.py, this may help.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Yes, it's quite useful for things like this; although things where
multiple instances/instance_id's are the problem can be tricikier and
some tracing can help.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
> +
>  Common infrastructure
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> --=20
> 2.26.0.rc2.42.g98cedd0233
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


