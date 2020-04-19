Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA2C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CD221744
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtBpiElc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CD221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCsP-0004bf-2t
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43302 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQCrS-0003Qu-B5
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:32:02 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQCrQ-0007TU-GF
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:32:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54369
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQCrP-0007OJ-Ke
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587313916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pesQP7cRSpxsyS1fcfkJAP4LS9zAm+K6PXhY9VbHvhM=;
 b=QtBpiElcjkIQifYyC38sjPFTNr7I5A9h13pBeA7lc+mbyIW7rQyYAMX7YF1Tjpt5bj5YFC
 I84Ki35Vg1LTb7TsqfyHU3pS6dEEmFyNEZ59CIL2ItJQJO8h+5a0DvzUclbisFXHXPEkxz
 Ba3S/o1oJkafoGuLOW0b0nWIBOKQLUM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-ylny8ibTNeuACJT0ysbuww-1; Sun, 19 Apr 2020 12:31:52 -0400
X-MC-Unique: ylny8ibTNeuACJT0ysbuww-1
Received: by mail-ej1-f69.google.com with SMTP id k26so4515941ejx.6
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2020 09:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mdx8uZoicdMAL3gsk4iw2tZTBBc5tNVnam1BJXq8JpA=;
 b=hsV99FdYJA/HkPslrEf2Vah5Hs2zt+vdfctXEC/i6GVYPNhoT1UfXxBQzR/5UaF9O/
 DRxcppWHkd3Jz1z7sgUi/JGFB/NtWbO/kGdrlH04joLSDCLlWzsVtOCYmPhum+j4yiu+
 iSu00fM4a/jTmYu4oW7yOrV7xjVmJdnd/NaVo3kbF5wQ3MQFyziOsajJEw8KIzLAf6+p
 btEl7uWi8QDq/FONz0QNpYoM8qNLjm6tu8BBYKwbfxauv3p2tzGzqWen4gskms3YyWoc
 +zJvcDVXc5m8q2S8a3ssHOzhbr8RYAA75DsUqnhc5Iv7teIqxLBJAj55BsQjJVg2SB+v
 3VRw==
X-Gm-Message-State: AGi0PuYPVD0BsmvbXeaeH0xIiRMNvq3N3pGW+BHF7rKj6K/Pa9WxFTmX
 EZVGvSR5DwTxd58fU8j5Leihw5M+3sGxktwrgt7QzUzSjNzM4HMPRoTbTbxsenrWN1Hq4vGKTuG
 0mDd5NjwN0Do4nEQ=
X-Received: by 2002:a17:906:2548:: with SMTP id
 j8mr12206236ejb.378.1587313911278; 
 Sun, 19 Apr 2020 09:31:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIGMVc28IzTxhaadVRoFY6tLBI6HBJuXp/EquYW22a4sqO/BslnxojkVnswkaba/ShOkJowLQ==
X-Received: by 2002:a17:906:2548:: with SMTP id
 j8mr12206211ejb.378.1587313910951; 
 Sun, 19 Apr 2020 09:31:50 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b8sm1799672edt.7.2020.04.19.09.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2020 09:31:50 -0700 (PDT)
Subject: Re: [PATCH v3 01/19] target/arm: Rename KVM set_feature() as
 kvm_set_feature()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-2-philmd@redhat.com>
 <cb3178f1-5a0c-b11c-a012-c41beeb66cd2@linaro.org>
 <3dc0e645-05a5-938c-4277-38014e4a68a3@redhat.com>
Message-ID: <f4ee109e-b6fc-8e1b-7110-41e045e58c30@redhat.com>
Date: Sun, 19 Apr 2020 18:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3dc0e645-05a5-938c-4277-38014e4a68a3@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 10:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/16/20 9:16 PM, Richard Henderson wrote:
>> On 3/16/20 9:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> +++ b/target/arm/kvm32.c
>>> @@ -22,7 +22,7 @@
>>> =C2=A0 #include "internals.h"
>>> =C2=A0 #include "qemu/log.h"
>>> -static inline void set_feature(uint64_t *features, int feature)
>>> +static inline void kvm_set_feature(uint64_t *features, int feature)
>>
>> Why, what's wrong with the existing name?

Peter suggested the rename here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg641931.html

>> Plus, with patch 2, you can just remove these.

Since they don't have the same prototype, they clash:

target/arm/kvm64.c:450:20: error: conflicting types for =E2=80=98set_featur=
e=E2=80=99
  static inline void set_feature(uint64_t *features, int feature)
                     ^~~~~~~~~~~
In file included from target/arm/kvm64.c:30:0:
target/arm/internals.h:30:20: note: previous definition of =E2=80=98set_fea=
ture=E2=80=99=20
was here
  static inline void set_feature(CPUARMState *env, int feature)
                     ^~~~~~~~~~~
target/arm/kvm64.c:455:20: error: conflicting types for =E2=80=98unset_feat=
ure=E2=80=99
  static inline void unset_feature(uint64_t *features, int feature)
                     ^~~~~~~~~~~~~
In file included from target/arm/kvm64.c:30:0:
target/arm/internals.h:35:20: note: previous definition of=20
=E2=80=98unset_feature=E2=80=99 was here
  static inline void unset_feature(CPUARMState *env, int feature)
                     ^~~~~~~~~~~~~
rules.mak:69: recipe for target 'target/arm/kvm64.o' failed
make[1]: *** [target/arm/kvm64.o] Error 1

>=20
> The prototypes are different:
>=20
>  =C2=A0 void set_feature(uint64_t *features, int feature)
>=20
>  =C2=A0 void set_feature(CPUARMState *env, int feature)
>=20
> Anyway you are right, I'll use the later prototype instead, thanks.

There are ~180 uses of set_feature(CPUARMState,...) and 10 of=20
set_feature(uint64_t,...) (kvm32:4 kvm64:6).

We are going to remove kvm32, so replacing 180 set_feature(env) by=20
set_feature(env->features) seems a waste.

If you prefer to avoid renaming as kvm_set_feature() another option is=20
to move the declaration in a local "features.h" header that would not be=20
included by kvm*.c.

The main problem is the use of the ARMHostCPUFeatures structure which=20
apparently was introduced similar to a CPUClass (commit a96c0514ab7)=20
then lost this in commit c4487d76d52.


