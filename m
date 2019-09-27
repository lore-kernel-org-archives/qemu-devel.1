Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF011C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C5D2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C5D2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmT6-0003re-PN
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1iDmFu-0006ws-3Q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1iDmFs-00029A-Mm
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1iDmFs-00026k-EW
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:09:36 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16A8F641C2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:09:35 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f63so1961959wma.7
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 02:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=sVtwfNmgEZ0sSn8j3G1vfEiZOqawpU0nyVrUe8q0sWg=;
 b=Q+dD1cbEo74JWyIEH/z5D0kzAsz8bro/jmhGyV4095ObXqb0W5JA8tpz3IABbhK3hN
 ow7HA+4ZtUYygNxxylPoO9kM7leIP2+ZbMfZUZl5+sRzCDLBKa5NT9KwUcGL85tUH8U6
 aN1VdWPZPQpvFDI9233YtU8C4FZzAzvJtzXuGCZdzWHRKt7+g362aY07vcMd3fcTacpq
 uvBjWN9cIbcM19fZutWV/u+L+NSFYl2Fn4ylHcQ9udMZVy23PvmEKFPxyAYpwz1WJ9A4
 60gt0hej62yk7ZdDIQZOXxhWKHnB+KjhY12cxooO25/29KFL0pqAs8IxFC/VPoactiZr
 JNgA==
X-Gm-Message-State: APjAAAWZakqkPUp/NJ1FcOf3sMEADWCD8E4a005rWbj3ZmgyQUMdzJOJ
 WXfUN8flYAV5yLDcYqsgrJK1XGLhNz4bjBnyKGyG43CMaPi5en5mCKDNC79EfxGtR9Q+L6tt3Xn
 AbRfPXjjeB4TzWG0=
X-Received: by 2002:a1c:e906:: with SMTP id q6mr5889792wmc.136.1569575373512; 
 Fri, 27 Sep 2019 02:09:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsy2DSCkbcifdrZPQ+6vNphEeRwpSwKrwaoHlw+1Y+5LUZTOHPVNPKSxWaAeiOWKJ90tGVPg==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr5889777wmc.136.1569575373289; 
 Fri, 27 Sep 2019 02:09:33 -0700 (PDT)
Received: from auriga.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 g13sm6480630wrm.42.2019.09.27.02.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 02:09:32 -0700 (PDT)
Date: Fri, 27 Sep 2019 11:09:32 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <20190927090931.rbzujfb2t35hfx2q@auriga.localdomain>
References: <919bbd6e0557d2fe2d9c17de394cc0b4c6fa4426.1569445204.git.tgolembi@redhat.com>
 <156954674521.23674.9914013622784989955@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156954674521.23674.9914013622784989955@8230166b0665>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

already fixed in v4

On Thu, Sep 26, 2019 at 06:12:26PM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/919bbd6e0557d2fe2d9c17de394cc0b4c=
6fa4426.1569445204.git.tgolembi@redhat.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20
> Type: series
> Message-id: 919bbd6e0557d2fe2d9c17de394cc0b4c6fa4426.1569445204.git.tgo=
lembi@redhat.com
> Subject: [PATCH v3] qga: add command guest-get-devices for reporting Vi=
rtIO devices
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Switched to a new branch 'test'
> 42c2919 qga: add command guest-get-devices for reporting VirtIO devices
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> ERROR: "(foo*)" should be "(foo *)"
> #155: FILE: qga/commands-win32.c:2316:
> +    values =3D g_array_new(TRUE, TRUE, sizeof(gchar*));
>=20
> ERROR: "foo* bar" should be "foo *bar"
> #157: FILE: qga/commands-win32.c:2318:
> +        gchar* id8 =3D g_utf16_to_utf8(id, -1, NULL, NULL, NULL);
>=20
> total: 2 errors, 0 warnings, 281 lines checked
>=20
> Commit 42c2919fb935 (qga: add command guest-get-devices for reporting V=
irtIO devices) has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/919bbd6e0557d2fe2d9c17de394cc0b4c6fa4426.156944=
5204.git.tgolembi@redhat.com/testing.checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

