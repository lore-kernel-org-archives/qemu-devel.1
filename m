Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1DBC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBF321881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBF321881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAB2t-000657-HA
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAAo5-0001FF-7v
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAAo4-0004Xo-4M
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAAo3-0004XB-SW
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:33:59 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB8A785538
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 10:33:58 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n6so1135411wrm.20
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h3d2eFSTiaXOJqpx4576Tbxu4r4n99cBosvK9J+DeU4=;
 b=lxS2CQjsrze8MMWrGNI4Tw9Us9u9G5vhi8UITMsaNQCEGZMIUeqgHs3eWZQLVdm3jA
 Pi/mhp0dmBpgdVWTqEXO6HWdQRo0JjWZYN1Oatwm6MZ4l9SziYf/VkBeJ20ZXbhZw6Qy
 E7ZQ6TBzMaTOgVYk+JS2LxMM3NIwnHUTMUtob+UV/YRw2QYageO3zfuB5xSQjNi0Gz3l
 QzKmeg61myaIzlFFocT7Heaqddu5DE0S8kIu9ptdENd+jEOtlP0aZVXa+u3TEDdzKNak
 0URWtqlivbvftOJROzb7H6UCcprrdmN5U7P0pQEXH7UImykSHPrpPjkwdHv612JxZQfd
 iJuA==
X-Gm-Message-State: APjAAAXELmumc/QD3RCP6cpom2gvefoCMW6VpR+60LzYfAiQfpaTOpC+
 MwzWwVh/eZXll3bNTcYFE+xmoT54K7Z1u2XOaVyUbDFPJd2hs20edh4nuscyuJX8msZG4lOtwM1
 Qa1jbunjvJ3bBXgo=
X-Received: by 2002:a1c:a851:: with SMTP id r78mr2842225wme.166.1568716437764; 
 Tue, 17 Sep 2019 03:33:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwW0eZK1V6D3u3hLCZgYVJXU/+v6xNIOgkaJ8Zkmy4m1jRIaGA+VR77yVOjmAgc0WKdSrFrKQ==
X-Received: by 2002:a1c:a851:: with SMTP id r78mr2842217wme.166.1568716437612; 
 Tue, 17 Sep 2019 03:33:57 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v6sm4160993wma.24.2019.09.17.03.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:33:57 -0700 (PDT)
To: =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>,
 qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
References: <83f649c6482bf363c38e7f3778d866f4@linuxsystems.it>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9d1ea4ff-a0df-f7c6-54ca-c03b010c5ff1@redhat.com>
Date: Tue, 17 Sep 2019 12:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <83f649c6482bf363c38e7f3778d866f4@linuxsystems.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] ELF load command alignment not page-aligned
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

Cc'ing PPC folks and Laurent.

On 9/16/19 11:06 PM, Niccol=C3=B2 Belli wrote:
> Hi,
> I'm trying to use qemu-user-static to chroot into a foreign amd64
> environment from my ppc64le host.
> The host has a 64k page size, while x86_64 uses 4k.
> I get those errors while loading shared libraries: "ELF load command
> alignment not page-aligned"
> Is there any way to fix this? I cannot simply switch to 4k page size
> because my btrfs filesystem won't mount anymore (it requires the
> sectorsize to be equal to the page size).
>=20
> Bests,
> Niccolo'
>=20

