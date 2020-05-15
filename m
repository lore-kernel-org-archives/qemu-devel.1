Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB8B2065C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlnHj2IA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB8B2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXCA-00033H-LX
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jZXB1-0002AF-Dz
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:02:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jZXB0-0006xb-M3
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589536965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhB5rU2yYfbAQtLiTAc/XbKUc7Cvw2G8m9y4Or2c6U8=;
 b=MlnHj2IAdsgLymCa6bQmc3r/JNrjI3/0lijoh2+EDKvjUzJl80dQqjCcEl/mq0crSiqlmT
 BXaaqHFW3aCbIRs327hWC8uD3oWVmqI5C79TeZ0xK7XFkNEwc61Cxksb75J7oy3ISncPPO
 bxfZGsa9arNMtqVoftZ1BzhtByTn+I4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-KLCkQBnZOXGvFYt4S3Tn4g-1; Fri, 15 May 2020 06:02:43 -0400
X-MC-Unique: KLCkQBnZOXGvFYt4S3Tn4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C71B107ACF6
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:02:42 +0000 (UTC)
Received: from localhost (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF1292E05F;
 Fri, 15 May 2020 10:02:41 +0000 (UTC)
Date: Fri, 15 May 2020 11:02:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] trace/simple: Fix unauthorized enable
Message-ID: <20200515100240.GC355503@stefanha-x1.localdomain>
References: <20200515070021.20811-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200515070021.20811-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 09:00:21AM +0200, Markus Armbruster wrote:
> diff --git a/trace/simple.c b/trace/simple.c
> index fc7106ec49..906391538f 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -302,10 +302,10 @@ static int st_write_event_mapping(void)
>      return 0;
>  }
> =20
> -void st_set_trace_file_enabled(bool enable)
> +bool st_set_trace_file_enabled(bool enable)
>  {
>      if (enable =3D=3D !!trace_fp) {
> -        return; /* no change */
> +        return enable;          /* no change */
>      }
> =20
>      /* Halt trace writeout */
> @@ -323,14 +323,14 @@ void st_set_trace_file_enabled(bool enable)
> =20
>          trace_fp =3D fopen(trace_file_name, "wb");
>          if (!trace_fp) {
> -            return;
> +            return !enable;
>          }
> =20
>          if (fwrite(&header, sizeof header, 1, trace_fp) !=3D 1 ||
>              st_write_event_mapping() < 0) {
>              fclose(trace_fp);
>              trace_fp =3D NULL;
> -            return;
> +            return !enable;
>          }
> =20
>          /* Resume trace writeout */
> @@ -340,6 +340,7 @@ void st_set_trace_file_enabled(bool enable)
>          fclose(trace_fp);
>          trace_fp =3D NULL;
>      }
> +    return !enable;
>  }

The meaning of the return value confuses me. Is it the previous value
(even when the function fails)?  Please document the meaning.

The code might be easier to understand like this:

  bool st_set_trace_file_enabled(bool enable)
  {
      bool was_enabled =3D trace_fp;

      if (enable =3D=3D was_enabled) {
          return was_enabled;      /* no change */
      }

      ...

      return was_enabled;
  }

Now it is not necessary to remember that !enable is the previous value
because we would have already returned if the value was unchanged.

Stefan

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6+aMAACgkQnKSrs4Gr
c8hQvgf+OL/aKSyyxdnfbU+1VaP65BJ2/aeBWgd6tk721bp/E1vVhCO8hNzD5jdJ
pahi6zeD+LZb2SK7N18nVWenuxrDXTXxoIKNTgLrxsekCA/nC9m78dHvqKiLR7Db
s3mGS4tpgZM/1fF80j/+cz1rsSmwf9Do6+qwOuwAZiDd7j0xs8EHqgAf9ws7MVrl
rcXQIuwlCKjO0lTtsoyZPwqsZ7/EFgHUNLSpYnl+DUbxyrri7B5mOjtkVldGPc7H
PCOM1ScfpPXKV571MIZA6YS+rrXlYfPqCXdHEuobey6fm8s/jfE87gSptTtgwJ7u
zA7zfwznBKVHvfkIrXHvqiG5a4ipWw==
=ajdW
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--


