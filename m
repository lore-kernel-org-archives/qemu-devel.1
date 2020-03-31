Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67EEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53DA2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6uLybLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53DA2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJM62-000300-SW
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 14:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJM5R-0002Ul-Uz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJM5Q-0003Ww-A9
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:58:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60274
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJM5Q-0003WS-4k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585681087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2pulfJ374zPcF7F8ydN2D8o0aSH7Dww62VTApKZBjM=;
 b=A6uLybLwYrFdSMfJS3lYi99oIsBbL6qlGTameYVRL9ifA+Z/ycQebkoBRCHlHO/DISO5rl
 r0oKkatask/48MbW4dJxlnEFUe1tWZi+rZp0pPll2v7PaEPbYZROlErEDuuasfGNOEQeD+
 8UPmD1XcD54l26h2dWnR56jpmGOJbaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-AMLwik-UO9yUM-aUV3dE2w-1; Tue, 31 Mar 2020 14:58:05 -0400
X-MC-Unique: AMLwik-UO9yUM-aUV3dE2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59345107ACCA;
 Tue, 31 Mar 2020 18:58:04 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56F1C99DE0;
 Tue, 31 Mar 2020 18:58:03 +0000 (UTC)
Subject: Re: [PATCH v14 4/4] iotests: 287: add qcow2 compression type test
From: Eric Blake <eblake@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
 <20200331174455.31792-5-dplotnikov@virtuozzo.com>
 <bebbcc59-9392-9461-7976-5ab3367df3a2@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0b676532-91c0-6ebf-c436-b02fd5fb351d@redhat.com>
Date: Tue, 31 Mar 2020 13:58:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bebbcc59-9392-9461-7976-5ab3367df3a2@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 1:43 PM, Eric Blake wrote:

> Is it also worth trying to generate an image with (pseudo-)random=20
> contents, and trying qemu-img convert to prove that uncompressable=20
> clusters are handled sanely?=A0 Ideally, there would be a way to use a=20
> fixed PRNG and seed that produces a deterministic sequence that cannot=20
> be compressed, but even if we can't meet the ideal, having a test that=20
> non-deterministically is likely to generate an uncompressable cluster in=
=20
> most runs is better than nothing (such as 1M of data copied from=20
> /dev/urandom, then qemu-img convert on that data).

For an example,

nbdkit -U - random 1M seed=3D1234 --run 'qemu-img convert $nbd file'

produces 'file' containing deterministic pseudo-random data.  And 'zstd=20
file' proves that the data was non-compressible in bulk:
$ zstd file
file                  :100.00%   (1048576 =3D> 1048613 bytes, file.zst)

In fact, inspecting od output, I can see that the first few bytes of the=20
original file are replayed verbatim after a 12-byte header in the .zst file=
.

But we don't have any other uses of nbdkit in our iotests, so I'm not=20
sure if making this the first test to depend on that is ideal.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


