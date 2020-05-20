Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA38C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1622C20758
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fp/IYFg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1622C20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVlm-0005Y2-2l
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 16:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXt-0005ou-ID
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:33 -0400
Received: from mout.web.de ([212.227.15.3]:34685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXs-00079F-JK
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590007345;
 bh=rI0siZjB1fnXQBtvS0qkV9XKqMdAQZHTmQcm9q2ms80=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fp/IYFg1mY9KYSufwivykFYkZ3B2aZ/fxAJNGFe69WDcp2D7YR1uaALHs6HSU48rI
 ezq3UHtb0TVep4SIAkwcN3n822UhpgKfS8r806lo+BF110I8pSWp5r1jR05n4jrMy2
 mrja6sRfVapra7W85h/0nkczFoJRoSy8/ogk3blo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LshGz-1ivPZY1Ygz-012Foq; Wed, 20
 May 2020 22:42:25 +0200
Date: Wed, 20 May 2020 22:42:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 4/6] migration/colo.c: Relaunch failover even if there
 was an error
Message-ID: <85df331bfe69661072d9f29b616f065ca261f471.1590007004.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590007004.git.lukasstraub2@web.de>
References: <cover.1590007004.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5kTYTU/5IwxYSoMwMX_qhmS";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:L3cYkJcfcO04JSDwvaPz2lFaFK2ur+1NvpQsnqJLp6zlV6L0/mq
 JL2MeDqtaOUEPGh389v5NTKzCUr/A9421cqcAETznYwfIZrpRIhdiMZAjlKnTZSDuWD8hAt
 4no/Y1BGx5dwFHW+3ZhduK5WDX0lY3B3/TZ5B5hrG9ORdp/V3yyD6qqgDJuXEI6G1CMc8SN
 OmLxzUDnOhXZWjMARVkAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H45V3UIycU0=:MhMKrNBUt9EbNQipKzwj2k
 qpmONqDPhBGkvRM7ts+m6UUPWKeB+0SW+Y5tPSaVDtZDsf7Gr14KqdCt8QP5NhHynvt9cqdVm
 7kGRROzIUvj6DbgT1VHUdBR214kWvHge01FMZhCoM4GF7AHrDKtFRWNUpmOlJa03tAq6uMuen
 ujSsN8lNH/qiQsx9yWtfqkEhds37z67MdjRKp9fJ0KFO26SvUJd7MxEMj1pn3AbqAVDNAYQNj
 fFvM9Vl9vIZJSg8PtJkzHK/stPZEPHc252NN9lLcO8lWYggUlLilR60IjmxEH3I+gYSpl9BaS
 DpS+m/VLbJrHnutoXWMoV5BXRQuZCHcyPOlpXQXDTcvak1wrXyST0D96Mr7/N+N6lSpyBLlgl
 sZ+V4Aw+H0ZGw6uCFXi7vlIiaJf97oPg2UmROVMYZruOBC6q3Zhaz6vQurvlekDzYAXJhj9Uz
 ByHXtilUJ69hABaTs4BwKaqf9Grd+DnnRDxpC+fY4A1p6xTVUJGS9eKbpbAhboItoLRCEnobE
 KWP6elnGdpl/1mvPuyJN37GZ4vllG3N6nbVfuOGA7Xl84nSRR8CVGhuFBESTUTgODjMY9tI5D
 n9MAOifQF+WncHG30lujDSVteNUnimrJsvXCBC96Bwvr168c9m14XBThXp5/Tq94NsHJn3GSF
 kY7nRHCKrSDCrfKpd0/5rMikQ3yy8Z85KItVCblrUGJPGT3ZGrw305YHYEwl3TbBN/gjyoXnb
 15YaxD6/0vNuIsc+km2hn+0ccAy/sUfc6H6NlwcXktSQUEwfJ3s1o54YXXYYnsSHNnY+VtBZR
 KFVH9f3qJ6YOMdwU53q6ybaU29LiQmwq8T6z4TXlbJ0I03DAvyWgzM+MYioEOmGjxvLIn/QTt
 21vPJSIP+C/NZqDwAsSOxCbNc7gxfqoC2m4oh1V/okT7CtLi8H4ApAZtNEtqRvzOXUpy1QIAu
 Qtlmbf/2ThtPX5shsVCWEV+D18Dx+GZ5arYCrWxT5DjdkQ/FyRojkJzqoyuD2tU+VxQcTYJWh
 TMVVa42KFHAx/eQ9ZqmGqpZ/83H1bS5LzCFZQLyOzHgkKq8jiJ4HWcVEcRbmfcj8ssfR0yYmz
 mwXPUWDiHuBiyWtyeV+koYiF+Wvfs0KWuCfB4iv5nis5jFZfBupVH8ADjp39oHLIg11scuv3a
 btXAZC0zke785hcP0jHucM3z6OjLDKbNAVAFuPiVARoGAn0EjLpLdiQPsXfYt/HTwsfNNNNA9
 5C3pQSYe9sorHV0rq
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/5kTYTU/5IwxYSoMwMX_qhmS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If vmstate_loading is true, secondary_vm_do_failover will set failover
status to FAILOVER_STATUS_RELAUNCH and return success without initiating
failover. However, if there is an error during the vmstate_loading
section, failover isn't relaunched. Instead we then wait for
failover on colo_incoming_sem.

Fix this by relaunching failover even if there was an error. Also,
to make this work properly, set vmstate_loading to false when
returning during the vmstate_loading section.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 2947363ae5..a69782efc5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -743,6 +743,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     ret =3D qemu_load_device_state(fb);
     if (ret < 0) {
         error_setg(errp, "COLO: load device state failed");
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -751,6 +752,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     replication_get_error_all(&local_err);
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -759,6 +761,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     replication_do_checkpoint_all(&local_err);
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -770,6 +773,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,

     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading =3D false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -780,9 +784,6 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     qemu_mutex_unlock_iothread();

     if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
-        failover_set_state(FAILOVER_STATUS_RELAUNCH,
-                        FAILOVER_STATUS_NONE);
-        failover_request_active(NULL);
         return;
     }

@@ -881,6 +882,14 @@ void *colo_process_incoming_thread(void *opaque)
             error_report_err(local_err);
             break;
         }
+
+        if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
+            failover_set_state(FAILOVER_STATUS_RELAUNCH,
+                            FAILOVER_STATUS_NONE);
+            failover_request_active(NULL);
+            break;
+        }
+
         if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
             error_report("failover request");
             break;
@@ -888,8 +897,6 @@ void *colo_process_incoming_thread(void *opaque)
     }

 out:
-    vmstate_loading =3D false;
-
     /*
      * There are only two reasons we can get here, some error happened
      * or the user triggered failover.
--
2.20.1


--Sig_/5kTYTU/5IwxYSoMwMX_qhmS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7Fli8ACgkQNasLKJxd
slhCtA/+NEEiPBIUoM31GRt37ytqX78lDccKBgOmWo8YJdIuh3/C9hexEISicC0p
5aIZj2Hk4akqFqvP5GHddvgtWfKnbP+1dMjBGVZct6zX9cDJqqTZQXQNyH6AW3td
V8pmTQdhZg+A+ETcpMCft6XsnCha/P42F6ADx02iQo5BMb3BV1B/7tWB4BjNPSww
t5XNjkmjex4VCwqy/W+DkRJ9W0fMd0lfqZKr0eU9DW4h0pP0uNS6+J2O+llQmbzM
dBC7280TM5L0eWwOjmTvgfeGsichXMtgOUdHL2aVo8qhoGHL7hjcSCIWqgW71GFd
TKAq0FCGOGc3mm1MCDdxBGfv/vsKtC0Nx259J+QT+nrbhRCFmrqnjh7Es+PCSirN
obFLJT84It88bvz6oz3PbXBduCBliP24+dEBUo0Q+wxuhwxmMOL9Vdn2tpOT/QMm
2fTFPhh14f0Y7wJwUorG7XPCD5bRGAw1+bNvIHoRK5Krb5I/Rvl4ejXVsnO6OnXC
w81WFpp0oAey87eIKE0e5TecSlU8/+DZVB9YyfjcLR8UZmeAPEPArKl59zzTsYiZ
Mgz/X9jlWQSQUqWCxYqdZoBtcs1C4mj6Oo5USfKeXiW0Bmz3vJ0zEEj5iJ9pYUEb
l5IeabbmPUawoZDCqeswRABUayoWkuJbduywV3gufKISdjq5nRk=
=ViO6
-----END PGP SIGNATURE-----

--Sig_/5kTYTU/5IwxYSoMwMX_qhmS--

