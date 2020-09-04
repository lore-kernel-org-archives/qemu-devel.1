Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD20C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6902920770
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6902920770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE9EP-0007dV-I8
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE9Do-0007BI-Gd
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:45:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kE9Dm-0006Wq-5Y
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:45:32 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-kII3zCfZOb-CiIM-fApI0Q-1; Fri, 04 Sep 2020 06:45:27 -0400
X-MC-Unique: kII3zCfZOb-CiIM-fApI0Q-1
Received: by mail-wr1-f71.google.com with SMTP id k13so603341wrw.16
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 03:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WWyMqYdlFWzes5l9Z9Fjjy9XY7hqgwPhXoj0bZzl2W8=;
 b=LprP0XSDfKorQLMGxpd9c6O3+omhVQG4GiILuBLXM/ZwCebW7+GafELLTabkLl1+IL
 xfzHEwJXx33kZxALH6PyHL1ssjZ6oF5tZMTqgtz8OMG9VpZaTcXmNGglRxCqcAlX94aA
 0MQSRg/gxOTNRE08oCCUi2jQ9fsD3bdr+XdEQfA9pw8mMKjKhp5VUojy3ZKEVBM6Y2xv
 v5wIi4ZYuUsXV9JaKWQrkOea1qYgfTPwdy2nAQVta/AE4NAIHzYOGMw/fJcoWRiOYNki
 Ca+0zQxB3YY4y6HO1e5YPtMGXPPA+/9jHMYA5VJEdTYo45hL9j5A+YoJxONOrqVtGlEZ
 1s7A==
X-Gm-Message-State: AOAM530P9wbOwNrxVs4Hq74KCCrw92n+S7MIJUCHRTCs7IiGZMoLDCxt
 iIeHnmRwLwO+PWLzneEskt0AX5dLcS4HvHBuAvU8/SVaErCfsrKVPulmMZulTfvJaH4Ul68RODK
 46kAT93+y58EDo3c=
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr6679605wrn.333.1599216326859; 
 Fri, 04 Sep 2020 03:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG/Nxop5XtmzsCq4/EcSYHVyT9th6vIvYl+TwC9R8PuA4D0eV18b7Oglp1AQye1Y/go2uoXg==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr6679583wrn.333.1599216326653; 
 Fri, 04 Sep 2020 03:45:26 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 8sm11446716wrl.7.2020.09.04.03.45.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 03:45:26 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] configure,Makefile: Install colo resource-agent
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1596536719.git.lukasstraub2@web.de>
 <108a9f4106fcc52f089c9bded571d46f79929235.1596536719.git.lukasstraub2@web.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <35188009-4bc3-63fc-60c5-cb92908c1de5@redhat.com>
Date: Fri, 4 Sep 2020 12:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <108a9f4106fcc52f089c9bded571d46f79929235.1596536719.git.lukasstraub2@web.de>
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 12:47 PM, Lukas Straub wrote:
> Optionally install the resouce-agent so it gets picked up by
> pacemaker.

This patch now needs to be rebased.

> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  Makefile  |  5 +++++
>  configure | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index c2120d8d48..dccc20b120 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -969,6 +969,11 @@ ifneq ($(DESCS),)
>  		$(INSTALL_DATA) "$$tmpf" \
>  			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
>  	done
> +endif
> +ifdef INSTALL_COLO_RA
> +	mkdir -p "$(DESTDIR)$(libdir)/ocf/resource.d/qemu"
> +	$(INSTALL_PROG) "scripts/colo-resource-agent/colo" \
> +		"$(DESTDIR)$(libdir)/ocf/resource.d/qemu/colo"
>  endif
>  	for s in $(ICON_SIZES); do \
>  		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
> diff --git a/configure b/configure
> index 2acc4d1465..39051d25f8 100755
> --- a/configure
> +++ b/configure
> @@ -438,6 +438,7 @@ softmmu="yes"
>  linux_user="no"
>  bsd_user="no"
>  blobs="yes"
> +colo_ra="no"
>  edk2_blobs="no"
>  pkgversion=""
>  pie=""
> @@ -1336,6 +1337,10 @@ for opt do
>    ;;
>    --disable-blobs) blobs="no"
>    ;;
> +  --disable-colo-ra) colo_ra="no"
> +  ;;
> +  --enable-colo-ra) colo_ra="yes"
> +  ;;
>    --with-pkgversion=*) pkgversion="$optarg"
>    ;;
>    --with-coroutine=*) coroutine="$optarg"
> @@ -1821,6 +1826,7 @@ Advanced options (experts only):
>    --enable-gcov            enable test coverage analysis with gcov
>    --gcov=GCOV              use specified gcov [$gcov_tool]
>    --disable-blobs          disable installing provided firmware blobs
> +  --enable-colo-ra         enable installing the COLO resource agent for pacemaker
>    --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
>    --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
>    --tls-priority           default TLS protocol/cipher priority string
> @@ -6930,6 +6936,7 @@ echo "Linux AIO support $linux_aio"
>  echo "Linux io_uring support $linux_io_uring"
>  echo "ATTR/XATTR support $attr"
>  echo "Install blobs     $blobs"
> +echo "Install COLO resource agent $colo_ra"
>  echo "KVM support       $kvm"
>  echo "HAX support       $hax"
>  echo "HVF support       $hvf"
> @@ -7496,6 +7503,9 @@ fi
>  if test "$blobs" = "yes" ; then
>    echo "INSTALL_BLOBS=yes" >> $config_host_mak
>  fi
> +if test "$colo_ra" = "yes" ; then
> +  echo "INSTALL_COLO_RA=yes" >> $config_host_mak
> +fi
>  if test "$iovec" = "yes" ; then
>    echo "CONFIG_IOVEC=y" >> $config_host_mak
>  fi
> --
> 2.20.1
> 


