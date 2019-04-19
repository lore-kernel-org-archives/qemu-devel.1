Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3348C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 13:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D630222B2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 13:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNneNbkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D630222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHTpF-0001UO-Dm
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 09:45:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHToS-0001Ba-EK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHToR-0001jJ-GD
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:44:20 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:53082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hHToR-0001id-Bc
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 09:44:19 -0400
Received: by mail-it1-x143.google.com with SMTP id x132so8324040itf.2
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 06:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=in-reply-to:references:mime-version:message-id:cc
	:content-transfer-encoding:from:subject:date:to;
	bh=riDh5nUDTq+lsJ1OHfkJH++AJwaxRVW+r7UHKMUMLG8=;
	b=QNneNbkUI0roUHeUhTYZG9AIxKPJakV+mIMDw97JP0R4kHV2EJpADMD0AIVsBMaDt5
	AWGP9Xa4a7apuXrlRoDm9eiMl5arFifdYD5TfrCZagL6BQ2EPtQmzKi4c1PCnXK0TU4z
	auYwbSPTs+KxKwMvN/guC4IPtS74BowASt4FRq5TOXHr2qrVwpyUPzka9JdJn1pVLhre
	wz9maaW8CslzsaGOBtsuJwBvwzimO2benRukiHJmbjLOV83NUrxYwVKUZFDEItm9VOMJ
	A6n5W1STIUTktHGg6kugrVcWd2lhZkHRwkh6KYy5ErwQtCJBX5GMf4tfgl8aQl3i+nDv
	vznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:in-reply-to:references:mime-version:message-id
	:cc:content-transfer-encoding:from:subject:date:to;
	bh=riDh5nUDTq+lsJ1OHfkJH++AJwaxRVW+r7UHKMUMLG8=;
	b=uYEJka5tQf6GsdsB96DI1cP/hZdZCA6TCR9IfWbJ31qi7eJpJ+aa9tYEA93ApdTUbg
	gbXOsqPVkK5vEwu51QktlaOsRxy7u1mX53brIvhgjaJ0XXXFV/39MaYIPKzkVA93b2Wz
	7JKdmUBOB7Zjt+iEv9Qs6R0SE6uCv5sVpCw+WIShj8XYxf7BPr85Y30BoASPm7DDv/1+
	hlieM7OSBUvVny3Ab6W7rcVdP0ebg18CJk9JiRxjSSV0p89prf5GMgsV/L+T3HEWYO8S
	c9y0hC8QKyQ2fwOHAgpCvEA+JILJeARzMjP+AV4whMxSND3hA12L6tuUwSZT1Xeosg0T
	8IQg==
X-Gm-Message-State: APjAAAUFkhx5eBzPzFv573/Qm/PQ0C5fEWXPnhW0kgmcWHPrQukrfO4g
	jOFmzbPAZrk3H9aCTetgaGF5D564
X-Google-Smtp-Source: APXvYqznPewbg7sKjfF2JKxbaFud9Qh3zXoryFeJBNxR2Kot19iwpuS7ioFulxhkaCUHnxFwaCplcA==
X-Received: by 2002:a24:5dc8:: with SMTP id w191mr2898196ita.136.1555681458366;
	Fri, 19 Apr 2019 06:44:18 -0700 (PDT)
Received: from [192.168.0.11] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20])
	by smtp.gmail.com with ESMTPSA id n7sm2691583itc.19.2019.04.19.06.44.17
	(version=TLS1 cipher=AES128-SHA bits=128/128);
	Fri, 19 Apr 2019 06:44:17 -0700 (PDT)
In-Reply-To: <723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="UTF-8"; delsp="yes"; format="flowed"
Message-Id: <4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Fri, 19 Apr 2019 09:44:15 -0400
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.753.1)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419134415.WtPhdKir1DyKwivQ_dDNcNFEPA2ekGrVbMJrVvm1Z1Y@z>


On Apr 19, 2019, at 3:10 AM, Thomas Huth wrote:

> On 19/04/2019 00.47, John Arbuckle wrote:
>> Capstone is not necessary in order to use QEMU. Disable it by  
>> default.
>> This will save the user the pain of having to figure why QEMU isn't
>> building when this library is missing.
>>
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 1c563a7027..77d7967f92 100755
>> --- a/configure
>> +++ b/configure
>> @@ -433,7 +433,7 @@ opengl_dmabuf="no"
>>  cpuid_h="no"
>>  avx2_opt=""
>>  zlib="yes"
>> -capstone=""
>> +capstone="no"
>>  lzo=""
>>  snappy=""
>>  bzip2=""
>
> AFAIK we ship capstone as a submodule, so how can this be missing?  
> Also,
> our philosophy is to keep everything enabled by default if  
> possible, so
> that the code paths don't bitrot. Thus I don't think that disabling  
> this
> by default is a good idea. ... so if you've got a problem here, there
> must be another solution (e.g. is the system capstone detection not
> working right on your system?).
>
>  Thomas

Thank you for replying. Capstone comes with QEMU? Every time I try to  
compile QEMU I see an error relating to Capstone not being on my  
system. Why do you feel that disabling Capstone by default is not a  
good idea?

Here is the error message I see when compiling QEMU:

CHK version_gen.h
make[1]: *** No rule to make target `/Users/John/qemu-git/capstone/ 
libcapstone.a'.  Stop.
make: *** [subdir-capstone] Error 2


