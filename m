Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DF7C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 21:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE9621842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 21:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE9621842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr88Z-00081m-NE
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 17:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52825)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1hr88O-0007bY-Ep
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1hr887-00040t-34
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 17:52:04 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1hr87x-0002ob-7A; Fri, 26 Jul 2019 17:51:49 -0400
Received: by mail-ed1-f48.google.com with SMTP id p15so54384719eds.8;
 Fri, 26 Jul 2019 14:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:references:mime-version
 :content-transfer-encoding:subject:to:from:message-id;
 bh=2AyAQVGQBQq6GkY01jBrkoZB7K3SRJrtiK85l7NW6Vo=;
 b=sGnvTfCGDaCAYGKcqKfCsRJ95IqoOd9kYvEQznj5OObLtz5zuOmZBlvdjzmG1I7PEB
 VUPHxeLDy8vxgTt0y6c9UmBTUnqzNvsuWQscW2jMIfgnAHLWcafhjLxi6OEchNF5G3oY
 R0S+EiVv1BLV8/wwQHAzM/TXMiqN16j+ggCbL6FTnObSVKUeWXvmGHx2v96SuOJkXXGq
 PEMsFPyFb/5DMx2s1yBlnu0J1xyZbEvc59pXwsdECnIRR5F/ZNGgvc0SOTyOaVFn8LEq
 adZKQ82/OshXjOi6xfi5V255GaL0I8azj8mfurkYinWUw+6EemyTxOgBnJ0jkUf+Q2Zy
 9xHg==
X-Gm-Message-State: APjAAAUM6fcJjWRb9S8gqjP7HLrqemrNGoLjADdrsGo4nBmBkaAvfzA8
 mbv/dCvQhgKxKRzzXrrIQ+AUc1ojd+I=
X-Google-Smtp-Source: APXvYqwVTdz0eBkMTidrDK9VGJHhW8JYWJ2bgN10x4f9xvpXsFqV2eMJT+0uPO7NhF4G7mMIa2O4pg==
X-Received: by 2002:a50:fb8c:: with SMTP id e12mr27651492edq.155.1564175381374; 
 Fri, 26 Jul 2019 14:09:41 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:c2bd:509e:e83c:a9b1:9a76:b53e?
 ([2a00:1fa0:c2bd:509e:e83c:a9b1:9a76:b53e])
 by smtp.gmail.com with ESMTPSA id f24sm13909666edt.82.2019.07.26.14.09.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 14:09:40 -0700 (PDT)
Date: Fri, 26 Jul 2019 23:09:36 +0200
In-Reply-To: <76881947-141b-0a16-c52d-a315203c32eb@redhat.com>
References: <1562335669-10127-1-git-send-email-alex.popov@linux.com>
 <76881947-141b-0a16-c52d-a315203c32eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, mst@redhat.com, pmatouse@redhat.com,
 sstabellini@kernel.org, mdroth@linux.vnet.ibm.com, pjp@redhat.com
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <781B2374-635B-4B24-AF3C-EA42152C2335@linux.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.48
Subject: Re: [Qemu-devel] [QEMU-SECURITY] ide: fix assertion in ide_dma_cb()
 to prevent qemu DoS from quest
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



26 =D0=B8=D1=8E=D0=BB=D1=8F 2019 =D0=B3=2E 2:25:03 GMT+02:00, John Snow <j=
snow@redhat=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>Oh, this is fun=2E
=2E=2E=2E=20
>I can worry about a proper fix for 4=2E2+=2E

Hello John,=20

Thanks for your letter=2E=20

I double-checked the git history and mailing list, I'm still sure
that my fix for this assertion is correct=2E

You know this code very well, of course it would be great if you
prepare the further fixes=2E=20

Feel free to add me to CC, I can review the patches and test
them with fuzzing=2E=20

Best regards,=20
Alexander 

