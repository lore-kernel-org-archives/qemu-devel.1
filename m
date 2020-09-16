Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B29AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C2302222B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4G7wKqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2302222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWOj-0002pM-JM
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIWBF-0006cR-K1; Wed, 16 Sep 2020 08:04:57 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:36107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIWBC-0001vj-HT; Wed, 16 Sep 2020 08:04:57 -0400
Received: by mail-lf1-x12a.google.com with SMTP id x69so6720604lff.3;
 Wed, 16 Sep 2020 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=28lA9K0Y7vK3gyOz2tFYnoRJMiI2arDvXFbLiyUK6+U=;
 b=i4G7wKqOgY3fkpd9WlZqCuEyRG+zU47T217XFo3Y2txyx4ir+S/58iZeaDEIeFMJX5
 nlkZnNlKXUIaeItF35IM0CDkkIJ4V1ED63+tlskB1jq4yJeWBE+VaDr1nCn7x4GZT2Gr
 TqUL+NhV7I4NZGI7xcx+yxDQNHnywb5ftEuP/QEDzBflaDX9xFgiZ1VHIdKwpmpHMVdr
 6suf6fu6FZ1XzAdB5WL/ZYE3EaUyfSbvRxsC4sl6VWrR3yHkc8Zw4pKjpmF0i/azVW4l
 scpYRcdpGvIODN/G7RdgKGG8wZ2X+6eg8PZBOhHgfDCz0wrdBy6RClAq96jSdpTBj0C9
 dZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=28lA9K0Y7vK3gyOz2tFYnoRJMiI2arDvXFbLiyUK6+U=;
 b=B8Ei27CZcVbHiweUHmiQFL4GvuydetJdZg8LxRwvgISAfh3AVE7Mb/FIy7iV+MnnRw
 zqDj02Xy5DCN4T6tuT6CGwe1D10ixFVfGNHFZVUtAPs7J1nMSeMyRIrSx0USW3em20P0
 GNqYWk0O/gbvNPXf9Dt3GAJ+E5nWdb7cl40ct3jmikAOpUfgLVvNJrF+Z4buSFCdsxcp
 9iw3pgogTXNBl59zZDJI78mLvEE2bibhHQQN4EUqvnz1cFXYVsHHDc8ZU0YFz3SKhDZV
 kr7v25sdODgL3PYKLy7+Dgo43+KU5Wto7s+Mw1jtnnZFnq42CXlbD1iKziDIkjPaoIT9
 PfTA==
X-Gm-Message-State: AOAM531ENKSg6IPRAdNbo5xrZEE8l8K1jXzqMzJPOjuWoPgsJ8RxoILU
 48sbfBp9dmSJEho8D78nTPe4aKo67maToYeohHA=
X-Google-Smtp-Source: ABdhPJxnwwlGQQ4Pa1JFAZ1Hx1dRqFHqzBJrH0Po7haCtKiHFgvi3dlerMRX+KpW3aWG0TCTDaqmc6uu2qXQj94UEHc=
X-Received: by 2002:a19:383:: with SMTP id 125mr8010907lfd.356.1600257890287; 
 Wed, 16 Sep 2020 05:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200915171234.236-1-luoyonggang@gmail.com>
 <cd40da60-d03f-bf37-c0d7-1f362419cf75@redhat.com>
In-Reply-To: <cd40da60-d03f-bf37-c0d7-1f362419cf75@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 16 Sep 2020 20:04:40 +0800
Message-ID: <CAE2XoE9dJvwH_12XRo5c62D9x_akcuvO2EY5xCOm-E5Y8WysCw@mail.gmail.com>
Subject: Re: [PATCH v10 00/26] W32, W64 msys2/mingw patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001984bd05af6d135b"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12a.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001984bd05af6d135b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 7:52 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 15/09/2020 19.12, Yonggang Luo wrote:
> [...]
> > It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses an=
d
> > disable partial test-char tests.
> > And then fixes all unit tests failure on msys2/mingw
> > This fixes the reviews suggested in the mailling list
> > All cirrus CI are passed
>
> Thanks a lot for your work, I've added most of your patches to my latest
> "testing" pull request now, so that we should get basic test coverage on
> msys2 now in the Cirrus-CI if it gets merged.
>
> I skipped the NFS, capstone, test-char and crypto patches for now (and
> replaced them with older versions of your patches where you've disabled
> them) - I think these patches still need some more review / work and
> then should go through the trees of the corresponding maintainers later.
Happy to see, once your branch merged, I'll rebase these patches and resend
them
separately
>
>  Cheers,
>   Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001984bd05af6d135b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Sep 16, 2020 at 7:52 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; On 15/09/2020 19.12, Yonggang Luo wrote:<br>&gt; [...]<br>&gt; &gt; =
It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses and<br=
>&gt; &gt; disable partial test-char tests.<br>&gt; &gt; And then fixes all=
 unit tests failure on msys2/mingw<br>&gt; &gt; This fixes the reviews sugg=
ested in the mailling list<br>&gt; &gt; All cirrus CI are passed<br>&gt;<br=
>&gt; Thanks a lot for your work, I&#39;ve added most of your patches to my=
 latest<br>&gt; &quot;testing&quot; pull request now, so that we should get=
 basic test coverage on<br>&gt; msys2 now in the Cirrus-CI if it gets merge=
d.<br>&gt;<br>&gt; I skipped the NFS, capstone, test-char and crypto patche=
s for now (and<br>&gt; replaced them with older versions of your patches wh=
ere you&#39;ve disabled<br>&gt; them) - I think these patches still need so=
me more review / work and<br>&gt; then should go through the trees of the c=
orresponding maintainers later.<div>Happy to see, once your branch merged, =
I&#39;ll rebase these patches and resend them</div><div>separately<br>&gt;<=
br>&gt; =C2=A0Cheers,<br>&gt; =C2=A0 Thomas<br>&gt;<br><br><br>--<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div><=
/div>

--0000000000001984bd05af6d135b--

