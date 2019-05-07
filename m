Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECAC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A7420C01
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A7420C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvDS-0006Tw-Gt
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:12:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNvBq-0005eS-1p
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNvBp-0003sO-61
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:11:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNvBp-0003rs-0j
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:11:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so18611238wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 01:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QBThy8UXvr/DHTUHSEz2ZVL3ciAScRGhiWQuJCjzl4Q=;
	b=C1v6nPYTYJfyhHblsunXxft09aHn/J6wAzMJAMByrF2oobNMhp+CKM7oX0aLMqQOUL
	gi7v3Thuhv9LhSCY2tAMGJ2fi0VrWCg6Ld9BcvnPXZz9iTdwQX+5u7nguoxLZjmPwWQ5
	oOk3yzrRdqn5eBo8osxGpwy8VtMUnB+GpU/p8MIstj8YzXTjyt9Dr47TXFkgwN1pwBlV
	GNVdgnUmkNy1BhPWVtLNHyQufj/YW6WTBC4aam9w2UuQVHWwRUP0x4lsdX/QYxCd6lKT
	GZ7yAo6VH0wt6T8Gf33dsM2Vxdo0Nt/L2oGa/krcnjlBWIrlV/ajagTp1INjy/Zc8PjZ
	/4+A==
X-Gm-Message-State: APjAAAVClO9MOF8UQhK78gdUcSzyS9AAHnm34d8qcwTQsH8zQ133oUWf
	9dsNuJwlO3wUM9bplB3wqenp0w==
X-Google-Smtp-Source: APXvYqx7ilBV5pUNg4TN9sgx7tOu1we41LsMjKoDBI44BBZ7G9omWCwLqdPczjW4wUGPueAzMM5j+Q==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr20110368wmh.68.1557216664037; 
	Tue, 07 May 2019 01:11:04 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	e5sm10080138wrh.79.2019.05.07.01.11.02
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 01:11:03 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190412121626.19829-1-berrange@redhat.com>
	<20190412121626.19829-6-berrange@redhat.com>
	<20190507075415.fsngpdrgnh2e5vch@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0516fc8f-5bf1-66cc-4865-f75c4f5309b8@redhat.com>
Date: Tue, 7 May 2019 10:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507075415.fsngpdrgnh2e5vch@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 5/5] qxl: avoid unaligned pointer
 reads/writes
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/7/19 9:54 AM, Gerd Hoffmann wrote:
> On Fri, Apr 12, 2019 at 01:16:26PM +0100, Daniel P. Berrangé wrote:
>> The SPICE_RING_PROD_ITEM() macro is initializing a local
>> 'uint64_t *' variable to point to the 'el' field inside
>> the QXLReleaseRing struct. This uint64_t field is not
>> guaranteed aligned as the struct is packed.
>>
>> Code should not take the address of fields within a
>> packed struct. Changing the SPICE_RING_PROD_ITEM()
>> macro to avoid taking the address of the field is
>> impractical. It is clearer to just remove the macro
>> and inline its functionality in the three call sites
>> that need it.
> 
> Added patch to vga queue.

What about the other patch Marc-André sent?
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01318.html

