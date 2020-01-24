Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB9720709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKKfuzgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB9720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1FV-0002Fj-4W
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 10:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iv1Ej-0001MX-U3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iv1Eh-0000vr-TG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:51:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iv1Eh-0000uM-JQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 10:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579881066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gwdnt1gcinRXboHO2Lt50qdjrSmpoA2FwtwFrZMd4Rw=;
 b=YKKfuzgqKt+kkiOWjBmSPNVsD4JH6Q8bhjDJ4C0P3tSRkonOXXMAiXMKdjd45Kv6vqEUmy
 Dp5yDIanP9ETIQOy4PgyWoqiEcmrwWOFwUp2sxfx9yM9GQl0/7oBjtJZ+S4KVIbZ0aKiSl
 P7mxZGMD1wjxzJJSBQQpBAZy6fPZcLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-gdoVFH22OK-wOmVLoPORBQ-1; Fri, 24 Jan 2020 10:51:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D485133FBE;
 Fri, 24 Jan 2020 15:51:01 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 284C61001B05;
 Fri, 24 Jan 2020 15:51:00 +0000 (UTC)
Subject: Re: [Bug 1860759] Re: [REGRESSION] option `-snapshot` ignored with
 blockdev
To: Bug 1860759 <1860759@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Peter Krempa <pkrempa@redhat.com>,
 "libvirt-list@redhat.com" <libvirt-list@redhat.com>
References: <157985376657.5102.13233182944615356318.malonedeb@wampee.canonical.com>
 <157986030424.5154.393920880621051062.malone@chaenomeles.canonical.com>
 <CACAYGhuurXCHk7b9we2P7Vbx_dajAN5_i4FyL7Ck3q4-m7fbQA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <15cde2ad-31d0-69ea-fecf-4db380c55984@redhat.com>
Date: Fri, 24 Jan 2020 09:50:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACAYGhuurXCHk7b9we2P7Vbx_dajAN5_i4FyL7Ck3q4-m7fbQA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: gdoVFH22OK-wOmVLoPORBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 4:41 AM, Ildar wrote:
> Max, thanks a lot for the explanation.
> Do you mean that snapshot-ing isn't possible totally for blockdev? Then I
> guess some libvirt users are in trouble :((
> Actually I didn't quite caught the reason why a blockdev supports backing
> but not {backing to a file on /tmp then promptly deleted} ? What's the
> technical difference?
>=20

On 1/24/20 4:05 AM, Max Reitz wrote:
>=20
>=20
> I don=E2=80=99t know much about libvirt, but I would have thought that an=
y
> manual modification of the qemu command line isn=E2=80=99t supported and =
might
> always break.
>=20
> Anyway, from a QEMU POV, -snapshot only works with -drive (this includes
> -hda, etc.).  It doesn=E2=80=99t work with -blockdev.  I can see that thi=
s isn=E2=80=99t
> documented for -snapshot, but basically whenever -blockdev is used, the
> user assumes full responsibility for the block graph (or at least that
> particular subgraph).  We cannot enable snapshot functionality then.

Libvirt has never produced a qemu command line containing '-snapshot'.=20
Part of this is that libvirt wants to control SELinux settings, and=20
letting qemu create a temporary overlay in /tmp in order to implement=20
-snapshot does not play nicely with libvirt pre-creating all files that=20
qemu is allowed to access.

The fact that you were able to manually add -snapshot to your qemu=20
command line with older libvirt using -drive (I'm assuming you were also=20
not using libvirt's SELinux support, because if you were, qemu would=20
have been unable to create/access the temporary wrapper in /tmp), is a=20
nice hack.  But since modern qemu has declared -snapshot to be=20
unsupported with -blockdev, and modern libvirt has switched to=20
-blockdev, I claim that this is not a qemu bug, but a libvirt feature=20
request.

That said, libvirt has had a vision for a design for implementing the=20
equivalent of -drive -snapshot: the <transient/> sub-element added to=20
the domain/disk/source/driver element has been documented for a long time:

https://libvirt.org/formatdomain.html
"transient
     If present, this indicates that changes to the device contents=20
should be reverted automatically when the guest exits. With some=20
hypervisors, marking a disk transient prevents the domain from=20
participating in migration or snapshots. Since 0.9.5 "

However, no one has yet implemented it for libvirt's qemu driver.  Part=20
of our reluctance has been that we knew that implementing it would=20
require libvirt to precreate the wrapper file on every guest start, and=20
it is only very recently that we've even had enough functionality in=20
libvirt's qemu driver coupled with new qemu commands to create qcow2=20
images using QMP rather than having to shell out to qemu-img.  And part=20
of it is that there was no point in implementing something to work with=20
-drive, when we knew we had to rework everything for -blockdev anyways.=20
But now that the work in libvirt to switch to -blockdev is done, it=20
should be a lot easier to implement PROPER support for the <transient/>=20
tag, at least for -blockdev usage.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


