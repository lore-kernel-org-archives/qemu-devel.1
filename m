Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126DC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBC0206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="Uk/Fy1zT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBC0206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRLH-00065q-Jg
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1isRKY-0005fF-Bt
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1isRKX-0007RU-A7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:06:30 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::8]:24201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1isRKW-0007KF-L8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579266384;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=ATQQuGb0dM2QGVZvfbXYXvvwMCJHYEMh4foInLS31jg=;
 b=Uk/Fy1zTIhz5R9d0/TajJbzatWfYA0tXMcayz7HaVlm0wPAleTonKQalHTxnKDI8xS
 2jdHTEEsLRjJQnQS/aWXmbWTOboqnfw41Xh7UHz7L7SiQAqJOV6A83jVUgGOqPdomCBU
 r7TScmWc5mQW/nGewXJaYTH+rhkDtqKtARXVQroYwkvD/nGWDqmW9GvtbTFz/rjH6hOV
 +zZ8G/aiSl3WdxUJuS7GZPxGeZ7TIU/FOzMVbqrvKZgWJi4DyDeOUpg5PMc3OvJ5UZy+
 ulvmBx6WqWnVhJkNxGGz/8WBwQJJ1AELwhN41HZ+vEAoRQU8BRIRiUO7Oly5FCVEp2bo
 5LsQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuaMkK"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.4 SBL|AUTH)
 with ESMTPSA id j08473w0HD6MX3Z
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 17 Jan 2020 14:06:22 +0100 (CET)
Date: Fri, 17 Jan 2020 14:06:16 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200117140616.18cb8c45.olaf@aepfle.de>
In-Reply-To: <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/q9xPsR_hzaa7+Hle.GrEOb+"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::8
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/q9xPsR_hzaa7+Hle.GrEOb+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Fri, 17 Jan 2020 11:27:59 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> It doesn't even try to be compatible for all existing and future guests.

This looks like the underlying bug.

What would future domUs lose if 'xenfv' would be locked to 'pc-i440fx-3.0'?


Olaf

--Sig_/q9xPsR_hzaa7+Hle.GrEOb+
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl4hsUgACgkQ86SN7mm1
DoClkA//TuE1AuPNZf54XdvWswWaXPf32O4Y5my7x3NwVt6zWT30PpMc9gfnDnt6
j23Ma+bGfxMRBlXMC2A/c25Q2Lo0oufIIWSHA3tx0V5q9nU02k/4pfutHVNbAlBQ
/jGiyJpHLmNTAgF6TJ442HETZyBuKm3F3TIFUj2CPAu2uuRB4Y/EMU7XWoTrG3Vq
Smu9VzqQcU6KcR88li2GvfgBoPDb+b0FLsAl2jlk03NlNHbr7D+kxWF3cOYtWdBX
ZItGHprQF+ykQq/VH78g9/CdWFqk9H6y3rUIwwzMJ+HrGvTpa3qfBYbBfQxZQBTa
Gd5BOub+excFcqL/C+FLFJa3ygRCBxK0i0W/iQQvLmu/4YmWbNe0ulpxaRZc3k9R
g4ksSHQnI5S4OcJHE/Uz+F/PNeN5AhMefqaH/j7658b2d/mWTW7l4OJxuo3HD7Ww
dZtZtNCFkvCfqLV2joFPZGPHItzKz/m2a5MMzEr338/0YD0umusJXbG3wwxgdNiW
FUh+TDsvfuBVcYVZJLq3YqkPKE4Lp0UE2SscjVZ4tkb3mHkQXqkCmq+tV032TI5o
PFagE5OavAIMdlWM1Oawp82La92JOSyqozkXaf3axLcY/2f3+GOIBhQu63nbbUmO
39thpvI8dKQQOcvwvnwZi9KsA9AyqJKCyfnpJAnTJagKq63zfGQ=
=9U56
-----END PGP SIGNATURE-----

--Sig_/q9xPsR_hzaa7+Hle.GrEOb+--

