Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAAAC38A2B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B8722202
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrBOuJLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B8722202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPVpT-0005x8-08
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 14:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leoluan@gmail.com>) id 1jPVo0-0004SA-8U
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leoluan@gmail.com>) id 1jPVnx-0005wf-Sg
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:33:36 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:41008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <leoluan@gmail.com>) id 1jPVnx-0005u3-Mi
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:33:33 -0400
Received: by mail-io1-xd34.google.com with SMTP id b12so3358482ion.8
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=gqWyM1NUsDEgwukS7pgzVFpqxPCykt/KGKvJC0x5ZK8=;
 b=RrBOuJLkGXO8lVWwCENZcFx0vTwAlyr77uV9zpkJPi8IFJtYV1eMpft0M1trdyJpmk
 xOy0GdembnvEbxhbsXDrnAiXP6diSxbHVcuIeh3U92jaLYUn/+L//HLT50RapVkF977X
 Q4wS5R190Xy4pXer3zB4N7tTYw2OKWMlClkgzC0M5a782hfm8efuBOH4ifXOam8hAcyt
 nf0Il5Rv5uuM2Q0/kbbsMG8R9lZJTA6t2pywacHivcWI9g4grt2iys+dmCzuE2PQu4B6
 NfmJVoYB2nhpbLYEf31mi62OFCVdX4WanTI+M2ffjFoDNPjow2RtfJpcYVNq+HmJOzlF
 ONAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=gqWyM1NUsDEgwukS7pgzVFpqxPCykt/KGKvJC0x5ZK8=;
 b=Vz+hGhzP3LIUd3fTyUi0tskEvjsd8P5Lx4srGcjM3vV76LvdhtjyrJ9tvCRLq4AdU8
 zv6ih2hRk7skbDnlLRnGjn1eiheaGgo3CGZjE45WCfvp7ANfMBuU/QFb+s5uJVjNNYsD
 4MEaSA6bATD9OJe+7q/AvRDPAnELDaTUCdL26ItJFem6cyI/aAuuBrnFiR+jxVqDdrOO
 UFbVpAEVHnuBFx51XrAvoST01xUD8B7Hc4KAKk3rQ1j1wnAgzodAePNWB+Oqo+daP9aN
 JvL0a9/gSfXqPxMPg8I0CI7Ha8lPphID3tFi4WJnJJkQL5RWLHRM6/FSRzbI6LwKMLAN
 XP0w==
X-Gm-Message-State: AGi0PuYCX7C5GwHVJYpS4mqXtLYZ/lKOXytQvJg/WB+Ml+HHXrgj3FQt
 R5MMzWxSstRV3Lughr7nTZ6jFk0Hite2g5RPAvbZ2Obn
X-Google-Smtp-Source: APiQypJjt5qHudyFk/2jUVYv9+lOXSDetKAk+0+OQE26LR+fQ59kX/qfFEDNwCmge5+8xdBx7d/FX4csRxOFNDLKF7E=
X-Received: by 2002:a02:1482:: with SMTP id 124mr4610111jag.4.1587148411454;
 Fri, 17 Apr 2020 11:33:31 -0700 (PDT)
MIME-Version: 1.0
From: Leo Luan <leoluan@gmail.com>
Date: Fri, 17 Apr 2020 11:33:20 -0700
Message-ID: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
Subject: Avoid copying unallocated clusters during full backup
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000045486605a380c9eb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d34
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

--00000000000045486605a380c9eb
Content-Type: text/plain; charset="UTF-8"

When doing a full backup from a single layer qcow2 disk file to a new qcow2
file, the backup_run function does not unset unallocated parts in the copy
bit map.  The subsequent backup_loop call goes through these unallocated
clusters unnecessarily.  In the case when the target and source reside in
different file systems, an EXDEV error would cause zeroes to be actually
copied into the target and that causes a target file size explosion to the
full virtual disk size.

This patch aims to unset the unallocated parts in the copy bitmap when it
is safe to do so, thereby avoid dealing with unallocated clusters in the
backup loop to prevent significant performance or storage efficiency
impacts when running full backup jobs.

Any insights or corrections?

diff --git a/block/backup.c b/block/backup.c
index cf62b1a38c..609d551b1e 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -139,6 +139,29 @@ static void backup_clean(Job *job)
     bdrv_backup_top_drop(s->backup_top);
 }

+static bool backup_ok_to_skip_unallocated(BackupBlockJob *s)
+{
+    /* Checks whether this backup job can avoid copying or dealing with
+       unallocated clusters in the backup loop and their associated
+       performance and storage effciency impacts. Check for the condition
+       when it's safe to skip copying unallocated clusters that allows the
+       corresponding bits in the copy bitmap to be unset.  The assumption
+       here is that it is ok to do so when we are doing a full backup,
+       the target file is a qcow2, and the source is single layer.
+       Do we need to add additional checks (so that it does not break
+       something) or add addtional conditions to optimize additional use
+       cases?
+     */
+
+    if (s->sync_mode == MIRROR_SYNC_MODE_FULL &&
+       s->bcs->target->bs->drv != NULL &&
+       strncmp(s->bcs->target->bs->drv->format_name, "qcow2", 5) == 0 &&
+       s->bcs->source->bs->backing_file[0] == '\0')
+       return true;
+    else
+        return false;
+}
+
 void backup_do_checkpoint(BlockJob *job, Error **errp)
 {
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
@@ -248,7 +271,7 @@ static int coroutine_fn backup_run(Job *job, Error
**errp)

     backup_init_copy_bitmap(s);

-    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
+    if (s->sync_mode == MIRROR_SYNC_MODE_TOP ||
backup_ok_to_skip_unallocated(s)) {
         int64_t offset = 0;
         int64_t count;

--00000000000045486605a380c9eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>When doing a full backup from a single layer qcow2 di=
sk file to a new qcow2 file, the backup_run function does not unset unalloc=
ated parts in the copy bit map.=C2=A0 The subsequent backup_loop call goes =
through these unallocated clusters unnecessarily.=C2=A0 In the case when th=
e target and source reside in different file systems, an EXDEV error would =
cause zeroes to be actually copied into the target and that causes a target=
 file size explosion to the full virtual disk size.</div><div><br></div><di=
v>This patch aims to unset the unallocated parts in the copy bitmap when it=
 is safe to do so, thereby avoid dealing with unallocated clusters in the b=
ackup loop to prevent significant performance or storage efficiency impacts=
 when running full backup jobs.</div><div><br></div><div>Any insights or co=
rrections?</div><div><br></div>diff --git a/block/backup.c b/block/backup.c=
<br>index cf62b1a38c..609d551b1e 100644<br>--- a/block/backup.c<br>+++ b/bl=
ock/backup.c<br>@@ -139,6 +139,29 @@ static void backup_clean(Job *job)<br>=
=C2=A0 =C2=A0 =C2=A0bdrv_backup_top_drop(s-&gt;backup_top);<br>=C2=A0}<br>=
=C2=A0<br>+static bool backup_ok_to_skip_unallocated(BackupBlockJob *s)<br>=
+{<br>+ =C2=A0 =C2=A0/* Checks whether this backup job can avoid copying or=
 dealing with<br>+ =C2=A0 =C2=A0 =C2=A0 unallocated clusters in the backup =
loop and their associated <br>+ =C2=A0 =C2=A0 =C2=A0 performance and storag=
e effciency impacts. Check for the condition<br>+ =C2=A0 =C2=A0 =C2=A0 when=
 it&#39;s safe to skip copying unallocated clusters that allows the<br>+ =
=C2=A0 =C2=A0 =C2=A0 corresponding bits in the copy bitmap to be unset.=C2=
=A0 The assumption<br>+ =C2=A0 =C2=A0 =C2=A0 here is that it is ok to do so=
 when we are doing a full backup,<br>+ =C2=A0 =C2=A0 =C2=A0 the target file=
 is a qcow2, and the source is single layer.<br>+ =C2=A0 =C2=A0 =C2=A0 Do w=
e need to add additional checks (so that it does not break<br>+ =C2=A0 =C2=
=A0 =C2=A0 something) or add addtional conditions to optimize additional us=
e<br>+ =C2=A0 =C2=A0 =C2=A0 cases?<br>+ =C2=A0 =C2=A0 */<br>+<br>+ =C2=A0 =
=C2=A0if (s-&gt;sync_mode =3D=3D MIRROR_SYNC_MODE_FULL &amp;&amp;<br>+ =C2=
=A0 =C2=A0 =C2=A0 s-&gt;bcs-&gt;target-&gt;bs-&gt;drv !=3D NULL &amp;&amp;<=
br>+ =C2=A0 =C2=A0 =C2=A0 strncmp(s-&gt;bcs-&gt;target-&gt;bs-&gt;drv-&gt;f=
ormat_name, &quot;qcow2&quot;, 5) =3D=3D 0 &amp;&amp;<br>+ =C2=A0 =C2=A0 =
=C2=A0 s-&gt;bcs-&gt;source-&gt;bs-&gt;backing_file[0] =3D=3D &#39;\0&#39;)=
<br>+ =C2=A0 =C2=A0 =C2=A0 return true;<br>+ =C2=A0 =C2=A0else<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return false;<br>+}<br>+<br>=C2=A0void backup_do_checkp=
oint(BlockJob *job, Error **errp)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0BackupB=
lockJob *backup_job =3D container_of(job, BackupBlockJob, common);<br>@@ -2=
48,7 +271,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)<b=
r>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0backup_init_copy_bitmap(s);<br>=C2=A0<br>- =
=C2=A0 =C2=A0if (s-&gt;sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {<br>+ =C2=A0=
 =C2=A0if (s-&gt;sync_mode =3D=3D MIRROR_SYNC_MODE_TOP || backup_ok_to_skip=
_unallocated(s)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t offset =3D =
0;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t count;<br>=C2=A0<br></div>

--00000000000045486605a380c9eb--

