Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E004C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 06:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017BF206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 06:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017BF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDN1T-0006AP-8C
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 02:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDN06-0005DM-BJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 02:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDN01-00087L-Tl
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 02:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDN01-0007uE-ME
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 02:11:33 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98C8FC049E1A
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 06:11:29 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id z205so634263wmb.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 23:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wdvzJ5BUbmXeBkpBPOz/EkhJhpcKuotyhBOl5JxNZYw=;
 b=buOTdB/AvIZ7+OyMceuaf7rxP68Gbq4u3+8McAXPJ0gEVYYDRv7AJnW9UCEM1EgFmK
 bcZ17ACrIByTFRjZnsW09+fI7vppJ9uCEJaMXORVQG+kAGpx4MOww1+b/NlkvYUgOkaR
 HSTpHXejzRczDITLGS9Xoa4M+9kc9m6lU18EVsg4elYt2WnC+95hkrLM5/vW3pMAxmUS
 EBScC4T+PgdYxM4m8r4LSk82KNruM03a9VK4SnPqtNr6gJHB4Ze385V2LY9RpVGMZ0I4
 XxUS9zr74YGCQgi4ouhbNmTuP4oolnNC1WPmvRmZ1l8md2XPgtyKnhQNiguhUXhsZ76a
 jjUA==
X-Gm-Message-State: APjAAAX4mcsQRGU/g1o5TJS1AZiWp3t188goHiyRhDG7KE8eGFEXdB5Z
 rgQF6ZstGU/CcHwkI8ODyBdb94lyAfWG6X7V4f2xplluZsLBfGpWuLPCoNvdV1mmEZftSmu82Ig
 TB5gY1tkXNPzos5w=
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr1555732wmd.14.1569478288403; 
 Wed, 25 Sep 2019 23:11:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIi5Mnl8wdCh+o6KSfORL3hFuatP2pJyuqulEiwUyEMAEJGsg3fM9fWKaJdZVF/RSYJF58DA==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr1555704wmd.14.1569478288079; 
 Wed, 25 Sep 2019 23:11:28 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z13sm1147316wrq.51.2019.09.25.23.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 23:11:27 -0700 (PDT)
Subject: Re: [PATCH] hw/core/loader: Fix possible crash in rom_copy()
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20190925130331.27825-1-thuth@redhat.com>
 <ca146886-12e5-14c7-7b18-76494b1d7c8f@redhat.com>
 <fc1616b5-1404-166a-6cae-c729ce77b1b3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9ffdb4ee-46d0-8186-c80e-6177295bd3e2@redhat.com>
Date: Thu, 26 Sep 2019 08:11:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <fc1616b5-1404-166a-6cae-c729ce77b1b3@redhat.com>
Content-Type: text/plain; charset=utf-8
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 7:58 AM, Thomas Huth wrote:
> On 25/09/2019 22.51, Philippe Mathieu-Daud=C3=A9 wrote:
> [...]
>> Let's say I have write access to a LAN TFTP server used by some PXE
>> bootloader where I can store my crafted nasty kernel, then I get this =
score:
>>
>> https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator?vector=3DAV:A/AC:=
L/PR:N/UI:N/S:C/C:H/I:H/A:H/E:P/RL:O/RC:C&version=3D3.1
>>
>> CVSS Base Score:     9.6
>> CVSS Temporal Score: 8.6
>>
>> Which seems quite high.
>=20
> I don't think you can trigger this bug this way. If you load your kerne=
l
> via a PXE server, the ELF parsing will be done by the bootloader, won't
> it? I think you can only trigger this bug here if you load your kernel
> via the "-kernel" command line parameter of QEMU (or the generic-loader
> device), so it's not a real guest escape, as far as I can see.

Ah indeed you are correct. You have to use the -kernel option to set
kernel_filename. This reduce the scores:

CVSS Base Score: 8.4
CVSS Temporal Score: 7.6
Exploitability Subscore: 1.7

You could load a kernel stored on a NFS server, but it is unlikely a
production case :)

