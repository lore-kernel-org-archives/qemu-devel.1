Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AE8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2782067D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IH/XTwIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2782067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1PjT-0000Yt-Hm
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 03:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1Pih-0008Lj-27
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:44:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45175
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1Pie-0008IO-7E
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596181482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UdoygK3os5o72+8NFLQ+SCSJV9B0RM5JrZKIjlH2/c=;
 b=IH/XTwIfuENgtdXpFdRFDVwA3+nNy7Yjb7+5mkoWRY4ruR88sjC3fIGU7x4lYreMU48zI4
 g8D+wjJI6lAtcoSXIko6ACk6SHZV4Uv/HDV5ao67RFQLlgrRgc9nx/zkuoHXFcrHO6hROZ
 hxTHOTxddQ1oQkwj+zoK2u0NfiO+xJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-i5U6w9nNMwagjtd9X6eCfw-1; Fri, 31 Jul 2020 03:44:40 -0400
X-MC-Unique: i5U6w9nNMwagjtd9X6eCfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54F30100CCC5;
 Fri, 31 Jul 2020 07:44:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E85D35DA75;
 Fri, 31 Jul 2020 07:44:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 678151132FD2; Fri, 31 Jul 2020 09:44:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
 <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
 <87k0ylvy0t.fsf@dusky.pond.sub.org>
 <CAFEAcA-AYJ64HE698TMRS6cV=u4ig6S6TU2xufns7fCVbcQXrg@mail.gmail.com>
 <20200730155939.GP3477223@redhat.com>
 <4d2cba04-04d8-9b82-562f-acb84b6010d2@redhat.com>
Date: Fri, 31 Jul 2020 09:44:37 +0200
In-Reply-To: <4d2cba04-04d8-9b82-562f-acb84b6010d2@redhat.com> (Eric Blake's
 message of "Thu, 30 Jul 2020 11:24:51 -0500")
Message-ID: <87pn8ct9ga.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:46:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 7/30/20 10:59 AM, Daniel P. Berrang=C3=A9 wrote:
>
>>> Well, I suspect that management-layer code currently has
>>> gone for "assume we're always running on Linux" and was
>>> written by people who knew they were getting a Linux tid...
>>
>> Yes, on the libvirt side, the functionality that relies on thread_is is
>> only compiled on Linux. If someone wants to use it on other OS, they'll
>> have to provide an impl using their platforms equivalent of
>> sched_setaffinity and friends since none of this stuff is standardized
>> across OS.
>>
>>
>>>> The PID is quite unlikely to be "an OS-specific identifier of the
>>>> current thread".  Shouldn't we fail instead of lie when we don't know
>>>> how to compute the truth?
>>>
>>> Yeah, I think the default codepath is pretty bogus too. Should
>>> the QMP functions have a mechanism for saying "we don't know
>>> a thread-id on this platform" ?
>>
>> Thread_id should be optional and thus not filled in if we
>> can't provide a sensible value. Unfortunately we made it
>> mandatory in QMP.
>
> Normally, converting a mandatory output value to optional is a
> back-compatibility risk (we could break apps that depended on it being
> present).  But if the only apps that depended on it being present are
> compiled on Linux, where the member will actually be present, I think
> that changing the schema to make it optional for non-Linux platforms
> won't be a back-compatibility nightmare (but we will have to be
> careful in our documentation).

Options for systems where don't know how to compute a system-wide thread
ID:

0. Return a bogus value: the PID.  This is the status quo.

1. Return a more obviously bogus value: -1.  Semantic compatibility
   break.  Should be harmless, because a QMP client relying on the
   thread-id being the PID would be insane.

2. Make thread-id optional, present iff we can compute a value.

   This is what we should have done, but we didn't, and now it's a
   syntactic compatibility break.  Matters only if it actually breaks
   QMP clients.  We believe the one we know shouldn't break.

Preferences?


