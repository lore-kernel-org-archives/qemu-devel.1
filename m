Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E7C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EDE2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="mfEaW4wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EDE2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0Tl-0000NE-BR
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw0Sj-0007k0-6G
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:45:57 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:45293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw0Sh-0005dh-36
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=1Ii7rqOdbrfZsPCbgQ6gaWphFHgb8aTcYJPvEXH2rgo=; b=mfEaW4wWG3L7UUMw2KiTpbpIgw
 MKG8iA7yprrwGZV1FsMR/ZMr0jpPxFOSTyi6LF2oGVYa3AKz7PUN22tspMMcVLA4y2hSAgP9SR8xo
 PxraMkTbTb3uTZQ/jRwgCcd6wGHs0gZt3ikrUdfl2D8fp92XPL/OQBUiYHXyZj+9wPT4ewYj5BtwB
 R4Z4KoisGXu/eSjXOnnH/JzNdRLOY0SF6JWNG5TU6FFOKIMoVNsZf3HKVF6seD48g0DL4FFETDbst
 yldrhPPuDI+3KaoXG2vbEKpmUq30K0B7iX+wrhDLjqURJoAzRtAqJ6G11+IEyq7wtZdK5BbLD+Kyz
 iq+tVdJaqm0WUpAoHLVKmT3VH4jC2jtorM02TsG5japSjZtg62aYR9n6QOyOJYS2IDcrU/WmjQZ+D
 ZA6edZs1AX1Mhy1VbQOt67dDiwAB3He5L1aKDIUvFSYn3Mwyg0nKq2+p8Co/MmXVPqcwKlTl8Yy8P
 xGb+enID8cHKyWpbC7N2jXOZkESEcqywdp0Su3UfEvR2mRsP1Qh8HD4+WEL/va+1PBHMbqZkLmyHq
 X4qee7roMz52jTOaFSS7ZENJN/7+aP3hWX1EZQ+uqosW/fNwN58jiOd45WsolALfzmL61sTw1ttIa
 UZD6ihIZTjSB7L49LfTYiOHrHtFOPrv8kcd4x0bV4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Date: Thu, 16 Jul 2020 11:45:50 +0200
Message-ID: <3491260.5YPxQhmjAg@silver>
In-Reply-To: <nycvar.YSQ.7.78.906.2007161428570.950384@xnncv>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200716083654.GA227735@redhat.com>
 <nycvar.YSQ.7.78.906.2007161428570.950384@xnncv>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 05:45:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. Juli 2020 11:21:55 CEST P J P wrote:
> +-- On Thu, 16 Jul 2020, Daniel P. Berrang=C3=A9 wrote --+
>=20
> | > Failing to start (with a message that explains why) if one of the
> | > command
> | > line options is not covered by a specified security policy is not
> | > unreasonable (after all, we fail to start for other cases of
> | > incompatible
> | > command line options as well.)
>=20
>   Yes, that's right.
>=20
> | > However, we also need to cover dynamically-added devices. Aborting se=
ems
> | > very bad there, just failing to add the device seems like what we'd
> | > want.
> |=20
> | Yep, aborting is simply not an option for the inner code. It all has to
> | propagate to a proper Error **errp object. The ultimate entry-point at =
the
> | CLI vs QMP then decides whether to turn the error into an abort or feed
> | back to the client app.
>=20
>   True, handling dynamic devices is tricky.
>=20
> Though it seems kind of uniform workflow to check for '--security' flag at
> options parsing OR while handling dynamic devices at run time; It is a hu=
ge
> task to cover all options/use-cases for all QEMU emulators across various
> architectures.

My concern here is that just distinguishing between either 'low' or 'high' =
is=20
a far too rough classification.

In our preceding communication regarding 9pfs, I made clear that a) we do c=
are=20
about security relevant 9pfs issues, and only b) the avarage use cases (as =
far=20
we know) for 9pfs are above a certain trust level.

However b) does not imply 9pfs being 'unsafe', nor that we want users to=20
refrain using it in a security relevant environment. So 9pfs would actually=
 be=20
somewhere in between.

Best regards,
Christian Schoenebeck



