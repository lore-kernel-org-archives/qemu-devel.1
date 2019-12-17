Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195CBC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F6D2465E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnPZalXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F6D2465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGwH-0002DV-Vw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihGp9-0001kq-5R
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihGp8-0000rQ-65
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihGp8-0000qT-2M
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576604393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otHh6o7oxDp9j6yghQWHjKyedFvOrFKCAiJYw7JbOso=;
 b=bnPZalXMiAaF53WxblMvaAk6GFNlAyhlmGtNc555QdflK8aeToXuarQu8onLZf2pNiw0AO
 leKUy7Jyjt447Z4TQKuKlqrrj2DZA9jAqxs/7958D6pxh7lh2NqJSDrjnDPG0NhIb0Fd74
 bFVg/b5J5IVKytkFNgpC3PZjUF5uQV8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-G7uGzzEVPWqcbIrMFp_nLw-1; Tue, 17 Dec 2019 12:39:52 -0500
Received: by mail-wr1-f69.google.com with SMTP id o6so4518733wrp.8
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 09:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bAAJWyVVZ1IKai9f9il7x2Z+RsApLRgS+QHt3wBYLSA=;
 b=KcCLSxkE6knS5N2B4hoZ6fo6XgxcZvGiBWHq6tI495MEkXWvI0jluXEGDeVMftLpPf
 C8crii2VmDI5p2gIlAFUHFiIk1R6sD8uAnAcz1OwiC1URTd3rn0B9RqSwOe6L9WQZ4sj
 lalNGaabslzU3Te5OO1WpOj4s3xd4vHfelHlK7mNOGWT1n8zRAvIOMddk/wQkAy8yiLb
 Pfq3oJtsLr0Mqd/rEJS7KUrf2TPEiF5KQa3mCZOtFbOGTeatXdkp9D292D/EBPx+x26o
 1ZwS5pgprOMrcdWuYpDjnTagRBpKyUQJTVFvfsEYulWvFXgCByW2uXN+q93nqDQPDT6J
 CxnA==
X-Gm-Message-State: APjAAAVK0VzyWXYVExQT0jn5yUjfuIU9lfDLxUB9XU2neWbivU2ZzjE/
 cBdj/5nRjsam5wzyGCYtDO3VcfQsDbuHTGeYZxlSoos3Ru7Uy5bA4RbCm3Xfy+y6dh2WxoXq7vV
 qbizDKM0mx8xPphA=
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr38388339wru.40.1576604390837; 
 Tue, 17 Dec 2019 09:39:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFBpSiHMJZuiUp5KC+DdlpgXyZDlJKyko8FRSj5XpUtFN/99wAgHNrx1ZQ4OV5F9Cdqp7BRQ==
X-Received: by 2002:a5d:6a0f:: with SMTP id m15mr38388290wru.40.1576604390534; 
 Tue, 17 Dec 2019 09:39:50 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id h17sm27417449wrs.18.2019.12.17.09.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 09:39:50 -0800 (PST)
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
To: qemu-devel@nongnu.org
References: <20191217173252.4672-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6a8266c6-7c6d-3139-249f-2dd46c98e02f@redhat.com>
Date: Tue, 17 Dec 2019 18:39:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217173252.4672-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: G7uGzzEVPWqcbIrMFp_nLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 6:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix some trivial warnings when building with -O3.
>=20
> Philippe Mathieu-Daud=C3=A9 (6):
>    audio/audio: Add missing fall through comment
>    hw/display/tcx: Add missing fall through comments
>    hw/net/imx_fec: Rewrite fall through comments
>    hw/timer/aspeed_timer: Add a fall through comment
>    hw/scsi/megasas: Silent GCC9 duplicated-cond warning
>    qemu-io-cmds: Silent GCC9 format-overflow warning

Sorry, this series failed because I used this tag in the first patch:

Cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>

Then git-send-email was happy with --dry-run, but then failed:
(body) Adding cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.co=
m> from line 'Cc:=20
K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>'
5.1.1 <K  v  g  >: Recipient address rejected: User unknown in local=20
recipient table

Note to self, enclose utf-8 names, as:
Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>


