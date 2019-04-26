Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB9CC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3163206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 12:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3163206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJzmG-0002wK-1K
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 08:16:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJzkN-0001fb-87
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJzkM-0007LA-AD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:14:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJzkM-0007Ji-4I
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:14:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id r6so4175514wrm.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 05:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Uc3TUnt2pnnS2LZJnVOQHzvdj8j5WznaFo3G0a0u98g=;
	b=tKaP1rKuXctsDTfophFhq59jLWW50XcWZjviTkF5tHjhJoYuS7uZm6j8pr4OmKOlXR
	qvD8dT4AhL9rhpNvHmd0DAPnCp//1WSC5jDFwwjd/Musu/ufuZdmIatR66KlYEO41SGQ
	X4WjyJFWzuS8fXDOoHYVZDXE4IaXBWUkfBvVr+VLN4LKH4pUM4NhWk7bU/4oTb7E2pxd
	asn0Sq/sw9IiWasissKN9CSXFnt0+ZH8gZGn9u54EuPVuz27Hp4anS8jWfWpIRUNJbTp
	jGjRQgMwGB5E4NfWGSM6n+VLKYOh+GXvAkz4RCwGbh0dSDBTGolojkaEkOmEmR/v7ugX
	4dCA==
X-Gm-Message-State: APjAAAWQyebxUKfM0MGtZPsh/tVOhzAbuDvzcRI8mlFxEQGQaDiVYqXQ
	+mZxTTJVpJyprJ6CxqcPjwmMxA==
X-Google-Smtp-Source: APXvYqxJCR8Ae9pNcdXHFpE5DflHIk2YJn2rynVMu8kx3tkbuvbviPFJoId7XNrh1Xdc4RW0leEt9A==
X-Received: by 2002:a5d:4483:: with SMTP id j3mr641215wrq.145.1556280867785;
	Fri, 26 Apr 2019 05:14:27 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122])
	by smtp.gmail.com with ESMTPSA id 4sm20517061wmg.12.2019.04.26.05.14.26
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 05:14:27 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190419075625.24251-1-thuth@redhat.com>
	<c0ce7a39-9e9f-a7be-c73b-a9c2c05da3af@redhat.com>
	<e0e3128d-371c-7812-d99f-77af15ef278b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <84638796-204e-3f43-3fe1-f5329e9cd466@redhat.com>
Date: Fri, 26 Apr 2019 14:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e0e3128d-371c-7812-d99f-77af15ef278b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
Message-ID: <20190426121425.dQWid1d-zTAS16z6abUGrO0pbeASliqlr3oXgxTp-CI@z>

On 4/26/19 7:42 AM, Thomas Huth wrote:
> On 26/04/2019 00.55, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 4/19/19 9:56 AM, Thomas Huth wrote:
>>> First patch fixes a problem with ohci_die(), second patch moves PCI code into
>>> a separate file, so that the sysbus OHCI device can also be used without
>>> the dependency on the PCI code.
>>>
>>> v2: Split the patch into two patches, one for the ohci_die() fix and one
>>>     for the PCI code movement.
>>
>> Way cleaner. I wonder why you don't use a typedef for the void
>> (*ohci_die_fn)(struct OHCIState *) prototype.
> 
> It does not work in that case:
> 
> typedef struct OHCIState {            // <-- struct OHCIState definition
>     [...]
>     uint32_t async_td;
>     bool async_complete;
> 
>     void (*ohci_die)(struct OHCIState *ohci); // <-- ohci_die definition
> } OHCIState;                         // <-- typedef OHCIState definition
> 
> The typedef is defined after the ohci_die entry.

I was thinking of forward declaration:

typedef struct OHCIState OHCIState;

typedef void (ohci_die_fn)(OHCIState *ohci);

struct OHCIState {
    [...]
    uint32_t async_td;
    bool async_complete;

    ohci_die_fn *ohci_die;
} OHCIState;

static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
                          uint32_t num_ports,
                          dma_addr_t localmem_base,
                          char *masterbus, uint32_t firstport,
                          AddressSpace *as,
                          ohci_die_fn *ohci_die, Error **errp)
{ ...

> 
>> Anyway to this series:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>  Thanks!
>   Thomas
> 

