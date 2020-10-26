Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9B320809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S74IotPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9B320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9Is-0008Lx-QK
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX999-00085n-Oz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX996-0001Fr-Tg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603744271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sLV2S/bDWEeRRkRpqHP93e9AMjdbRR3fIDEpnXsZD0=;
 b=S74IotPwLPibwJOPANyRXZ6Qumx6uAjrv1awebNtXAaZtgLfQjplGVXjGxiLdDb7n3l+8s
 yNlRJmaPmrkSwvtmYIjIY4rCDRFtNARXcB+mZ6Osk0dbJZWo6GGTboVyMVdwi2kH7dCevI
 Jt1jPA5mKXSkikda027YeQUJPM3Vy/g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-mxRZjSfTNnGPpo_YDdIe4w-1; Mon, 26 Oct 2020 16:31:09 -0400
X-MC-Unique: mxRZjSfTNnGPpo_YDdIe4w-1
Received: by mail-ej1-f71.google.com with SMTP id d12so6122013ejr.19
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5sLV2S/bDWEeRRkRpqHP93e9AMjdbRR3fIDEpnXsZD0=;
 b=ZWTIhUfl2/i3xt20vEHMtmywdXR8RvYaRLk2o7RbT3n2sessADcIWbDU15M/cw9d8W
 9y+lcqQGFV2z7d84IKNBgCosG0KxBNh46h8p76hXlIDo3XAAUk5t+h1vZ1UxhwdxEIgN
 ufXupFSmZQWHBoHqB1pfjxcu3wflOFPo7eSyY17tmNvFti4lfxkHXHj4BCfBx232nv5E
 523ShDf5jeku6hAw3uy9JCZeO5Q5GUV9kflb1PG0p85PebP7j2mjYICBIfJH/1MdJ9FV
 pCnlHfnOjmzeS6VujkXeVRtrh3C4+uqgwwaEYR2NC3I2IgbrdBoZryxji3OxWj8zZ8gL
 4tNQ==
X-Gm-Message-State: AOAM533BaD0EQqFI3Z4gIkG11HIJuqpP/d4bpC0YdTo3FUFcfo4o2RcT
 8b+F9kBdo1FutSOOXMGvL0KlxLInqShmQ7dKhRRui9YMMN110c8rqy1nxZ9KZl/h0wilg+I+el0
 d5mCMaslp9naFHXfY7T2hNG4mqswYN/Y=
X-Received: by 2002:a17:906:9483:: with SMTP id
 t3mr18336619ejx.390.1603744267791; 
 Mon, 26 Oct 2020 13:31:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJeW1fe5CPGUtGatbzD37uiWmfNj8QyOTgvUJ2OWpPqTx+MlK5wgZKAUKQauwp44GMC9kp6VttaJFKEYJh6fE=
X-Received: by 2002:a17:906:9483:: with SMTP id
 t3mr18336605ejx.390.1603744267593; 
 Mon, 26 Oct 2020 13:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-nwJRgoraR9HFoDpW-tgGER6CAaY0s5gyR8BGDH3aHxA@mail.gmail.com>
In-Reply-To: <CAE2XoE-nwJRgoraR9HFoDpW-tgGER6CAaY0s5gyR8BGDH3aHxA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 21:30:55 +0100
Message-ID: <CABgObfYHei8Dp-5vrvaf27fwwwhzf=G+b7nhm9AzACYQX349WA@mail.gmail.com>
Subject: Re: How about using a bot to guard the pull request can be apply?
 like rust compiler does.
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000061924c05b298cfb9"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000061924c05b298cfb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We will certainly have a lot more flexibility in handling application of
patches as soon as we get closer to a gating CI.

We should first make sure that Gitlab CI (directly or through custom
runners, Travis, or cirrus-build) can cover all the scenarios and tests
that Peter has in his CI. The main missing ones are NetBSD and OpenBSD
builds, and various additional tests for warnings during builds, though
there may be more. Once we do that, imagination is the limit. :-)

Paolo

Il lun 26 ott 2020, 21:15 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyon=
ggang@gmail.com> ha
scritto:

> Peter can @bots try to apply pull request, if pull request apply and all
> ci tests passed, then the bot automatically merge the pull request and pu=
sh
> to the mirrors.
> We even doesn't need gitlab or other things, only need the bot to monitor
> the instruction from Peter.
>
> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo
>

--00000000000061924c05b298cfb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>We will certainly have a lot more flexibility in han=
dling application of patches as soon as we get closer to a gating CI.<div d=
ir=3D"auto"><br></div><div dir=3D"auto">We should first make sure that Gitl=
ab CI (directly or through custom runners, Travis, or cirrus-build) can cov=
er all the scenarios and tests that Peter has in his CI. The main missing o=
nes are NetBSD and OpenBSD builds, and various additional tests for warning=
s during builds, though there may be more. Once we do that, imagination is =
the limit. :-)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il l=
un 26 ott 2020, 21:15 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=
=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Peter can @bots t=
ry to apply pull request, if pull request apply and all ci tests passed, th=
en the bot automatically merge the pull request and push to the mirrors.<di=
v>We even doesn&#39;t need gitlab or other things, only need the bot to mon=
itor the instruction from Peter.</div><div><div><br></div>-- <br><div dir=
=3D"ltr" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours=
<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div></div>
</blockquote></div></div></div>

--00000000000061924c05b298cfb9--


