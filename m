Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF0C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78492073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsBCTZG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78492073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcq7-0002Q1-3c
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iVcp0-0001ks-3o
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iVcox-0002sz-IU
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:43:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49418
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iVcow-0002sI-M6
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573829013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcDBtzmFlBERtLB1tPY8twydg2wf+DxbQVO58gwIlh4=;
 b=BsBCTZG/tl4rMgXJn12gBUlPtv5jpwPpr0tRdgYQnll6nvjDZxn7d+a0oNeeXkgnHyTX5A
 KUkZHt8g1fns+LToFN7+dmBi/tveREM8Xx38ite9tgkd5mkY1r+AZ6de/WhIt2+351nqYW
 NxETtQ+56IVuh4skHrzFhbh/TKMZesY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-hRMyaTLcOD2ECnLwUdegGg-1; Fri, 15 Nov 2019 09:43:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F3E107ACCC;
 Fri, 15 Nov 2019 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-84.ams2.redhat.com
 [10.36.117.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2796C66094;
 Fri, 15 Nov 2019 14:43:24 +0000 (UTC)
Subject: Re: [PATCH v1] s390x: kvm-unit-tests: a PONG device for Sub Channels
 tests
To: Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <1573671753-15115-1-git-send-email-pmorel@linux.ibm.com>
 <20191114113823.5d752648.cohuck@redhat.com>
 <b103f51b-f304-cf71-15f9-5fd456a6fcfe@redhat.com>
 <bfbf35b1-16a9-3fa1-14e0-49b0f9632897@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <badf7ed3-8832-89f6-e094-163d29c14bef@redhat.com>
Date: Fri, 15 Nov 2019 15:22:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <bfbf35b1-16a9-3fa1-14e0-49b0f9632897@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hRMyaTLcOD2ECnLwUdegGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: frankja@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/2019 18.17, Pierre Morel wrote:
>=20
> On 2019-11-14 13:33, Thomas Huth wrote:
>> On 14/11/2019 11.38, Cornelia Huck wrote:
>>> On Wed, 13 Nov 2019 20:02:33 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>
>>> Minor nit for $SUBJECT: this isn't a kvm-unit-tests patch, that's just
>>> one consumer :)
>>>
>>>> The PONG device accept two commands: PONG_READ and PONG_WRITE
>>>> which allow to read from and write to an internal buffer of
>>>> 1024 bytes.
>>>>
>>>> The QEMU device is named ccw-pong.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>> =C2=A0 hw/s390x/Makefile.objs=C2=A0 |=C2=A0=C2=A0 1 +
>>>> =C2=A0 hw/s390x/ccw-pong.c=C2=A0=C2=A0=C2=A0=C2=A0 | 186
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 include/hw/s390x/pong.h |=C2=A0 47 ++++++++++++
>>>> =C2=A0 3 files changed, 234 insertions(+)
>>>> =C2=A0 create mode 100644 hw/s390x/ccw-pong.c
>>>> =C2=A0 create mode 100644 include/hw/s390x/pong.h
>>>>
>>>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>>>> index ee91152..3a83438 100644
>>>> --- a/hw/s390x/Makefile.objs
>>>> +++ b/hw/s390x/Makefile.objs
>>>> @@ -32,6 +32,7 @@ obj-$(CONFIG_KVM) +=3D tod-kvm.o
>>>> =C2=A0 obj-$(CONFIG_KVM) +=3D s390-skeys-kvm.o
>>>> =C2=A0 obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o s390-mchk.o
>>>> =C2=A0 obj-y +=3D s390-ccw.o
>>>> +obj-y +=3D ccw-pong.o
>>> Not sure if unconditionally introducing a test device is a good idea.
>> This definitely needs a CONFIG switch (which can be "y" by default, but
>> still we should provide a possibility to disable it)
>=20
> yes, clearly

I just noticed that we already have a global config switch for such
devices, so you could simply do:

obj-$(CONFIG_TEST_DEVICE) +=3D ccw-pong.o

 Thomas


