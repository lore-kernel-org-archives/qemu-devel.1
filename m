Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4716EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E8520657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gH0Yqx/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E8520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huVy7-0004ZR-41
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 01:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1huVxY-0003sJ-HE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1huVxX-0000cC-JD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:55:04 -0400
Received: from mout.web.de ([212.227.15.3]:33223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1huVxX-0000Y5-Ah
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1564984495;
 bh=lR32kpDBJo3e07clQakH1YlWN5vRGa+qe46CvdhT5Xk=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=gH0Yqx/Ik1akr3/+shOZ0nDJ/3Tlwh+JFjrrS3HklOZXxEcHeUv77OsDMumKofNYT
 exvRWILsOFkL7LKkOv4E3ZbMakvR2WP6RkoXzC3PIncK9fKU68ciT7ixGh/3DpOTQT
 1P0vggNPOjeO1gS5fA6+HEkwfToP1n90Snh6mEY0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkhUq-1iSTCE2vye-00aUZC; Mon, 05
 Aug 2019 07:54:54 +0200
To: qemu-devel <qemu-devel@nongnu.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <d938a62c-7538-9d2b-cc0a-13b240ab9141@web.de>
Date: Mon, 5 Aug 2019 07:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMiBHAFbEqbRBFwA8NmGyfubxwMOKuHVefjpem3DQWUjWOK0IYy
 09SkZw3vz94KUbNhb03fWB1AEyPL8ygAzj6oxcwa5eWyyJ/mNP6ES/QnstcFnDTlhY9KSHA
 wPsAqtKwK3r14VuiNREhC0Atj4xi2OytcAf3LyN8g0dQIeoXG4cDTaq6L/Q4lDpiDsgIh3H
 uwpDrZbUL6yj8liaP8bVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LXIUFlXAf7g=:SVltVkaGnJYfO9C0BINb3m
 Vd0/wad+Fl5B0bRLESSL0Rdp4n3rQ/KsxSxfm4WPCJhkyEvqQTNDuRxarSH+ZUvoO8Y/8zCbk
 6HSGykAn2fuTUy76CV8Y/FtqYlZf+ceCEDp58k40sosJLsrpRsgADol4CG0jR3tMyClX6bBno
 ICFH3JHS2nbqkisBXXpSxD2yVz8u7C0LEsAuv5xzR5w38TrRoZPhmxMYUEr/gFrf2ldNCqTQi
 XE+gCBGMYZgu8kIZL/gdkQTAKh62hjXAw6MrN7Jt1s3gWt5gJruVTnQKZgSZcBJOj23hopzkV
 TNjYMMSRoZFOPitnWjrU1mKB+AbS46eLPuGOjbn7B7Yt/m8bfGRs3P/mwNgVbFp8g0pd8LRi2
 SKSGRZmzEPFu7UVMYYJAUlwY7zA+qw5BV742qGeiR9my2jrqHaTAoe3j8pn1ru6C+6NkBuX0j
 My0/5q+qmfyIfxnW2FbU5aECgLqtAp/8EB2BqNEgkji2+VNjx5DXfZz5XNVsyQURCkTRUQlnH
 vsnxYzgm6YKqzmtYD7fd/8yiqEDb8SauGPcJoQD90dJN9nBhbrcU4cqP9dvJGYOwKA11ari2z
 dg1V1d1ycd7GhjsjnsSZ+0v579hlOQV6RNHMAJ+SbV8jYfBXwD+Amcv5UeYGsD5cDNs9KLsl+
 yiS275N0qmXmUO0902gSMOLnDzrQKu7lGxyIK7qiwK9PjxXywGf91FsaiRyjxM/13Q4OtTIOJ
 5WXCPc87CwW1GZz/dcnpWrzxsJ5+gj+FMK5VFPUKHnynqrk8zKuekORBMjDyaLL05hmnGB/NT
 Zh/Rc+xCOYXomp3Mm3LbdELedhVY5Wa0ZejN/N/bWoaUJ2lZYFrEQrXinbVf7QnweaJeLzBrc
 DoTbOe1xwUUCPmoEA4f+mX1BDKJtCPh7N04niTPvYMz9YsMVRt2wKiBmsh0i2yGmLdhn1BPP5
 qTjuh1gHlNmTJuggBN2gjhYo5yZIyUzz7gpGIZlwLeuc1ybQnDSnKj4ncXePmR6SwsVN3ylca
 JCh0bkS/67eNWf5RyFtJpeE2kzFlwzfVxAvB3uAYQSGp6noLw6MojOW9GxTNUdKXnmLOc/jeR
 g3DB22btWdKiy8ku7wR+XJ0vyZMrLBmXjLilVa5aPiNP3G6P5vOTF7jBN4Bi3dSm7bf2hU1r8
 O1zS8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
Subject: [Qemu-devel] [PATCH v2] ivshmem-server: Clean up shmem on shutdown
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
Cc: Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

So far, the server leaves the posix shared memory object behind when
terminating, requiring the user to explicitly remove it in order to
start a new instance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--

Changes in v2:
 - respect use_shm_open
 - also clean up in ivshmem_server_start error path

 contrib/ivshmem-server/ivshmem-server.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-ser=
ver/ivshmem-server.c
index 77f97b209c..88daee812d 100644
=2D-- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -353,6 +353,9 @@ ivshmem_server_start(IvshmemServer *server)
 err_close_sock:
     close(sock_fd);
 err_close_shm:
+    if (server->use_shm_open) {
+        shm_unlink(server->shm_path);
+    }
     close(shm_fd);
     return -1;
 }
@@ -370,6 +373,9 @@ ivshmem_server_close(IvshmemServer *server)
     }

     unlink(server->unix_sock_path);
+    if (server->use_shm_open) {
+        shm_unlink(server->shm_path);
+    }
     close(server->sock_fd);
     close(server->shm_fd);
     server->sock_fd =3D -1;
=2D-
2.16.4

