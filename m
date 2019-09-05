Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED61C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41CF206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41CF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5p8X-00037E-Cb
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5p4y-0000tB-E7
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5p4u-0004n3-EG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:33:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5p4q-0004kZ-6r
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:33:24 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7992EC08EC06
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:33:17 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b1so800265wru.4
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XhjoPF0xk8X5zrcSoH+Q0tcKJkWvrA4D2gCufF2Iy98=;
 b=UpRB+i6diTrvjmx+kE9pt+E4JioJZe4fg39Xe8dLIQnF8HfUq2imzt0lGRMWM3JG9i
 rqpoqzBrbg7JVCRP3CFq7CGFJZ93829NbhQcfzfkTnHVs7r/drignyDzZkH5iavBVux3
 0U56f2vEU/GDBaXCZqF+KZzTVyspzEqpDmFdeA7RjN8R+5bUn7ZPxecZ9o4o1lVeBn9/
 gWl+28eMizllCMUCe+8AhzZuDDqsjX7a88FJGEnbEzhUaGD9sZhEXWBEJacaj470jiuG
 21/MicRfqIYHyBuLV9BGQzf/rUTW/kDJtP31YPHXwUuTquhpl8m41ORBMLvML+f5SMsO
 Dniw==
X-Gm-Message-State: APjAAAWlso0AN788jZNQYyIQczThOhS6hZ9igfA5s9KuN/qcnSOEPqCP
 7Jpts9NEvq1hR3flQYdIgZAq+QF0AKZm7m4i0lrFAWF44H3X+Gk7RrGwoR9ggZ0Tt6JO42DKWxQ
 88PfkPHNFdQol++s=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr2117992wro.17.1567679596232; 
 Thu, 05 Sep 2019 03:33:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysTMM8wTulSPgo9yE0vZAKcIWlGRDofrmbCeNCCaqF+M5UtiwtQ8bPJmp7OTMis951wLk4cA==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr2117973wro.17.1567679596074; 
 Thu, 05 Sep 2019 03:33:16 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id j26sm4567721wrd.2.2019.09.05.03.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:33:15 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-41-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8fe21ca3-1bd3-575a-6355-dc226f2816cf@redhat.com>
Date: Thu, 5 Sep 2019 12:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-41-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 40/42] Fedora images: use URLs from
 stable "archives.fedoraproject.org"
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
Cc: fam@euphon.net, Yash Mankad <ymankad@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, Cleber Rosa <crosa@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 10:30 PM, Alex Benn=C3=A9e wrote:
> From: Cleber Rosa <crosa@redhat.com>
>=20
> The LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 test,
> from tests/acceptance/linux_initrd.py, is currently failing to fetch
> the "vmlinuz" file.  The reason for the failure is that the Fedora
> project retires older versions from the "dl.fedoraproject.org" URL,
> and keeps them in "archives.fedoraproject.org".  As an added note,
> that test uses a Fedora 28 image, because of the specific Linux kernel
> version requirements of the test.
>=20
> For the sake of stability, let's use URLs from the archived and
> supposedely ever stable URLs.  The good news is that the currently
> supported versions are also hosted on the later.  This change limits
> itself to change the URLs, while keeping the fetched files the same
> (as can be evidenced by the unchanged hashes).
>=20
> Documentation and the "vm tests" fedora definition were also updated.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Yash Mankad <ymankad@redhat.com>
> Message-Id: <20190904005218.12536-1-crosa@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

