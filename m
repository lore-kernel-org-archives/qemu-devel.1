Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0595EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E7B208B3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6pEixDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E7B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZtN-0000JZ-2R
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arman.avetisyan2000@gmail.com>)
 id 1k6Vcx-0001ag-0n; Fri, 14 Aug 2020 05:03:55 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:37885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arman.avetisyan2000@gmail.com>)
 id 1k6Vcv-0000ti-0u; Fri, 14 Aug 2020 05:03:54 -0400
Received: by mail-pg1-x532.google.com with SMTP id g33so4237047pgb.4;
 Fri, 14 Aug 2020 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/dXvp/QAK2gwGfRF5jnDawUeoFcSaDqCIoYFiu/DYQg=;
 b=d6pEixDWTJ5YFePBb+nGFjIzxJa8bUElCOpNvAHZGM1NX4NQc73cM+Qt3LRPLXkiN5
 boKv2tcNFqbB8Ckw8ksF9QRQXehS6iZGw0B2aSi4DfM+Vm2JxOUKs3w/cOOLRQ+lRf19
 4EWxbrpToQD5EVY/y1YlnbcJcx/usKDVj3RgC3OH3KZhtFcAZcZMbwQVoq6ebOjC+WyT
 sAd2F9WeAqPG7mhIi+ZMXjDeMkJ+yYzJu9zK1vTsl+a3ImgSpRJshM/8WAdW4ygzYqp9
 +rH6fHm7GIQYHf/FmzpTTD4FVdyZ7N7Zn9i1GENeXZX0QwRlZl0evGx1NNMSX+dBQGDz
 RQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/dXvp/QAK2gwGfRF5jnDawUeoFcSaDqCIoYFiu/DYQg=;
 b=Ph35rqZcwq/oGCns44VerHFMKUX/jiDeuyzWoOH21NNi9PncbHYJCPN8MFC5T+HLhD
 tib4O/xsRszyo2eId43mOKgb/tBJlXNzdWnExyIfJGqiTVeyOP4JjySoLLIcvpICOhXX
 5ut//tSviTXefth9leguEh9o/7SZdZLJA3GAvxrKWxyFE0a5F7sI1QhKeSrE/8PKTQAL
 4PkXj2eRn3uz1SV+E7dtleHpxGYLTb+kRNcKu6Rrv/3eB6IrlaIZv5/bah0ro05Df9kn
 pG1QFNOScHdI6ghxa9iFG4OXtShPWqk3i6Dll6nObYH2XqyBx/FaRcLkh3dDvSlN/pSu
 zdBg==
X-Gm-Message-State: AOAM531Jj/TqohB46JBrC1GK9OvQ6KXebGMoTlWrw0u+MQR5K7p+ggft
 AccSrglfDNeN624hcxISPRm9Xuqm9OAmFAMkHCY=
X-Google-Smtp-Source: ABdhPJzpa28Cn5DpKo/ris1MGu+QkdAUeXn7XTAv8l/UF/T+1Ju2oIyJApG5kR7FSAl6gxNdILqZIu7y3Hg98DmgWIM=
X-Received: by 2002:a63:e018:: with SMTP id e24mr1091685pgh.175.1597395830913; 
 Fri, 14 Aug 2020 02:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAK29XkHKxt94TPFwwuTy78Ye1Z9=-zxMe77bx7R+xxtP-nmipw@mail.gmail.com>
 <f4dbe759-a360-efde-17f7-b67c8350c899@amsat.org>
 <CAEiOBXWOS-PxnFZRJiRhg8pvB0WKOaiLS8o5VsJuA85GMamayQ@mail.gmail.com>
In-Reply-To: <CAEiOBXWOS-PxnFZRJiRhg8pvB0WKOaiLS8o5VsJuA85GMamayQ@mail.gmail.com>
From: arman avetisyan <arman.avetisyan2000@gmail.com>
Date: Fri, 14 Aug 2020 13:03:39 +0400
Message-ID: <CAK29XkHcNV5aQDLVBOZ7qv7=GnWiQ0T52iMEBsPhfiwGio7sJg@mail.gmail.com>
Subject: Re: QEMU latest release riscv32-softmmu not working
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000113f7a05acd2b3f8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=arman.avetisyan2000@gmail.com; helo=mail-pg1-x532.google.com
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
X-Mailman-Approved-At: Fri, 14 Aug 2020 09:34:36 -0400
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
Cc: qemu-discuss@nongnu.org, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000113f7a05acd2b3f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi QEMU Team

-bios none worked. It fixed the issue.
Thank you!

Thanks, Arman

On Fri, Aug 14, 2020 at 12:45 PM Chih-Min Chao <chihmin.chao@sifive.com>
wrote:

>
>
>
> On Fri, Aug 14, 2020 at 3:31 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
> wrote:
>
>> Hi Arman,
>>
>> On 8/13/20 10:20 PM, arman avetisyan wrote:
>> > Hi QEMU Team, having issue running riscv32-softmmu
>>
>> Cc'ing this to the QEMU RISCV mailing list.
>>
>> >
>> > After running riscv32-softmmu supplying custom linux build it crashes
>> > and complains about rom segments overlaping
>> >
>> > $ qemu-system-riscv32 -nographic -machine virt -kernel bbl   -append
>> > "root=3D/dev/vda ro console=3DttyS0"   -drive
>> > file=3Dbusybear.bin,format=3Draw,id=3Dhd0   -device
>> virtio-blk-device,drive=3Dhd0
>> >
>
>
>
> > Log:
>> > rom: requested regions overlap (rom phdr #0: bbl.
>> > free=3D0x000000008000c160, addr=3D0x0000000080000000)
>> > qemu-system-riscv32: rom check and register reset failed
>> >
>
> Try to add "-bios none"
>
> Chih-Min Chao
>
>>
>
> > qemu version =3D 5.1.0
>> > Pulled from github.com <http://github.com> (latest commit in master =
=3D
>> > also tagged v5.1.0)
>> >
>> > Same files are used in 4.2.0 and are working fine.
>> > Tried different kernel files, all had same issue.
>> >
>> > How can I help to debug it? I really want to modify QEMU to support ne=
w
>> > board/machine but having hard time building latest version from github
>> > (which happens to be release v5.1.0)
>> >
>> > Thanks, Arman
>>
>>
>>

--000000000000113f7a05acd2b3f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi QEMU Team<div><br></div><div>-bios none worked. It fixe=
d the issue.</div><div>Thank=C2=A0you!<br><div><br></div><div>Thanks, Arman=
</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Fri, Aug 14, 2020 at 12:45 PM Chih-Min Chao &lt;<a href=3D"m=
ailto:chihmin.chao@sifive.com">chihmin.chao@sifive.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr"><div dir=3D"ltr"><br><=
/div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Fri, Aug 14, 2020 at 3:31 PM Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi Arman,<br>
<br>
On 8/13/20 10:20 PM, arman avetisyan wrote:<br>
&gt; Hi QEMU Team, having issue running riscv32-softmmu<br>
<br>
Cc&#39;ing this to the QEMU RISCV mailing list.<br>
<br>
&gt; <br>
&gt; After running riscv32-softmmu supplying custom linux build it crashes<=
br>
&gt; and complains about rom segments overlaping<br>
&gt; <br>
&gt; $ qemu-system-riscv32 -nographic -machine virt -kernel bbl =C2=A0 -app=
end<br>
&gt; &quot;root=3D/dev/vda ro console=3DttyS0&quot; =C2=A0 -drive<br>
&gt; file=3Dbusybear.bin,format=3Draw,id=3Dhd0 =C2=A0 -device virtio-blk-de=
vice,drive=3Dhd0<br>
&gt;=C2=A0=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Log:<br>
&gt; rom: requested regions overlap (rom phdr #0: bbl.<br>
&gt; free=3D0x000000008000c160, addr=3D0x0000000080000000)<br>
&gt; qemu-system-riscv32: rom check and register reset failed<br>
&gt;=C2=A0</blockquote><div>Try to add &quot;-bios none&quot;</div><div><br=
></div><div>Chih-Min Chao=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; qemu version =3D 5.1.0<br>
&gt; Pulled from <a href=3D"http://github.com" rel=3D"noreferrer" target=3D=
"_blank">github.com</a> &lt;<a href=3D"http://github.com" rel=3D"noreferrer=
" target=3D"_blank">http://github.com</a>&gt; (latest commit in master =3D<=
br>
&gt; also tagged v5.1.0)<br>
&gt; <br>
&gt; Same files are used in 4.2.0 and are working fine.<br>
&gt; Tried different kernel files, all had same issue.<br>
&gt; <br>
&gt; How can I help to debug it? I really want to modify QEMU to support ne=
w<br>
&gt; board/machine but having hard time building latest version from github=
<br>
&gt; (which happens to be release v5.1.0)<br>
&gt; <br>
&gt; Thanks, Arman<br>
<br>
<br>
</blockquote></div></div>
</blockquote></div>

--000000000000113f7a05acd2b3f8--

