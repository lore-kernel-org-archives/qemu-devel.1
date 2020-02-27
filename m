Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D66FC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6B62467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVOWdwWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6B62467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55693 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7F5x-00081E-2k
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j7F50-00076V-H1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j7F4w-0000uu-LH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:03:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j7F4w-0000rW-GZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582794213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tAGT6+D5APn3RgQA4N1rYsRoQo3i1TfaRHt2AkRKnYA=;
 b=GVOWdwWmNUDbpjJe5CTU7jr3LZHQWzpwU/5exvliL9pLpcDGHx9UKav/xQCj3NV1VbJyTA
 uF0ViKD6UYuAMT/ub6SoC8dfBzRO2HQKmTZ9SQPvDI5Z2PXqn30G4iXDx6M7caJS7uKB90
 3pOCT5C1xwC7CxJCrQlhfy5rmRMa+1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-AnlwsfZqMdy71aIwSBa2uQ-1; Thu, 27 Feb 2020 04:03:31 -0500
X-MC-Unique: AnlwsfZqMdy71aIwSBa2uQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26D0B1005514;
 Thu, 27 Feb 2020 09:03:30 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F115F1001DC0;
 Thu, 27 Feb 2020 09:03:25 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:03:23 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v2 1/3] iotests: Specify explicit backing format where
 sensible
Message-ID: <20200227090323.GC2262365@lpt>
References: <20200227023928.1021959-1-eblake@redhat.com>
 <20200227023928.1021959-2-eblake@redhat.com>
 <20200227072046.GC20737@andariel.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200227072046.GC20737@andariel.pipo.sk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On a Thursday in 2020, Peter Krempa wrote:
>On Wed, Feb 26, 2020 at 20:39:26 -0600, Eric Blake wrote:
>> There are many existing qcow2 images that specify a backing file but
>> no format.  This has been the source of CVEs in the past, but has
>> become more prominent of a problem now that libvirt has switched to
>> -blockdev.  With older -drive, at least the probing was always done by
>> qemu (so the only risk of a changed format between successive boots of
>> a guest was if qemu was upgraded and probed differently).  But with
>> newer -blockdev, libvirt must specify a format; if libvirt guesses raw
>> where the image was formatted, this results in data corruption visible
>> to the guest; conversely, if libvirt guesses qcow2 where qemu was
>> using raw, this can result in potential security holes, so modern
>> libvirt instead refuses to use images without explicit backing format.
>>
>> The change in libvirt to reject images without explicit backing format
>> has pointed out that a number of tools have been far too reliant on
>> probing in the past.  It's time to set a better example in our own
>> iotests of properly setting this parameter.
>>
>> iotest calls to create, rebase, convert, and amend are all impacted to
>> some degree.  It's a bit annoying that we are inconsistent on command
>> line - while all of those accept -o backing_file=...,backing_fmt=...,
>> the shortcuts are different: create and rebase have -b and -F, convert
>> has -B but no -F, and amend has no shortcuts.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>
>[...]
>
>>  113 files changed, 414 insertions(+), 338 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
>> index 0a4b854e6520..585512bb296b 100755
>> --- a/tests/qemu-iotests/017
>> +++ b/tests/qemu-iotests/017
>> @@ -66,7 +66,7 @@ echo "Creating test image with backing file"
>>  echo
>>
>>  TEST_IMG=$TEST_IMG_SAVE
>> -_make_test_img -b "$TEST_IMG.base" 6G
>> +_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 6G
>>
>
>My understanding of the intricacies of the qemu-iotest suite is not good
>enoug to be able to review this patch. Specifically $IMGFMT in this
>instance is also used in the '-f' switch of qemu-img in _make_test_img
>and I don't know if it's expected for the backing file to share the
>format.

IMGFMT is also used for the earlier creation of the base image and
I did not see it changing in any of the tests.

Jano

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5XhdcACgkQ+YPwO/Ma
t52mLwgAuJZ9lehIowdwrECQ8BGLU4u5DDGwopTcc4/gig1lGJlyRGScN6+fb4ey
p19eHcaIMOpr3C582y9BdpzU7gmUzsZk6OGB7XsHhg59ybhXM7BaMmDIyVr079Xd
Gqljcs8qK7Ima/bu2SeyqbSehnsZG3PwcD144ZsucDMF7/GsMq3eQXEZVyfnAVny
I7w7KIflJyxTLvVYIKEvhpax2FlCrI1Zm/NiXM9RTmIwGFLCUqO0wNplEm5CezDT
Jct2HZF0DJT8tZ4wca69y93bNAKSkt4gFGuDW5Nu/IStouDBZyVbtIC6qriQFVeP
3uxU65rl7Rgg/LtNKFRq8KCWf+ydaA==
=eurf
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--


