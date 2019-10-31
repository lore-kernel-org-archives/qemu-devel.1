Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2A5CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE9B20873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE9B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQBDe-0006q7-G7
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQB5x-0003AW-NK
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQB5w-0000x6-4z
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQB5v-0000wC-VJ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:06:36 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08358369AC
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 14:06:35 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a15so3417359wrr.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 07:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TD45plrnyPHInxzEtPt0P6CQkxemeVIjXZSlu6W1jR8=;
 b=K6D6coVBvv2E5wa2HUDnjMOZDf0ZMdp3Fhw+97V6LmTKE519QxC3d1z/JEqJX7Y9at
 g2O8M0MtRt01pvbSN79FkE2aUYaT56kQnvJkrwJFGIeAJoglA6/us75iLdL7WVyoiMku
 sDfRByRte9bT46wJv5gingzzGP9ywW4auzsQvl7Z26Ei3/p1wKx1vA2/uU3K6JzwnWNp
 OHuz0XOHAB1XtoPe7rXuJ7/M1INyRNXNpYDA2fbLcOJD1Vy2It8OtbPMWG0dU1Fs/BU+
 adgJqDlhaSwLXcOFPUbHX/9bbKgEUs/gmiQku7iWx3dC0RHQIz9MmT50JpXiE40NR65w
 UPtw==
X-Gm-Message-State: APjAAAW98Kw0XswO0gBvyqrKRQcedDg7OsQHxZsmsGnw/+s0guk02xw9
 9+GO8pABi3xs1dYaKpWyqouqlpR2zBt3xFkft87Csl0qeKa5E+58xxUyDq6tcNDxO0Pp0ZlEg+e
 dg2NNJ4VIXDRLORY=
X-Received: by 2002:a5d:4982:: with SMTP id r2mr61393wrq.254.1572530793565;
 Thu, 31 Oct 2019 07:06:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRwOstzO9U7bPFJjay183fX6yBS2QsyF2IXzm5ByAKNrV5CFhTYWTCaKvRztw1enpzf+PiSg==
X-Received: by 2002:a5d:4982:: with SMTP id r2mr61370wrq.254.1572530793368;
 Thu, 31 Oct 2019 07:06:33 -0700 (PDT)
Received: from [172.20.51.145] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id a7sm4411168wrr.89.2019.10.31.07.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 07:06:32 -0700 (PDT)
Subject: Re: [PATCH v6 3/4] tests/vm: use console_consume for netbsd
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20191031085306.28888-1-kraxel@redhat.com>
 <20191031085306.28888-4-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ac99c55-9cca-69e7-8890-16bf033385ee@redhat.com>
Date: Thu, 31 Oct 2019 15:06:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031085306.28888-4-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

On 10/31/19 9:53 AM, Gerd Hoffmann wrote:
> Use new helper to read all pending console output,
> not just a single char.  Unblocks installer boot.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/vm/netbsd | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 5e04dcd9b1..d1bccccfd0 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -93,7 +93,7 @@ class NetBSDVM(basevm.BaseVM):

Why not use this by default for everything?

Anyway,
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>           for char in list("5consdev com0\n"):
>               time.sleep(0.2)
>               self.console_send(char)
> -            self.console_wait("")
> +            self.console_consume()
>           self.console_wait_send("> ", "boot\n")
>  =20
>           self.console_wait_send("Terminal type",            "xterm\n")
>=20

