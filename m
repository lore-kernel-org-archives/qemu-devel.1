Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D79BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3CE20870
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R72H5Ka1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3CE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2tI-0005Bo-6C
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX2ie-0005Ho-C3
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:07:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jX2ic-00076X-Sc
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588943228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmqnEPBHm7xS7uPpmghTJS93/hexnmN1g25lr9BQt+o=;
 b=R72H5Ka1e0dI2dt9FYkC1R3i3KeatX1EVfnnvo9FARsJwh2fIpFATj2nty3kwt/SVy4m1Q
 +Sh0qO3so1xMd2maBtNPVU/0aY426ETV2B0ucwjUNBFBeBBjCr6nerjrIc+yDfNsSEmBEj
 nSfs2bXQlKQ9rUAsYWs0/04xDDGYljM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-MHcayo9WPputGo5AvLYI-Q-1; Fri, 08 May 2020 09:07:07 -0400
X-MC-Unique: MHcayo9WPputGo5AvLYI-Q-1
Received: by mail-wm1-f69.google.com with SMTP id d134so5335401wmd.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 06:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3FKuiRR3O8LmcwZdbwLVvVLWFoqltBGT9KYsB06Dmlc=;
 b=OXExFpyJFt5Y8TYZgjm88VY8rbr12MjNTsy0BZKF6OdDyXE+BfFOFT6Q6ZwXwJ1d7m
 HCKzDVvHtNhTSetFkAdRFeRTMXBMpLc+yoW0F0hv8R45Vu9UtQci/yb/HfLdg21LOhT9
 9OmzBTv7HzCuUmOUWMrsAXtRpy7sTFZNZuBXoy6SUoXGDXNJ7CIQHpnPTr2y1MnAX+y/
 HZtT5g+I9aytMCkn6Ezdx4UU6iIw3mYbxKYj+iTGUYB5JFWsO+vMTFoR1LejrpqHdqpR
 TPi3g+D6JMRvyKSGxTxIQtdx/sP8hDiJ//L9uWolmAggzGaMOjNK6rCZm7Cpf6wTesrH
 RPFA==
X-Gm-Message-State: AGi0PuZEQ4Smggv25GYzqm94qTMATLpz3qFtoyXj/6bkp9xrDhny6ky/
 JBYcZa/shg4WBWwVSGEzf/J6O2Kal4kTCrjclzovFKT9WwuS2Ae9xrQSyDEg8yOY+JAbIXIwybK
 FX/mOBePQZUX+YaE=
X-Received: by 2002:adf:a4c5:: with SMTP id h5mr2832404wrb.408.1588943225516; 
 Fri, 08 May 2020 06:07:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypKG4xW3KRV/fDEhzMFe4Pz4n1cZWNNoXFxlxOQyfKnh9LaKTzW8uAsA83mdCwAK3t0IY1ARdA==
X-Received: by 2002:adf:a4c5:: with SMTP id h5mr2832381wrb.408.1588943225280; 
 Fri, 08 May 2020 06:07:05 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b14sm89508wmb.18.2020.05.08.06.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 06:07:04 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt'
 machine TCG test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200507162235.1790-1-philmd@redhat.com>
 <874ksr615d.fsf@linaro.org>
 <CAFEAcA800Lhgqa6gOWmA5M2D3+Xj0hYcJw9Tkget4yvW5fFs+A@mail.gmail.com>
 <871rnv5vva.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15b8c809-d8f8-4ca0-9815-d35a87fc5f83@redhat.com>
Date: Fri, 8 May 2020 15:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <871rnv5vva.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 10:32 PM, Alex Benn=C3=A9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On Thu, 7 May 2020 at 19:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>>
>>>
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>>
>>>> The BootLinuxAarch64.test_virt_tcg is reported to take >7min to run.
>>>> Add a possibility to users to skip this particular test, by setting
>>>> the AVOCADO_SKIP_SLOW_TESTS environment variable:
>>>>
>>>>    $ AVOCADO_SKIP_SLOW_TESTS=3Dplease make check-acceptance
>>>>    ...
>>>>      (05/88) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt=
_tcg: SKIP: Test takes >7min
>>>>    ...
>>>
>>> 7m =3D 420s - I'm seeing:
>>>
>>>    hyperfine "./tests/venv/bin/avocado run ./tests/acceptance/boot_linu=
x.py:BootLinuxAarch64.test_virt_tcg"
>>>    Benchmark #1: ./tests/venv/bin/avocado run ./tests/acceptance/boot_l=
inux.py:BootLinuxAarch64.test_virt_tcg
>>>      Time (mean =C2=B1 =CF=83):     162.179 s =C2=B1  3.138 s    [User:=
 204.726 s, System: 9.663 s]
>>>      Range (min =E2=80=A6 max):   158.651 s =E2=80=A6 170.036 s    10 r=
uns
>>>
>>> Is this on very slow hardware?
>>
>> Intel(R) Xeon(R) W-2145 CPU @ 3.70GHz 16-core
>> clang sanitizer build, which probably slows it down a bit.
>>
>> But even 200 seconds is an order of magnitude slower than any
>> of the other tests that check-acceptance runs. I think we
>> should be aiming for tests here to be ~30 seconds at most,
>> or the whole thing will take forever by the time we have
>> decent coverage of most machines.
>=20
> I think we could say the same for a whole bunch of the tests that are
> based on full distro downloads. What is this one running under the hood
> anyway?

Download time is now counted separately, this was one big feature=20
request after the last KVM forum.

The second request was to improve test timing management, like having=20
different timers tracking if the test is behaving as expected. I.e. you=20
might want to boot a VM and run 'ping -c 3'. The whole test shouldn't=20
take more than 7min, but we want to be sure the 'ping' command doesn't=20
take more than 3.x seconds. I haven't heard about a such feature ready yet.

I really hope you are using a common cache location and now download the=20
artifacts each time...

>=20
>=20
>>
>> thanks
>> -- PMM
>=20
>=20


