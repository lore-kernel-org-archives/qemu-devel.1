Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0598C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D52C20738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K2ZPpmA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D52C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2XpL-0004gr-EM
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k2Xof-0004Bn-IE
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:35:37 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:42997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k2Xod-000845-DQ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:35:36 -0400
Received: by mail-oi1-x234.google.com with SMTP id j7so16438520oij.9
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e9sfjVipAzOY/W6aqcIDPMN6DiHPEBcPBUUg65g/v08=;
 b=K2ZPpmA+s5nBZqoTRK+gDhXWTHX/mLxTOWBl9bnXzAetfEJjnGlv3mV1TGFzLm3VG+
 jj880SIbJ98Zj+7M8KYY5N5e3Wr6MLvgkhAZQymCW0ZvR3covoE4SjQ6BQeXaAWuVp0/
 O13b6atxxUNkRwhNiFeoCBuDThYgRuPlP0SMM/ftzCdiAPuKjhPmdF+pThK8GNE5zWQ0
 ZDS9B2oL6WxcqeShJBO5z24TtBKlUqiVLkb5c+xKXdXpg4RRHdpoPGzQyAyCm6MG4pcv
 hywRrvTQHjjkfoDEOmloh3pW3w4ZCzN4QDE3tz7ScKcf8BPmtFTK5gi2ndIRKhwVg/yW
 jmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e9sfjVipAzOY/W6aqcIDPMN6DiHPEBcPBUUg65g/v08=;
 b=NAJMAg1WO07BhT4UpM0ciS1LJnOWwIoYtXDoL5CzqcftWR3ngaj6g/RBkhFV0V3nxy
 7hJmAf9Lclthmu0HepuQv2GurM9iiL9K5X49m/rzjJPctFRCX1BBJ25b11MMhM8BsdEE
 Z25cFgOFIkua3Fj5mkGV3OEt4LhIQR7sIHXmpR3qVpxSoQHfO1TYUptd4F5Op25q0cZU
 ZpAfqXqWEDsb2QhjAfuDgpGPX3Mne/nA+BCXGzZWKawH4JH85e100Kw3jqFDzjkVwUNR
 Gu1f+EKpBVBJc8ZLqgSjt0chHn8/pZlKHr0jySEj9RwJr4xrltn1Z95WgAlCnWDh9cu4
 oZ4g==
X-Gm-Message-State: AOAM530JSj83Rxc+WsxfA/mFI46T+stA+HUe/B8RQOvDhuDb3JWvjsnR
 NdjzqZGZz08kUMJpT15ZvaD802qsWOpbf7OEh4hzRQ==
X-Google-Smtp-Source: ABdhPJzLZAZAG95EH1E46Cvf+ucozJLWdD4lLezdGBC9k+zEMlGcpMymswnFN+cF/MggTp907HcO1rA9B5GdPr5NSXk=
X-Received: by 2002:aca:c451:: with SMTP id u78mr4013945oif.118.1596450933525; 
 Mon, 03 Aug 2020 03:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-60-frank.chang@sifive.com>
 <8ae82210-965a-25cc-46d6-f3d2e05e88a5@linaro.org>
In-Reply-To: <8ae82210-965a-25cc-46d6-f3d2e05e88a5@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 3 Aug 2020 18:35:22 +0800
Message-ID: <CAE_xrPjqNSJBvK3E6c4FW3idxOvHGCf9Sj0x1918rqV35vL77A@mail.gmail.com>
Subject: Re: [RFC v2 59/76] target/riscv: rvv-0.9: floating-point slide
 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cb615105abf6b23a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cb615105abf6b23a
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 1, 2020 at 12:05 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> > +DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1up_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1down_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1down_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> > +DEF_HELPER_6(vfslide1down_vf_d, void, ptr, ptr, i64, ptr, env, i32)
>
> You should not need new helpers.
>
> The only difference between vfslide1up and vslide1up is the source and the
> nanboxing.  Which you can do in the translator before using the existing
> helpers.
>
>
> r~
>

I agree that the implementation of *vslide1up*'s helper function can be
reused by *vfslide1up*.

However, I've encountered an issue
where the helper function called in *opfvf_trans()* used by *vfslide1up*
takes *TCGv_i64* type as *s1* parameter.
This conflicts with *vslide1up*'s helper function called in *opivx_trans(),*
where *s1* parameter is the type of *TCGv* rather than *TCGv_i64*.

i.e.
*DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)* vs.
*DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)*

As *opfvf_trans()* and *opivx_trans()* are shared among other instructions,
I wouldn't like to make prototype changes to these functions.

So far what I can come up with is to extract the logic in *vslide1up*'s
helper function to an individual static function and make *vslide1up*
and *vfslide1up*'s helper functions to call this static function.

So that the're no redundant logic to be redefined.
However, this still require to declare *vfslide1up'*s helper function
explicitly
as its function prototype is different with *vslide1up*.

Any suggestions to this issue?

Thanks
Frank Chang

--000000000000cb615105abf6b23a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Aug 1, 2020 at 12:05 AM Richard H=
enderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_bla=
nk">richard.henderson@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/22/20 2:16 =
AM, <a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang=
@sifive.com</a> wrote:<br>
&gt; +DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)<br>
&gt; +DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)<br>
&gt; +DEF_HELPER_6(vfslide1up_vf_d, void, ptr, ptr, i64, ptr, env, i32)<br>
&gt; +DEF_HELPER_6(vfslide1down_vf_h, void, ptr, ptr, i64, ptr, env, i32)<b=
r>
&gt; +DEF_HELPER_6(vfslide1down_vf_w, void, ptr, ptr, i64, ptr, env, i32)<b=
r>
&gt; +DEF_HELPER_6(vfslide1down_vf_d, void, ptr, ptr, i64, ptr, env, i32)<b=
r>
<br>
You should not need new helpers.<br>
<br>
The only difference between vfslide1up and vslide1up is the source and the<=
br>
nanboxing.=C2=A0 Which you can do in the translator before using the existi=
ng helpers.<br>
<br>
<br>
r~<br></blockquote><div><br></div><div>I agree that the implementation of=
=C2=A0<i>vslide1up</i>&#39;s helper function can be</div><div>reused by=C2=
=A0<i>vfslide1up</i>.</div><div><br></div><div>However, I&#39;ve encountere=
d an issue</div><div>where the helper function called in=C2=A0<i>opfvf_tran=
s()</i> used by <i>vfslide1up</i></div><div>takes <i>TCGv_i64</i> type as=
=C2=A0<i>s1</i> parameter.</div><div><div>This conflicts with <i>vslide1up<=
/i>&#39;s=C2=A0helper function called in <i>opivx_trans(),</i></div><div>wh=
ere=C2=A0<i>s1</i> parameter is the type of=C2=A0<i>TCGv</i>=C2=A0rather th=
an=C2=A0<i>TCGv_i64</i>.</div></div><div><br></div><div><div>i.e.</div><div=
><i>DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, <b>tl</b>, ptr, env, i32)<=
/i> vs.</div><div><i>DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, <b>i64</=
b>, ptr, env, i32)</i></div></div><div><br></div><div>As=C2=A0<i>opfvf_tran=
s()</i> and=C2=A0<i>opivx_trans()</i> are shared among other instructions,<=
/div><div>I wouldn&#39;t like to make prototype changes to these functions.=
</div><div><br></div><div>So far what I can come up with is to extract the =
logic in=C2=A0<i>vslide1up</i>&#39;s</div><div>helper function to an indivi=
dual static function and make=C2=A0<i>vslide1up</i></div><div>and=C2=A0<i>v=
fslide1up</i>&#39;s helper functions to call this static function.</div><di=
v><br></div><div>So that the&#39;re no redundant logic to be redefined.</di=
v><div>However, this still require to declare=C2=A0<i>vfslide1up&#39;</i>s<=
i>=C2=A0</i>helper function explicitly</div><div>as its function prototype =
is different with=C2=A0<i>vslide1up</i>.</div><div><br></div><div>Any sugge=
stions to this issue?<br></div><div><br></div><div>Thanks</div><div>Frank C=
hang</div></div></div>

--000000000000cb615105abf6b23a--

