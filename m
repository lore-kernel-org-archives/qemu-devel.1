Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4415920663
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH8mHx4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4415920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtD3h-0001xp-GX
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <killpy178@gmail.com>)
 id 1jtAWl-0003VJ-GS
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 09:54:23 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:36173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <killpy178@gmail.com>)
 id 1jtAWj-0005zX-VH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 09:54:23 -0400
Received: by mail-lj1-x233.google.com with SMTP id d17so39625756ljl.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=xNYnJRTawpxG3jwRYJG4qBN9Zdd7JrZ9B70Lq7ryvYs=;
 b=LH8mHx4su1SEvmPd/EWNpgQLjM3EJydGUzflyw4IXzZkHheVWBbYv6Jt33yvGH1xxB
 qY8lFPle5ONISr85G1HQs0leRAPGFQBSETTu2wgJDyga/Rv+sRTTQJJL/3In3/p8BKI2
 ZsZa3x/uS0zqANzTSoCuXsY1h/j2r7tXDzdXzz++TzmLzyD6WHiQ6lrVxznkzAzaBi/s
 Jrf4XCnLXVZ1wAXMYjXhBDNk6MGhnz71Gjsv5hIlY2wiQJhNSgTQ+hu8VGudHyXFhu6z
 KiEtgWhWzOXb9YdDmCq5oJ7i7hB4VmeaBzeKJCdK6QPraLfV2yI04zxUkn/ATkYC7XMO
 G4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=xNYnJRTawpxG3jwRYJG4qBN9Zdd7JrZ9B70Lq7ryvYs=;
 b=eV7g6K5mluF44G0jmLoaYxWroNBpOmnnKYeIpj/BIVwPv3OBwR3auqYhvNolPj1E31
 E2BZP3hxB4r6+NYGbppsYFGgSKibFeg28yCULBnwIXYJFkJKkuGYe28BjBkxVjPP6PPB
 C+n2k3rMfXt3PtmVxDU2fplQ5L+LoHXK/0/z02HiopXK66fbFsXf959skxJs5iYvt4M4
 PVZLZf/SKOoH7XAf15OEw+AWYCMtP+3r1z6pBZZWe8kkGZf/TOezJ4B+IfRb9cdUxwWm
 oaAUJ5tVzaWN9DFUoXNZpEXh0Ov5Sx2FzKqhfcvw438xsYRQB3mLU6Pjd6TAM0lJBPnO
 NwCw==
X-Gm-Message-State: AOAM5326zOFENUtAD5MiMmCXua2GVi+nwq3Waxa/ZMTMQ6ob9YXLNygG
 xi6MFKRFa9Kw7B0CuJ9243OKYjkCULrbZ5rvLunqNEZY9HI=
X-Google-Smtp-Source: ABdhPJxuhJCuvY3cQUDqe49liJFc8RcBIKvL5xlfyKqX780HasDBc9eiA9CWWDXFpQ/CFkI7xjXOmZ1jW8TPiXX8vqI=
X-Received: by 2002:a2e:b55a:: with SMTP id a26mr28060859ljn.349.1594216459107; 
 Wed, 08 Jul 2020 06:54:19 -0700 (PDT)
MIME-Version: 1.0
From: Super Man <killpy178@gmail.com>
Date: Wed, 8 Jul 2020 21:53:59 +0800
Message-ID: <CAFB2YPkxtLqyf4Mo4Yx1jovSpwyrHz6TPz1tDZd27mazXNQRWA@mail.gmail.com>
Subject: Memory callback
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bd7f3505a9ee71ac"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=killpy178@gmail.com; helo=mail-lj1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Jul 2020 12:35:46 -0400
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

--000000000000bd7f3505a9ee71ac
Content-Type: text/plain; charset="UTF-8"

Sorry to bother you, I would like to ask a question.I want to use qemu to
monitor the information of the target thread reading and writing memory. I
see that qemu supports the tcg plugin, but I just find the following code
in plugin-gen.c .Do I just need to add a record function in it? How do I
read the current register values such as rip, rsp, how do I know the
current target address and data that the CPU read or written?Is there any
reference example?

/*
> * These helpers are stubs that get dynamically switched out for calls
> * direct to the plugin if they are subscribed to.
> */
> void HELPER(plugin_vcpu_udata_cb)(uint32_t cpu_index, void *udata)
> { }
> void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
> qemu_plugin_meminfo_t info, uint64_t vaddr,
> void *userdata)
> { }

--000000000000bd7f3505a9ee71ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry to bother you, I would like to ask a question.I want=
 to use qemu to monitor the information of the target thread reading and wr=
iting memory. I see that qemu supports the tcg plugin, but I just find the =
following code in plugin-gen.c .Do I just need to add a record function in =
it? How do I read the current register values such as rip, rsp, how do I kn=
ow the current target address and data that the CPU read or written?Is ther=
e any reference example?<br><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><table class=3D"gmail-highlight gmail-tab-size gmail-js-f=
ile-line-container" style=3D"border-spacing:0px;border-collapse:collapse;co=
lor:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe =
UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Seg=
oe UI Emoji&quot;;font-size:14px"><tbody style=3D"box-sizing:border-box"><t=
r style=3D"box-sizing:border-box"><td id=3D"gmail-LC84" class=3D"gmail-blob=
-code gmail-blob-code-inner gmail-js-file-line" style=3D"box-sizing:border-=
box;padding:0px 10px;line-height:20px;vertical-align:top;overflow:visible;f=
ont-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monosp=
ace;font-size:12px;white-space:pre"><span class=3D"gmail-pl-c" style=3D"box=
-sizing:border-box;color:rgb(106,115,125)"><span class=3D"gmail-pl-c" style=
=3D"box-sizing:border-box">/*</span></span></td></tr><tr style=3D"box-sizin=
g:border-box"><td id=3D"gmail-L85" class=3D"gmail-blob-num gmail-js-line-nu=
mber" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:=
50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,=
monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.3);text-ali=
gn:right;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-LC85" =
class=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file-line" style=3D=
"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top=
;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono=
&quot;,Menlo,monospace;font-size:12px;white-space:pre"><span class=3D"gmail=
-pl-c" style=3D"box-sizing:border-box;color:rgb(106,115,125)"> * These help=
ers are stubs that get dynamically switched out for calls</span></td></tr><=
tr style=3D"box-sizing:border-box"><td id=3D"gmail-L86" class=3D"gmail-blob=
-num gmail-js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;=
width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberat=
ion Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(2=
7,31,35,0.3);text-align:right;white-space:nowrap;vertical-align:top"></td><=
td id=3D"gmail-LC86" class=3D"gmail-blob-code gmail-blob-code-inner gmail-j=
s-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-height:20=
px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,=
&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre"=
><span class=3D"gmail-pl-c" style=3D"box-sizing:border-box;color:rgb(106,11=
5,125)"> * direct to the plugin if they are subscribed to.</span></td></tr>=
<tr style=3D"box-sizing:border-box"><td id=3D"gmail-L87" class=3D"gmail-blo=
b-num gmail-js-line-number" style=3D"box-sizing:border-box;padding:0px 10px=
;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Libera=
tion Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(=
27,31,35,0.3);text-align:right;white-space:nowrap;vertical-align:top"></td>=
<td id=3D"gmail-LC87" class=3D"gmail-blob-code gmail-blob-code-inner gmail-=
js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-height:2=
0px;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas=
,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre=
"><span class=3D"gmail-pl-c" style=3D"box-sizing:border-box;color:rgb(106,1=
15,125)"> <span class=3D"gmail-pl-c" style=3D"box-sizing:border-box">*/</sp=
an></span></td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L88=
" class=3D"gmail-blob-num gmail-js-line-number" style=3D"box-sizing:border-=
box;padding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,C=
onsolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-hei=
ght:20px;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;verti=
cal-align:top"></td><td id=3D"gmail-LC88" class=3D"gmail-blob-code gmail-bl=
ob-code-inner gmail-js-file-line" style=3D"box-sizing:border-box;padding:0p=
x 10px;line-height:20px;vertical-align:top;overflow:visible;font-family:SFM=
ono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:=
12px;white-space:pre"><span class=3D"gmail-pl-k" style=3D"box-sizing:border=
-box;color:rgb(215,58,73)">void</span> <span class=3D"gmail-pl-en" style=3D=
"box-sizing:border-box;color:rgb(111,66,193)">HELPER</span>(plugin_vcpu_uda=
ta_cb)(<span class=3D"gmail-pl-c1" style=3D"box-sizing:border-box;color:rgb=
(0,92,197)">uint32_t</span> cpu_index, <span class=3D"gmail-pl-k" style=3D"=
box-sizing:border-box;color:rgb(215,58,73)">void</span> *udata)</td></tr><t=
r style=3D"box-sizing:border-box"><td id=3D"gmail-L89" class=3D"gmail-blob-=
num gmail-js-line-number" style=3D"box-sizing:border-box;padding:0px 10px;w=
idth:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&quot;Liberati=
on Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;color:rgba(27=
,31,35,0.3);text-align:right;white-space:nowrap;vertical-align:top"></td><t=
d id=3D"gmail-LC89" class=3D"gmail-blob-code gmail-blob-code-inner gmail-js=
-file-line" style=3D"box-sizing:border-box;padding:0px 10px;line-height:20p=
x;vertical-align:top;overflow:visible;font-family:SFMono-Regular,Consolas,&=
quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre">=
{ }</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L90" class=
=3D"gmail-blob-num gmail-js-line-number" style=3D"box-sizing:border-box;pad=
ding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas=
,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20p=
x;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;vertical-ali=
gn:top"></td><td id=3D"gmail-LC90" class=3D"gmail-blob-code gmail-blob-code=
-inner gmail-js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;=
line-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Reg=
ular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;wh=
ite-space:pre">
</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L91" class=3D=
"gmail-blob-num gmail-js-line-number" style=3D"box-sizing:border-box;paddin=
g:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&q=
uot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;c=
olor:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;vertical-align:=
top"></td><td id=3D"gmail-LC91" class=3D"gmail-blob-code gmail-blob-code-in=
ner gmail-js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;lin=
e-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regula=
r,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white=
-space:pre"><span class=3D"gmail-pl-k" style=3D"box-sizing:border-box;color=
:rgb(215,58,73)">void</span> <span class=3D"gmail-pl-en" style=3D"box-sizin=
g:border-box;color:rgb(111,66,193)">HELPER</span>(plugin_vcpu_mem_cb)(<span=
 class=3D"gmail-pl-k" style=3D"box-sizing:border-box;color:rgb(215,58,73)">=
unsigned</span> <span class=3D"gmail-pl-k" style=3D"box-sizing:border-box;c=
olor:rgb(215,58,73)">int</span> vcpu_index,</td></tr><tr style=3D"box-sizin=
g:border-box"><td id=3D"gmail-L92" class=3D"gmail-blob-num gmail-js-line-nu=
mber" style=3D"box-sizing:border-box;padding:0px 10px;width:50px;min-width:=
50px;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,=
monospace;font-size:12px;line-height:20px;color:rgba(27,31,35,0.3);text-ali=
gn:right;white-space:nowrap;vertical-align:top"></td><td id=3D"gmail-LC92" =
class=3D"gmail-blob-code gmail-blob-code-inner gmail-js-file-line" style=3D=
"box-sizing:border-box;padding:0px 10px;line-height:20px;vertical-align:top=
;overflow:visible;font-family:SFMono-Regular,Consolas,&quot;Liberation Mono=
&quot;,Menlo,monospace;font-size:12px;white-space:pre">                    =
            <span class=3D"gmail-pl-c1" style=3D"box-sizing:border-box;colo=
r:rgb(0,92,197)">qemu_plugin_meminfo_t</span> info, <span class=3D"gmail-pl=
-c1" style=3D"box-sizing:border-box;color:rgb(0,92,197)">uint64_t</span> va=
ddr,</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L93" clas=
s=3D"gmail-blob-num gmail-js-line-number" style=3D"box-sizing:border-box;pa=
dding:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consola=
s,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20=
px;color:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;vertical-al=
ign:top"></td><td id=3D"gmail-LC93" class=3D"gmail-blob-code gmail-blob-cod=
e-inner gmail-js-file-line" style=3D"box-sizing:border-box;padding:0px 10px=
;line-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Re=
gular,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;w=
hite-space:pre">                                <span class=3D"gmail-pl-k" =
style=3D"box-sizing:border-box;color:rgb(215,58,73)">void</span> *userdata)=
</td></tr><tr style=3D"box-sizing:border-box"><td id=3D"gmail-L94" class=3D=
"gmail-blob-num gmail-js-line-number" style=3D"box-sizing:border-box;paddin=
g:0px 10px;width:50px;min-width:50px;font-family:SFMono-Regular,Consolas,&q=
uot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;line-height:20px;c=
olor:rgba(27,31,35,0.3);text-align:right;white-space:nowrap;vertical-align:=
top"></td><td id=3D"gmail-LC94" class=3D"gmail-blob-code gmail-blob-code-in=
ner gmail-js-file-line" style=3D"box-sizing:border-box;padding:0px 10px;lin=
e-height:20px;vertical-align:top;overflow:visible;font-family:SFMono-Regula=
r,Consolas,&quot;Liberation Mono&quot;,Menlo,monospace;font-size:12px;white=
-space:pre">{ }</td></tr></tbody></table></blockquote></div>

--000000000000bd7f3505a9ee71ac--

