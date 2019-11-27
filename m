Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260EC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DBE2080F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aOMsJVdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DBE2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia4nh-0006rw-NX
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 16:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1ia4bZ-0001As-55
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1ia4bY-0004L1-2o
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:12:09 -0500
Received: from mout.web.de ([212.227.17.11]:52687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1ia4bX-0004Gr-Je
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574889096;
 bh=a5HMcSi8BUK0EG5pE/ziARVSZAvE4Sj3WFiLwoqPXO4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aOMsJVdWJuQNMEtHXz0TKDF38MztnIX/iFt/ZIw6BkfCn1CDh+EyKvwhZYmHiLCTa
 uutTqMccorLD3t+GMckocdH74Z5rIj68fnGS8LW06+p29oMGVk1SYveTMU448vR892
 baatdU1dgKJtSEyO5Zcf1zpRxfZAfg8PJWPnpdHw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.185]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZlR4-1iEYfW2pN0-00LYlg; Wed, 27
 Nov 2019 22:11:36 +0100
Date: Wed, 27 Nov 2019 22:11:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/4] colo: Introduce resource agent and high-level test
Message-ID: <20191127221134.2b439e00@luklap>
In-Reply-To: <20191122094646.GA2785@work-vm>
References: <cover.1574356137.git.lukasstraub2@web.de>
 <20191122094646.GA2785@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GKadwlqT0LO5uWKRztE+q7+WQdbJdwhhfmnkbpCUKoWZykc+lZz
 v8dm+2cM+PxlsN9SZByWbA40d/vBzqn0kQTK81NOqCg4gTPwKwy2FBVB8pd2PZA65B3KRqi
 +n06A63gAV/GaNyQ/EPB6GzK3LrhQOKmukNRie+HQLLV2Xx9ByBR6wf7t2lbNVSP6bwjK0Z
 LfvOVJdHs+PTYiFi1Hf+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+MuZjeNPC4=:9P+msCcJ8tNNciZskDcGXq
 5RdWQ/1CcTL/iwiZ+Tbt+ozwJxrGmQYuWKAwNaoff15WJZFkczVVcuQDCpN4CLu+nVDvej2cU
 nkilvfB61aDpx/rzeYGa7lTgFi6tAabQLGqbyGkcL+uKlr5jVZvcI/Q/p7mdzBq7jqU4PgYc1
 zik0CkEjvYydQ/fxzIJqzkxEt5Lvk0yZREd7Jk0GSS8IRVjLBB5uQB+BjDAcC7RhDOZRh+PIt
 BKNytD7MpjRmESjY+qEDCrvi4u8GpvnUm1Wr+DKjy8pbwUjuP24eZalvYXYtrGsJQ7dBxPapB
 kWwdWSYMPGHGOcVRUbYxX7BtG0CB3c4Ktz9DCwD6UHLXYGOsrljIVNn4cjee48SDVho/qDId0
 jfFy/jAQjJi+HZL0XIFE6yVTirYQPGDAtIPlK6de0k+8vn9tQykQXSLF5n2X8/12QehBDo0fq
 jqkHhV5mVMkC1+413zXGt3/IebSmo8Iwn657ksdkcT87XJzpklhY9x/SA1NwHsotQlndiT8G7
 WFiEmJ7u4m9ANF24fQjbdZ8t5SNPdEAMvBnqQ8lQuBdzEW1Ivke5XgyxAbAbGSDr0OrymUwT3
 7ZtqvZOMuGx3jfaVIIYWyly6AfMpnZbHs5o1jngSAn4oblm9AbkKHaqCdm10n5NfBj96pxrE9
 c1KjAkojMMZ6pWxx877koVSvTAsgIf7899lHLYpIMq8IPeGOpoJ/uVYcAI02sNfeopWvI4DPx
 skTZrcKNmqUd4iMWl/TV1OIXSgropp69EI8ml+BjOHiCH7rUWJOwjFMnxgj8DTzxTB4Iy2oYt
 UZWUgLW029D4AWzI7yhmNkel/85l5YBiLxm2Om1XARlL0wTjrHdyHvDZ/TPpk/mj/x8wceBwx
 fUspqX9xNrJVf1ZzTkvU9TCWAP2+qHg79MzujGEXeCW9vLRBzvftaKqAdPD0yslgylEfgHN0Y
 mWHpZeMjilBGogOoto0RGGOXwSh2uMmYiwICbY7MrbbWgwAmpxthqIIbKRtrF/fYm6sGKOZ1S
 jAFDgV0dL7OAKY/+YPdnix4oVwiia3N16qfNYWEMGrkv6TofoHDt+aydQuo2g60XGCS0WH1KV
 Q/nPQlHjD6JfyY2o1TnthauNAy2x8ZYFA59+caC25y9eJr4q1VxQUtJO0nAPOz+FoFXEqliFL
 izBID9VwLKQCm9diNtTSe1ONXYd0ar5vQJxPlQI0SOKeTocYJm/FG/49gtKw7YyTlesj8UjQI
 RmGVT39gAQKEPJgRsCdgT2ZQGNXB6YRLO/sBIJuBgDedqSoRV+2uXKiBoNFs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, "Zhang, Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 09:46:46 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Lukas Straub (lukasstraub2@web.de) wrote:
> > Hello Everyone,
> > These patches introduce a resource agent for use with the Pacemaker CR=
M and a
> > high-level test utilizing it for testing qemu COLO.
> >
> > The resource agent manages qemu COLO including continuous replication.
> >
> > Currently the second test case (where the peer qemu is frozen) fails o=
n primary
> > failover, because qemu hangs while removing the replication related bl=
ock nodes.
> > Note that this also happens in real world test when cutting power to t=
he peer
> > host, so this needs to be fixed.
>
> Do you understand why that happens? Is this it's trying to finish a
> read/write to the dead partner?
>
> Dave

I haven't looked into it too closely yet, but it's often hanging in bdrv_f=
lush()
while removing the replication blockdev and of course thats probably becau=
se the
nbd client waits for a reply. So I tried with the workaround below, which =
will
actively kill the TCP connection and with it the test passes, though I hav=
en't
tested it in real world yet.

A proper solution to this would probably be a "force" parameter for blockd=
ev-del,
which skips all flushing and aborts all inflight io. Or we could add a tim=
eout
to the nbd client.

Regards,
Lukas Straub

diff --git a/scripts/colo-resource-agent/colo b/scripts/colo-resource-agen=
t/colo
index 5fd9cfc0b5..62210af2a1 100755
=2D-- a/scripts/colo-resource-agent/colo
+++ b/scripts/colo-resource-agent/colo
@@ -935,6 +935,7 @@ def qemu_colo_notify():
            and HOSTNAME =3D=3D str.strip(OCF_RESKEY_CRM_meta_notify_maste=
r_uname):
             fd =3D qmp_open()
             peer =3D qmp_get_nbd_remote(fd)
+            os.system("sudo ss -K dst %s dport =3D %s" % (peer, NBD_PORT)=
)
             if peer =3D=3D str.strip(OCF_RESKEY_CRM_meta_notify_stop_unam=
e):
                 if qmp_check_resync(fd) !=3D None:
                     qmp_cancel_resync(fd)



