Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A53DC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347F72084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347F72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcv9U-0007dI-Ht
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuFb-0005oT-9D
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuFR-0006Np-CB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:12:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuFP-0006Kf-E9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:12:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so312618wmd.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0V1Qrt8LxrAbQQ43nPV9FyjxZsd5A5vX9bmHl3kOz4o=;
 b=TJLlQiNU7it1R7q0+Txf9D7PQSxPVPStE8wMnbt5QuZ66qcy9YARx1wOWCXmSgFaiq
 JKPvePgQuv7LSFlqLZtYTDpzzgUW0sXZ1PBCa5lRwcPlnTO3BMBTAbw7SVI3WXAC7RJ2
 mGpnlkBV8nxrtysP5h444k867FroriqJ7ySwrEWbbVitKWXFP62KAd5DZe18yYQnNekA
 1it84nwcJhDA04JNkVJ1aQ31oqQ+CCvsGinLFpbDvGoRBAm8m4CH2XUU+AZC97eEZBOH
 8McAwKaxSlFJ5+d+gYbUTBSx3Ap2mAYoAyOfdzHZzJGAYcQRbXz9yCFAW8NbpmsZK0AC
 a4Iw==
X-Gm-Message-State: APjAAAVehECbnX7U1y7c0kfytV3Rr8HFJrtxfL8M2M8Ik+PVZ7iWmH8S
 Aflle/wr/qXuSIb0Rzn3JrZoJw==
X-Google-Smtp-Source: APXvYqy5mIXydWA6eHt1qnLuqxWO/l3gpgQ7RGej7Z16UATt8Q4kvmEG77BD8nZPst0wRXUJ7CNX/Q==
X-Received: by 2002:a1c:2907:: with SMTP id p7mr19437175wmp.100.1560787960609; 
 Mon, 17 Jun 2019 09:12:40 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id r4sm27034856wra.96.2019.06.17.09.12.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:12:40 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-8-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6169c2d4-876c-9311-8b00-b847a3de047c@redhat.com>
Date: Mon, 17 Jun 2019 18:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-8-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v4 07/11] tests/vm: openbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 6:38 AM, Gerd Hoffmann wrote:
> Instead of fetching the prebuilt image from patchew download the install
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

From v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

