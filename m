Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335BBC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 21:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E707820661
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 21:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO7LEqUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E707820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW52o-0005wn-1M
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 17:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW51p-0005Mc-7X
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:23:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jW51n-0002Qn-Dc
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588713778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjEwP3bdEXjzHmlAKr8oHB3g0cn++Whr50HiO26/XNE=;
 b=EO7LEqUG7lJnTddftjPz2uCA4j/GjjZbDlwJOGX60eV9PKgcFzlFdk6cCV5/8IimiZBGqt
 aRoP5vPhaWn9wjneCQ16sFlVhewfb7RfB4oJ1QoP+y1nJ/F1zl3JxaTi6D1ZpsVvB09UQX
 G5Ta1Z0Jy+9SU/5YWsoz93P3j1O3Dxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-ebFEjIkeOpeMBnYX7rbReQ-1; Tue, 05 May 2020 17:22:56 -0400
X-MC-Unique: ebFEjIkeOpeMBnYX7rbReQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64F0D100960F;
 Tue,  5 May 2020 21:22:55 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5E7B1000232;
 Tue,  5 May 2020 21:22:54 +0000 (UTC)
Subject: Re: [PATCH v2 6/6] iotests: Add test 291 to for qemu-img bitmap
 coverage
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-7-eblake@redhat.com>
 <7fb923a4-0ea8-c29b-2b05-86c4336c1286@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1b6cb574-a15b-e79d-53d5-1d8ea90e0d96@redhat.com>
Date: Tue, 5 May 2020 16:22:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7fb923a4-0ea8-c29b-2b05-86c4336c1286@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 15:23:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 8:05 AM, Max Reitz wrote:
> On 21.04.20 23:20, Eric Blake wrote:
>> Add a new test covering the 'qemu-img bitmap' subcommand, as well as
>> 'qemu-img convert --bitmaps', both added in recent patches.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>

>> +echo
>> +echo "=3D=3D=3D Bitmap preservation not possible to non-qcow2 =3D=3D=3D=
"
>> +echo
>> +
>> +mv "$TEST_IMG" "$TEST_IMG.orig"
>=20
> =E2=80=9Cmv=E2=80=9D doesn=E2=80=99t work images with external data files=
.
>=20
> (ORIG_IMG=3D$TEST_IMG; TEST_IMG=3D"$TEST_IMG".orig should work)

Good idea.

>=20
>> +$QEMU_IMG convert --bitmaps -O raw "$TEST_IMG.orig" "$TEST_IMG"
>> +
>> +echo
>> +echo "=3D=3D=3D Convert with bitmap preservation =3D=3D=3D"
>> +echo
>> +
>> +# Only bitmaps from the active layer are copied
>=20
> That=E2=80=99s kind of obvious when you think about (whenever an image is
> attached to a VM, only the active layer=E2=80=99s bitmaps are visible, no=
t those
> from the backing chain), but maybe this should be noted in the
> documentation?

As part of integrating bitmaps with external snapshots, libvirt actually=20
depends on being able to see bitmaps from the backing chain - but as=20
bitmaps are always referenced as a 'node name, bitmap name' tuple, this=20
is indeed doable.

>=20
>> +$QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG.orig" "$TEST_IMG"
>> +$QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
>> +# But we can also merge in bitmaps from other layers
>> +$QEMU_IMG bitmap --add --disabled -f $IMGFMT "$TEST_IMG" b0
>> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" tmp
>> +$QEMU_IMG bitmap --merge b0 -b "$TEST_IMG.base" -F $IMGFMT "$TEST_IMG" =
tmp
>> +$QEMU_IMG bitmap --merge tmp "$TEST_IMG" b0
>> +$QEMU_IMG bitmap --remove -f $IMGFMT "$TEST_IMG" tmp
>=20
> Why do we need tmp here?  Can=E2=80=99t we just merge base=E2=80=99s b0 d=
irectly into
> $TEST_IMG=E2=80=99s b0?

Yes, we could.  But then I wouldn't cover as many bitmap subcommands.=20
Adding a comment about why the example is contrived (for maximal=20
coverage) is a good idea.


>> +=3D=3D=3D Check bitmap contents =3D=3D=3D
>> +
>> +[{ "start": 0, "length": 3145728, "depth": 0, "zero": false, "data": tr=
ue, "offset": OFFSET},
>> +{ "start": 3145728, "length": 1048576, "depth": 0, "zero": false, "data=
": false},
>> +{ "start": 4194304, "length": 6291456, "depth": 0, "zero": false, "data=
": true, "offset": OFFSET}]
>> +[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": tr=
ue, "offset": OFFSET},
>> +{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false, "data=
": false},
>> +{ "start": 2097152, "length": 8388608, "depth": 0, "zero": false, "data=
": true, "offset": OFFSET}]
>> +[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": tr=
ue, "offset": OFFSET},
>> +{ "start": 2097152, "length": 1048576, "depth": 0, "zero": false, "data=
": false},
>> +{ "start": 3145728, "length": 7340032, "depth": 0, "zero": false, "data=
": true, "offset": OFFSET}]
>=20
> Am I looking at this wrong or does the bitmap data seem to be inverted?
>   Everywhere where I=E2=80=99d expect the bitmaps to be cleared, this map=
 reports
> data=3Dtrue, whereas where I=E2=80=99d expect them to be set, it reports =
data=3Dfalse.
>=20
> I suppose that=E2=80=99s intentional, but can you explain this behavior t=
o me?

This is an artifact of how x-dirty-bitmap works (it has the x- prefix=20
because it is a hack, but we don't have anything better for reading out=20
bitmap contents).  The NBD spec returns block status as a 32-bit value=20
for a 'metadata context'; normally, we use context 'base:allocation'=20
context where bit 0 is set for holes or clear for allocated, and bit 1=20
is set for reads-as-zero or clear for unknown contents (favoring all-0=20
as the most-common case).  But with x-dirty-bitmap, we are instead=20
abusing NBD to query the 'qemu:dirty-bitmap:FOO' context, where bit 0 is=20
set for anywhere the bitmap has a 1, yet feed that information into the=20
pre-existing qemu code for handling block status.  So qemu-img map is=20
reporting "data":true for what it thinks is the normal 0-for-allocated,=20
and "data":false for 1-for-sparse, and we just have to translate that=20
back into an understanding of what the bitmap reported.  Yes, a comment=20
would be helpful.

I would _really_ love to enhance 'qemu-img map' to output image-specific=20
metadata _in addition_ to the existing "zero" and "data" fields (by=20
having qemu-img read two NBD contexts at once: both base:allocation and=20
qemu:dirty-bitmap:FOO), at which point we can drop the x- prefix and=20
avoid the abuse of qemu's internals by overwriting the block_status=20
code.  But that's a bigger project.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


