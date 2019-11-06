Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B37C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE0921848
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IflMVPK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE0921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOt5-0003Un-UP
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 12:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iSOsB-0002wD-G6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iSOs9-0002a0-EK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:13:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iSOs9-0002V9-16
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573060411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZXRXYQyer9AWzMpJ0JxIiqDSXDkwJH87MufxInH82I=;
 b=IflMVPK+rzks4Vegt6UddcFa6tfUgbXdVIWAXlheUGvNfSyR/tvABPWU3JiNFE3XG/5p01
 k2Nir7hSdH5Zi73VYIQYtJZ/811cKLjb9D6p4L0B14UATsGw+evW/CfjzMOsX9QZTDBjib
 YccWLJ3uomzFBxXjOMerDo/Bf6mM3vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-d412yJz4MdWe9hhs5DS7tw-1; Wed, 06 Nov 2019 12:13:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E24A3477;
 Wed,  6 Nov 2019 17:13:27 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 525E710013D9;
 Wed,  6 Nov 2019 17:13:27 +0000 (UTC)
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <8a9a5eae-d388-867b-f4a1-080e876389b3@redhat.com>
 <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b84a0589-bf80-96a6-9bdb-0d56f329420d@redhat.com>
Date: Wed, 6 Nov 2019 11:13:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106145800.GC7548@dhcp-200-226.str.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: d412yJz4MdWe9hhs5DS7tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 8:58 AM, Kevin Wolf wrote:

>> Well, but anyway.  Just as I didn=E2=80=99t have anything against adding=
 QMP to
>> qemu-nbd, I don=E2=80=99t have anything against adding a new application=
 that
>> kind of fulfills the same purpose.  And I think introducing a new
>> application instead of reusing qemu-nbd that focuses on all-around QAPI
>> compatibility (which qemu-nbd decidedly does not have) makes sense.
>=20
> Yes, QAPI is one big reason for creating a new tool that doesn't need to
> support the old qemu-nbd command line. Another is that we can add other
> types of exports that are not NBD.

If we could make qemu-nbd a thin wrapper around the new tool (even if=20
the two are not necessarily command-line compatible), that might be=20
worthwhile.

>=20
>> The only thing I don=E2=80=99t like is the name, but that=E2=80=99s what=
 <Tab> is for.
>> :-)
>=20
> I'm open for suggestions, but I thought 'qsd' was a bit too terse. :-)
>=20
> (Actually, maybe we could even pick something that doesn't mention
> storage or block? After all, it can do all kinds of QEMU backends in
> theory. Not sure if there's any standalone use for them, but who
> knows...)

Maybe 'qback', for qemu-backend?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


