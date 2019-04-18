Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47038C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0809B20821
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 09:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0809B20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38652 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH3fi-0001Cs-GA
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 05:49:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH3ec-0000lZ-8q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH3eb-0008Ou-4X
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:48:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hH3ea-0008O4-TZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:48:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so2137841wmd.0
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2kP0cJ/QX/LphCr64z8xx0JlGOBKJEt5lEwatvc/Q0c=;
	b=QS1/rlg0lQJ7e2Ms2dCVMjzv2BP4GM+DCfZI67UoiA7BO6IOXrpfI9Wo83M8Zi3lvr
	Tkdvyivxsh2SIOjsWZ02QzJRHXhsgq1lY0bgtu8bEY+ab5vwkpAJHYT1brp8WSlMuFoR
	TkzQi2IGqvZ4sWD9LcvujrxVFErKrbGF+t/MvEtHKGj4W5z84O8COjqQvlMzKLW7VULS
	BHgCD6+0rFuo+I0LJu5SOPNMrOGek+ojvqEMrI/wKI3msvSCYsiaXKUDdFCDGMa17eqB
	KdW3/ParEKgic/EosBQLuiDtJ8Vhvvm01WuOy6tYBpaU+8qRwOCxKJAk0L9XAipZUQXb
	t37g==
X-Gm-Message-State: APjAAAVrraHdcRFqk5FIsqMQhll6iwA8HZ/JiqHQsQf3TJpgVccKp8gL
	rVnGieGFXcADqKnmn9Ky1ffDeA==
X-Google-Smtp-Source: APXvYqxv5KgItpOpQnMfnSGyMQHR+cbUKk6gGM34FWD7J1HWZYUQ4y8kDVzhjvyjPMiQlElqi9o28Q==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr2399655wmc.144.1555580903477; 
	Thu, 18 Apr 2019 02:48:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49bf:c33a:2074:ab2?
	([2001:b07:6468:f312:49bf:c33a:2074:ab2])
	by smtp.gmail.com with ESMTPSA id
	y197sm1839646wmd.34.2019.04.18.02.48.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 02:48:22 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
Date: Thu, 18 Apr 2019 11:48:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	qemu block <qemu-block@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418094821.Z-VkdXaYsJ9yQTko3QGbs_4pODYTI3uWjqVH5iNewcA@z>

On 17/04/19 14:30, Stefan Hajnoczi wrote:
> On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
>> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
>> from exceeding these limits, by capping the maximum transfer length to
>> that value in the block limits VPD page.
>>
>> [1] Oh well, at least it was easier to follow the kernel source knowing
>>     it had to end as ENOMEM...
>>
>> Cc: qemu-stable@nongnu.org
>> Cc: qemu-block@nongnu.org
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

This is acually only an issue with kernels prior to 4.5, so it should be
fixed downstream instead.

Paolo

