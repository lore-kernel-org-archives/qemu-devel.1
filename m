Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E65920665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEwls/+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E65920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZt51-0006ho-1Y
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iZt2Q-0003QQ-Nr
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iZt2O-0000es-0W
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:51:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29096
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iZt2N-0000eP-TK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:51:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574844663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lt2/2v/I5nSOi4lJ6ehrs8+3OMDsoODUgKUHieEDjLk=;
 b=QEwls/+aHg6GvuUSkSKQC24n50E3zHOMMHhFlWkdX9EmWkW3WQ89D9vEDUN+aOG1gbD751
 3z+OYktpTDPJczO12BU8dOGQ/rACY2aJkXiCuLGdbVskzy7h4dduaUtfex2wJRajt80DZk
 A/KAS28rsVl8KkHI6btWN8vgOIVxzjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-tlROl-7XMf6dUjxsn_qOWg-1; Wed, 27 Nov 2019 03:51:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD5321856A60;
 Wed, 27 Nov 2019 08:51:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-186.ams2.redhat.com [10.36.117.186])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C88C3608B9;
 Wed, 27 Nov 2019 08:50:54 +0000 (UTC)
Subject: Re: [PATCH 0/6] Enable Travis builds on arm64, ppc64le and s390x
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191119170822.45649-1-thuth@redhat.com>
 <87wobr7bkz.fsf@linaro.org> <878so4gsh1.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eb3ff72d-647b-ce46-d0de-9fb8556dfacc@redhat.com>
Date: Wed, 27 Nov 2019 09:50:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <878so4gsh1.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: tlROl-7XMf6dUjxsn_qOWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/11/2019 11.28, Alex Benn=C3=A9e wrote:
>=20
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>=20
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> Travis recently added build hosts for arm64, ppc64le and s390x, so
>>> this is a welcome addition to our Travis testing matrix.
>>>
>>> Unfortunately, the builds are running in quite restricted LXD container=
s
>>> there, for example it is not possible to create huge files there (even
>>> if they are just sparse), and certain system calls are blocked. So we
>>> have to change some tests first to stop them failing in such environmen=
ts.
>> <snip>
>>>    iotests: Skip test 060 if it is not possible to create large files
>>>    iotests: Skip test 079 if it is not possible to create large files
>>
>> It seems like 161 is also failing:
>>
>>    https://travis-ci.org/stsquad/qemu/jobs/615672478
>=20
> And sometimes 249

These must be intermittent problems ... I've seen 161 failing once at=20
the very beginning of my tests, but then never again, so I assumed that=20
it was a quirk with the test system that got fixed later. Seems like=20
that was a wrong assumption. I've never seen 249 failing so far... I'll=20
try to do some more tests when I've got some spare time...

  Thomas


