Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15A7C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB4120692
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUMXj21G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB4120692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpvA-0006To-Qu
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXptd-0004h9-Gb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXpta-00059D-UW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:05:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXpta-00058w-NP
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574355929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDK9nPJjEcaWnY0EIQTdrbUwZ13Zr8lT+1KWPZ1DSmU=;
 b=SUMXj21Gk5cxxRXw2gLyx9uTL13OVXsfA4n2EYrHwh0KleIUgHjNcJtACsFx/XjijrSso9
 QcK4accyXmn+IvynNgRV8SpKbJdK5k8p9+drf9FY5UYJdh7IUqhOKWEQSqDcP65xo9d0SC
 BWH7RyM0Pd+iBLZ/cOH0Y9ypRwTlTok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-OqXQno-hM--YchYZP0V6hA-1; Thu, 21 Nov 2019 12:05:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40AC91005502
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85EF47A5D2;
 Thu, 21 Nov 2019 17:05:25 +0000 (UTC)
Subject: Re: [qemu-web PATCH] Add a blog post about the QEMU-related
 presentation of KVM Forum 2019
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20191121115207.5832-1-thuth@redhat.com>
 <d25b1eb9-343d-f8bf-f090-4e8d77ad8383@redhat.com>
 <2cc0abb3-095e-8c40-3056-4c7265492a0a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9a9278d2-7cde-0390-47b7-983880755d49@redhat.com>
Date: Thu, 21 Nov 2019 18:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2cc0abb3-095e-8c40-3056-4c7265492a0a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OqXQno-hM--YchYZP0V6hA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/2019 17.04, Paolo Bonzini wrote:
> On 21/11/19 14:59, Eric Blake wrote:
>> On 11/21/19 5:52 AM, Thomas Huth wrote:
>>> There have been quite a lot of QEMU-related talks at KVM Forum this
>>> year - let's provide a summary for the people who could not attend.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> =C2=A0 Note: For some talks it's hard to decide whether they really fit=
 the
>>> =C2=A0 QEMU blog or not. I've assembled the list below by quickly skimm=
ing
>>> =C2=A0 through the schedule and the videos, and that's what I came up w=
ith ...
>>> =C2=A0 If you think any of the other talks should be mentioned here, to=
o,
>>> =C2=A0 please let me know.
>>
>> Perhaps:
>>
>> [Making the Most of NBD](https://www.youtube.com/watch?v=3DPMa6KFX9AxM) =
by
>> Eric Blake and Richard Jones
>>
>> which mentions optimizations to 'qemu-img convert' made possible through
>> NBD protocol extensions
>=20
> Agreed.  Also I would remove the RISC-V talk, as I was going to write a
> blog post about it too.

All right, thanks for the feedback, I did the suggested changes and
pushed the article to the blog now:

 https://www.qemu.org/2019/11/21/kvm-forum/

  Thomas


