Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F0BC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC0620735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp1r/hmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC0620735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEgZ-0008Qj-W1
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEETQ-0000hs-Lw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEETP-0001R6-CC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:49:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEETP-0001Q5-8S
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584460182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TrUBFfmOxAYmngy3zlaZXcvzSD96s69b7MxBJGq0Hoc=;
 b=Xp1r/hmr+LFvhTTCOVZKAXMBsqxE8NmgJdVGcSUbd8C6kVbwYrQCmZnzM5pNLJgY4jq5Hh
 W0F4bMMh1ocaR7OAwoNH/7UX/J0UV2EkYtnJ+q+0yfBoMnEkd684V4ROOrxOQa0iIb6AgK
 aBOWqtmWOZxX1Rtvh/nTdPoabVIV5BI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-UL983GE3OaWNGLQ1oIcleQ-1; Tue, 17 Mar 2020 11:49:36 -0400
X-MC-Unique: UL983GE3OaWNGLQ1oIcleQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 489C3107ACC9;
 Tue, 17 Mar 2020 15:49:35 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48CEF60BE0;
 Tue, 17 Mar 2020 15:49:29 +0000 (UTC)
Subject: Re: [PULL 00/10] Bitmaps patches
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200317043819.20197-1-jsnow@redhat.com>
 <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
 <5805273e-0a2f-850a-a07a-97dac0d7211e@redhat.com>
 <20200317145703.GH2041016@redhat.com>
 <CAFEAcA9-YLNcZPPsHsdLB0O2Ac4WKPspMe=Re2S7tyTZu=kwFA@mail.gmail.com>
 <20200317150528.GK2041016@redhat.com>
 <CAFEAcA_pLvupGhgeuevVBxhNz-NVkKWOUrr=nJaPAEKquHaqxw@mail.gmail.com>
 <20200317151131.GL2041016@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7db6423a-e930-f197-692b-8799ba4f4d29@redhat.com>
Date: Tue, 17 Mar 2020 10:49:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317151131.GL2041016@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Libvirt <libvir-list@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 10:11 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 17, 2020 at 03:07:34PM +0000, Peter Maydell wrote:
>> On Tue, 17 Mar 2020 at 15:05, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>>>
>>> On Tue, Mar 17, 2020 at 03:00:48PM +0000, Peter Maydell wrote:
>>>> On Tue, 17 Mar 2020 at 14:57, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
>>>>> I don't feel like -Wno-unused-function looses anything significant, a=
s
>>>>> the GCC builds will still be reporting unused functions which will
>>>>> catch majority of cases.
>>>>
>>>> The most interesting difference is that clang will catch unused
>>>> static inline functions which gcc does not.
>>>
>>> That's mostly just about dead code cruft detection IIUC. That code won'=
t
>>> make it into the binary if it isn't used.
>>
>> Indeed, but it's nice to have the dead code cruft detection. You
>> can always mark the function as __attribute__((unused)) if you really
>> mean that it might be present but not used.
>=20
> The *BSDs  seem to track latest glib pretty quickly. So if we got the
> unused attribute into upstream glib, we would probably have about
> 6-9 months before we get a build platform with the fixed glib included
> where we can conditionally re-enable the unused-function warning.

Looks like glib commit https://github.com/GNOME/glib/commit/b41bff1f=20
(2.57.2) added G_GNUC_UNUSED to all of the functions declared during=20
G_DEFINE_AUTOPTR_CLEANUP_FUNC.  Which version of glib is on the NetBSD=20
machine?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


