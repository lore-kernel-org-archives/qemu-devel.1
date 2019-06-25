Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E79C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E2C204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E2C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfj4w-0008Lb-Dm
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44300)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfj40-0007tp-2c
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfj3x-0002kY-Uu
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:52:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfj3w-0002ia-03
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:52:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so16115985wrs.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/034iMw4N2o8o2zeO7jU7OT16EBNfVC2YaHl8KaGDVc=;
 b=WpNF6CV19CJkyR1KJ5Rzw6qPHQ8tzA6NleGUdCTR/Gf5pD/eFOmhcjIkgh32owQRh9
 isuX/N8ygC5VT8wl53kFEOObmLGBF8vrUEO/9TkwU9ItL9VyCoaMvaNcWittljl+w0dV
 I6va2ylBWPuFd/b6uZpPXfQ1TJlL7/t7JGQqxsM3/UdDrEgFjfidR//FgdYifhyKYpTT
 FehEMONL4deX3DPF21ng1EGJvz/VuG5HXBftLARH7/DaJ8r6IEISJzImJlYABVCL1960
 itc25oxYXfXNcySAvnTkgOERpgH6hbJyPdbraCe6rMmN8gGTHLtlI7+I3wSvVu2nzdUZ
 azkQ==
X-Gm-Message-State: APjAAAUudtUA31AvDrTd+QnOtFLGHkpU/OacWxswEksN49s/ul30cmV0
 taSRF2i6UZTmJUYfnLwvKoKznQ==
X-Google-Smtp-Source: APXvYqzq8UbEvqAghdQ/LDX6711zB/wvPj3/E59TjzgKyuVD6pzKN+O69o8va3tXgpkfQwNdBHxtfw==
X-Received: by 2002:adf:ea45:: with SMTP id j5mr21131717wrn.281.1561459950792; 
 Tue, 25 Jun 2019 03:52:30 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v18sm11333854wrs.80.2019.06.25.03.52.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 03:52:30 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190625081339.9176-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4bc3239b-f3cf-3374-5d50-8980b413dfaa@redhat.com>
Date: Tue, 25 Jun 2019 12:52:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625081339.9176-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] minikconf: do not include variables from
 MINIKCONF_ARGS in config-all-devices.mak
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
Cc: Christophe de Dinechin <cdupontd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 10:13 AM, Paolo Bonzini wrote:
> When minikconf writes config-devices.mak, it includes all variables including
> those from MINIKCONF_ARGS.  This causes values from config-host.mak to "stick" to
> the ones used in generating config-devices.mak, because config-devices.mak is
> included after config-host.mak.  Avoid this by omitting assignments coming
> from the command line in the output of minikconf.
> 
> Reported-by: Christophe de Dinechin <cdupontd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/minikconf.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/minikconf.py b/scripts/minikconf.py
> index 0ffc6c38da..3109a81db7 100644
> --- a/scripts/minikconf.py
> +++ b/scripts/minikconf.py
> @@ -688,11 +688,13 @@ if __name__ == '__main__':
>  
>      data = KconfigData(mode)
>      parser = KconfigParser(data)
> +    external_vars = set()
>      for arg in argv[3:]:
>          m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
>          if m is not None:
>              name, value = m.groups()
>              parser.do_assignment(name, value == 'y')
> +            external_vars.add(name[7:])
>          else:
>              fp = open(arg, 'r')
>              parser.parse_file(fp)
> @@ -700,7 +702,8 @@ if __name__ == '__main__':
>  
>      config = data.compute_config()
>      for key in sorted(config.keys()):
> -        print ('CONFIG_%s=%s' % (key, ('y' if config[key] else 'n')))
> +        if key not in external_vars:
> +            print ('CONFIG_%s=%s' % (key, ('y' if config[key] else 'n')))
>  
>      deps = open(argv[2], 'w')
>      for fname in data.previously_included:
> 

