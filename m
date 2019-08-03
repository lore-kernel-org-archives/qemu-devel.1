Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47914C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 11:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1342F206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 11:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gxnFhTJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1342F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htsX8-0006BT-2a
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 07:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49722)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1htsW5-0005Yc-T8
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 07:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1htsW5-00041S-0i
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 07:48:05 -0400
Received: from mout.web.de ([212.227.15.3]:59237)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1htsW4-0003z9-KX
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 07:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1564832877;
 bh=JHX7J9UKoSuakFaucfbR6MAoUY6vwY81hVZ4V54HHBs=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=gxnFhTJZdmn5IEbzspfSO08xDlXBUOqTXw7/eVbuErxVkz1T2CK5+63b4PpDV+a3P
 MIUd9nSTKHJveD4QcQy7apPuotV7z5Jn39iep9ODUJjXZ/j2waWPuACpXCzgEGMDjB
 vDK9TASxn4I2Npm3czz3Q+zlV8ZZ5m33ERDuoAJo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgIMg-1hg2ax3TjK-00NiKi for
 <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 13:47:57 +0200
To: qemu-devel <qemu-devel@nongnu.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <3967fae7-0d95-6927-0a6a-b5ec90858ab4@web.de>
Date: Sat, 3 Aug 2019 13:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UrqO7U+4l39XUrwMNFoHoizHQzsDecC/pElEASbdQeVYJa2JLc2
 vfZCg51XkuyWbLCG2G6m0KOYwSkA+a2j7W3AAGGho84mTYP8Z3EhOHlRDrzD3QUvpyq/Kje
 IhT3lMnAKW/hIKoNOtxrS35YwMATX6d6SwOKigVXHnTmLqE8uVCjM5DVZWZt0PeUaPXUFRP
 V3wb1WEQvSB5+deeIWt9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iP87hpimuU=:aQDq9ENtjNP835KvRfeHNc
 nwNqBPVIJkiM4a7snK3gJWSXEaca3mPqMoPNlaFRq+YPi9X6wmurjh/SCyxo+g0ypZ+g3F82n
 VN1gVqIymOAZUHqENFR1fFGHTZFXI8w3rM4wdqiqllAEQiOrmkqey1ieK7br+U4Y7mb7OoMFy
 +G/eJBcNODNa0TGjOQ4u58rV2cwa4Vic582tHYhIoU8Hh2QWnvTw5DYBB3KXJubdovNdiL4BQ
 SkhF6dZwkKAp9HM0/8A1AUyJqGdHYPd4Ovvzl+YduPhYWTL0WA0tJyngFQ9ynIP9uyspYMmP9
 7NjDF5k7fL/E05blLI+fOy5OyvCSPHMhlehovLfzMKAEHNPs9T4StkjquLTbOPcEFSPWRF6CH
 8reWhCps5dzme3Y2slI7ZqFJIKbg8kgvzCwcWUya9V1J3ft+B7mw/N6Oa3av+9iZt1d7qndEy
 AWfuX2Md98FjtV562iGYYxMH3YbNmzmjYy6SP4hN0YOhGB+K2gKu3TIuNaD+3nprxull+/RIC
 g+Z12UgMUY6r6IISgW9PiEz8hbzAeC0+Ctg2jJ2HKJOdapZpCWaPpQVtbReoDIuVZgXM1gkEg
 bGUIaCYzED5lRWfgi9JYiUjvdIL4u2UIXMS8RxXxJncjnfrL7UVBeP6Nhn+URJfZA+wpIhuGF
 FjZVq2ffhmiawrCxKgiYAbB2Oaa0pTsT2IItWOUfIaJl+WNngetmzfGthGAtcRlohVAJqZkJg
 MJCYNNkR6qgaXuV+/pSWqNCz78qZPFeZJvWVXguD3kWGPBdoO9jR+kjiwc7gKie8uDOnKY/Ju
 /PJtYukfOy9UQTgU85ZzI4PRJASv3RQzcpuGEGk78odHU6B/icoCCHWj041CHQsgQwlEzDPnV
 qctUN/vy+NQfMhWG6u8iXr+WSxQfWJZ/8keFFZCM19aUdyoz4TjWkAdQbUXfXkd9GfPH/grap
 umvh7KhqR5yj/VYi9fVGBq6sW7OlpGmV74YB8U+bQ/wPMd8IW4kbNSoP6laU3/QNTby/wbhTD
 cNXuGYZZQbgEuB77DOEJ1vqF81An+Ofwn6EU0jtN7+K6UlNo+O/QHa1KfY7W+eun++qam5u9r
 6xOZzKbNxDyqnTod3M+VrPNM67pQtbPEMPCStY/jDEwBIkKNG0mcOq96DPzfRABqow3Gg30j5
 3vzKk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.3
Subject: [Qemu-devel] [PATCH] ivshmem-server: Clean up shmem on shutdown
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

From: Jan Kiszka <jan.kiszka@siemens.com>

So far, the server leaves the posix shared memory object behind when
terminating, requiring the user to explicitly remove it in order to
start a new instance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 contrib/ivshmem-server/ivshmem-server.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-ser=
ver/ivshmem-server.c
index 77f97b209c..9b9dbc87ec 100644
=2D-- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -370,6 +370,7 @@ ivshmem_server_close(IvshmemServer *server)
     }

     unlink(server->unix_sock_path);
+    shm_unlink(server->shm_path);
     close(server->sock_fd);
     close(server->shm_fd);
     server->sock_fd =3D -1;
=2D-
2.16.4

