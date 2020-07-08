Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D90C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531DB206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTmy8T7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531DB206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIOQ-0003Ch-Fw
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHpS-0004QX-7M
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:42:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHpQ-0003uD-FH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FBLEBVgGKoBHephmOo8gKgAtaSyG+1TqE/46835xKwM=;
 b=QTmy8T7rtDpy4hhbvaJTg78Z9FqWVWkkHAUfdWTF3D5NfVLnNhMrs9gXOejgvFRqq3CNLi
 MfW6Q2A78AQlvSEVFaMVUJ4B8ImAcOqms1Zoriwke8hXVZ+RVVh+4f/U/8Ury/tC25RjLk
 vn8OPuILOt6JkdAb+dlrlCQOiGY4na8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-2goVDd94NEq5DW7_fkkoQw-1; Wed, 08 Jul 2020 08:38:59 -0400
X-MC-Unique: 2goVDd94NEq5DW7_fkkoQw-1
Received: by mail-wm1-f72.google.com with SMTP id g138so2787912wme.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 05:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=Q9rCli72g6ZPAOI2O7D7tQG+C/FYFLWgNl+4re9HeQs=;
 b=M2dD7zupXoN3ItJ/2oCngRVheVVMfrDRX+U/cHA5amM/mVz2FS/kX1CWd9kGdlP+av
 93QdUqpwIf5gSiCIV3zPC7AZuIhLrrdQe1fYhtQJkmx4Z9F7hQ+eHXaGm1YvtZxDsiV3
 oezKPw1V9D4YBHnr4xf5v9DFTK3x0xu+4udp/tfMGi+pe65/6M2c0ki9Utdx9REmL+jB
 K5yeHhpc5XKmCCla2TmShigX2eImWolyhN7OwTVI46D2hIg4Lk02sW8fM8OaPzvffbI6
 NdGtUqrA8FdkEAZQ+diM81kL4D23rCku/2GlBKy+p2tR+3eQ1EqOrv4sYcnCA+AII/Gi
 AWFg==
X-Gm-Message-State: AOAM531kelFD7EOlOJ+qNPHN2M/oKxVeArdYeY4CAkt2mGjCRhGEfXbN
 UF2PPiPkMRPCGV37Aoh6kzMcPNwfOz7KtLKheQRcDjo9mjlsu2KoKVfDGE6UztG8JyIX6sGhVNg
 inQay0wcNWSeBqzE=
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr55693718wrp.45.1594211938446; 
 Wed, 08 Jul 2020 05:38:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1VCjp0Vzk8b59MVuCEOs6rhFj7cAY6nQriELO2ERjaCICYHDjcecuqlxXxRfzTIdu8gU6Gw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr55693701wrp.45.1594211938233; 
 Wed, 08 Jul 2020 05:38:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id q3sm5656904wmq.22.2020.07.08.05.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 05:38:57 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyIDMvM10gc2NzaS1kaXNrOiBBZGQg?=
 =?UTF-8?Q?support_for_the_GET_LBA_STATUS_16_command?=
To: Stefan Hajnoczi <stefanha@redhat.com>, Lin Ma <LMa@suse.com>
References: <20200617103018.18026-1-lma@suse.com>
 <20200617103018.18026-4-lma@suse.com>
 <20200622121403.GB13543@stefanha-x1.localdomain>
 <AM6PR04MB57824A3955C649E2CEBCBFB7C56E0@AM6PR04MB5782.eurprd04.prod.outlook.com>
 <20200708122925.GF459887@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <134f2a0d-98ba-5a9a-3d8b-b0efeb8cd582@redhat.com>
Date: Wed, 8 Jul 2020 14:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708122925.GF459887@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a8AakT9C9dAotL5v7hzwymZ1t5lfKUpeC"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "'fam@euphon.net'" <fam@euphon.net>,
 "'kwolf@redhat.com'" <kwolf@redhat.com>,
 "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>,
 "'mreitz@redhat.com'" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a8AakT9C9dAotL5v7hzwymZ1t5lfKUpeC
Content-Type: multipart/mixed; boundary="gDv18CkCrkKkOACpUyHwO2cxwttxIGhG1"

--gDv18CkCrkKkOACpUyHwO2cxwttxIGhG1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/07/20 14:29, Stefan Hajnoczi wrote:
> Something similar is needed for GET_LBA_STATUS. Since there is no
> bdrv_aio_block_status() you can create a coroutine instead of an aiocb:
>=20
>   static void coroutine_fn scsi_co_block_status(void *opaque)
>   {
>       int ret;
>=20
>       aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
>=20
>       ret =3D bdrv_co_block_status(...);
>=20
>       ...fill in outbuf...
>=20
>       scsi_req_complete(&r->req, GOOD);
>=20
>       aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
>=20
>       scsi_req_unref(&r->req);
>   }
>=20
>   ...in scsi_disk_emulate_command()...
>   scsi_req_ref(&r->req);
>   co =3D qemu_coroutine_create(scsi_co_block_status, r);
>   aio_co_schedule(blk_get_aio_context(s->qdev.conf.blk), co);
>   return 0;
>=20
> This is just a sketch, I haven't checked the details. The trickiest
> issue is probably how to deal with r->req.aiocb, which is normally set
> for async requests. It will be necessary to study the code to figure out
> a solution because there is no BlockAIOCB in this case (we're using a
> coroutine instead).

It's probably simplest to put the code above in block/block-backend.c,
in the form of blk_aio_block_status which would follow what is done in
blk_aio_prwv.

Paolo


--gDv18CkCrkKkOACpUyHwO2cxwttxIGhG1--

--a8AakT9C9dAotL5v7hzwymZ1t5lfKUpeC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl8FvmAACgkQv/vSX3jH
roPv/gf/QKoD+1PPHQ49XmgA2eNyNgtk06kNikKF/rI6MkNMfWlUUSYcZ4K7sV1f
hX81e3KA4qMqAf4xMN6EmzKxHPFLn3Ct54wBhUSLE/VbTqcxg8rw4YyXMIwfp/Z4
4DQxJ6IkaPstgAPaA9x64IDHygu0GvtOU17b/shD0XKTKV5PiqX55ONaqzrtkwiH
SQ45qNWLy4qO/r1jKQ6KpqPpd8ukh9Sa/bC04SE9cd6nbe5PnL0pd/+mlNpCN2Y4
J6BEqwTGE5SQIg0CFDyPZ+TOKe4yFMzP0r4lcWxeBqBs+EdvmveNPeGWrFhA9AZy
NBx6jJ80v8oNJWrq1wSJ0yus8F37dw==
=aPZM
-----END PGP SIGNATURE-----

--a8AakT9C9dAotL5v7hzwymZ1t5lfKUpeC--


