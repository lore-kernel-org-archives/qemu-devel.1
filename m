Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB244C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE10F20850
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE10F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyrv-00029V-05
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:17:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyqb-0001Vd-77
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEyqU-0008W7-6Z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:16:08 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEyqP-0008Re-3Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:16:01 -0400
Received: by mail-wm1-f45.google.com with SMTP id 4so11953749wmf.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kzttUeME5sJ+AqDyYC9m2EvmOeczJbAuXq+uC1Rck9g=;
	b=M+LU5nJdlA6r0PCPXQLmzbf8+E3d9h7MURy/RpnwiWbc9VStDq/Y0FJvjQFJTYkXgL
	kzbCTn+oqgRsSNZDaCiG9T6W58Jv468CKw84qOTPTXPIR2zcLndwQCDqULq3jDlVinrl
	uDLaVcs6+Z7xxnnDvE6aKORKSxAmMc5xnvkN9hmd+I8A9wrkIkfk16VoN2+0dFqR9uP4
	E51V1qNgFhzTJfTulqPLW4fjjBq8O/gHtwVhaWUbhs2s3wPnZNSFcsaPersgDP1SVdsV
	tpFDQg0uUM4pEvswcvLb6FxvhRJ3Eb2LHEOTnPu28y+6MJk6kibFfrc3nAx9VamkT+Jn
	2Ppw==
X-Gm-Message-State: APjAAAUkBJNF3/4IkWRqRQy8H/in+/cwDgktEASRBPTDA/6cTYt/S38+
	or1lyQre/Tm0yzpg0Zzim4Oclw==
X-Google-Smtp-Source: APXvYqwrMX8CFR5RcurwwPc+NOHmjwNEmwYO426pUqOVLPLlQ1cY9LluMp6luPSs3jCIx+eawUPvIA==
X-Received: by 2002:a7b:c844:: with SMTP id c4mr11576827wml.108.1555085754188; 
	Fri, 12 Apr 2019 09:15:54 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o4sm14266322wmo.20.2019.04.12.09.15.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 09:15:53 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org
References: <20190412152713.16018-1-marcandre.lureau@redhat.com>
	<20190412152713.16018-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f3fee902-fe59-9381-7ff5-d3b3c6abb8dd@redhat.com>
Date: Fri, 12 Apr 2019 18:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412152713.16018-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.45
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: add -vga help support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412161552.GWkeoRIaIZRJYh06SH9VKYSoRIA2tqPPUVGG6y9h2aI@z>

On 4/12/19 5:27 PM, Marc-André Lureau wrote:
> Provide help output similar to other argument help handling:
> 
> $ qemu-system-x86_64 -vga help
> none
> std                  standard VGA (default)
> cirrus               Cirrus VGA
> vmware               VMWare SVGA
> xenfb
> qxl                  QXL VGA
> virtio               Virtio VG

Maybe you can show the previous behavior:

$ qemu-system-x86_64 -vga help
qemu-system-x86_64: unknown vga type: help

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 0a96232e95..840c45c00f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2080,11 +2080,39 @@ static bool vga_interface_available(VGAInterfaceType t)
>             object_class_by_name(ti->class_names[1]);
>  }
>  
> -static void select_vgahw(const char *p)
> +static const char *
> +get_default_vga_model(const MachineClass *machine_class)
> +{
> +    if (machine_class->default_display) {
> +        return machine_class->default_display;
> +    } else if (vga_interface_available(VGA_CIRRUS)) {
> +        return "cirrus";
> +    } else if (vga_interface_available(VGA_STD)) {
> +        return "std";
> +    }
> +
> +    return NULL;
> +}
> +
> +static void select_vgahw(const MachineClass *machine_class, const char *p)
>  {
>      const char *opts;
>      int t;
>  
> +    if (g_str_equal(p, "help")) {
> +        const char *def = get_default_vga_model(machine_class);
> +
> +        for (t = 0; t < VGA_TYPE_MAX; t++) {
> +            const VGAInterfaceInfo *ti = &vga_interfaces[t];
> +
> +            if (vga_interface_available(t) && ti->opt_name) {
> +                printf("%-20s %s%s\n", ti->opt_name, ti->name ?: "",
> +                       g_str_equal(ti->opt_name, def) ? " (default)" : "");
> +            }
> +        }
> +        exit(0);
> +    }
> +
>      assert(vga_interface_type == VGA_NONE);
>      for (t = 0; t < VGA_TYPE_MAX; t++) {
>          const VGAInterfaceInfo *ti = &vga_interfaces[t];
> @@ -4437,16 +4465,10 @@ int main(int argc, char **argv, char **envp)
>  
>      /* If no default VGA is requested, the default is "none".  */
>      if (default_vga) {
> -        if (machine_class->default_display) {
> -            vga_model = machine_class->default_display;
> -        } else if (vga_interface_available(VGA_CIRRUS)) {
> -            vga_model = "cirrus";
> -        } else if (vga_interface_available(VGA_STD)) {
> -            vga_model = "std";
> -        }
> +        vga_model = get_default_vga_model(machine_class);
>      }
>      if (vga_model) {
> -        select_vgahw(vga_model);
> +        select_vgahw(machine_class, vga_model);
>      }
>  
>      if (watchdog) {
> 

