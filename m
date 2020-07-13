Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_MIME_MALF,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C71C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B1E206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/MWaJGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B1E206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvfY-0006Op-1t
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <programmingkidx@gmail.com>)
 id 1juveW-0005qV-QW
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:25:41 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734]:46358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <programmingkidx@gmail.com>)
 id 1juveR-0007NI-VK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:25:40 -0400
Received: by mail-qk1-x734.google.com with SMTP id r22so11586994qke.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:message-id:from:subject:date:to;
 bh=IYL1nK9dC92a5r+6Cm64AE5ZsIv1DYyxirNbK9t28vw=;
 b=U/MWaJGTMJNlhPMLNvpbyrEi/G27rCkiYdqSM9xlY339oeqqvo/U/6nyHHSC9YWcMv
 vdGAFqW4+dAE7jx5EgNon1ugK7+uegTWjt3lnsqUOdqEOISU+xl30oihISqY/J6xX8OS
 JLycz9PEcI4KnJX+8ekquBiGM2F5lsgAHpMcoD0B6feEORynJkQjMYwjUI2TcRTFQtyQ
 OVk9oz2E0gNwkM8ejOeiSIrBLZk0xl0h7rwgU/TwTQwrbOqd41IgPmS1joJMl7DkHS3I
 IkN/S5Qu7Gs/EfFHYQAYLhu9veZA2QCsPPg34pE+xfzm5L+mKsqT26A3O+eEY0O66ICM
 USXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:message-id
 :from:subject:date:to;
 bh=IYL1nK9dC92a5r+6Cm64AE5ZsIv1DYyxirNbK9t28vw=;
 b=PvhCDbnW9Janxgyun4s/uhYGKjGQEe1q2+iAlz5j70ANooVc11v/janPNxPFqA7O5a
 rKG1MSK+teOcPniIOel6DUkcMImNNwxmNWEoVeuiTnZnNkEixPSEyH6bQGlIvfP/HAXm
 GU/6wEc8MwnIisKQEM37L0ymdwmjAi20mUn8Tusfz3XvKsXsynnC335b8xrayIENbV7u
 NaqZ+t9EDw5r2JaiNKzrBpsCIfiJfaUOsB+qpzsv/Eog3iN0b9tGFShw4vMWP2TbkIA3
 FFNQDJlM7/fLj1UpmdJ1u8/g/xTeTpoUiUaaFxwphpWSko9Kzd+O8XzmPsVQ1YMmZMER
 zAyA==
X-Gm-Message-State: AOAM533UDVbchqBA/hE7dMXxBLVdWfMyM9xj7Eet6BeQP7ju9aCktMlI
 szPZUJTpVfpjo1Ge9Ajh79Vbg+Cs
X-Google-Smtp-Source: ABdhPJyT4uIZRIkS+Vu8upwSlj/+7aKaSBPUQ4+GI4dYpOOk5bGRmYbY3ipwq65gzH55rk/EA676yA==
X-Received: by 2002:a05:620a:a56:: with SMTP id
 j22mr78338281qka.193.1594635928754; 
 Mon, 13 Jul 2020 03:25:28 -0700 (PDT)
Received: from [192.168.0.8] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id v184sm18721923qki.12.2020.07.13.03.25.27
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 13 Jul 2020 03:25:28 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
In-Reply-To: <mailman.2146.1594605768.2305.qemu-devel@nongnu.org>
References: <mailman.2146.1594605768.2305.qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary=Apple-Mail-1-920166
Message-Id: <1435E68C-6844-455C-9A86-62835A7A1E2E@gmail.com>
From: G 3 <programmingkidx@gmail.com>
Subject: Re: [Bug 1887318] [NEW] impossible to install in OSX Yosemite 10.10.5
Date: Mon, 13 Jul 2020 06:25:26 -0400
To: qemu-devel@nongnu.org,
 JuanPabloCuervo <1887318@bugs.launchpad.net>
X-Mailer: Apple Mail (2.753.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=programmingkidx@gmail.com; helo=mail-qk1-x734.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_MIME_MALF=0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail-1-920166
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Jul 12, 2020, at 10:02 PM, qemu-devel-request@nongnu.org wrote:

> Message: 6
> Date: Mon, 13 Jul 2020 00:17:30 -0000
> From: JuanPabloCuervo <1887318@bugs.launchpad.net>
> To: qemu-devel@nongnu.org
> Subject: [Bug 1887318] [NEW] impossible to install in OSX Yosemite
> 	10.10.5
> Message-ID:
> 	 
> <159459945016.20204.12821765315233915598.malonedeb@chaenomeles.canonic 
> al.com>
> 	
> Content-Type: text/plain; charset="utf-8"
>
> Public bug reported:
>
> the Brew method has glib problems, glib is impossible to install.
> the MacPorts method has a very long .log file.
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> ** Attachment added: "main.log"
>    https://bugs.launchpad.net/bugs/1887318/+attachment/5392136/ 
> +files/main.log
>
> -- 
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1887318
>
> Title:
>   impossible to install in OSX Yosemite 10.10.5
>
> Status in QEMU:
>   New
>
> Bug description:
>   the Brew method has glib problems, glib is impossible to install.
>   the MacPorts method has a very long .log file.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1887318/+subscriptions

This is why we need installer files for QEMU. They make life so much  
easier than building from source.


--Apple-Mail-1-920166
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=US-ASCII

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
<br><div><div>On Jul 12, 2020, at 10:02 PM, <a =
href=3D"mailto:qemu-devel-request@nongnu.org">qemu-devel-request@nongnu.or=
g</a> wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">Message: =
6</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">Date: =
Mon, 13 Jul 2020 00:17:30 -0000</font></p> <p style=3D"margin: 0.0px =
0.0px 0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: =
12.0px Helvetica">From: JuanPabloCuervo &lt;<a =
href=3D"mailto:1887318@bugs.launchpad.net">1887318@bugs.launchpad.net</a>&=
gt;</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">To: <a =
href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a></font></p>=
 <p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">Subject: [Bug 1887318] [NEW] =
impossible to install in OSX Yosemite</font></p> <p style=3D"margin: =
0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" =
style=3D"font: 12.0px Helvetica"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>10.10.5</font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">Message-ID:</font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica"><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>&lt;<a =
href=3D"mailto:159459945016.20204.12821765315233915598.malonedeb@chaenomel=
es.canonical.com">159459945016.20204.12821765315233915598.malonedeb@chaeno=
meles.canonical.com</a>&gt;</font></p> <p style=3D"margin: 0.0px 0.0px =
0.0px 0.0px; min-height: 14.0px"><font face=3D"Helvetica" size=3D"3" =
style=3D"font: 12.0px Helvetica"><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span></font></p> <p style=3D"margin: =
0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" =
style=3D"font: 12.0px Helvetica">Content-Type: text/plain; =
charset=3D"utf-8"</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px; font: 12.0px Helvetica; min-height: 14.0px"><br></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">Public bug =
reported:</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: =
12.0px Helvetica; min-height: 14.0px"><br></p> <p style=3D"margin: 0.0px =
0.0px 0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: =
12.0px Helvetica">the Brew method has glib problems, glib is impossible =
to install.</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica">the MacPorts method has a very long .log file.</font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica; =
min-height: 14.0px"><br></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica">** Affects: qemu</font></p> <p style=3D"margin: 0.0px 0.0px =
0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica"><span class=3D"Apple-converted-space">&nbsp;&nbsp; &nbsp; =
</span>Importance: Undecided</font></p> <p style=3D"margin: 0.0px 0.0px =
0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica"><span class=3D"Apple-converted-space">&nbsp;&nbsp; &nbsp; =
&nbsp; &nbsp; </span>Status: New</font></p> <p style=3D"margin: 0.0px =
0.0px 0.0px 0.0px; font: 12.0px Helvetica; min-height: 14.0px"><br></p> =
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">** Attachment added: =
"main.log"</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica"><span =
class=3D"Apple-converted-space">&nbsp;&nbsp; </span><a =
href=3D"https://bugs.launchpad.net/bugs/1887318/+attachment/5392136/+files=
/main.log">https://bugs.launchpad.net/bugs/1887318/+attachment/5392136/+fi=
les/main.log</a></font></p> <p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; =
font: 12.0px Helvetica; min-height: 14.0px"><br></p> <p style=3D"margin: =
0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" =
style=3D"font: 12.0px Helvetica">--<span =
class=3D"Apple-converted-space">&nbsp;</span></font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">You received this bug =
notification because you are a member of qemu-</font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">devel-ml, which is =
subscribed to QEMU.</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica"><a =
href=3D"https://bugs.launchpad.net/bugs/1887318">https://bugs.launchpad.ne=
t/bugs/1887318</a></font></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px; font: 12.0px Helvetica; min-height: 14.0px"><br></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">Title:</font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica"><span =
class=3D"Apple-converted-space">&nbsp; </span>impossible to install in =
OSX Yosemite 10.10.5</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px; font: 12.0px Helvetica; min-height: 14.0px"><br></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">Status in QEMU:</font></p> =
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica"><span =
class=3D"Apple-converted-space">&nbsp; </span>New</font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica; =
min-height: 14.0px"><br></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica">Bug description:</font></p> <p style=3D"margin: 0.0px 0.0px =
0.0px 0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica"><span class=3D"Apple-converted-space">&nbsp; </span>the Brew =
method has glib problems, glib is impossible to install.</font></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica"><span =
class=3D"Apple-converted-space">&nbsp; </span>the MacPorts method has a =
very long .log file.</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px; font: 12.0px Helvetica; min-height: 14.0px"><br></p> <p =
style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">To manage notifications =
about this bug go to:</font></p> <p style=3D"margin: 0.0px 0.0px 0.0px =
0.0px"><font face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px =
Helvetica"><a =
href=3D"https://bugs.launchpad.net/qemu/+bug/1887318/+subscriptions">https=
://bugs.launchpad.net/qemu/+bug/1887318/+subscriptions</a></font></p> =
</blockquote><br></div><div>This is why we need installer files for =
QEMU. They make life so much easier than building from =
source.</div><br></body></html>=

--Apple-Mail-1-920166--

