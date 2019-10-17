Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2019ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960452082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960452082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL30J-0005tA-Oe
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL2yk-0004jy-Mo
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL2yg-000288-6F
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:25:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL2yf-00027K-Fv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:25:54 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 860CF89AC2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 10:25:52 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m6so837224wmf.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 03:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q5jC7nXyy6mAcbvWk6Lqheecu274ZSxb2w3ryjCOylY=;
 b=fOHtbs9wIUeRqF+hbFvh9SaiisWeITaSGlkr3fXuxT4OnO2QjhBiQXmFBJXBnT3rob
 Ax3U26z9G+Ojc/H4fgpobjb8S0LdN2k0yAdVb/U5x612SWpIFuhZMy+elhORTajYgM9/
 +wrAGrj3d5au+c29axvLsBNSRpPhHYB5j0EnGVtwGd0A1Uathcd54gUlO9tN9zZKUT3j
 n4wNmTVcSryzPa3reIF3LvBlM3ROIDPII/Uzqi1xZDdy9pyveQgtLxNzYy/O7p+hbjY8
 XjOCQRr37l2QGES8+wNjiXR/9C127jL1+Pn9DQbQwtB6706ROYOhYis1oyLmSxB5OmuV
 Fdig==
X-Gm-Message-State: APjAAAUwvksS5GRFexbs2P+lNtK0+Lj6JTGlGznY2XWRyH1NAiKeBIhf
 7EKrsFFao4iTy0hJIcdFPsd/Ejb4Zs5LNjTLotrvcKO7c+6MguFxkyZFYt4ZrDy7akluJ+M42cW
 Pn54haHHG6+MWYm0=
X-Received: by 2002:a1c:c2c2:: with SMTP id s185mr2106995wmf.107.1571307950989; 
 Thu, 17 Oct 2019 03:25:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwXGXkRRAKZvr2ygP6anvuAtK8kbzazjZaUlKZwh88eDasuAeWjBDRAT5hHo/rvfj0J733K0Q==
X-Received: by 2002:a1c:c2c2:: with SMTP id s185mr2106979wmf.107.1571307950782; 
 Thu, 17 Oct 2019 03:25:50 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id w18sm1723870wmc.9.2019.10.17.03.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 03:25:50 -0700 (PDT)
Subject: Re: s390x/qemu-user: TODO /home/dhildenb/git/qemu/tcg/tci.c:859:
 tcg_qemu_tb_exec()
To: David Hildenbrand <david@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <95ddf722-ba5d-dd48-a840-0d940ded3acd@redhat.com>
Date: Thu, 17 Oct 2019 12:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <60a0d510-b693-0ed7-560f-e70904d9574d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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

Hi David,

On 10/17/19 12:02 PM, David Hildenbrand wrote:
> Hi,
>=20
> I'm currently trying to run Fedora 31 under qemu-user=20
> (https://github.com/fedora-cloud/docker-brew-fedora/tree/8a81f67271e959=
dfc8f8a888b161bbd540b7a83b/s390x)=20
> in order to debug=C2=A0 a vector instruction issue.
>=20
> Strangely, when trying to chroot into above rootfs and running=20
> /bin/bash, I get
>=20
> t460s: ~/f31=C2=A0 $ sudo chroot . ./qemu-s390x=C2=A0 /bin/bash
> TODO /home/dhildenb/git/qemu/tcg/tci.c:859: tcg_qemu_tb_exec()
> /home/dhildenb/git/qemu/tcg/tci.c:859: tcg fatal error
> Aborted
>=20
>=20
> But it's not fundamentally broken:
>=20
> t460s: ~/f31=C2=A0 $ sudo chroot . ./qemu-s390x=C2=A0 /bin/ls
> bin=C2=A0=C2=A0 dev=C2=A0 home=C2=A0 lib64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 media=C2=A0 opt=C2=A0=C2=A0 qemu-s390x=C2=A0 run=C2=A0=C2=A0 srv=C2=
=A0 tmp=C2=A0 var
> boot=C2=A0 etc=C2=A0 lib=C2=A0=C2=A0 lost+found=C2=A0 mnt=C2=A0=C2=A0=C2=
=A0 proc=C2=A0 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sbin=C2=A0 =
sys=C2=A0 usr
>=20
>=20
> I do wonder why we don't run into the same issue under qemu-systems390x=
.

Are you also using TCI in system emulation?

Can you simply use TCG to debug your vector instruction issue instead?

Regards,

Phil.

