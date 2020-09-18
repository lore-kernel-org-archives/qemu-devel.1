Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CBCC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134302076B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3zacQBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134302076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHFu-000164-6m
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJHEM-0007xX-HG
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:19:18 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJHEK-0000ja-Ef
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:19:18 -0400
Received: by mail-lj1-x244.google.com with SMTP id n25so5252530ljj.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=guH+2yAkgh+BxDdqOG/KHxX/WMrWynIe20tywraAe94=;
 b=E3zacQBRXU578vw9/HiHm1OZpzxlGAbCp91jNWGGYGbD4wlHqg3rfkQRQF9z1ZteBX
 GT3nrLsI7n4VLGRff0bKof+/BTX7ksKIuwUmgEHtTKjfSQDmfM/5QeCrDpp/h5gFvxU6
 YWu8WHyYaW4Tyglg/eg/fctDDc4NuDr3IlD4Z7/VP2Ym95gU4/1QEz2ASE5yf7/O88TV
 4g2kplva0ABzemKSr7VMT5VDCBnSlBFVkrVxcA7hCz6C67y6SJ8Brs33K9tqOxYHFQin
 RT4STg5lISEQ4zofTr5wzIw0ypZy2+mrZqDp1HtbtDalb/Lr3vy1mQ0CuZ5Vx9/86Rbt
 Cg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=guH+2yAkgh+BxDdqOG/KHxX/WMrWynIe20tywraAe94=;
 b=Qb9vmza0ALMkXGhMYXqqMzHThUtxUAmiCNpEQWsFbjB0hPyofDYeIc9SwCISHSRXyy
 hMQ+7kJeZHUoxAoKFfAKtBzIMv6/CG3q44m1mSRzbtkoLK/tpl7Ghav7IDXBrXcXxHJW
 Djgy0xFRN0cig6lnWsSCaCtG7tYUkNM25wPtOjukpi8TA32OOJhOXnjJiLu11aMiAere
 IUF3fkvD8dXBfC9NkATySXrHAgyAb0Ay7wy4MO+OHuqcVHvSmI34pFH37WqdZLybCs5H
 Rr2DE9otpduXAUJg49kn6sg6n8LfMqelNTDX34WU2EKsX9StZdcHmwtWKXPIEM+9PAHH
 o/2g==
X-Gm-Message-State: AOAM533XT/0vAtUjgKi6KjVd7XPUNtccvCHwon1KOYGcMSI1m5v/MGJf
 l7kIdniN5ZSiHNE6FnXWXQs6I7HG7+vYeWJU/Ww=
X-Google-Smtp-Source: ABdhPJyLGGgFI56zswrBMuDUuNV47hJDChlOQqSa1p6nYo56niCr9D89I450MKyGhZt3lur5ZzGwwtgiDdPwtcgtyKw=
X-Received: by 2002:a2e:8983:: with SMTP id c3mr12314783lji.171.1600438751908; 
 Fri, 18 Sep 2020 07:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200918132903.1848939-1-berrange@redhat.com>
 <655b71e6-da6e-38b1-2c80-5d7d9caa8770@redhat.com>
 <20200918141520.GL1628512@redhat.com>
In-Reply-To: <20200918141520.GL1628512@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2020 22:19:00 +0800
Message-ID: <CAE2XoE92NV5qhS8x7v-COPkVUfM5GHRP+WSb_e_bOcXx5aorSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] gitlab: add jobs for checking paches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004ad56505af972fef"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004ad56505af972fef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 10:16 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
wrote:
>
> On Fri, Sep 18, 2020 at 04:07:22PM +0200, Thomas Huth wrote:
> > On 18/09/2020 15.29, Daniel P. Berrang=C3=A9 wrote:
> > > This introduces two new jobs to GitLab. The first runs "checkpatch.pl=
"
> > > across all patches, while the second is a dedicated DCO signoff check=
.
> >
> > This feels quite redundant since we're checking the patches with Patche=
w
> > already ... or are there plans to get rid of this check in Patchew?
>
> patchew only runs once the contributor has sent their patches to the
> mailing list, whci his too late.
>
> We want contributors to test their series in GitLab CI ahead of sending
> it, so that patchew never has to report any failure, because the code is
> already perfect once on the list (except if git master has moved and
> causes conflicts of course).
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
https://www.instagram.com/dberrange :|
>
>
agreed, and ineed patchew are broken now.

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000004ad56505af972fef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Sep 18, 2020 at 10:16 PM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Fri, Sep 18, 2020 at 04:07:22PM +0200, Thomas =
Huth wrote:<br>&gt; &gt; On 18/09/2020 15.29, Daniel P. Berrang=C3=A9 wrote=
:<br>&gt; &gt; &gt; This introduces two new jobs to GitLab. The first runs =
&quot;<a href=3D"http://checkpatch.pl">checkpatch.pl</a>&quot;<br>&gt; &gt;=
 &gt; across all patches, while the second is a dedicated DCO signoff check=
.<br>&gt; &gt;<br>&gt; &gt; This feels quite redundant since we&#39;re chec=
king the patches with Patchew<br>&gt; &gt; already ... or are there plans t=
o get rid of this check in Patchew?<br>&gt;<br>&gt; patchew only runs once =
the contributor has sent their patches to the<br>&gt; mailing list, whci hi=
s too late.<br>&gt;<br>&gt; We want contributors to test their series in Gi=
tLab CI ahead of sending<br>&gt; it, so that patchew never has to report an=
y failure, because the code is<br>&gt; already perfect once on the list (ex=
cept if git master has moved and<br>&gt; causes conflicts of course).<br>&g=
t;<br>&gt; Regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a href=3D"https:/=
/berrange.com">https://berrange.com</a> =C2=A0 =C2=A0 =C2=A0-o- =C2=A0 =C2=
=A0<a href=3D"https://www.flickr.com/photos/dberrange">https://www.flickr.c=
om/photos/dberrange</a> :|<br>&gt; |: <a href=3D"https://libvirt.org">https=
://libvirt.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<a href=3D"https://fstop138.berrange.com">https://fstop138=
.berrange.com</a> :|<br>&gt; |: <a href=3D"https://entangle-photo.org">http=
s://entangle-photo.org</a> =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a href=3D"https:/=
/www.instagram.com/dberrange">https://www.instagram.com/dberrange</a> :|<br=
>&gt;<br>&gt;<br>agreed, and ineed patchew are broken now.<br><br>--<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=
=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</di=
v>

--0000000000004ad56505af972fef--

