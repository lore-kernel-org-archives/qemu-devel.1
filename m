Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A24207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is+rC6jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A24207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeLxE-0000Ag-Kk
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeLwF-0007Qg-O9
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:03:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeLwE-0002gc-8w
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590685404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DmXWHfkP0U4ta8rhjy/zffnfHCjr1W8oBOwpoSpa7IE=;
 b=is+rC6jmeRw8lEu4LQFRiZwWrjkhrDko/DYBO/ZgN+NlbWejXYPQ7bvgzfir+MNERhRzGI
 lfmnMEpsC/kSwLRmJEvipyzifmWj9AniQ9RHDBMY1UMbBr/3HFfD0veu2F1PUAHe3L49Ai
 qXTJLUI1w+UK9knTNu9veX9suO5JBJU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-APqIwUgcN9-rIg7C2aRrKw-1; Thu, 28 May 2020 13:03:23 -0400
X-MC-Unique: APqIwUgcN9-rIg7C2aRrKw-1
Received: by mail-wr1-f72.google.com with SMTP id o1so1274497wrm.17
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 10:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DmXWHfkP0U4ta8rhjy/zffnfHCjr1W8oBOwpoSpa7IE=;
 b=qfpRSwXZKrGJX9tJKIptJSktsq3DJbVWpYBNIk2pWvBxC2l7V4p+dmoQWw7ixeGJ5X
 G69rKI+t+Ta2eY0mDArH1lilOfCrpaO4UMSmA8IOWlLBuy8uXwZc61cJVhNVd8v0nE/x
 c444+dptGvjtRDJuUqd8I3ZKFVubqavhWMU/94+x6hIY3CXjF2WK7zQuZA6SRAAUW1LP
 Lh9lqR6hhGLHhwHsHLW1VRB7Y06QR+Gw21xPhKgMLRX344nBv8WxDCKlv/BI0TjfYj0U
 2Q0nsYEXgoH30d0t6GLYmnSncbGwBsVO3AHbNaj90m1+4G6gflC+JlHcw/w6INoExGAS
 72qA==
X-Gm-Message-State: AOAM530L3YXdnIY6O5Uqx92BZCJrdJ8sGMm5co9wFX1pPe8hGSw6KYtd
 7x8D4RLuYgRr3yp/K4mN/gSNLJTIiDYhoRFeXtwLSPsuUQnfInOXYdkpbqvwK25pc7fnStw84Iy
 gwGsOg+U0FZHSSLk=
X-Received: by 2002:a05:600c:21d7:: with SMTP id
 x23mr4497121wmj.95.1590685400926; 
 Thu, 28 May 2020 10:03:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuY5D6DmWBEDc3aFHpx913YmRaDT0LDeZ42pDcjFy6Ulx+D0ZmnGSurbPCFVWGjY3Py1SDjw==
X-Received: by 2002:a05:600c:21d7:: with SMTP id
 x23mr4497101wmj.95.1590685400681; 
 Thu, 28 May 2020 10:03:20 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id f11sm1013131wrj.2.2020.05.28.10.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 10:03:19 -0700 (PDT)
Subject: Re: [RFC PATCH v6 3/5] softmmu/vl: Allow -fw_cfg 'blob_id' option to
 set any file pathname
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-4-philmd@redhat.com>
 <3225db1c-1dcb-8bec-18a5-0ea7fe890508@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <70be0748-0cb7-e493-53b9-f3c1d13077fd@redhat.com>
Date: Thu, 28 May 2020 19:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3225db1c-1dcb-8bec-18a5-0ea7fe890508@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 12:45 AM, Laszlo Ersek wrote:
> On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
>> This is to silent:
>>
>>   $ qemu-system-x86_64 \
>>     -object tls-cipher-suites,id=ciphersuite0,priority=@SYSTEM \
>>     -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0
>>   qemu-system-x86_64: -fw_cfg name=etc/edk2/https/ciphers,blob_id=ciphersuite0: warning: externally provided fw_cfg item names should be prefixed with "opt/"
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  softmmu/vl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index f76c53ad2e..3b77dcc00d 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -2052,7 +2052,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>                     FW_CFG_MAX_FILE_PATH - 1);
>>          return -1;
>>      }
>> -    if (strncmp(name, "opt/", 4) != 0) {
>> +    if (!nonempty_str(blob_id) && strncmp(name, "opt/", 4) != 0) {
>>          warn_report("externally provided fw_cfg item names "
>>                      "should be prefixed with \"opt/\"");
>>      }
>>
> 
> Hmmm, difficult question! Is "ciphersuite0" now externally provided or not?
> 
> Because, ciphersuite0 is populated internally to QEMU alright (and so we
> can think it's internal), but its *association with the name* is external.
> 
> What if we keep the same "-object" switch, but use a different (bogus)
> "name" with "-fw_cfg"? IMO that kind of invalidates "-object" too.
> 
> Should the fw_cfg generator interface dictate the fw_cfg filename too?
> Because that would eliminate this problem. Put differently, we now have
> a possibility to label the "ciphersuite0" object in the fw_cfg file
> directory any way we want -- but is that freedom *useful* for anything?

Good point. Not now.

> 
> I guess we might want multiple "tls-cipher-suites" objects one day, so
> hard-coding the fw_cfg names on that level could cause conflicts.

I haven't thought of that. If we set a limit today, we can relax it
tomorrow. That won't break anything.

> On the
> other hand, I wouldn't like "blob_id" to generally circumvent the "etc/"
> namespace protection.

Eh, that was too easy.

> 
> I'm leaning towards agreeing with this patch, but I'd appreciate some
> convincing arguments.

OK. I'll think about it. Maybe keep this as single-RFC patch & repost
the rest so review can go on until we settle on this.

> 
> Thanks
> Laszlo
> 


