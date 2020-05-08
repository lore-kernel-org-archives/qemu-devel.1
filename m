Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1ABC47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF2D24999
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buOYjOXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF2D24999
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2nF-0004at-9k
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX2kP-00086s-0L; Fri, 08 May 2020 09:09:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX2kO-0007oN-7O; Fri, 08 May 2020 09:09:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so1773079wrt.5;
 Fri, 08 May 2020 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SfoftjUdJMP/vemqd09MfiuAR5q0nKJtH0beyh9JsQg=;
 b=buOYjOXc2/tIRGGk9mjFWqjrviH/6shur17U6RKWI2VfnGj0jhu/j1HwE055G95CxE
 RT2I+OVK3GxUqG4LwYG7coF2qnGOdV8GiaQqJkVhH0R4vx8q8MrNCC4aF/Axd01eqJ0a
 hvnWfuoZUPxaxHjak7DxgRmHuOxReHOkUaO6yJsDTeTTTUoLEr5AW/tfQqJVBC60cX3e
 A1x+fyJINBTWYPbcniWG+sU7UIefEakcisBAjkBt5tLrZn0J8Pr6Pu11r9pRiRfMDNYE
 ZBcx0gCAdPOHOQw9hrhP3bWhJkECk7KmGOZKGAS1kgQBSq6r3eBaxmZ9w4GzmgZtWi5Y
 OT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SfoftjUdJMP/vemqd09MfiuAR5q0nKJtH0beyh9JsQg=;
 b=uVXeTCsR5Ys2ImiMtiZzNgLVoyW0+MXOr41kBosXWlC71BWaiUCWmSXqG40OcVh+Vc
 XL/JXvIhQ9dKcBLXPLwmFPpLoOq59mKKdVbCwG4b0do8rVWSX8bvxI7ZKc67OKi5UNF8
 3uoLt3eAtivsIKmyT9kVvFcjbOVmvbACy+8CrQhxg6xEWRDJCdFMXnrKm/61G9ARVN+W
 Jv1XAyUtJcCYMkzbjfRZD3RUHXOEfumUzxxqYpDDVmD1ajLDLhYKVAWAV8rzodDxbeqc
 jqhmEUIzcYX9m37FLiC6xhKnmr1x2ReVJpXHpzU2wLk7ksitKHDwj0iOpP8zfuxbA9Bm
 J5zQ==
X-Gm-Message-State: AGi0PuYRCZSC6FNzdibmAe+mQJH8lUqRpMlu4Q7Hexnb17qKuO8veltf
 d5g8R6wefL1HslqjsMwDv+U=
X-Google-Smtp-Source: APiQypKW2ZHWmhB+ydNX9xkm44FQ6geGPfM0Pb3LxCGEVG3UmAv4x62XFMba1P1sJsmshnoslGVWWg==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr2782543wrn.69.1588943337081; 
 Fri, 08 May 2020 06:08:57 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s14sm12369462wmh.18.2020.05.08.06.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 06:08:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] various: Remove unnecessary OBJECT() cast
To: Markus Armbruster <armbru@redhat.com>
References: <20200504100735.10269-1-f4bug@amsat.org>
 <20200504100735.10269-3-f4bug@amsat.org> <87mu6iy4k3.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b23abb5d-7222-c6ad-7314-a4138cb5d062@amsat.org>
Date: Fri, 8 May 2020 15:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87mu6iy4k3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Corey Minyard <cminyard@mvista.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 2:49 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> The OBJECT() macro is defined as:
>>
>>    #define OBJECT(obj) ((Object *)(obj))
>>
>> which expands to:
>>
>>    ((Object *)object_dynamic_cast_assert((Object *)(obj), (name),
>>                                          __FILE__, __LINE__, __func__))
> 
> Nope :)
> 
>> This assertion can only fail when @obj points to something other
>> than its stated type, i.e. when we're in undefined behavior country.
> 
> There is no assertion.
> 
>> Remove the unnecessary OBJECT() casts when we already know the
>> pointer is of Object type.
>>
>> Patch created mechanically using spatch with this script:
>>
>>    @@
>>    typedef Object;
>>    Object *o;
>>    @@
>>    -   OBJECT(o)
>>    +   o
>>
>> Acked-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Corey Minyard <cminyard@mvista.com>
>> Acked-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> v2: Reword (Markus)
> 
> My rewording suggestion applied to PATCH 3, not to this one.

OK.

> 
> With v2's commit message;
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Are you willing to take these patches? In that case, are you OK to take 
1 & 3 and I resend 2?

Thanks,

Phil.

