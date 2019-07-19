Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05493C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C838320873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FknPawL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C838320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPxv-0001Kj-UG
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50131)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hoPxi-0000vP-96
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:18:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hoPxh-0005N7-6K
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:18:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hoPxg-0005MQ-R3; Fri, 19 Jul 2019 06:18:01 -0400
Received: by mail-wr1-x429.google.com with SMTP id x1so16710361wrr.9;
 Fri, 19 Jul 2019 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3lRiD31d29uPAV0gYtO208/DdcFup1VMFsYcMzfmML8=;
 b=FknPawL/1yvGwIbaUWw/H2Q5iN7QUfl4i+jJ3I9Sc+ghm+JF5Y4C3mixZn0kazs3Ui
 C6opEpON01VnXfJxPob78wLLsy5gIT138YPX2YiqSurF0AbE54SK2/rYdjZgq5kdh1UH
 NX017db6BBMIzhYVsXtByWoK4rFpOpA9vKqSZ6Zzxf+4zjw/2q15w78sbMIu49Hmmq8+
 6dN/WjXhf/ite3Wch+fZHXuQR7fFLeqK5nEdlzrmYnyqo/1wXuC/TT45W2F7eak685ts
 eHizHwsn6kxvOy/ieucmE1FJkcCNwgTzRIOQm6EziFSm9yG7MIJbVMlZS8Zce6qTGGwd
 Eoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3lRiD31d29uPAV0gYtO208/DdcFup1VMFsYcMzfmML8=;
 b=eT0goRewfHWcnf6VfbBHQ+9CT0I8TEYwUQoKoVAlmXPLymhi/Rsa3ewphUhVieK8BV
 eIummHrUEAlOjKEgtv3l8zs/eaP6Glc1T6cbA+DJQc4HalRwcH7kIZsDTH7QYb4Ldkkk
 dtmyB2dkYKHguN1TS/sWnKAmoRZheXbwlAzQv+TL9BFyMZzvAs2dnk4hKakVA8z/Qtl+
 rt+S+X0W/6sUDozpYJt+2RD6zz1CmvNptfjSAFRpXIG+CyQWPmwCJfNHEsxKIYlPyMYC
 rFT1DkM7R4HeDOsJ0b1mS0IyQshhhHhFnv4FQ8DPPKaUrmmm/Sot1+ffVCRoTU2nahhU
 l6zQ==
X-Gm-Message-State: APjAAAU7MP7UEL/fYdGV/lRwInCgEXS+zsIXXopsM7M6OQaBTNMZfdkn
 sf3/3CoPyBW9jihTNnEcGvQ=
X-Google-Smtp-Source: APXvYqyUwl0qo3BMyeZR7kpbwDHxOMdYi5KKtmDJzwqPuNfny6/mnCxrYq1rz9D0AOxDFmc1EA9GSw==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr58299189wrj.283.1563531479551; 
 Fri, 19 Jul 2019 03:17:59 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b203sm34179067wmd.41.2019.07.19.03.17.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 03:17:58 -0700 (PDT)
Date: Fri, 19 Jul 2019 11:17:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>
Message-ID: <20190719101757.GF18585@stefanha-x1.localdomain>
References: <8146312c-8a9c-3c4e-ab80-a3f42cc1d6ce@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <8146312c-8a9c-3c4e-ab80-a3f42cc1d6ce@yandex-team.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: Re: [Qemu-devel] BDRV request fragmentation and vitio-blk write
 submission guarantees
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
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 04:44:17PM +0300, =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D0=
=B8=D0=B9 =D0=AF=D0=BA=D0=BE=D0=B2=D0=BB=D0=B5=D0=B2 wrote:
> Hi everyone,
>=20
> We're currently working on implementing a qemu BDRV format driver which we
> are using with virtio-blk devices.
>=20
> I have a question concerning BDRV request fragmentation and virtio-blk wr=
ite
> request submission which is not entirely clear to me by only reading virt=
io
> spec. Could you please consider the following case and give some addition=
al
> guidance?
>=20
> 1. Our BDRV format driver has a notion of max supported transfer size. So=
 we
> implement BlockDriver::bdrv_refresh_limits where we fill out
> BlockLimits::max_transfer and opt_transfer fields.
>=20
> 2. virtio-blk exposes max_transfer as a virtio_blk_config::opt_io_size
> field, which (according to spec 1.1) is a **suggested** maximum. We read
> "suggested" as "guest driver may still send requests that don't fit into
> opt_io_size and we should handle those"...
>=20
> 3. ... and judging by code in block/io.c qemu block layer handles such
> requests by fragmenting them into several BDRV requests if request size i=
s >
> max_transfer
>=20
> 4. Guest will see request completion only after all fragments are handled.
> However each fragment submission path can call qemu_coroutine_yield and m=
ove
> on to submitting next request available in virtq before completely
> submitting the rest of the fragments. Which means the following situation=
 is
> possible where BDRV sees 2 write requests in virtq, both of which are lar=
ger
> than max_transfer:
>=20
> ||
>=20
> |Blocks: |-------------------------------------> Write1: xxxxxxxx Write2:
> yyyyyyyy Write1Chunk1: xxxx Write2Chunk1: yyyy Write2Chunk2: yyyy
> Write1Chunk1: xxxx Blocks: |------------yyyyxxxx----------------->|
>=20
> ||
>=20
> |In above scenario guest virtio-blk driver decided to submit 2 intersecti=
ng
> write requests, both of which are larger than ||max_transfer, and then ca=
ll
> hypervisor.|
>=20
> |I understand that virtio-blk may handle requests out of order, so guest
> must not make any assumptions on relative order in which those requests w=
ill
> be handled.|
>=20
> |However, can guest driver expect that whatever the submission order will
> be, the actual intersecting writes will be atomic?|
>=20
> |In other words, will it be correct for conforming virtio-blk driver to
> expect only "|||xxxxxxxx" or "||||yyyyyyyy" but not anything else in
> between, after both requests are reported as completed?||
>=20
> ||Because i think that is something that may happen in qemu right now, if=
 i
> understood correctly. ||

Write requests are not atomic in general.  Specific storage technologies
support atomic writes via special commands with certain restrictions but
applications using this feature aren't portable.

Portable applications either don't submit intersecting write requests or
they do not depend on atomicity.

Out of curiousity I took a quick look at Linux device-mapper.  The same
issue applies in device-mapper when intersecting write requests cross
device-mapper targets.  I think Linux submits split bios in parallel and
without serialization.

Stefan

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0xmNUACgkQnKSrs4Gr
c8iBfAf+MrNAsr5xREcbHz1WWK1XGHLp8hGV5Nu8J0J6XUl2lHw8gTmcKpnkhWHw
X6gaSzQ4ZQ2KRK1sCsn0J7UsprvybA2IUO9lLya7NLGdoSRpBoZk6juZbSWoR5jZ
twcCaSnYSf/5fod4fHF8zSsuKuj+Fz1Dxs/umUUHGSEIrWX/s5N+eju2ZvT9t6AH
/ZKv541kgoPfeq7aLyls7OcR3ExJgRSRV6p5iHmg07AsL4ttcYvAwNZDARhzVgTW
rdsqpUiqmPXBgnXGm7NYutnP7lptfsyrjjuoKCfrNU81yxDTs6BIrcgtnXwKI0x2
3TZcGXiKEQ2F4VPLLI8l/Igys5CrKQ==
=7pUu
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--

