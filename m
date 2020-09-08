Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D69B206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqPTPYhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D69B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbC3-0008G7-FU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFbBL-0007py-UD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:48:59 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:41708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFbBK-000394-BB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:48:59 -0400
Received: by mail-lj1-x236.google.com with SMTP id y4so19386483ljk.8
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=H6NqE5JunFUx7o7L3kpqoMWCA2TpDBnoIMk34rsNFqk=;
 b=tqPTPYhdW/h+XFyNm/w3HTpIDOotgUQZNNMwB++kMe5MCdzQoIjXcYsDqLeuSOXkqd
 Bj/82t2LhsOAClrQ1IHMvrjLlqiRRYU64BuHSpbxY7ODVHthcvn30HPIs61Dwzvaw5xg
 0Iy71JklXaVh1/xM9n1N9ANKiXmksQ32blp+/Jpc31VVbJtW0luvTFlAQuJ9+WlstbiC
 5MGFHZNQKgzoPNPucORuGUonzoWmR5HURgE0ysRp+Q2NMms+48MlOyhfrmHqwwynZaK8
 vI5Yecvz4kTAX4r7g64dTSHGP1pRryZFZFzE1i41/sYj7+JWPXGBSXh53Zg8OW/SLZtF
 6ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=H6NqE5JunFUx7o7L3kpqoMWCA2TpDBnoIMk34rsNFqk=;
 b=aUGG9awp2U3cycmwJ/BPSOqehfUjXMQOUeyp40uogYe5KJEGxv1TkmjTxBqRe0GX+L
 zRmvcs0Zs2xtiZxgXAjRKpl5VgTplP2Hp/DY6bIuUSfe7F753b29MPJRofhWyXugVlnf
 xeywzw8FxjJESyZAvesYDjDZvqcttDzcyBSEgb4yzYcZx5LRGezOVa5KVIeKCbE57pOF
 sNMlc9bYiZu3Od3xW2XCjEJQXJbj4BWoSijIGoCKs55m0kGrwTED6uCBTyOmGm7LKm5m
 mqfstF08RyseKg7fXUatZT9h41dpX5ERgVqou4kjirpR2+JxS9ZJYjWFWU8gIPKWlnNH
 8Yhw==
X-Gm-Message-State: AOAM532uvzGAJ3uwvSW/skIkgxHaJFvikpkcvsS5IyktdsV4BKBwAigT
 NFyWkMz5oCY+NqbpQbVOg46hm7V3kykshLg/qNOiYHekgriB3T4z
X-Google-Smtp-Source: ABdhPJxoQUXtvHAPRBaiGIXkEa2/Rde8fOD5Zsoc+t+s6Ko0BTWS53xo+2IYfbsEk1IcbD/XiSI0gVb50nRVVhTLza4=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr12228163ljj.120.1599562135664; 
 Tue, 08 Sep 2020 03:48:55 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 18:48:46 +0800
Message-ID: <CAE2XoE8P4YjfqAFZQS+6rcMcxbTF86AdeQA9AAD+27VbLtSveA@mail.gmail.com>
Subject: test-logging.c are failling because when removing those logging
 files, the longging file handlers are not closed
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e47cbe05aecb1453"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e47cbe05aecb1453
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I found  qemu_log_close use  call_rcu with  qemu_logfile_free to closing
log files.
What I need to do to wait those logging  files closed?
I tried to using synchronize_rcu but have no effection

void qemu_log_close(void)
{
    QemuLogFile *logfile;

    qemu_mutex_lock(&qemu_logfile_mutex);
    logfile =3D qemu_logfile;

    if (logfile) {
        atomic_rcu_set(&qemu_logfile, NULL);
        call_rcu(logfile, qemu_logfile_free, rcu);
    }
    qemu_mutex_unlock(&qemu_logfile_mutex);
}

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000e47cbe05aecb1453
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I found =C2=A0qemu_log_close use =C2=A0call_rcu with =C2=
=A0qemu_logfile_free to closing log files.<br>What I need to do to wait tho=
se logging =C2=A0files closed?<br>I tried to using synchronize_rcu but have=
 no effection<br><br>void qemu_log_close(void)<br>{<br>=C2=A0 =C2=A0 QemuLo=
gFile *logfile;<br><br>=C2=A0 =C2=A0 qemu_mutex_lock(&amp;qemu_logfile_mute=
x);<br>=C2=A0 =C2=A0 logfile =3D qemu_logfile;<br><br>=C2=A0 =C2=A0 if (log=
file) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_rcu_set(&amp;qemu_logfile, NU=
LL);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 call_rcu(logfile, qemu_logfile_free, rc=
u);<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;qemu_logfile=
_mutex);<br>}<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo</div>

--000000000000e47cbe05aecb1453--

