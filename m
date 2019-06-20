Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E38C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD43206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD43206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdwAt-0008At-L1
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33214)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdw2s-00017h-E5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hdvqu-00049c-Od
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:09:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hdvqu-00048p-Ik
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 08:07:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so2742348wrl.9
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 05:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=54om2P5mtO8ywAEztbJjeUJW56nk4ieGCbpzao0kQ70=;
 b=aLgj4G16Z6ysLk2WR6LNGXkj/VFTGA9d8iVzF7P2zTgmSVzYAEL0L76qN9uHdHaDw4
 y+/AzzowkDjpKr9yK9Rce/9R4z7lZFBxtd1TGgQVban4mInRykgNlR1m9lbU1q4CJwzc
 wxtyy8ytrtrY+pFARoH4Naha4XI/iEh0tsrK097vTswkDMxmFmASsoFEWDvEZy2HqnPt
 Rn7I+G0OJF2ofPQEis4EBAbusVca6bA9yvONwY+4aRko3zny766y2BwmwnBmUtWEYphw
 LwmPKSgKXRlOLkkaTRKFBVejz4lGykrx3492CCbOHynjt1hzgPyLfOg+gAD6UD+AOCHB
 80hg==
X-Gm-Message-State: APjAAAUuldI2O+SYHzb9c2GxIDZSSpFQEhJrfGqEdmTOgQrvAya2w5Db
 sV19lj6kKlrmkZvu3UumrRGcsA==
X-Google-Smtp-Source: APXvYqyzpHIxQ6wcxokP762DdtQQQBhiqhmsLR9TEHldmt+C+1nkmMNYxX5fj8q5tsWUw/EXY64u6Q==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr47619501wrq.15.1561032459285; 
 Thu, 20 Jun 2019 05:07:39 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id r3sm24570166wrr.61.2019.06.20.05.07.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 05:07:38 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20190310004749.27029-1-philmd@redhat.com>
 <20190310004749.27029-3-philmd@redhat.com>
 <5e2f3651-5f00-0c93-353e-e58f079998e9@redhat.com>
 <124e54f9-c7e1-0157-61f1-673154872749@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <88b7370c-1b6f-11e0-9fbe-d532e5726aa6@redhat.com>
Date: Thu, 20 Jun 2019 14:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <124e54f9-c7e1-0157-61f1-673154872749@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 2/4] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 3/13/19 11:11 AM, Laszlo Ersek wrote:
> On 03/13/19 10:43, Laszlo Ersek wrote:
>> On 03/10/19 01:47, Philippe Mathieu-Daudé wrote:
>>> The Edk2Crypto object is used to hold configuration values specific
>>> to EDK2.
>>>
>>> The edk2_add_host_crypto_policy() function loads crypto policies
>>> from the host, and register them as fw_cfg named file items.
>>> So far only the 'https' policy is supported.
>>>
>>> A usercase example is the 'HTTPS Boof' feature of OVMF [*].
>>>
>>> Usage example:
>>>
>>>   $ qemu-system-x86_64 \
>>>       --object edk2_crypto,id=https,\
>>>               ciphers=/etc/crypto-policies/back-ends/openssl.config,\
>>>               cacerts=/etc/pki/ca-trust/extracted/edk2/cacerts.bin
>>>
>>> (On Fedora these files are provided by the ca-certificates and
>>> crypto-policies packages).
>>>
>>> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> v3:
>>> - '-object' -> '--object' in commit description (Eric)
>>> - reworded the 'TODO: g_free' comment
>>> ---
>>>  MAINTAINERS                             |   8 ++
>>>  hw/Makefile.objs                        |   1 +
>>>  hw/firmware/Makefile.objs               |   1 +
>>>  hw/firmware/uefi_edk2_crypto_policies.c | 177 ++++++++++++++++++++++++
>>>  include/hw/firmware/uefi_edk2.h         |  28 ++++
>>>  5 files changed, 215 insertions(+)
>>>  create mode 100644 hw/firmware/Makefile.objs
>>>  create mode 100644 hw/firmware/uefi_edk2_crypto_policies.c
>>>  create mode 100644 include/hw/firmware/uefi_edk2.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index cf09a4c127..70122b3d0d 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2206,6 +2206,14 @@ F: include/hw/i2c/smbus_master.h
>>>  F: include/hw/i2c/smbus_slave.h
>>>  F: include/hw/i2c/smbus_eeprom.h
>>>  
>>> +EDK2 Firmware
>>> +M: Laszlo Ersek <lersek@redhat.com>
>>> +M: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> +S: Maintained
>>> +F: docs/interop/firmware.json
>>> +F: hw/firmware/uefi_edk2_crypto_policies.c
>>> +F: include/hw/firmware/uefi_edk2.h
>>> +
>>
>> I'm not happy with this.
>>
>> First, "docs/interop/firmware.json" is meant for more than just EDK2. We
>> shouldn't list it in a section called "EDK2 Firmware". I can't suggest
>> an alternative (MAINTAINERS is *huge* -- 2500+ lines), but this one
>> would be misleading.
>>
>> Second, we expose fw_cfg files to edk2 platform firmware from a bunch of
>> other places. For example -- and in this case I do mean to provide a
>> complex example! --, see "etc/smi/supported-features",
>> "etc/smi/requested-features", and "etc/smi/features-ok", in file
>> "hw/isa/lpc_ich9.c". I'm unconvinced that the present feature merits new
>> directories and new files.
>>
>> Then again, I also don't know where to put the logic. I guess I'll have
>> to defer to more experienced reviewers.
>>
>> [snipping lots of QOM boilerplate]
>>
>>> +void edk2_add_host_crypto_policy(FWCfgState *fw_cfg)
>>> +{
>>> +    Edk2Crypto *s;
>>> +
>>> +    s = edk2_crypto_by_id("https", NULL);
>>> +    if (!s) {
>>> +        return;
>>> +    }
>>> +
>>> +    if (s->ciphers_path) {
>>> +        /*
>>> +         * Note:
>>> +         * Unlike with fw_cfg_add_file() where the allocated data has
>>> +         * to be valid for the lifetime of the FwCfg object, there is
>>> +         * no such contract interface with fw_cfg_add_file_from_host().
>>> +         * It would be easier that the FwCfg object keeps reference of
>>> +         * its allocated memory and releases it when destroy, but it
>>> +         * currently doesn't. Meanwhile we simply add this TODO comment.
>>> +         */
>>> +        fw_cfg_add_file_from_host(fw_cfg, "etc/edk2/https/ciphers",
>>> +                                  s->ciphers_path, NULL);
>>> +    }
>>> +
>>> +    if (s->cacerts_path) {
>>> +        /*
>>> +         * TODO: g_free the returned pointer
>>> +         * (see previous comment for ciphers_path in this function).
>>> +         */
>>> +        fw_cfg_add_file_from_host(fw_cfg, "etc/edk2/https/cacerts",
>>> +                                  s->cacerts_path, NULL);
>>> +    }
>>> +}
>>
>> Shouldn't we do some error checking here?
>>
>> I mean, printing an error message in fw_cfg_add_file_from_host(), and
>> then continuing without exposing the named files in question to the
>> firmware, could be OK if this was a "default on" feature. But (IIUC)
>> here the user provided an explicit "-object" option, and we've just
>> failed to construct the object. Doesn't such a situation usually prevent
>> QEMU startup?
> 
> Wait, I could be totally confused here. (Returning to this patch after
> seeing the rest of the series.)
> 
> Is it actually the case that the Edk2Crypto object holds nothing more
> than two pathnames -- and so its construction can virtually never fail?
> While the actual fw_cfg population occurs separately, in a machine_done
> notifier?
> 
> If that's the case, I don't think it's the right approach. Reading the
> host files, and populating fw_cfg with them, should be part of the
> object construction. And if those steps fail, the object should not be
> possible to construct.
> 
> We did something similar with the vmgenid device [hw/acpi/vmgenid.c], if
> I remember correctly. It also has a dependency on fw_cfg...
> 
> Ahh, no, I'm absolutely wrong about that. vmgenid_realize() doesn't do
> anything with fw_cfg. Instead, we have acpi_setup() in
> "hw/i386/acpi-build.c", which calls find_vmgenid_dev() and
> vmgenid_add_fw_cfg(). And acpi_setup() is certainly called from
> pc_machine_done().
> 
> In other words, the pattern that you use here matches existing practice.
> Realize the device (or object) first, then add the fw_cfg thingies in
> the "machine done" callback. OK.
> 
> *Still*, I would like to see better error handling/reporting (or an
> explanation why I'm wrong). How about reworking the edk2crypto class
> itself -- it shouldn't just hold the pathnames of the files, but also
> their contents. That is:
> 
> - g_file_get_contents() should be called in the realize method
> - the object would own the file contents
> - the realize method would ensure that there wouldn't be any other
> instance of the class (i.e. that it would be a singleton -- see the same
> idea in vmgenid)
> - there would be no need for the fw_cfg_add_file_from_host() API
> - the machine done notifier would be extended to locate the object
> (there could be zero or one instances), and if the one instance were
> found, the machine done callback would hook the file contents into
> fw_cfg. fw_cfg_add_file() cannot fail, so no errors to report at this stage.
> 
> Again I think this would follow the pattern from vmgenid.

I want to say I am impressed by your deep review. Your design is
obviously way cleaner/safer. I think I was missing some part of the big
picture here, thank you for your detailed comments!

I did not know how vmgenid is processed. The only difference is I don't
want the edk2crypto class to be a device, but rather a simple user
object, and we already have an interface that does that:
TYPE_USER_CREATABLE. Its UserCreatableClass::complete() method is
similar to DeviceClass::realize() in managing errors at object
instantiation, so the machine done notifier never fails.
I'll respin.

Regards,

Phil.

