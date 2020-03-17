Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82885C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B14020738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrS0etrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B14020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFB0-0007wY-Ch
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1jEEyb-0004dl-ND
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1jEEya-0004NX-Da
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1jEEya-00048E-8d
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584462114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orvLYlEEWJzeUpo60BebdaSdH9YGE55BT75MrtrXn7w=;
 b=XrS0etrWIhdzCcDOT0xo0Yov6t4tL7pe/YJ8UZlSH2TgYtbtAGyouyWPyPPZVGkQkrhhYR
 ry6916nULJykdBWkpZHmH1NUFPrGYLbdZZ14I/FihX9Zx0EDXFKyfzNfenw+sG6A6bhBo/
 msP5UUtQMMfni1hHrfF8tik5Cs5h7Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-EFLHFOqRNri054wBV2NsSw-1; Tue, 17 Mar 2020 12:21:52 -0400
X-MC-Unique: EFLHFOqRNri054wBV2NsSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 014FA1007274;
 Tue, 17 Mar 2020 16:21:52 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-115-127.ams2.redhat.com
 [10.36.115.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C41111001DC0;
 Tue, 17 Mar 2020 16:21:48 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 5B3273E048A; Tue, 17 Mar 2020 17:21:46 +0100 (CET)
Date: Tue, 17 Mar 2020 17:21:46 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 7/7] qemu-img: Deprecate use of -b without -F
Message-ID: <20200317162146.GB10493@paraplu>
References: <20200312192822.3739399-1-eblake@redhat.com>
 <20200312192822.3739399-8-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200312192822.3739399-8-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 02:28:22PM -0500, Eric Blake wrote:
> Creating an image that requires format probing of the backing image is
> inherently unsafe (we've had several CVEs over the years based on
> probes leaking information to the guest on a subsequent boot, although
> these days tools like libvirt are aware of the issue enough to prevent
> the worst effects).  However, if our probing algorithm ever changes,
> or if other tools like libvirt determine a different probe result than
> we do, then subsequent use of that backing file under a different
> format will present corrupted data to the guest.  Start a deprecation
> clock so that future qemu-img can refuse to create unsafe backing
> chains that would rely on probing.  The warnings are intentionally
> emitted from the block layer rather than qemu-img (thus, all paths
> into image creation or rewriting perform the check).
>=20
> However, there is one time where probing is safe: if we probe raw,
> then it is safe to record that implicitly in the image (but we still
> warn, as it's better to teach the user to supply -F always than to
> make them guess when it is safe).
>=20
> iotest 114 specifically wants to create an unsafe image for later
> amendment rather than defaulting to our new default of recording a
> probed format, so it needs an update.  While touching it, expand it to
> cover all of the various warnings enabled by this patch.  iotest 290
> also shows a change to qcow messages; note that the fact that we now
> make a probed format of 'raw' explicit now results in a double
> warning, but no one should be creating new qcow images so it is not
> worth cleaning up.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/system/deprecated.rst | 19 +++++++++++++++++++
>  block.c                    | 21 ++++++++++++++++++++-
>  qemu-img.c                 |  2 +-
>  tests/qemu-iotests/114     | 11 +++++++++++
>  tests/qemu-iotests/114.out |  8 ++++++++
>  tests/qemu-iotests/290.out |  5 ++++-
>  6 files changed, 63 insertions(+), 3 deletions(-)

[A quick question ... while I'm still testing]

I just applied your v4, and I'm here:

    $> git describe
    v4.2.0-2399-g3cba0d19f2


Expected warning on 'create' wiht no -F:

    $> ~/build/v4_tightened_qemu-img-QEMU/qemu-img create -f qcow2 -b ./bas=
e.raw ./overlay1.qcow2
    qemu-img: warning: Deprecated use of backing file without explicit back=
ing format (detected format of raw)
    Formatting './overlay1.qcow2', fmt=3Dqcow2 size=3D4294967296 backing_fi=
le=3D./base.raw backing_fmt=3Draw cluster_size=3D65536 lazy_refcounts=3Doff=
 refcount_bits=3D16

But here is the lack of warning with 'convert' expected?

    $> ~/build/v4_tightened_qemu-img-QEMU/qemu-img convert -B ./base.raw -O=
 qcow2 overlay1.qcow2 flattened.qcow2

In your response on the v3, you said the above should throw a warning;
refer to Message-ID: <2fd580c2-4b94-4430-1072-ef04bbd2da60@redhat.com>

For completeness' sake:

    $> ~/build/v4_tightened_qemu-img-QEMU/qemu-img info --backing-chain fla=
ttened.qcow2
    image: flattened.qcow2
    file format: qcow2
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 196 KiB
    cluster_size: 65536
    backing file: ./base.raw
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false
   =20
    image: ./base.raw
    file format: raw
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 778 MiB

[...]

--=20
/kashyap


