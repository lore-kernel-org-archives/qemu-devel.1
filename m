Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEE820575
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJLwdMBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEE820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOQGO-0001Vq-Mx
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 14:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jOQFC-0000Xf-Eu
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 14:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jOQFB-0002yi-CI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 14:25:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jOQFB-0002xn-9G
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 14:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586888709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wefEcnnmTf/uKt2nTBTU51h3QxV4HvK8HnrJ5xuQUk=;
 b=QJLwdMBd9KCeLJrkIq/6DUGo4GDj/fwNMjZ1ZkXghUjwkOItPtAEUQ27v++25tG1CCkvcT
 kQhuDMN102HXWsjNSw1fvQGlpXY+CjfxnydEEP1Wb9XYcYsAgQoYnaEx3vAd1Bkq8R4I31
 O2+T889JVYjpoHeeAa6p1VfKJLGDtWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Uq_-1gFROu2jLyUQG0asIQ-1; Tue, 14 Apr 2020 14:25:04 -0400
X-MC-Unique: Uq_-1gFROu2jLyUQG0asIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B3CB1926DA5;
 Tue, 14 Apr 2020 18:25:03 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F3805D9E2;
 Tue, 14 Apr 2020 18:25:02 +0000 (UTC)
Subject: Re: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
 <8c88b96f-c6f5-e06c-73e1-56001089a7ca@redhat.com>
 <w51ftd6rkys.fsf@maestria.local.igalia.com>
 <1e6c2a1c-e2b5-609a-72fc-144de466345b@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9ddb390a-3a41-3f35-25fc-31d490d62d77@redhat.com>
Date: Tue, 14 Apr 2020 13:25:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1e6c2a1c-e2b5-609a-72fc-144de466345b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 1:23 PM, Eric Blake wrote:
> On 4/14/20 1:16 PM, Alberto Garcia wrote:
>> On Thu 09 Apr 2020 05:12:16 PM CEST, Eric Blake <eblake@redhat.com>=20
>> wrote:
>>> Hmm - raw external files are incompatible with backing files.
>>
>> Pre-existing, but I just realized that we are not checking that in
>> qcow2_do_open(), only on _create().
>>
>> I suppose that if we find such an image we should either
>>
>> =A0=A0=A0 a) Show an error message and abort.
>> =A0=A0=A0 b) Clear the 'raw data file' bit and proceed as if it was unse=
t.
>=20
> I would favor a).=A0 Such an image was (hopefully) created externally, an=
d=20
> not by qemu; therefore refusing to open it will call attention to the=20
> image (and it's creation process) being broken, rather than risking=20
> silent corruption of whatever the external process thought it was=20
> accomplishing by creating an image like that.

Also, 'qemu-img check' should flag the problem, and I'd be okay with=20
'qemu-img check -r all' repairing the problem by method b) (because then=20
the user is explicitly opting in to having qemu change the image in=20
order to maximize the amount of data that qemu can then extract from the=20
image).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


