Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF0EC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4CF2098B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UomVDQFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4CF2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkcU-0005C8-E1
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFkbx-0004iA-PN; Tue, 08 Sep 2020 16:53:05 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFkbw-0002Qe-1j; Tue, 08 Sep 2020 16:53:05 -0400
Received: by mail-lj1-x243.google.com with SMTP id u4so644364ljd.10;
 Tue, 08 Sep 2020 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=LD1xMJ3m+ssgVoZDnsek+ObU+jPPgZptuupRocZz4oA=;
 b=UomVDQFvGzf31q5GJTc1lOncOrgWz38pu78zx5/eHwbCEiPki4f2K2OgQsU2TfPqER
 fmgxk+TADjnoWdV6ub4sc6Vtrn90gjNBfJa0YHlOfwyBNgOU1c7J7pc6xMk46GKKTeaP
 OjX0N7No6nUt+Mrn4+jp/Ux+CgI512CPbDjFOGP4F7fcLBpp2YsAc+xqARvu9rEI+gjT
 uvsL3mA6RBOGAEsbv1r/9BFCuK+1vUG2hUx/2EpuqgAS1bgb6cHk8MDnl9K9cIP/MC4s
 Fsv4sWCeMnoJX9uVrHXt2U5CIYlO35veixFW/ZxF9nLc2wrox4KEZEJWXz2bsgHu1YKn
 AFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=LD1xMJ3m+ssgVoZDnsek+ObU+jPPgZptuupRocZz4oA=;
 b=cc7K5jwrt+XoantZGkQ0CJUjTa8IwhDgqG6ltEhJ0GRy+0Yx+hejZC7mciqJnU8+WI
 JxqoNqVTJApnccIK30o+bjly7M4buVu6WHEzCt2FKNGAu3MGjcZzKdS0MZoMKepMzru8
 rRtkjLCXhrBKSXUaPLnuNO9o6P4O/1DGuHU2L73uKVIMXSs9xqRhMT97WoH+vGeK2KZu
 x5aiZrbT1XNM0wfXaMifJZtNBWV9CctpjZFiOY5Cz7fqPxqlL5nLfL/WB3Pix2VVmvH1
 q6yK92xNHnslUTVbvI23B9B7ntF/oLh6rUj0IolEmZTWQmCc97/Xq2yNlkt/u6ny6wt3
 cimA==
X-Gm-Message-State: AOAM532kbDe9hqGMLoXAoR+q2y3SUf72o7Z2aWcmgTIKaZI4Rihyslwp
 5XLdSFUnQSBdq8tW4fWM7boHXNWG8V1HursGw+8=
X-Google-Smtp-Source: ABdhPJzU3uNPfA2gs1g//ZV+QgxAVAN89cDJcRdvAkKvLGqFBRsr1vbG1RGt8tZzCDHB648GJxe/9p5BZmQufbN2e14=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr190347ljj.368.1599598381960; 
 Tue, 08 Sep 2020 13:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <ffbf4759-18cb-9162-5900-843d89aa1cfb@redhat.com>
In-Reply-To: <ffbf4759-18cb-9162-5900-843d89aa1cfb@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 04:52:50 +0800
Message-ID: <CAE2XoE8JFROYyYUddcm4PLx2CdPg8PWAKXc875X6zjxDYof2RA@mail.gmail.com>
Subject: Re: [PATCH 00/16] W32, W64 patches
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005712d405aed385a2"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005712d405aed385a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:42 AM Eric Blake <eblake@redhat.com> wrote:

> On 9/8/20 2:48 PM, Yonggang Luo wrote:
> > It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses an=
d
> > disable partial test-char tests.
> > And then fixes a number of unit tests failure on msys2/mingw
>
> Please remember to include a version number (v2, v3, ...) if this is an
> improved posting of an earlier revision of the patch series.  'git
> send-email -v2' does that automatically, for example.
>
> See that, I am using git-publish.py script, next time it will comes with =
a
v2.

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005712d405aed385a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:42 AM Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/8/20 2:=
48 PM, Yonggang Luo wrote:<br>
&gt; It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses a=
nd<br>
&gt; disable partial test-char tests.<br>
&gt; And then fixes a number of unit tests failure on msys2/mingw<br>
<br>
Please remember to include a version number (v2, v3, ...) if this is an <br=
>
improved posting of an earlier revision of the patch series.=C2=A0 &#39;git=
 <br>
send-email -v2&#39; does that automatically, for example.<br>
<br></blockquote><div>See that, I am using git-publish.py script, next time=
 it will comes with a v2.=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000005712d405aed385a2--

