Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA41AC31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 05:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA71218A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 05:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA71218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hck2c-0002IR-Fs
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 01:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hck1g-0001e7-Mv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 01:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hck1c-0000r1-LA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 01:17:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hck1c-0000qL-Ar
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 01:17:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so8375316wrm.8
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 22:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OKt9jQ2XkTBriMIJyq+OVWR9dcuw6dEUr7tevrMsG7A=;
 b=hkFC5HXMdjRL3BRLvui7f/6Clu0beKZIQ4Ux0d2aJ9VGr5g9JLe1RV1LaMVgiKPSeU
 NOmRrrzMwapZ8FrRfVMw5kBU3ziOK7y88FEAiCFFN/6HPR2LvcnKZwU9+wXyH3GO2ZvS
 QOaDc255KYBzfJhL7ikdMdLvMmYxuBPfuMNm8IXxgFNiN8tqs8l2j8yuX6utFD/QXEvs
 9YgI097QijIhJ6o1Luc9v6dRRfPfYoVEm6K8KK2iQRZ+cJ9qkgkDnCaXIn3YODbhjNiw
 AvKDAkrfRT7FX3RGqvp8sq2Z6gyycnibus7cVfIIdLco9n9/Zc46qhEn1ttPddp5uXrT
 MDUA==
X-Gm-Message-State: APjAAAWeProWc5MNWHMQ346rJH4nlDcoFp9biuElHiPLAfQ0XrCUhC77
 MP5HorEXteHHlwXsaG7UQ/sT4g==
X-Google-Smtp-Source: APXvYqzqSMXWGii0p8STnA/hQzZBju3pyUEqImBLCFHPXAX0dRefQAsrhHgnnszAHlQCHp/SAH3wCw==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr1017201wrn.54.1560748667009;
 Sun, 16 Jun 2019 22:17:47 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z5sm8081185wmf.48.2019.06.16.22.17.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 22:17:46 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
 <23253f77-ccc8-220d-3028-f27945f9542c@redhat.com>
 <791dd038-8811-6335-75f7-6dd309ff0ff7@amsat.org>
 <20180511135544.GH25013@localhost.localdomain>
 <4e72cde3-8475-2964-b834-f74d15d66cae@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fb3237cd-002b-528b-32cf-4e7675ef27f7@redhat.com>
Date: Mon, 17 Jun 2019 07:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4e72cde3-8475-2964-b834-f74d15d66cae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] Publishing binary images for testing
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Alexander Graf <agraf@suse.de>, avocado-devel@redhat.com,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

On 5/11/18 4:27 PM, Cleber Rosa wrote:
> On 05/11/2018 09:55 AM, Eduardo Habkost wrote:
>> (CCing Cleber and avocado-devel in case they have suggestions)
>>
>> On Tue, May 08, 2018 at 12:47:52PM -0300, Philippe Mathieu-Daudé wrote:
>> [...]
>>> Ironically I have been using the Gumstix machines quite a lot for the SD
>>> 'subsystem' refactor, using the MMC commands in U-Boot (I am unable to
>>> reach the Linux userland since the kernel crashes), and plan to add SD
>>> integration tests via Avocado.
>>>
>>> This raises:
>>>
>>> - What will happens if I add tests downloading running on their compiled
>>> u-boot
>>> (https://downloads.gumstix.com/images/angstrom/developer/2012-01-22-1750/u-boot.bin)
>>> and the company decides to remove this old directory?
>>> Since sometimes old open-source software are hard to rebuild with recent
>>> compilers, should we consider to use a public storage to keep
>>> open-source (signed) blobs we can use for integration testing?
>>
>> I think a maintained repository of images for testing would be
>> nice to have.  We need to be careful to comply with the license
>> of the software being distributed, though.
>>
>> If the images are very small (like u-boot.bin above), it might be
>> OK to carry them in qemu.git, just like the images in pc-bios.
>>
>>>
>>> Avocado has a 'vmimage library' which could be extended, adding support
>>> for binary url + detached gpg signatures from some QEMU maintainers?
>>
>> Requiring a signature makes the binaries hard to replace.  Any
>> specific reason to suggest gpg signatures instead of just a
>> (e.g.) sha256 hash?
>>
>>>
>>> (I am also using old Gentoo/Debian packaged HPPA/Alpha Linux kernel for
>>> Avocado SuperIO tests, which aren't guaranteed to stay downloadable
>>> forever).
>>
>> Question for the Avocado folks: how this is normally handled in
>> avocado/avocado-vt?  Do you maintain a repository for guest
>> images, or you always point to their original sources?
>>
> 
> For pure Avocado, the vmimage library attempts to fetch, by default, the
> latest version of a guest image directly from the original sources.
> Say, a Fedora image will be downloaded by default from the Fedora
> servers.  Because of that, we don't pay too much attention to the
> availability of specific (old?) versions of guest images.
> 
> For Avocado-VT, there are the JeOS images[1], which we keep on a test
> "assets" directory.  We have a lot of storage/bandwidth availability, so
> it can be used for other assets proven to be necessary for tests.
> 
> As long as distribution rights and licensing are not issues, we can
> definitely use the same server for kernels, u-boot images and what not.
> 
> [1] - https://avocado-project.org/data/assets/

1/ How do we check for distribution rights?

Is it OK for:
- a Debian/Fedora image
- a compiled Linux kernel (for a Debian/Fedora release)

2/ Who to ask to add files to this assets directory?

3/ Can we use a 'webarchive' directory structure?

Such /site/date/original_site_path/file

4/ What are the chances that this website disappears? :S

(Someone has to pay for it, and the bandwidth...)

Thanks,

Phil.

