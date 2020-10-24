Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1519C21D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvtQqTXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1519C21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQmJ-0003BH-9d
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWQlT-0002fq-Dr; Sat, 24 Oct 2020 17:07:51 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:40926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWQlR-0008Gw-8F; Sat, 24 Oct 2020 17:07:51 -0400
Received: by mail-il1-x144.google.com with SMTP id n5so4695283ile.7;
 Sat, 24 Oct 2020 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2AbV7PP/tQpb+7v+BfrbRrbBAjy7HQm5Fe4eF+mId6A=;
 b=JvtQqTXNJInTywvhFEnPhkpSauUTu+koKSnBcaqJHS2ZK4ULH8LRcMCkLz0gowtJnE
 XTb3HYjhK6g2U0RVYROoTWsjAfZktNVyoDLVwGf1xQOfna1v6vta/aby4bQoy2zaIbv2
 NActoL3UTCjMxyQakuibSUPkExwtvvyFcBtSF7v8qpBBC+YAQryVBAV17smLDHvk1kIU
 2azdXRUyNlGJ4e4EDtMrDLf6Q2pwZH5zwcZf22Rg5k9+JrbZVxnCbEdI5TnJrRn42ke0
 W72gqinFRTlHCmyulO4xuy6nkPsMHaEmsz+nWJs4/7OTgV+lG6naAeSc/IFXssiDLSg8
 D7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2AbV7PP/tQpb+7v+BfrbRrbBAjy7HQm5Fe4eF+mId6A=;
 b=ITqtXWZzAAJJjUhaXPdyX+iXTJ+R/CPipRHx34IYO8hVGIZVg0Dw/dvm45tIjZy8Cm
 GUEBK47l8IwKyvztM+gNuuNB1EaGkEMfFd8EbG7jlkWNv1ML1ornE+Y+tHmS5Dhg+1aV
 E4xmH2JsICsiUCV7lWG6zSvPG2flhx1nGx8yu40aEEKxbsFgy/p5swG4rlkLxcGrOs4d
 J3PN5oM8dfCKCSLbI0XfSqoIcFQX2FpUmh0qQsSbNQzioobqQeUORr7taaIZaHs9mJev
 cNFi3g8BvaFHIXsTERoz3eu2VZ5J2F+fv4AFsmlw87xCZ48YXjufd9arjitCO2hESTrz
 40lw==
X-Gm-Message-State: AOAM532v1Le7NYO79UeDXXjdAMbdK7asoklobwB5iDKhhfesv0HZky6/
 IM8aGxPM98OJL2Ab+cZAlRzAAmL+MM7FHoO6TCI=
X-Google-Smtp-Source: ABdhPJyJOLte5MSXHlsLA0okaP1Usr6t4zyKPUXSw8WHARS0fPRNEzem/jGiQsMbGUw8m+Jg0gdCf2ZxUC11opxX0zI=
X-Received: by 2002:a05:6e02:507:: with SMTP id
 d7mr5810572ils.67.1603573667848; 
 Sat, 24 Oct 2020 14:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <20201023131808.3198005-2-f4bug@amsat.org>
In-Reply-To: <20201023131808.3198005-2-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 24 Oct 2020 23:07:36 +0200
Message-ID: <CAPan3WrDHYzJb1fONHiOBWtEMW9Bg6jVt+tuvXC5XsF_CcDjbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] Revert "hw/sd: Fix incorrect populated function
 switch status data structure"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d7e8ef05b2711677"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x144.google.com
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d7e8ef05b2711677
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Fri, Oct 23, 2020 at 3:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> This reverts commit b638627c723a8d0d2bb73489bc6bf9ff09b8d53a.
>
> Currently booting U-Boot on the Orange Pi PC we get:
>
>   console: U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
>   ...
>   console: Autoboot in 1 seconds, press <Space> to stop
>   console: =3D>
>   console: =3D> setenv extraargs 'printk.time=3D0 console=3DttyS0,115200
> loglevel=3D7 nosmp systemd.default_timeout_start_sec=3D9000
> systemd.mask=3Darmbian-zram-config.service
> systemd.mask=3Darmbian-ramlog.service'
>   console: =3D> boot
>   console: unable to select a mode
>   console: Device 0: unknown device
>   console: BOOTP broadcast 1
>   console: DHCP client bound to address 10.0.2.15 (12 ms)
>   console: *** Warning: no boot file name; using '0A00020F.img'
>   console: Using ethernet@1c30000 device
>   console: TFTP from server 10.0.2.2; our IP address is 10.0.2.15
>   console: Filename '0A00020F.img'.
>   console: Load address: 0x42000000
>   console: Loading: *
>   console: TFTP error: 'Access violation' (2)
>   console: Not retrying...
>   console: missing environment variable: pxeuuid
>   console: missing environment variable: bootfile
>   ...
>
> With commit b638627c723 reverted:
>
>   console: U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)
>   ...
>   console: Autoboot in 1 seconds, press <Space> to stop
>   console: =3D>
>   console: =3D> setenv extraargs 'printk.time=3D0 console=3DttyS0,115200
> loglevel=3D7 nosmp systemd.default_timeout_start_sec=3D9000
> systemd.mask=3Darmbian-zram-config.service
> systemd.mask=3Darmbian-ramlog.service'
>   console: =3D> boot
>   console: switch to partitions #0, OK
>   console: mmc0 is current device
>   console: Scanning mmc 0:1...
>   console: Found U-Boot script /boot/boot.scr
>   console: 3967 bytes read in 16 ms (241.2 KiB/s)
>   console: ## Executing script at 43100000
>   console: U-boot loaded from SD
>   console: Boot script loaded from mmc
>   console: 153 bytes read in 10 ms (14.6 KiB/s)
>   console: 11185760 bytes read in 6698 ms (1.6 MiB/s)
>   console: 7788240 bytes read in 2966 ms (2.5 MiB/s)
>   console: Found mainline kernel configuration
>   console: 32121 bytes read in 50 ms (627 KiB/s)
>   console: 4185 bytes read in 23 ms (176.8 KiB/s)
>   console: Applying kernel provided DT fixup script (sun8i-h3-fixup.scr)
>   console: ## Executing script at 45000000
>   console: ## Loading init Ramdisk from Legacy Image at 43300000 ...
>   console: Image Name:   uInitrd
>   console: Image Type:   ARM Linux RAMDisk Image (gzip compressed)
>   console: Data Size:    11185696 Bytes =3D 10.7 MiB
>   console: Load Address: 00000000
>   console: Entry Point:  00000000
>   console: Verifying Checksum ... OK
>   console: ## Flattened Device Tree blob at 43000000
>   console: Booting using the fdt blob at 0x43000000
>   console: Loading Ramdisk to 49555000, end 49fffe20 ... OK
>   console: Loading Device Tree to 494e4000, end 49554fff ... OK
>   console: Starting kernel ...
>   console: Uncompressing Linux... done, booting the kernel.
>
> Fixes: b638627c723 ("hw/sd: Fix incorrect populated function switch statu=
s
> data structure")
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c3febed2434..c17197785bc 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -823,12 +823,11 @@ static void sd_function_switch(SDState *sd, uint32_=
t
> arg)
>      sd->data[11] =3D 0x43;
>      sd->data[12] =3D 0x80;       /* Supported group 1 functions */
>      sd->data[13] =3D 0x03;
> -
>      for (i =3D 0; i < 6; i ++) {
>          new_func =3D (arg >> (i * 4)) & 0x0f;
>          if (mode && new_func !=3D 0x0f)
>              sd->function_group[i] =3D new_func;
> -        sd->data[16 - (i >> 1)] |=3D new_func << ((i % 2) * 4);
> +        sd->data[14 + (i >> 1)] =3D new_func << ((i * 4) & 4);
>      }
>      memset(&sd->data[17], 0, 47);
>      stw_be_p(sd->data + 64, sd_crc16(sd->data, 64));
> --
> 2.26.2
>
>

--=20
Niek Linnenbank

--000000000000d7e8ef05b2711677
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Tested-by: Niek Linnenbank &lt;<a href=3D"mailto:niek=
linnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><div>Reviewed-b=
y: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinn=
enbank@gmail.com</a>&gt;<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 3:18 PM Philippe Math=
ieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This r=
everts commit b638627c723a8d0d2bb73489bc6bf9ff09b8d53a.<br>
<br>
Currently booting U-Boot on the Orange Pi PC we get:<br>
<br>
=C2=A0 console: U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)<b=
r>
=C2=A0 ...<br>
=C2=A0 console: Autoboot in 1 seconds, press &lt;Space&gt; to stop<br>
=C2=A0 console: =3D&gt;<br>
=C2=A0 console: =3D&gt; setenv extraargs &#39;printk.time=3D0 console=3Dtty=
S0,115200 loglevel=3D7 nosmp systemd.default_timeout_start_sec=3D9000 syste=
md.mask=3Darmbian-zram-config.service systemd.mask=3Darmbian-ramlog.service=
&#39;<br>
=C2=A0 console: =3D&gt; boot<br>
=C2=A0 console: unable to select a mode<br>
=C2=A0 console: Device 0: unknown device<br>
=C2=A0 console: BOOTP broadcast 1<br>
=C2=A0 console: DHCP client bound to address 10.0.2.15 (12 ms)<br>
=C2=A0 console: *** Warning: no boot file name; using &#39;0A00020F.img&#39=
;<br>
=C2=A0 console: Using ethernet@1c30000 device<br>
=C2=A0 console: TFTP from server 10.0.2.2; our IP address is 10.0.2.15<br>
=C2=A0 console: Filename &#39;0A00020F.img&#39;.<br>
=C2=A0 console: Load address: 0x42000000<br>
=C2=A0 console: Loading: *<br>
=C2=A0 console: TFTP error: &#39;Access violation&#39; (2)<br>
=C2=A0 console: Not retrying...<br>
=C2=A0 console: missing environment variable: pxeuuid<br>
=C2=A0 console: missing environment variable: bootfile<br>
=C2=A0 ...<br>
<br>
With commit b638627c723 reverted:<br>
<br>
=C2=A0 console: U-Boot SPL 2020.04-armbian (Sep 02 2020 - 10:16:13 +0200)<b=
r>
=C2=A0 ...<br>
=C2=A0 console: Autoboot in 1 seconds, press &lt;Space&gt; to stop<br>
=C2=A0 console: =3D&gt;<br>
=C2=A0 console: =3D&gt; setenv extraargs &#39;printk.time=3D0 console=3Dtty=
S0,115200 loglevel=3D7 nosmp systemd.default_timeout_start_sec=3D9000 syste=
md.mask=3Darmbian-zram-config.service systemd.mask=3Darmbian-ramlog.service=
&#39;<br>
=C2=A0 console: =3D&gt; boot<br>
=C2=A0 console: switch to partitions #0, OK<br>
=C2=A0 console: mmc0 is current device<br>
=C2=A0 console: Scanning mmc 0:1...<br>
=C2=A0 console: Found U-Boot script /boot/boot.scr<br>
=C2=A0 console: 3967 bytes read in 16 ms (241.2 KiB/s)<br>
=C2=A0 console: ## Executing script at 43100000<br>
=C2=A0 console: U-boot loaded from SD<br>
=C2=A0 console: Boot script loaded from mmc<br>
=C2=A0 console: 153 bytes read in 10 ms (14.6 KiB/s)<br>
=C2=A0 console: 11185760 bytes read in 6698 ms (1.6 MiB/s)<br>
=C2=A0 console: 7788240 bytes read in 2966 ms (2.5 MiB/s)<br>
=C2=A0 console: Found mainline kernel configuration<br>
=C2=A0 console: 32121 bytes read in 50 ms (627 KiB/s)<br>
=C2=A0 console: 4185 bytes read in 23 ms (176.8 KiB/s)<br>
=C2=A0 console: Applying kernel provided DT fixup script (sun8i-h3-fixup.sc=
r)<br>
=C2=A0 console: ## Executing script at 45000000<br>
=C2=A0 console: ## Loading init Ramdisk from Legacy Image at 43300000 ...<b=
r>
=C2=A0 console: Image Name:=C2=A0 =C2=A0uInitrd<br>
=C2=A0 console: Image Type:=C2=A0 =C2=A0ARM Linux RAMDisk Image (gzip compr=
essed)<br>
=C2=A0 console: Data Size:=C2=A0 =C2=A0 11185696 Bytes =3D 10.7 MiB<br>
=C2=A0 console: Load Address: 00000000<br>
=C2=A0 console: Entry Point:=C2=A0 00000000<br>
=C2=A0 console: Verifying Checksum ... OK<br>
=C2=A0 console: ## Flattened Device Tree blob at 43000000<br>
=C2=A0 console: Booting using the fdt blob at 0x43000000<br>
=C2=A0 console: Loading Ramdisk to 49555000, end 49fffe20 ... OK<br>
=C2=A0 console: Loading Device Tree to 494e4000, end 49554fff ... OK<br>
=C2=A0 console: Starting kernel ...<br>
=C2=A0 console: Uncompressing Linux... done, booting the kernel.<br>
<br>
Fixes: b638627c723 (&quot;hw/sd: Fix incorrect populated function switch st=
atus data structure&quot;)<br>
Reported-by: Michael Roth &lt;<a href=3D"mailto:mdroth@linux.vnet.ibm.com" =
target=3D"_blank">mdroth@linux.vnet.ibm.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/sd/sd.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
index c3febed2434..c17197785bc 100644<br>
--- a/hw/sd/sd.c<br>
+++ b/hw/sd/sd.c<br>
@@ -823,12 +823,11 @@ static void sd_function_switch(SDState *sd, uint32_t =
arg)<br>
=C2=A0 =C2=A0 =C2=A0sd-&gt;data[11] =3D 0x43;<br>
=C2=A0 =C2=A0 =C2=A0sd-&gt;data[12] =3D 0x80;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
Supported group 1 functions */<br>
=C2=A0 =C2=A0 =C2=A0sd-&gt;data[13] =3D 0x03;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 6; i ++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_func =3D (arg &gt;&gt; (i * 4)) &amp;=
 0x0f;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mode &amp;&amp; new_func !=3D 0x0f)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;function_group[i] =
=3D new_func;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 sd-&gt;data[16 - (i &gt;&gt; 1)] |=3D new_func=
 &lt;&lt; ((i % 2) * 4);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sd-&gt;data[14 + (i &gt;&gt; 1)] =3D new_func =
&lt;&lt; ((i * 4) &amp; 4);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0memset(&amp;sd-&gt;data[17], 0, 47);<br>
=C2=A0 =C2=A0 =C2=A0stw_be_p(sd-&gt;data + 64, sd_crc16(sd-&gt;data, 64));<=
br>
-- <br>
2.26.2<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000d7e8ef05b2711677--

