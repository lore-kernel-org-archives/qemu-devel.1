Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035B2C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34E0206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tenjy8WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34E0206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j49ux-0000VI-Vg
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j49u2-0008Du-Qg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j49u0-00077P-RD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:55:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j49u0-00074c-GN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582059331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Q+ZYE+cxtUvibcqJjja8mk3mm7opy0G92bmyXUjpxY=;
 b=Tenjy8WONEcQ5xKrwQ9jurq4a0Dhx0BNRImTp2mN7K/VepyQJciIZvMfE8Ziu2lFtbKhCm
 cG3VHT6BPwoxcs03RRt9lUkY+a0m2N9QEUpJv5gHzjjzT8WeOw+Tp7KJww/Z2BTbLL2Azf
 V6MU+CQcSIaFayVslsaP5P45Rbgq3Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-gUKhjVMVNR6N8UsgMQlcTQ-1; Tue, 18 Feb 2020 15:55:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE14FDB20;
 Tue, 18 Feb 2020 20:55:23 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 896A960BF7;
 Tue, 18 Feb 2020 20:55:19 +0000 (UTC)
Subject: Re: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
To: Max Reitz <mreitz@redhat.com>, "nbd@other.debian.org"
 <nbd@other.debian.org>, QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <1b3741aa-7841-9062-ecca-73c38e599e05@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c47d277e-35f8-9837-1f1d-eab4bb6d5840@redhat.com>
Date: Tue, 18 Feb 2020 14:55:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1b3741aa-7841-9062-ecca-73c38e599e05@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: gUKhjVMVNR6N8UsgMQlcTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, "Richard W.M. Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:13 AM, Max Reitz wrote:
> Hi,
>=20
> It=E2=80=99s my understanding that without some is_zero infrastructure fo=
r QEMU,
> it=E2=80=99s impossible to implement this flag in qemu=E2=80=99s NBD serv=
er.

You're right that we may need some more infrastructure before being able=20
to decide when to report this bit in all cases.  But for raw files, that=20
infrastructure already exists: does block_status at offset 0 and the=20
entire image as length return status that the entire file is a hole.=20
And for qcow2 files, it would not be that hard to teach a similar=20
block_status request to report the entire image as a hole based on my=20
proposed qcow2 autoclear bit tracking that the image still reads as zero.

>=20
> At the same time, I still haven=E2=80=99t understood what we need the fla=
g for.
>=20
> As far as I understood in our discussion on your qemu series, there is
> no case where anyone would need to know whether an image is zero.  All > =
practical cases involve someone having to ensure that some image is
> zero.  Knowing whether an image is zero can help with that, but that can
> be an implementation detail.
>=20
> For qcow2, the idea would be that there is some flag that remains true
> as long as the image is guaranteed to be zero.  Then we=E2=80=99d have so=
me
> bdrv_make_zero function, and qcow2=E2=80=99s implementation would use thi=
s
> information to gauge whether there=E2=80=99s something to do as all.
>=20
> For NBD, we cannot use this idea directly because to implement such a
> flag (as you=E2=80=99re describing in this mail), we=E2=80=99d need separ=
ate is_zero
> infrastructure, and that kind of makes the point of =E2=80=9Cdrivers=E2=
=80=99
> bdrv_make_zero() implementations do the right thing by themselves=E2=80=
=9D moot.

We don't necessarily need a separate is_zero infrastructure if we can=20
instead teach the existing block_status infrastructure to report that=20
the entire image reads as zero.  You're right that clients that need to=20
force an entire image to be zero won't need to directly call=20
block_status (they can just call bdrv_make_zero, and let that worry=20
about whether a block status call makes sense among its list of steps to=20
try).  But since block_status can report all-zero status for some cases,=20
it's not hard to use that for feeding the NBD bit.

However, there's a difference between qemu's block status (which is=20
already typed correctly to return a 64-bit answer, even if it may need a=20
few tweaks for clients that currently don't expect it to request more=20
than 32 bits) and NBD's block status (which can only report 32 bits=20
barring a new extension to the protocol), and where a single all-zero=20
bit at NBD_OPT_GO is just as easy of an extension as a way to report a=20
64-bit all-zero response to NBD_CMD_BLOCK_STATUS.

>=20
> OTOH, we wouldn=E2=80=99t need such a flag for the implementation, becaus=
e we
> could just send a 64-bit discard/make_zero over the whole block device
> length to the NBD server, and then the server internally does the right
> thing(TM).  AFAIU discard and write_zeroes currently have only 32 bit
> length fields, but there were plans for adding support for 64 bit
> versions anyway.  From my na=C3=AFve outsider perspective, doing that doe=
sn=E2=80=99t
> seem a more complicated protocol addition than adding some way to tell
> whether an NBD export is zero.

Adding 64-bit commands to NBD is more invasive than adding a single=20
startup status bit.  Both ideas can be done - doing one does not=20
preclude the other.  But at the same time, not all servers will=20
implement both ideas - if one is easy to implement while the other is=20
hard, it is not unlikely that qemu will still encounter NBD servers that=20
advertise startup state but not support 64-bit make_zero (even if qemu=20
as NBD server starts supporting 64-bit make zero) or even 64-bit block=20
status results.

Another thing to think about here is timing.  With the proposed NBD=20
addition, it is the server telling the client that "the image you are=20
connecting to started zero", prior to the point that the client even has=20
a chance to request "can you make the image all zero in a quick manner=20
(and if not, I'll fall back to writing zeroes as I go)".  And even if=20
NBD gains a 64-bit block status and/or make zero command, it is still=20
less network traffic for the server to advertise up-front that the image=20
is all zero than it is for the client to have to issue command requests=20
of the server (network traffic is not always the bottleneck, but it can=20
be a consideration).

>=20
> So I=E2=80=99m still wondering whether there are actually cases where we =
need to
> tell whether some image or NBD export is zero that do not involve making
> it zero if it isn=E2=80=99t.

Just because we don't think that qemu-img has such a case does not mean=20
that other NBD clients will not be able to come up with some use for=20
knowing if an image starts all zero.

>=20
> (I keep asking because it seems to me that if all we ever really want to
> do is to ensure that some images/exports are zero, we should implement
> that.)

The problem is WHERE do you implement it.  Is it more efficient to=20
implement make_zero in the NBD server (the client merely requests to=20
make zero, but lets the server do all the work) or in the NBD client=20
(the client learns whether the server is already zero, and not hearing=20
yes, the client proceeds to do all the work to write zeroes).  From the=20
qemu perspective, qemu-img convert needs the image to be zero, and=20
bdrv_make_zero will report back either "yes I quickly made it zero,=20
possibly by doing nothing" or "no, making it zero now is no more=20
efficient than you just writing zeroes as you go".  But although the=20
code in qemu-img is the same whether bdrv_make_zero is able to request=20
the work be done in the server or whether the work has to be done in the=20
client, the code in the block layer that implements bdrv_make_zero may=20
itself care about knowing whether the NBD server started all zero.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


