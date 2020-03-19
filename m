Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C97C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED212072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 16:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOevhMBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED212072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jExv8-0001Jd-Tj
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 12:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1jExuO-0000ss-Od
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1jExuN-00056e-Dy
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:20:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33963)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1jExuN-00055v-9K
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584634834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qu3hW6S/HYoudYInkk/CJ6ouZXNipK3CSzwIF5mWAQ=;
 b=KOevhMBnZwpnxdnU/GRGB4e7hZHCRIA2mXyi9UfBoqFhGGvHx1N+ErwQ8InWhIxI9/OjHf
 ASHqECfNYj+Vpc/2VK3s9vr+Oj3aXvc7RAOFCscXHys/J33VRuB0YWPWlqDP9+ExbNvgZg
 bmNxEl+yIW8aslR0q4tyBk8BONZlNW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-9hp5ruJlNPyhxPK3uBTFMQ-1; Thu, 19 Mar 2020 12:20:32 -0400
X-MC-Unique: 9hp5ruJlNPyhxPK3uBTFMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56D271085988;
 Thu, 19 Mar 2020 16:19:44 +0000 (UTC)
Received: from lpt (unknown [10.40.208.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08F5F91290;
 Thu, 19 Mar 2020 16:19:39 +0000 (UTC)
Date: Thu, 19 Mar 2020 17:19:37 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/1] conf: qemu 9pfs: add 'multidevs' option
Message-ID: <20200319161937.GB2150275@lpt>
References: <E1jEFpH-00028X-1c@lizzy.crudebyte.com>
 <E1jEFpL-00028n-Qj@lizzy.crudebyte.com>
 <20200319131026.GA2150275@lpt> <1876644.SqPMx7qSmg@silver>
MIME-Version: 1.0
In-Reply-To: <1876644.SqPMx7qSmg@silver>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Thursday in 2020, Christian Schoenebeck wrote:
>On Donnerstag, 19. M=E4rz 2020 14:10:26 CET J=E1n Tomko wrote:
>> On a Tuesday in 2020, Christian Schoenebeck wrote:
>> >Introduce new 'multidevs' option for filesystem.
>> >
>> >  <filesystem type=3D'mount' accessmode=3D'mapped' multidevs=3D'remap'>
>>
>> I don't like the 'multidevs' name, but cannot think of anything
>> beter.
>>
>> 'collisions' maybe?
>
>Not sure if 'collisions' is better, e.g. collisions=3D'remap' sounds scary=
. :)
>And which collision would that be? At least IMO 'multidevs' is less ambigi=
ous.
>I have no problem though to change it to whatever name you might come up w=
ith.
>Just keep the resulting key-value pair set in mind:
>
>multidevs=3D'default'
>multidevs=3D'remap'
>multidevs=3D'forbid'
>multidevs=3D'warn'
>
>vs.
>
>collisions=3D'default'
>collisions=3D'remap' <- probably misleading what 'remap' means in this cas=
e
>collisions=3D'forbid'
>collisions=3D'warn' <- wrong, it warns about multiple devices, not about f=
ile ID
>collisions.
>
>So different key-name might also require different value-names.
>
>Another option would be the long form 'multi-devices=3D...'

Okay, let's leave it at 'multidevs'.

>
>> >    <source dir=3D'/path'/>
>> >    <target dir=3D'mount_tag'>
>> >
>> >  </filesystem>
>> >
>> >This option prevents misbheaviours on guest if a 9pfs export
>> >contains multiple devices, due to the potential file ID collisions
>> >this otherwise may cause.
>> >
>> >Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>> >---
>> >
>> > docs/formatdomain.html.in     | 47 ++++++++++++++++++++++++++++++++++-
>> > docs/schemas/domaincommon.rng | 10 ++++++++
>> > src/conf/domain_conf.c        | 30 ++++++++++++++++++++++
>> > src/conf/domain_conf.h        | 13 ++++++++++
>> > src/qemu/qemu_command.c       |  7 ++++++
>> > 5 files changed, 106 insertions(+), 1 deletion(-)
>>
>> Please split the XML changes from the qemu driver changes.
>
>Ok
>
>> Also missing:
>> * qemu_capabilities addition
>
>AFAICS the common procedure is to add new capabilities always to the end o=
f
>the enum list. So I guess I will do that as well.
>
>> * qemuDomainDeviceDefValidateFS in qemu_domain.c - check for the capabil=
ity,
>> reject this setting for virtiofs
>
>Good to know where that check is supposed to go to, thanks!
>
>> * qemuxml2xmltest addition
>> * qemuxml2argvtest addition
>
>Ok, I have to read up how those tests work. AFAICS I need to add xml files=
 to
>their data subdirs.
>
>Separate patches required for those 2 tests?

Usually xml2xmltest is in the same test as the XML parser/formatter
and xml2argvtest is a part of the qemu driver patch.

Jano

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5zm5UACgkQ+YPwO/Ma
t50mjwf+MForC0B+csloaTXRq8y4Yeqsybsl39EL/sqUfm7tSvzuDRgmgUJ3wJ4z
woJ3XMBdGIVEOORSWCp64tKIpvKQkD9torcFFzSsuLRkWNwltuYkuNmMfUNB18b1
PSnywo7ARNC0z7gNi8qEmWhsPmZXidl/q4ae7z8yCFxGkomJDrDMhoJeZRlmKbPz
7mjJlpt60IvMo/+1sh1nbDohp5kHZrgLlfht4YXskSf9rLBx8lCNLQEEsMWmUe1M
oRVWsZS9pF8q1Jvgkx+kIW7AfeTDaZ6xosTCWfSVEY/N0siVhoCWpzX5nqQ8/OOu
3d6m/fvb2wd20mo+xu3Ve37u9ncZLA==
=wrZK
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--


