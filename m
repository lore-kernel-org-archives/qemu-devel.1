Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F1CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405A7206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405A7206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfXP-0003pt-Fn
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCfWf-0002lD-4U
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCfWd-00065W-TP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:18:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36009)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jCfWd-00061F-KU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:18:35 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVvGt-1in42l34QX-00Rslc; Fri, 13 Mar 2020 09:17:58 +0100
Subject: Re: [PATCH] configure: Fix configure error.
To: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20200313065525.31722-1-chen.zhang@intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e240baab-18b8-94b9-7ed5-e7ec9daed489@vivier.eu>
Date: Fri, 13 Mar 2020 09:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313065525.31722-1-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yEveM/LF/bAaKDSLVqFxt/gFtqitF8XW7Wvw+pDU3wAF6UVadCZ
 QP0qr07gzb7DaG3MIItYpvrSKhnl/50JPKsdASgA6egkBaU6O7J9MbQ+TtEvuLECzW9nUQn
 qJT4KiBR3RKcEvD77VsjWoi6kkGq9+2x5LCcfA9xwzRpQNP9frU968gO2loWytKp0UMOvNM
 7teDhZu9DNefA1rCollOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y45HNCT81Pw=:o3NBKKy9/WvjXbNOJZWSXG
 oK0i5bKJv8BMxrPfszT9o4RwkwCksSdz3BHely1RYuSiDS6rjsvwb/mIuxcD9G7NH78j8I9ly
 eC2cc3Oq4OpAgiKklUk970XNKggqbc8m1aruhuLo3KmFj2/QnszR7MKB3WrC7jYmj0C8nhbjn
 kqS5oeO16XiGUJ66Q9arh4jr1k0aPrn9Jmdqis/ojrkxikN7X75Ei/Zu9yOXmXsMKWeLlxqbV
 BYHGW1F5Xpfwo+4wUa01mbxbFDYbUFQRDJ3nTzueh98cSu0iy1NDo8MK4okwo/j5sXy3acGjW
 kBV0QqG+YEdmuk7DCZNHMarGs9w5dY5HjN8RV9EWywo58LFenCSRrIJc/vXaaz0IxITFJYyIy
 M6kdiHR+kh5kYrn4m7TcWUMkKIIwNVddWLffLGd9bEFGk6kT55JVNq6qhpRVVN0gbk60VPdiY
 6LW47LXLvPG1170QW/iLtwFROuR1Qm0HcqRXvgKX3rZnrf0eRf5Lg48qm+FUtdWvYgl/sEVa1
 kaPaspi9DZGLOxQzWa1AhHZYxfKA/vhymY1h7ycRFyQl1FYBeMUwekHxwpDWMNLXVCpGfjI/y
 PAaMq8d1ly0yPNF8Z37dyHPDJxWqdfF0RZZPzOCYyBYI0x8j3B2EQC5szWcugdelH9j0EXd7Z
 8DUNU/x7XviOmw2Tv0i0ZgWABEAXfE+P5mdhQdc/s7X67KPQ0Efq5Kfzs2tX0el2sMHGIs/fd
 iMpeNfRdywAX6SthtUwh93pIdCdyYFGLtrKcAYyRI5RKppahpzDE29AfUj3OcmWcout0bEZmn
 96MuMeafBv5Ak+LO79xUjsreqBAYBqKFXFt7cg/s5Tvl6obHoKF0M5A5Rp1+PCzh3Zf6BQB
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/03/2020 à 07:55, Zhang Chen a écrit :
> From: Zhang Chen <chen.zhang@intel.com>
> 
> When run the ./configure will always get this error:
> Unknown option --exist
> 
> It caused by this patch:
> commit 3a67848134d0c07da49033f9ed08bf0ddeec0c6d
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Tue Dec 17 21:15:24 2019 +0100
> 
>     configure: Enable test and libs for zstd
> 
>     Add it to several build systems to make testing good.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 3c7470096f..305591f7e0 100755
> --- a/configure
> +++ b/configure
> @@ -2475,7 +2475,7 @@ fi
>  # zstd check
>  
>  if test "$zstd" != "no" ; then
> -    if $pkg_config --exist libzstd ; then
> +    if $pkg_config --exists libzstd ; then
>          zstd_cflags="$($pkg_config --cflags libzstd)"
>          zstd_libs="$($pkg_config --libs libzstd)"
>          LIBS="$zstd_libs $LIBS"
> 

Juan already sent a patch to fix that:

[PATCH v2] configure: Improve zstd test
https://patchew.org/QEMU/20200310111431.173151-1-quintela@redhat.com/

Thanks,
Laurent

