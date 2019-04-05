Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B6C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EEE217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EEE217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKvi-0008Hi-1B
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:14:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKlu-0008LQ-Sf
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKYR-0002Hl-CF
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:50:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKYQ-0002F1-Uu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:50:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so6956016wrn.11
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=O5U6J0TiUGGFrt9pF72uhDfG00VMCpnIL45ddprCxh4=;
	b=bak3SnYyJKeB6+aYGKCPqqaPaRFybF0JHGB1LEGWnXDdMu4BiWtTYYZcz4HWbadr5D
	S5hkwpXbiw5OEeFqa1X8Bk77YJ/cjYAhR0tjrmzbwguIpxS0aUXHLUgrOtHqOTKkzFql
	BHlSTH8Swr7R6gY+W6s3Wbin4+i4ptaALuvgKk+9k4TqWXIeWDeaeIfOvcmM3AXwgIs5
	C9bGIKbGH6DWZu4D7muzhcVFEV5r8V+x51um9x5zcxUqxoG6mu09mweyrWndEdhNiSIX
	4gnc6l5f3qBaO+sn1+tzhV64RJwHyl4ZDbpxaDp6hokYVx6l9I1DBvQT6rHrbkzF//UP
	ITDg==
X-Gm-Message-State: APjAAAWR54ePkrhr4JYzz5tgA+5faH/SpTNg/DYn8EKE/+jegGFbFozy
	lM8i0tpnq0zLCPjhnPnuWBE8Rw==
X-Google-Smtp-Source: APXvYqxGe19SLgWnug/36OgU9CN9E/G2ES04MNNa+exsNlf3pgW5Cjgcuxx/aa/PI5WkuRSqS/Ah5A==
X-Received: by 2002:adf:b458:: with SMTP id v24mr7450612wrd.46.1554454229978; 
	Fri, 05 Apr 2019 01:50:29 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v6sm25236253wrt.56.2019.04.05.01.50.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 01:50:29 -0700 (PDT)
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<20190403161729.GW25150@redhat.com>
	<CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
	<43102ef9-2f96-2863-00aa-b6f2906c2f4f@redhat.com>
	<20190404085621.GD10471@redhat.com>
	<20190404183923.GA22347@ls3530.dellerweb.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <02191499-2d1c-18a1-346d-4afda800d5ee@redhat.com>
Date: Fri, 5 Apr 2019 10:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404183923.GA22347@ls3530.dellerweb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] configure: Relax check for libseccomp
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405085028.Sd2BLLwsMWKcfbne4HZLMTDH-d-4ByixOLaO3Y0s0Us@z>

On 4/4/19 8:39 PM, Helge Deller wrote:
> All major distributions do support libseccomp version >= 2.3.0, so there
> is no need to special-case on various architectures any longer.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/configure b/configure
> index 1c563a7027..8fe4fc84d8 100755
> --- a/configure
> +++ b/configure
> @@ -2377,36 +2369,16 @@ fi
>  ##########################################
>  # libseccomp check
> 
> -libseccomp_minver="2.2.0"
>  if test "$seccomp" != "no" ; then
> -    case "$cpu" in
> -    i386|x86_64|mips)
> -        ;;
> -    arm|aarch64)
> -        libseccomp_minver="2.2.3"
> -        ;;
> -    ppc|ppc64|s390x)
> -        libseccomp_minver="2.3.0"
> -        ;;
> -    *)
> -        libseccomp_minver=""
> -        ;;
> -    esac
> -
> -    if test "$libseccomp_minver" != "" &&
> -       $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
> +    libseccomp_minver="2.3.0"
> +    if $pkg_config --atleast-version=$libseccomp_minver libseccomp ; then
>          seccomp_cflags="$($pkg_config --cflags libseccomp)"
>          seccomp_libs="$($pkg_config --libs libseccomp)"
>          seccomp="yes"
>      else
>          if test "$seccomp" = "yes" ; then
> -            if test "$libseccomp_minver" != "" ; then
> -                feature_not_found "libseccomp" \
> -                    "Install libseccomp devel >= $libseccomp_minver"
> -            else
> -                feature_not_found "libseccomp" \
> -                    "libseccomp is not supported for host cpu $cpu"
> -            fi
> +            feature_not_found "libseccomp" \
> +                 "Install libseccomp devel >= $libseccomp_minver"
>          fi
>          seccomp="no"
>      fi
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


