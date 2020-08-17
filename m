Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116CAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2250206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB/yIqGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2250206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7XeG-0000RZ-0Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 01:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7Xde-0008Pm-VG
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:24:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k7Xdb-00079o-UQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597641890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t8sSNWEgbGqHQQao5jWuxMb/IzyK23atDvjGWJkZhe4=;
 b=iB/yIqGkfKPrjhPcd3V8iWZNDFsY6aTqEViwdD71nbyw1ZxhYR8AqVW6QFcUJg2ssMWGQM
 kzHFBjhPICUpjV77bGg/cllsbW4PO4765MVFjS0LAt3g5p6akFikkxsIK1sqS69yUOOQUg
 4Sfi1tVssVJzYbg76gcLKUTxPJ1q4Xs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-U-jRxnc9MCSxsOG1abpNxQ-1; Mon, 17 Aug 2020 01:24:48 -0400
X-MC-Unique: U-jRxnc9MCSxsOG1abpNxQ-1
Received: by mail-wr1-f72.google.com with SMTP id j2so6504708wrr.14
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 22:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZYpalzqwUoNBePZOpV7je+sSd/fyQW+gkbORBclRMMY=;
 b=eun1Vqe+i1nW/bVXTY8e7QFpptmEsPndYI4vFSVy1A7boNm8/YQNtEQ0R8kiFXR0kU
 5mtCsThaTz8DvkXHrO9+OcI8yNAcGa+ZYeWQbj9DQC4X0p3VJ2Oo4R2nwdqAOfOTPUxk
 CYVdwh82BDS0vkBeETzmOnQb4SKP2W8r7oCFaJJbXBe9WCDGF/BMFa/ptHD7jIfaPHC2
 A5/EeDtxaWCnIDGE78PkoxkaboAwwa11VH0Z/GoOiE/iwiETz6t2OiwC5Flu4yd4QbD6
 uqeI3En4ZkwfNVRONy/2zG+jbT+26nCnV0AKYzfsKG3kdh9SRE0QaqNvkM3Ny4WU4IKp
 +1qA==
X-Gm-Message-State: AOAM530nhyB1lFbyIJC4CeHy9elqwxUSjIT4UNZVMmxzOU8FMHLXWixL
 8hSNB2R1Te1ohYksz2QF0fUMafM6smN8/mWtKHODEeqrbA5ggd7pl52c7goq9t9FgqOZw526kg2
 aJXMABO1wvzKsMx8=
X-Received: by 2002:adf:f812:: with SMTP id s18mr13848474wrp.96.1597641887111; 
 Sun, 16 Aug 2020 22:24:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqbZaD+LNv1uT7Vd2Q07YL8RuhuP+GBLo1VgQNMnZg0Fs29yk4osUdxfT1lfi76rBMugdpWw==
X-Received: by 2002:adf:f812:: with SMTP id s18mr13848440wrp.96.1597641886788; 
 Sun, 16 Aug 2020 22:24:46 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c10sm27697729wro.84.2020.08.16.22.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 22:24:45 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
To: David Gibson <david@gibson.dropbear.id.au>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200817044730.GK12805@yekko.fritz.box>
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
Message-ID: <83ebefab-8bdf-2584-53e6-e4fa0f540109@redhat.com>
Date: Mon, 17 Aug 2020 07:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817044730.GK12805@yekko.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:54:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 6:47 AM, David Gibson wrote:
> On Wed, Jul 22, 2020 at 11:56:49PM -0300, Thiago Jung Bauermann wrote:
>> The ARM code has a start-powered-off property in ARMCPU, which is a
>> subclass of CPUState. This property causes arm_cpu_reset() to set
>> CPUState::halted to 1, signalling that the CPU should start in a halted
>> state. Other architectures also have code which aim to achieve the same
>> effect, but without using a property.
>>
>> The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
>> before cs->halted is set to 1, causing the vcpu to run while it's still in
>> an unitialized state (more details in patch 3).
>>
>> Peter Maydell mentioned the ARM start-powered-off property and
>> Eduardo Habkost suggested making it generic, so this patch series does
>> that, for all cases which I was able to find via grep in the code.
>>
>> The only problem is that I was only able to test these changes on a ppc64le
>> pseries KVM guest, so except for patches 2 and 3, all others are only
>> build-tested. Also, my grasp of QOM lifecycle is basically non-existant so
>> please be aware of that when reviewing this series.
>>
>> The last patch may be wrong, as pointed out by Eduardo, so I marked it as
>> RFC. It may make sense to drop it.
>>
>> Applies cleanly on yesterday's master.
> 
> This series appears to break the Travis build for a MIPS target:
> 
> Unexpected error in qdev_prop_set_after_realize() at /home/travis/build/dgibson/qemu/hw/core/qdev-properties.c:30:
> qemu-system-mips64el: Attempt to set property 'start-powered-off' on anonymous device (type 'I6400-mips64-cpu') after it was realized
> Broken pipe
> /home/travis/build/dgibson/qemu/tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> Aborted (core dumped)
> ERROR qom-test - too few tests run (expected 8, got 0)
> /home/travis/build/dgibson/qemu/tests/Makefile.include:650: recipe for target 'check-qtest-mips64el' failed

Good catch. hw/mips/cps.c, hw/ppc/e500.c and hw/sparc/sun4m.c are
incorrectly setting the property after the cpu is realized because
the cpu is created with cpu_create(). We need to create them with
object_initialize_child() and realize them manually with qdev_realize().


