Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7925AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F7B2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho0/h1yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F7B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPiZY-0007uM-UN
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPiXi-0006cd-D8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPiXf-00033g-RT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 04:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601973710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LPnSZi6f+vgSA5T9Ql1rvwGN0jDOW+YK/Csyla+Yig=;
 b=ho0/h1yq0CI16eD+Wfrj9asW9IJLZwee7qY8RVX6Gl2Jyb+S5JgvB1jj4e29ECDEVuJZ9s
 JRaMUE5yFVQsZa9fgRzkVkRq3F6ihpNeD4wLjliZwWjiQr73GpKSAIkqxACbjyarAB7YNY
 Qwtw24yc2/ZzQ43cB3J52eEyqpgaCc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-WgaG_RQsNpi4yS7EsEolAQ-1; Tue, 06 Oct 2020 04:41:49 -0400
X-MC-Unique: WgaG_RQsNpi4yS7EsEolAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38FCD18A0720;
 Tue,  6 Oct 2020 08:41:48 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-235.ams2.redhat.com
 [10.36.112.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 676FD73666;
 Tue,  6 Oct 2020 08:41:43 +0000 (UTC)
Subject: Re: [PULL 5/5] crypto/tls-cipher-suites: Produce fw_cfg consumable
 blob
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200704163927.28188-1-philmd@redhat.com>
 <20200704163927.28188-6-philmd@redhat.com>
 <20200929154651.GC4398@linux.fritz.box>
 <d454d4ae-3c8b-72fb-698d-938e11d18d3a@redhat.com>
 <b47fe2e3-6867-20ec-70b5-c2dd52c6d698@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <23aed98b-6844-d027-14dd-26298698160d@redhat.com>
Date: Tue, 6 Oct 2020 10:41:39 +0200
MIME-Version: 1.0
In-Reply-To: <b47fe2e3-6867-20ec-70b5-c2dd52c6d698@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/05/20 11:16, Philippe Mathieu-Daudé wrote:
> Hi Laszlo,
> 
> On 10/1/20 9:18 AM, Laszlo Ersek wrote:
>> On 09/29/20 17:46, Kevin Wolf wrote:
>>> Am 04.07.2020 um 18:39 hat Philippe Mathieu-Daudé geschrieben:
>>>> Since our format is consumable by the fw_cfg device,
>>>> we can implement the FW_CFG_DATA_GENERATOR interface.
>>>>
>>>> Example of use to dump the cipher suites (if tracing enabled):
>>>>
>>>>   $ qemu-system-x86_64 -S \
>>>>     -object tls-cipher-suites,id=mysuite1,priority=@SYSTEM \
>>>>     -fw_cfg name=etc/path/to/ciphers,gen_id=mysuite1 \
>>>>     -trace qcrypto\*
>>>>   1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
>>>>   1590664444.197219:qcrypto_tls_cipher_suite_info data=[0x13,0x02] version=TLS1.3 name=TLS_AES_256_GCM_SHA384
>>>>   1590664444.197228:qcrypto_tls_cipher_suite_info data=[0x13,0x03] version=TLS1.3 name=TLS_CHACHA20_POLY1305_SHA256
>>>>   1590664444.197233:qcrypto_tls_cipher_suite_info data=[0x13,0x01] version=TLS1.3 name=TLS_AES_128_GCM_SHA256
>>>>   1590664444.197236:qcrypto_tls_cipher_suite_info data=[0x13,0x04] version=TLS1.3 name=TLS_AES_128_CCM_SHA256
>>>>   1590664444.197240:qcrypto_tls_cipher_suite_info data=[0xc0,0x30] version=TLS1.2 name=TLS_ECDHE_RSA_AES_256_GCM_SHA384
>>>>   1590664444.197245:qcrypto_tls_cipher_suite_info data=[0xcc,0xa8] version=TLS1.2 name=TLS_ECDHE_RSA_CHACHA20_POLY1305
>>>>   1590664444.197250:qcrypto_tls_cipher_suite_info data=[0xc0,0x14] version=TLS1.0 name=TLS_ECDHE_RSA_AES_256_CBC_SHA1
>>>>   1590664444.197254:qcrypto_tls_cipher_suite_info data=[0xc0,0x2f] version=TLS1.2 name=TLS_ECDHE_RSA_AES_128_GCM_SHA256
>>>>   1590664444.197258:qcrypto_tls_cipher_suite_info data=[0xc0,0x13] version=TLS1.0 name=TLS_ECDHE_RSA_AES_128_CBC_SHA1
>>>>   1590664444.197261:qcrypto_tls_cipher_suite_info data=[0xc0,0x2c] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
>>>>   1590664444.197266:qcrypto_tls_cipher_suite_info data=[0xcc,0xa9] version=TLS1.2 name=TLS_ECDHE_ECDSA_CHACHA20_POLY1305
>>>>   1590664444.197270:qcrypto_tls_cipher_suite_info data=[0xc0,0xad] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_CCM
>>>>   1590664444.197274:qcrypto_tls_cipher_suite_info data=[0xc0,0x0a] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
>>>>   1590664444.197278:qcrypto_tls_cipher_suite_info data=[0xc0,0x2b] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
>>>>   1590664444.197283:qcrypto_tls_cipher_suite_info data=[0xc0,0xac] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_CCM
>>>>   1590664444.197287:qcrypto_tls_cipher_suite_info data=[0xc0,0x09] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
>>>>   1590664444.197291:qcrypto_tls_cipher_suite_info data=[0x00,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_GCM_SHA384
>>>>   1590664444.197296:qcrypto_tls_cipher_suite_info data=[0xc0,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_CCM
>>>>   1590664444.197300:qcrypto_tls_cipher_suite_info data=[0x00,0x35] version=TLS1.0 name=TLS_RSA_AES_256_CBC_SHA1
>>>>   1590664444.197304:qcrypto_tls_cipher_suite_info data=[0x00,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_GCM_SHA256
>>>>   1590664444.197308:qcrypto_tls_cipher_suite_info data=[0xc0,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_CCM
>>>>   1590664444.197312:qcrypto_tls_cipher_suite_info data=[0x00,0x2f] version=TLS1.0 name=TLS_RSA_AES_128_CBC_SHA1
>>>>   1590664444.197316:qcrypto_tls_cipher_suite_info data=[0x00,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_GCM_SHA384
>>>>   1590664444.197320:qcrypto_tls_cipher_suite_info data=[0xcc,0xaa] version=TLS1.2 name=TLS_DHE_RSA_CHACHA20_POLY1305
>>>>   1590664444.197325:qcrypto_tls_cipher_suite_info data=[0xc0,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_CCM
>>>>   1590664444.197329:qcrypto_tls_cipher_suite_info data=[0x00,0x39] version=TLS1.0 name=TLS_DHE_RSA_AES_256_CBC_SHA1
>>>>   1590664444.197333:qcrypto_tls_cipher_suite_info data=[0x00,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_GCM_SHA256
>>>>   1590664444.197337:qcrypto_tls_cipher_suite_info data=[0xc0,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_CCM
>>>>   1590664444.197341:qcrypto_tls_cipher_suite_info data=[0x00,0x33] version=TLS1.0 name=TLS_DHE_RSA_AES_128_CBC_SHA1
>>>>   1590664444.197345:qcrypto_tls_cipher_suite_count count: 29
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> Acked-by: Laszlo Ersek <lersek@redhat.com>
>>>> Message-Id: <20200623172726.21040-6-philmd@redhat.com>
>>>
>>> I noticed only now that this breaks '--object help' in
>>> qemu-storage-daemon:
>>>
>>> $ qemu-storage-daemon --object help
>>> List of user creatable objects:
>>> qemu-storage-daemon: missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>>> Aborted (core dumped)
>>>
>>> The reason is that we don't (and can't) link hw/nvram/fw_cfg.c into the
>>> storage daemon because it requires other system emulator stuff.
>>
>> Ouch. I've been completely oblivious to "--object help" and how it
>> affects qemu-storage-daemon. Sorry about that.
>>
>> Could you please include a backtrace about the abort()?
>>
>> Grepping for the error message, I can find type_initialize() in
>> "qom/object.c", but my knowledge about QOM internals is practically nil.
>>
>> The error message seems bogus FWIW -- why would
>> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE be *required* from "tls-creds"?
>>
>> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE is implemented by
>> "tls-cipher-suites", and required by "-fw_cfg name=...,gen_id=...". If
>> that -fw_cfg switch is not used, then why would anything look for the
>> TYPE_FW_CFG_DATA_GENERATOR_INTERFACE interface? Especially under the
>> tls-creds object?
> 
> Sorry for not updating Kevin's post in time (we have been discussing
> over IRC).
> 
> What happens here is a QOM design flow, first triggered by fw_cfg as
> we are now trying to have QEMU split into more components.
> 
> QOM interface/object type names are simple strings, so we don't get
> any link failure in case of missing dependency (which are resolved at
> runtime using strcmp).
> 
> "tls-cipher-suites" is a generic crypto object, it happens to implement
> the fw_cfg-data-generator interface. The fw_cfg-data-generator interface
> is registered as QOM type in hw/nvram/fw_cfg.c which is only built when
> SOFTMMU is selected. qemu-storage-daemon doesn't select SOFTMMU.
> We don't want to restrict "tls-cipher-suites" to SOFTMMU.
> 
> The simplest fix we discuss is to have a single C file to register the
> fw_cfg-data-generator interface in QOM, and link with it if any of
> CRYPTO / NVRAM kconfig is selected.
> 
> I'll send a patch.

Thank you for the explanation!

(I suggest keeping such discussions *originally* on the list. IRC is
practically indistinguishable from the bit bucket, and you'll have to
write up a summary for others on the mailing list anyway. (In some cases
it could even require filing a ticket in some tracker, in the end.) Best
to have the discussion at once on the list. Just my suggestion of course.)

Thanks!
Laszlo


