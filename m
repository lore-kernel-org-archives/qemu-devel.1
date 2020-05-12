Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F37CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13793206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7NbW4EX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13793206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXlb-0003do-3x
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYXkz-00035g-AD
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:27:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYXky-0003eA-4d
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:27:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id g12so24111862wmh.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=O4gKGkpm82pxMX3onBRzioTvYqwkJ/zVNHfoOm9bqjc=;
 b=o7NbW4EXEhBoam1x2ouG6znb6Hp34K0QryPkw+ZUgkbibh+EYiZU5uyPyBj+1/Luw+
 Zpftoo2R8Pf1lYroBRrrtNwy4wBZuwQfm8WN6lNV8Q4V6IRonuCnNK5DI7vLORGD0d0D
 iAq26boQ6F+skXe/pftYgple+EoOChrA8L2KA93hxcfi93MdTPZDnxxj5lcVQopJRU1i
 fhUYrE9JNq1EEB2V9E+28CuTXJ6Be3i/DO7v8QqDrXFSUvUNQQi2bJjOjvoKdq7qrljZ
 RywQtjZaY4AXRbeB6UEgiVp7otCvE07UlmeZXPZn8Wsq6xGLyKuq4OAzj5PFF90cqlZe
 8yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=O4gKGkpm82pxMX3onBRzioTvYqwkJ/zVNHfoOm9bqjc=;
 b=OPVRr2SC9/DEbt75qPNlVZSV0A3RLiQNaI2fygFq2p0zw6ED6d6su2RE6GnlSAX5NN
 RXcLWgCAmaJuoc2k19f0mcbB2tR3am4wzvV1r50rr5rOUNstMkAoyoe0YipDeWH8ykIg
 b7BhaC9WI2Ol0sN14JhUPlPja0WA9jHOet9/148mQBg2tfUKK2IZhmREl2TkEjjG79+v
 Y1/sn53aQmWopRKwX4kQxNtOcelzuhso2ywMjye9H3ijcxJyYNo/5YenNR/Ap6HsC6JN
 2Z0eORgtQaskT1lSrVczLCe91YcvgLQRha+PFNWt5ydXEq0ocFa6/aaxh7e+56MzJQOd
 Vqnw==
X-Gm-Message-State: AGi0PubitfVOvI6As7WdyVIQnG2qLRhQsRUXj1TEIVHLkmx26UciOiKW
 xunXu7Cff+qYg/wsiUcAmeOGqQ==
X-Google-Smtp-Source: APiQypKus/atP5ExzJPLtQ8z6jQUu8eFW0hHgxOjdqLeivn4+eZztVxJmbfcKs3uERfMebWwVO/k8A==
X-Received: by 2002:a05:600c:2dda:: with SMTP id
 e26mr29234417wmh.42.1589300866411; 
 Tue, 12 May 2020 09:27:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s24sm33257667wmj.28.2020.05.12.09.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:27:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E9BD1FF7E;
 Tue, 12 May 2020 17:27:44 +0100 (BST)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-75-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v8 74/74] cputlb: queue async flush jobs without the BQL
In-reply-to: <20200326193156.4322-75-robert.foley@linaro.org>
Date: Tue, 12 May 2020 17:27:44 +0100
Message-ID: <87imh1f79b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> This yields sizable scalability improvements, as the below results show.
>
> Host: Two Intel E5-2683 v3 14-core CPUs at 2.00 GHz (Haswell)
>
> Workload: Ubuntu 18.04 ppc64 compiling the linux kernel with
> "make -j N", where N is the number of cores in the guest.
>
>                       Speedup vs a single thread (higher is better):
>
>          14 +------------------------------------------------------------=
---+
>             |       +    +       +      +       +      +      $$$$$$  +  =
   |
>             |                                            $$$$$           =
   |
>             |                                      $$$$$$                =
   |
>          12 |-+                                $A$$                      =
 +-|
>             |                                $$                          =
   |
>             |                             $$$                            =
   |
>          10 |-+                         $$    ##D#####################D  =
 +-|
>             |                        $$$ #####**B****************        =
   |
>             |                      $$####*****                   *****   =
   |
>             |                    A$#*****                             B  =
   |
>           8 |-+                $$B**                                     =
 +-|
>             |                $$**                                        =
   |
>             |               $**                                          =
   |
>           6 |-+           $$*                                            =
 +-|
>             |            A**                                             =
   |
>             |           $B                                               =
   |
>             |           $                                                =
   |
>           4 |-+        $*                                                =
 +-|
>             |          $                                                 =
   |
>             |         $                                                  =
   |
>           2 |-+      $                                                   =
 +-|
>             |        $                                 +cputlb-no-bql $$A=
$$ |
>             |       A                                   +per-cpu-lock ##D=
## |
>             |       +    +       +      +       +      +     baseline **B=
** |
>           0 +------------------------------------------------------------=
---+
>                     1    4       8      12      16     20      24     28
>                                        Guest vCPUs
>   png: https://imgur.com/zZRvS7q

Can we re-run these numbers on the re-based series?

--=20
Alex Benn=C3=A9e

