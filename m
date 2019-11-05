Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6934CA9ED3
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987F12067D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 02:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahUz0KlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987F12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRoyW-000084-Nf
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 21:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <f26227279@gmail.com>) id 1iRoxt-0008BE-EG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 21:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <f26227279@gmail.com>) id 1iRoxs-0002Pq-EB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 21:53:05 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:34921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <f26227279@gmail.com>) id 1iRoxs-0002P7-77
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 21:53:04 -0500
Received: by mail-ot1-x32a.google.com with SMTP id z6so16380755otb.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 18:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=q7VLbLWSh+0SaZ89FrbkJ1MfHkaBSb7cabgVKEDZbHw=;
 b=ahUz0KlJctQY+2kF1VqavU8iFgqHW1hYtnv6/2PgJn/7oIE6FHzq9RWAKGk7u1iP5N
 cwbDeK4c7XRZRPRkylpX0gO4bkx5NN+vvEHldskTHpriUo8OR+DlEZ+V0YhvYl9RESr2
 Jyx+04V2j59ANccrc8DYm9b0NfQWh80Cuag4xIa+HPT41uO2JLJC6eE78K2DyR0O6Jt/
 gTPKQPphV6vsxjbdbBdkDd81yR6zhpWlGvCQEgTaqBUkxJDhXMTCZUSh9iDm0bN4bZU1
 X8yEQxAXX9w0gF+hVHikhdF7lBlvQEgIP9o5GJ+AXpuOyKKfBmrgzGtn/v3L+gr/RBGA
 AsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=q7VLbLWSh+0SaZ89FrbkJ1MfHkaBSb7cabgVKEDZbHw=;
 b=JrhE91fsGbr9IMbxm/VsXV87z6DZqXOdAbSVH91zrCMeHKcKaZq07GWTcgBO6T3JXT
 I1tCADBQIiHey/jn/9Y82f1x83weZ3wzCt0qpSQpDcXS1PhoTsYIHcgDy8f31GpWQZH0
 tnpX/fYgYt3EDUrUuYnqi/crchKT7vp4Dczh13ox4RwgJOvFtHmsgFdtPSiCSUztsjhZ
 EP6mRudSpkLRx20aaoD1byRAQJ3emD2oHIao7pfYYN9RRY0KNpEk33Rio3t89xL/XqGU
 I+8C5kcjgpcepwMy116cgqLU+MdGjA+AUzvYGT4G/aOEnegzR1jQ/j80Ol4YLHPsrBko
 KN9Q==
X-Gm-Message-State: APjAAAXvqHLfgBxeswXpcgODW1GD/ehe4FPQSK+l4RxuPIvqEYehk8LB
 GOvsoCxKT+pBRUbbgpY1xg/1kVfJOh2yQa1thR8qRpTK
X-Google-Smtp-Source: APXvYqwJl/r48AeS3fJpe5qfOrz9qTq8jYb0L0k2E9e1mftodAvcsUHDDEMRVXC/i0l2qDGjweh3bkc0zwj9BevAtXQ=
X-Received: by 2002:a9d:5f16:: with SMTP id f22mr21830862oti.78.1572922382856; 
 Mon, 04 Nov 2019 18:53:02 -0800 (PST)
MIME-Version: 1.0
From: Chang Howard <f26227279@gmail.com>
Date: Tue, 5 Nov 2019 10:52:50 +0800
Message-ID: <CAHr38=GUGpC1s8fo_E4w4qbB6qjf===5WjsS=wSSPKSZ6SQkeA@mail.gmail.com>
Subject: Live migration primary vncviewer blocked.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e3b5340596908707"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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

--000000000000e3b5340596908707
Content-Type: text/plain; charset="UTF-8"

Hi, I know after live migration, primary would be blocked and vnc is also
blocked.
Could I let primary vnc still work after live migration?
I do vm start after live migration and in text mode primary's vnc can still
work, but graphic mode it would blocked.
How can I do to make in graphic mode vnc can still work too?





thanks a lot!

--000000000000e3b5340596908707
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, I know after live migration, primary would be blocked =
and vnc is also blocked.<div>Could I let primary vnc still work after live =
migration?</div><div>I do vm start after live migration and in text mode pr=
imary&#39;s vnc can still work, but graphic mode it would blocked.</div><di=
v>How can I do to make in graphic=C2=A0mode vnc can still work too?</div><d=
iv><br></div><div><br></div><div><br></div><div><br></div><div><br></div><d=
iv>thanks a lot!</div></div>

--000000000000e3b5340596908707--

