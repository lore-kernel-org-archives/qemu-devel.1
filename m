Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9931DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647A420578
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Ur69P5qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647A420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ddu-00070B-I8
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2dNt-0007nW-I8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2dNr-0002CB-CP
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:27:49 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:41230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i2dNr-00029X-30
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:27:47 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 89F9A2E07C1;
 Tue, 27 Aug 2019 18:27:43 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 cNd939K7nK-RhQSddMl; Tue, 27 Aug 2019 18:27:43 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566919663; bh=uptfYJFlShDaAhHHgE+FaNihFxpXkEBKj2z+DcWwvU4=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=Ur69P5qgKC74cSTNIV+v3UZ5OVGwMzinevZ9IKVFBaaOyhQjGaw94KmYEqdVZopV1
 a8z/khfmhdNsdNlKQEsSdoVtJqWTcWEm4dEc4IsXz43Bp3ShfWauRTT3lM7hiiYKbG
 efppL4eyGN7jS0swbOA1UgzhW+5Z+OxeuEPmLlOI=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id 7HsU3T0WGL-8NZO89dI
 for <yury-kotov@yandex-team.ru>; Tue, 27 Aug 2019 18:27:33 +0300
Received: by sas2-ae5b5c0d8595.qloud-c.yandex.net with HTTP;
 Tue, 27 Aug 2019 18:27:33 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <e377939e-ffa0-9000-88bf-45410611ded6@redhat.com>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
 <20190827120221.15725-3-yury-kotov@yandex-team.ru>
 <e377939e-ffa0-9000-88bf-45410611ded6@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 27 Aug 2019 18:27:43 +0300
Message-Id: <850541566919653@sas2-ae5b5c0d8595.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/libqtest: Allow to set expected
 exit status
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.08.2019, 17:04, "Eric Blake" <eblake@redhat.com>:
> On 8/27/19 7:02 AM, Yury Kotov wrote:
>
> In the subject: 'Allow to $verb' is not idiomatic; either 'Allow
> $subject to $verb' or 'Allow ${verb}ing' sound better. In this case,
> I'd go with:
>
> tests/libqtest: Allow setting expected exit status
>

Ok, thanks. I'll fix it in v2

>> =C2=A0Add qtest_set_expected_status function to set expected exit stat=
us of
>> =C2=A0child process. By default expected exit status is 0.
>
>> =C2=A0@@ -130,11 +136,12 @@ static void kill_qemu(QTestState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* fishy and should be logged=
 with as much detail as possible.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wstatus =3D s->wstatus;
>> =C2=A0- if (wstatus) {
>> =C2=A0+ if (WEXITSTATUS(wstatus) !=3D s->expected_status) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (WIFEXI=
TED(wstatus)) {
>
> Wrong ordering. WEXITSTATUS() is not reliable unless WIFEXITED() is tru=
e.
>

Yes, it's a bug.. I'll fix it in v2

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc. +1-919-301-3226
> Virtualization: qemu.org | libvirt.org

Regards,
Yury

