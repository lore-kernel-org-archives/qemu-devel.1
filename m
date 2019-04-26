Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F29C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD722077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD722077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzuc-0007K8-2S
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:25:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJztM-0006bu-SD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJztL-00061V-Lm
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:23:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJztL-00060L-Fz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:23:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so4151873wrq.10
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 05:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3G5ZczD5MYjRWu8oRWz+5r8qOSayNo6797vcIUSZPLE=;
	b=TZsaKAu3ouMh+HMdbHxsEk2vzluC7DLSf+B8mv96+G+9xTQlbrqJexMfzX8OhxRwHl
	kY4Pgb8OaIMhVSgOG/HidJ/bi3LOyCHk/rNQK0bgEJw9h5enWgaZplvnFiUdZ3PDr9Ef
	u/cDS+vQkTcUVM1JILynV/GbAuBcbJDkGqsLPPSR4MJTjGtwrG3imSt4ZoJlN/CxuGdr
	5HPl5G4PWiAeUasCNYMVhMNLXZ3Umr8PrYk4DBehQt6TI8AAC17NMFJhnSpU50ez+iEW
	w/0lMoW5Q3ZJbus61TSqOEI+LHoFKCq860QXUXjz2TOYtErj/wcPxEq0B6dlECpmLkhq
	hz/Q==
X-Gm-Message-State: APjAAAXvC2qUh3i36wd2XfauBO23/y0qHOomSWDozE3jflWBN8opoqL+
	/UBBH3JASAs+ezfDo3HrqafK5g==
X-Google-Smtp-Source: APXvYqyRMIO/LUGgdmjCvttO/CtSHnbp0HTqRkHLq0cEEgOg5xzEVAL4/D9Kr9MaQ5aQTe5QX2n2Vg==
X-Received: by 2002:adf:dc45:: with SMTP id m5mr5973672wrj.262.1556281425980; 
	Fri, 26 Apr 2019 05:23:45 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	h84sm27491899wmf.15.2019.04.26.05.23.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 05:23:45 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190419075625.24251-1-thuth@redhat.com>
	<c0ce7a39-9e9f-a7be-c73b-a9c2c05da3af@redhat.com>
	<e0e3128d-371c-7812-d99f-77af15ef278b@redhat.com>
	<84638796-204e-3f43-3fe1-f5329e9cd466@redhat.com>
	<201457a3-d297-16ce-e375-f6ede5679492@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <58fd604a-7c72-a0f5-14fe-777146ed3d80@redhat.com>
Date: Fri, 26 Apr 2019 14:23:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201457a3-d297-16ce-e375-f6ede5679492@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 0/2] Fix ohci_die() and move PCI
 code to separate file
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426122344.wsiwFe57rTjOxew2sCOm7_RhHYdimZFpmD3_6Lo-Gj4@z>

On 4/26/19 2:20 PM, Thomas Huth wrote:
> On 26/04/2019 14.14, Philippe Mathieu-Daudé wrote:
>> On 4/26/19 7:42 AM, Thomas Huth wrote:
>>> On 26/04/2019 00.55, Philippe Mathieu-Daudé wrote:
>>>> Hi Thomas,
>>>>
>>>> On 4/19/19 9:56 AM, Thomas Huth wrote:
>>>>> First patch fixes a problem with ohci_die(), second patch moves PCI code into
>>>>> a separate file, so that the sysbus OHCI device can also be used without
>>>>> the dependency on the PCI code.
>>>>>
>>>>> v2: Split the patch into two patches, one for the ohci_die() fix and one
>>>>>     for the PCI code movement.
>>>>
>>>> Way cleaner. I wonder why you don't use a typedef for the void
>>>> (*ohci_die_fn)(struct OHCIState *) prototype.
>>>
>>> It does not work in that case:
>>>
>>> typedef struct OHCIState {            // <-- struct OHCIState definition
>>>     [...]
>>>     uint32_t async_td;
>>>     bool async_complete;
>>>
>>>     void (*ohci_die)(struct OHCIState *ohci); // <-- ohci_die definition
>>> } OHCIState;                         // <-- typedef OHCIState definition
>>>
>>> The typedef is defined after the ohci_die entry.
>>
>> I was thinking of forward declaration:
>>
>> typedef struct OHCIState OHCIState;
>>
>> typedef void (ohci_die_fn)(OHCIState *ohci);
> 
> Could work, too, but I don't like typedeferities... so unless Gerd
> forces me to use that here, I'd prefer to keep the patch in its current
> shape.

Fine with me ;)

