Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F271C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:23:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE780206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+Np35pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE780206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3fRJ-00059I-0k
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 07:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j3fQe-0004Nh-9C
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j3fQc-0001gk-8T
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:23:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35263
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j3fQc-0001gR-4c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581942189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zCxfxYz61Wr0zuP9rf8O+0Xgv9ZAriImoz/HZaIK0co=;
 b=h+Np35pbf97PAwA13Jf7oXTD8plZMj8S+wxq49EGoZR//iFm4KZh38c6A4Zv91stEGGtCH
 9QNPWvLKqdR52j4I98sRY9/CbvoozeRBz+lBWjC8M/R0J85tly1ljI//jbW5fBeanU2O8Y
 mVD9rakyTVNJYP6lckCj0EN/qFps3Hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-Kt7CXcdrO3SvBl6eeG9klg-1; Mon, 17 Feb 2020 07:23:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE471800D5F;
 Mon, 17 Feb 2020 12:22:59 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0113C8B551;
 Mon, 17 Feb 2020 12:22:58 +0000 (UTC)
Subject: Re: [GEDI] [PATCH 07/17] gluster: Drop useless has_zero_init callback
From: Eric Blake <eblake@redhat.com>
To: Niels de Vos <ndevos@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-8-eblake@redhat.com>
 <20200217080614.GG239686@ndevos-x270.lan.nixpanic.net>
 <457280bf-58da-404d-7ac1-edf1531623c9@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bf7673bd-8d40-dfcc-5373-b670650edea1@redhat.com>
Date: Mon, 17 Feb 2020 06:22:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <457280bf-58da-404d-7ac1-edf1531623c9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Kt7CXcdrO3SvBl6eeG9klg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, david.edmondson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:03 AM, Eric Blake wrote:

>  >
>  > Creation or truncation should behave just as on a file on a local
>  > filesystem. So maybe qemu_gluster_known_zeroes is not needed at all?
>=20
> Which version of gluster first required a regular filesystem backing for=
=20
> all gluster files?=C2=A0 Does qemu support older versions (in which case,=
=20
> what is the correct version-probing invocation to return 0 prior to that=
=20
> point, and 1 after), or do all versions supported by qemu already=20
> guarantee zero initialization on creation or widening truncation by=20
> virtue of POSIX file semantics (in which case, patch 7 should instead=20
> switch to using .bdrv_has_zero_init_1 for both functions)?=C2=A0 Per=20
> configure, we probe for glusterfs_xlator_opt from gluster 4, which=20
> implies the code still tries to be portable to even older gluster, but=20
> I'm not sure if this squares with qemu-doc.texi which mentions our=20
> minimum distro policy (for example, now that qemu requires python 3=20
> consistent with our distro policy, that rules out several older systems=
=20
> where older gluster was likely to be present).

For reference, I quickly found commit efc6c070ac as an example of=20
bumping minimum versions (however, that commit is from 2018, so I'm sure=20
there are even more recent examples, just not with the same keywords=20
that I was searching for).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


