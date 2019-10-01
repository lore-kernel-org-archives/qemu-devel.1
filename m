Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543FCECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291DF21855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291DF21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLbf-0001hD-30
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFLOh-00049h-Lf
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFLOg-0000sx-Hw
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFLOg-0000sa-AQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:53:10 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 662697BDA2
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 16:53:09 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g67so1151535wmg.4
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 09:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8K7V0ORuUpV1n/aSzdYRyHsfvbNslph/nRpcWyckUPI=;
 b=Mmt0nQaiEfnUhKtLAngycxlTDapibMjHK9+CRxMucTkkjm5Pl71HG5/YlRl85BxiBb
 E9mNI5HhkcdRJzekQ6KNMvR78Y/7BTY95Kvu4OxCi/fGi+ZsJucvMmAlTGxG8Jbn/SKy
 I5NLppyuZaLbyorUyDcpAEdUmqcHlLuCQFCx55N0l61o9mcQU8gKL4O+tvEuokre8ENZ
 Eqcuq9hS7pzWgKH9qQnmjjbj6cDLRsrx3PxGbqflUBXhkedRR3CqnSbjI101khWbFbvv
 oW7pdGPJ6IcAZtil6/2jBbEOfEzbjjQskDP+NoY9o/AD7OIgsimpSnnHH0fSIEVGwjnL
 +9jw==
X-Gm-Message-State: APjAAAWvFDx2i1Wt1LsIvBSnU8ZWnPTH88gZW9Wj7ZKXizV9O9dUT2OQ
 7DNZjmh5ANhKCpl4kbb1cldNKSDZhqpYzyP/ki3sBHKSoA/mNWW1z2IyKrowU5fMatKjGRCkyPv
 Cmojul0wRZrw0Lus=
X-Received: by 2002:a5d:4983:: with SMTP id r3mr19954984wrq.194.1569948787851; 
 Tue, 01 Oct 2019 09:53:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyl0WV7lV9wUEstWM/XzGci2CvYD0rtrpUhw6O6rSVe0KNCLJad0rXBFk+xx9JMRHMfivxwVA==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr19954967wrq.194.1569948787564; 
 Tue, 01 Oct 2019 09:53:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id l1sm16987568wrb.1.2019.10.01.09.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 09:53:07 -0700 (PDT)
Subject: Re: [PATCH 8/8] docker: test-debug: disable LeakSanitizer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
 <1569936988-635-9-git-send-email-pbonzini@redhat.com>
 <4f6b25f1-fff6-10bc-4089-26104ccec556@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a8b791e4-e66c-4f05-631a-d41a1f71d093@redhat.com>
Date: Tue, 1 Oct 2019 18:53:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4f6b25f1-fff6-10bc-4089-26104ccec556@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/19 15:59, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/1/19 3:36 PM, Paolo Bonzini wrote:
>> There are just too many leaks in device-introspect-test (especially fo=
r
>> the plethora of arm and aarch64 boards) to make LeakSanitizer useful;
>> disable it for now.
>>
>> Whoever is interested in debugging leaks can also use valgrind like th=
is:
>>
>> =C2=A0=C2=A0=C2=A0 QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aar=
ch64 \
>> =C2=A0=C2=A0=C2=A0 QTEST_QEMU_IMG=3Dqemu-img \
>> =C2=A0=C2=A0=C2=A0 valgrind --trace-children=3Dyes --leak-check=3Dfull=
 \
>> =C2=A0=C2=A0=C2=A0 tests/device-introspect-test -p
>> /aarch64/device/introspect/concrete/defaults/none
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0 tests/docker/test-debug | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/docker/test-debug b/tests/docker/test-debug
>> index 137f4f2..c050fa0 100755
>> --- a/tests/docker/test-debug
>> +++ b/tests/docker/test-debug
>> @@ -21,6 +21,7 @@ cd "$BUILD_DIR"
>> =C2=A0 OPTS=3D"--cxx=3Dclang++ --cc=3Dclang --host-cc=3Dclang"
>> =C2=A0 OPTS=3D"--enable-debug --enable-sanitizers $OPTS"
>> =C2=A0 +export ASAN_OPTIONS=3Ddetect_leaks=3D0
>> =C2=A0 build_qemu $OPTS
>> =C2=A0 check_qemu check V=3D1
>> =C2=A0 install_qemu
>=20
> Can we reduce it only for the arm/aarch64 targets?

Not easily, since check_qemu runs tests for all targets.  It's not
possible AFAICT to set ASAN_OPTIONS from inside the test, for example.

Paolo

