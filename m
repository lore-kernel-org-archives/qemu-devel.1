Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBCAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4FE20732
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNX89SOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4FE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbHm-00054O-Pn
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFbEy-0002jN-3j
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:52:44 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:40129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFbEw-0003oJ-8T
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:52:43 -0400
Received: by mail-lj1-x235.google.com with SMTP id s205so19438704lja.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to; bh=S8AEL3jiz4BmRinzbue6XlOtUIgwP2k9DaLdM+OR0To=;
 b=CNX89SOkHQEy4yUvvBTFhIdM75+qWxxWTtvTFEfBfpWQe7vrCAXcEz2CNLpCfkFYWU
 xhTYmXKEsEg38dQESsLJyzOSjVDgW8rfQBnyKuO57U36dS8jKGFTNcjy5+594I886C3F
 s0JmQntBEuwcs/Uy1uQOgrCngDwW3Xg0wuVXJ0VucGpxXGjkB0WBAbbTKdNQo9Ih+qss
 Nwtjfrxp04maJEULjaYSxATWxdqm9VvbHk9/JPd3yK7B4XbxziYjWYrxnpP7Q4l+tZfV
 almWKlijNZ1JlsowgycDBf9ivs108h+RWvG4v3iOVikFIabWnn+nCTKBr5R+MtTbAIkF
 LFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to;
 bh=S8AEL3jiz4BmRinzbue6XlOtUIgwP2k9DaLdM+OR0To=;
 b=oB5o7ibfg+9/9b1suSIgztQ8yvthvGrGTxZSwhNKSca3uLvpjywjIyql+ARdCS4krS
 jb7Ggey4CKw3xC9TjFhVNjMcC8kiOQbwAYRyb6HUo3DVEobhmi8Myifv9XCaaamkbJZ8
 R2yyz6BFDgBAnmM5v1S17Azx/VLWgsG2k0+SAxI6z9ccfsXs0JJBwS5Ww87CFSsn0MW8
 NQXtetVJN5EKyK8/SE3qU37aWYuCO9x5HJib1CfnXwvZx55sLKd9YZWe1APRUjP8vdPt
 j5lRGZB1g/DRQZbo1HYVgpzOKJ8Fmnws117LzF7yG7kzFTRsTi+08Ru4xU4VEY1Eefrm
 MXtw==
X-Gm-Message-State: AOAM531PlLBayl7CrVoKQCMyflLumdVERDWmAKhh8cwLsSIbL8Cpe3T+
 K10B03/upwplJ1cfcrd4rVRAHWtHDvOrKlA02BK8wtHJgwR1o5RB
X-Google-Smtp-Source: ABdhPJyLdNeCK24rcISMUYvQZM3ICqrSrGqHABcmgjXHJk+NS3ma0H8l2rV0gbsShak7ahjGky+q16r4H0s8E7jqPDw=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr12235204ljj.120.1599562360619; 
 Tue, 08 Sep 2020 03:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE8P4YjfqAFZQS+6rcMcxbTF86AdeQA9AAD+27VbLtSveA@mail.gmail.com>
In-Reply-To: <CAE2XoE8P4YjfqAFZQS+6rcMcxbTF86AdeQA9AAD+27VbLtSveA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 18:52:31 +0800
Message-ID: <CAE2XoE_DhvVNV4hL_x1N=5SO4GToLRvnt9AWvroFbqbFg_dYGg@mail.gmail.com>
Subject: Fwd: test-logging.c are failling because when removing those logging
 files, the longging file handlers are not closed
To: Thomas Huth <thuth@redhat.com>, Robert Foley <robert.foley@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Miroslav Rezanina <mrezanin@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004d075905aecb22df"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x235.google.com
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

--0000000000004d075905aecb22df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is the errors:

 ./tests/test-logging.exe
# random seed: R02S3184056dae59ebe73ccdba81f5807d40
1..4
# Start of logging tests
ok 1 /logging/parse_range
ok 2 /logging/parse_path
ok 3 /logging/logfile_write_path
ok 4 /logging/logfile_lock_path
# End of logging tests
**
ERROR:../tests/test-logging.c:196:rmdir_full: assertion failed:
(g_remove(entry_path) =3D=3D 0)
Bail out! ERROR:../tests/test-logging.c:196:rmdir_full: assertion failed:
(g_remove(entry_path) =3D=3D 0)

---------- Forwarded message ---------
From: =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com>
Date: Tue, Sep 8, 2020 at 6:48 PM
Subject: test-logging.c are failling because when removing those logging
files, the longging file handlers are not closed
To: qemu-level <qemu-devel@nongnu.org>


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


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000004d075905aecb22df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>This is the errors:<div><br></div><div>=C2=A0./tests/t=
est-logging.exe<br># random seed: R02S3184056dae59ebe73ccdba81f5807d40<br>1=
..4<br># Start of logging tests<br>ok 1 /logging/parse_range<br>ok 2 /loggi=
ng/parse_path<br>ok 3 /logging/logfile_write_path<br>ok 4 /logging/logfile_=
lock_path<br># End of logging tests<br>**<br>ERROR:../tests/test-logging.c:=
196:rmdir_full: assertion failed: (g_remove(entry_path) =3D=3D 0)<br>Bail o=
ut! ERROR:../tests/test-logging.c:196:rmdir_full: assertion failed: (g_remo=
ve(entry_path) =3D=3D 0)<br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr"><br></div><div dir=3D"ltr" class=3D"gmail_attr">---------=
- Forwarded message ---------<br>From: <strong class=3D"gmail_sendername" d=
ir=3D"auto">=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)</strong> <span dir=3D=
"auto">&lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</=
a>&gt;</span><br>Date: Tue, Sep 8, 2020 at 6:48 PM<br>Subject: test-logging=
.c are failling because when removing those logging files, the longging fil=
e handlers are not closed<br>To: qemu-level &lt;<a href=3D"mailto:qemu-deve=
l@nongnu.org">qemu-devel@nongnu.org</a>&gt;<br></div><br><br><div dir=3D"lt=
r">I found =C2=A0qemu_log_close use =C2=A0call_rcu with =C2=A0qemu_logfile_=
free to closing log files.<br>What I need to do to wait those logging =C2=
=A0files closed?<br>I tried to using synchronize_rcu but have no effection<=
br><br>void qemu_log_close(void)<br>{<br>=C2=A0 =C2=A0 QemuLogFile *logfile=
;<br><br>=C2=A0 =C2=A0 qemu_mutex_lock(&amp;qemu_logfile_mutex);<br>=C2=A0 =
=C2=A0 logfile =3D qemu_logfile;<br><br>=C2=A0 =C2=A0 if (logfile) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 atomic_rcu_set(&amp;qemu_logfile, NULL);<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 call_rcu(logfile, qemu_logfile_free, rcu);<br>=C2=A0 =
=C2=A0 }<br>=C2=A0 =C2=A0 qemu_mutex_unlock(&amp;qemu_logfile_mutex);<br>}<=
br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=
=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>=
Yonggang Luo</div>
</div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div></div>

--0000000000004d075905aecb22df--

