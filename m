Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52FCC742D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D954204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D954204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzgA-0002v0-Nr
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43268)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlzg1-0002WU-Es
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlzg0-0001NY-GA
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:49:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlzg0-0001Ll-AP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:49:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id j8so6724546wrj.9
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 10:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MihyLOUyh8L1NUuGYwX39KtHjH47RdWwdhFiLeKHWT0=;
 b=Nxh27ARfmw76918wFfrucMPB44lrMeVcsfx+lph+TqCXlUs9YW3xtW/xH2kf5CCxOK
 u6ateVWaHe3tXI4rK3RPBGHGSU3gA3eP73whcic9YKaWDBCAhsfQ5jHRjrgdBNLcthGk
 iEaj/ANOlBhIfHZOdZ69zOJc1Twi/BK6bRThx2LpzB/A/+1ccydg43isIdmTZNVtSu+v
 kRlhnqD9MyG0TcfPqMGlztd0yO0zQLYB86TWAmTLxIWQhejA6qC6AJFNk2ltm8vZHDvG
 glgwAb0FWQXq3zsRAL2WsGDn96b+OYuGU2o0Wz4nNp1S8jDL4fYqFQFje/vChHJ0rgrj
 5d9Q==
X-Gm-Message-State: APjAAAVuh1aB1pIFUtvRtoByIElgkqQCTBQpmnKsasiISEr7M60BmPHr
 ZW3P45hi6fIE4Ram4qt8jUWu7w7nKfw=
X-Google-Smtp-Source: APXvYqwIbb3p3aSCgZutpRJZK6k8QEqgUqKC5xWJW6XxTZNmesqe1Fx05k57zizkyltlpgMpbC6Shg==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr5891543wrv.63.1562953782128; 
 Fri, 12 Jul 2019 10:49:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id c30sm13746570wrb.15.2019.07.12.10.49.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 10:49:41 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190712172743.17632-1-marcandre.lureau@redhat.com>
 <f9a3ad2f-e895-d4e4-6aee-8d956f907e9b@redhat.com>
 <CAJ+F1CK2wgSsmFFnrhdRKh-pFh-JK5Ov3t34hVf2cB6THpYv0Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <53fb3e82-ba72-e987-0fdf-160c0070a274@redhat.com>
Date: Fri, 12 Jul 2019 19:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK2wgSsmFFnrhdRKh-pFh-JK5Ov3t34hVf2cB6THpYv0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] build-sys: remove slirp cflags from
 main-loop.o
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/07/19 19:46, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jul 12, 2019 at 9:37 PM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> Hi Marc-André,
>>
>> On 7/12/19 7:27 PM, Marc-André Lureau wrote:
>>> Left over from c2d63650d962612cfa1b21302782d4cd12142c74.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>>> ---
>>>  util/Makefile.objs | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/util/Makefile.objs b/util/Makefile.objs
>>> index 38178201ff..68af3cd5e9 100644
>>> --- a/util/Makefile.objs
>>> +++ b/util/Makefile.objs
>>> @@ -3,7 +3,6 @@ util-obj-y += bufferiszero.o
>>>  util-obj-y += lockcnt.o
>>>  util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
>>>  util-obj-y += main-loop.o iohandler.o
>>> -main-loop.o-cflags := $(SLIRP_CFLAGS)
>>>  util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
>>>  util-obj-$(CONFIG_POSIX) += aio-posix.o
>>>  util-obj-$(CONFIG_POSIX) += compatfd.o
>>>
>>
>> Since you are looking at slirp, I'm having a bunch of:
>>
>> $ make help
>> [...]
>>   CC      slirp/src/tftp.o
>> Package glib-2.0 was not found in the pkg-config search path.
>> Perhaps you should add the directory containing `glib-2.0.pc'
>> to the PKG_CONFIG_PATH environment variable
>> No package 'glib-2.0' found
>>   CC      slirp/src/udp6.o
>> Package glib-2.0 was not found in the pkg-config search path.
>> Perhaps you should add the directory containing `glib-2.0.pc'
>> to the PKG_CONFIG_PATH environment variable
>> No package 'glib-2.0' found
>> [...]
>>
>> On MinGW.
> 
> On "cross-mingw" I suppose
> 
>> I can silent the warnings using (32-git build):
>>
>> PKG_CONFIG_PATH=/usr/lib/mxe/usr/i686-w64-mingw32.shared/lib/pkgconfig
> 
> Hmm that looks like a pkg-config configuration issue to me.
> 
>>
>> This is new since the slirp split.
>>
>> Any idea where to fix that?
>>
> 
> Compile and install libslirp shared lib, ./configure --enable-slirp=system :)
> 
> Btw, I wonder if we can already warn about deprecation of
> --enable-slirp=git. Peter is that too early for 4.1? (first libslirp
> was released last month)

Yeah, I think we should let a year pass or so.

Paolo


