Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6BAC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3C22082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA/Ke9cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3C22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz20n-0000Py-PS
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iz1vU-0005Ly-SD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iz1vS-0005m1-5L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:23:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iz1vS-0005lf-1E
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580837029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXAyBvcJgY7G+8cnfkjn0VaQ7IOPoDQR9hAT1163B3E=;
 b=VA/Ke9cOJA466kLylooWSTftLp5xgKdsjs8aJuU7RvvUFEU+duoUY1bAMSQ5IeWYbaNHPi
 ZfgJ3XScJFfuexy5u07cdlq94XsoSdTjRM0lztrCrh+Py4BfP3qL3H4v3xLMyTDtG4CQUL
 yt6pmEKsniy9c0XGBMdF0P3mMM7TqNg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-ibRTXJAbPuG8dXd4qsNyXQ-1; Tue, 04 Feb 2020 12:23:46 -0500
Received: by mail-wr1-f69.google.com with SMTP id v17so10561712wrm.17
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 09:23:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Bay0K7XxOF53TvnYZKjIHHIcqgGt0iI0P5dIAbiOQ0=;
 b=VINjTZF1GhF2ov7ZMjXgqzcRNMfcK/RRv9SGgdC6F1cq/3x0OaDJljwP/stnXO6C5X
 LtiePdczWL4Ge01L1GH/mcY7T+W1aqeiFyISvrdqEEWkwpVfDL2tOiBsm5GT0hhziYdR
 4FTkHH0Ec0W13a5SpQ2bZ4eF6jUQSXHcJH/eY8sqqRlCmbOfRgFFTWYe21Wf1kdlalng
 3cOYMhfScmuqSNWugk40CEXFjry6RSmo/DFNwLL+yKUDF3aU86PAhjSi5bki00cRwt+U
 401Uc9/TLIfle7co1FpvmrrnHafRuWqYh6TVjAO85l3lAubEhY29z9b5c1oKMKeDNwYG
 xaHQ==
X-Gm-Message-State: APjAAAVAOYcDby+qo/a5mli72eI0KrpKJKFEViXqlPdYYpJgGiFu6YsI
 z+myE8HmAAolb/0GQvpFLu7OunpUKq+pVNuKfkhnNoYMMZPyref1l61d8ua/KHmT5wevhWP236q
 csQU3i/9t6/YW45I=
X-Received: by 2002:adf:8150:: with SMTP id 74mr24023759wrm.114.1580837025251; 
 Tue, 04 Feb 2020 09:23:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzyMt/isbL01MnkX/hCoGdm0DYTQZd5mRzYD6YQB25LxNFDapFHKuJ8PQ9+fGcZ4zj5n6Ytg==
X-Received: by 2002:adf:8150:: with SMTP id 74mr24023748wrm.114.1580837025090; 
 Tue, 04 Feb 2020 09:23:45 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id d13sm2058036wrc.3.2020.02.04.09.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 09:23:44 -0800 (PST)
Subject: Re: [PATCH] drop "from __future__ import print_function"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20200204160604.19883-1-pbonzini@redhat.com>
 <86185404-c4bc-b35d-eedc-9d95d1698379@redhat.com>
 <82c6a3aa-8143-7510-4369-c70c785b302b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0aa928f5-c975-2f13-6b0b-dc723a4f9e8f@redhat.com>
Date: Tue, 4 Feb 2020 18:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <82c6a3aa-8143-7510-4369-c70c785b302b@redhat.com>
Content-Language: en-US
X-MC-Unique: ibRTXJAbPuG8dXd4qsNyXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 2/4/20 6:10 PM, Paolo Bonzini wrote:
> On 04/02/20 17:07, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/4/20 5:06 PM, Paolo Bonzini wrote:
>>> This is only needed for Python 2, which we do not support anymore.
>>>
>>> Based-on: <20200204160028.16211-1-pbonzini@redhat.com>
>>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  =C2=A0 scripts/analyse-9p-simpletrace.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/analyse-locks-simpletrace.py=C2=A0=C2=A0=C2=A0=C2=A0 | =
1 -
>>>  =C2=A0 scripts/device-crash-test=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/dump-guest-memory.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/kvm/kvm_flightrecorder=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/kvm/vmxcap=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/minikconf.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 -
>>>  =C2=A0 scripts/modules/module_block.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/qapi-gen.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/qapi/doc.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/qmp/qemu-ga-client=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/qmp/qmp=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/qmp/qmp-shell=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
1 -
>>>  =C2=A0 scripts/qmp/qom-get=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/qmp/qom-list=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 -
>>>  =C2=A0 scripts/qmp/qom-set=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/qmp/qom-tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 -
>>>  =C2=A0 scripts/replay-dump.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/signrom.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/simpletrace.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 scripts/vmstate-static-checker.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/docker/travis.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/guest-debug/test-gdbstub.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/migration/guestperf/engine.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 -
>>>  =C2=A0 tests/migration/guestperf/plot.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/migration/guestperf/shell.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/qapi-schema/test-qapi.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/qemu-iotests/149=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/qemu-iotests/165=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/qemu-iotests/iotests.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/qemu-iotests/nbd-fault-injector.py | 1 -
>>>  =C2=A0 tests/qemu-iotests/qcow2.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/qemu-iotests/qed.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 tests/vm/basevm.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 -
>>>  =C2=A0 34 files changed, 34 deletions(-)
>>>
>>> diff --git a/scripts/analyse-9p-simpletrace.py
>>> b/scripts/analyse-9p-simpletrace.py
>>> index f20050fddd..7dfcb6ba2f 100755
>>> --- a/scripts/analyse-9p-simpletrace.py
>>> +++ b/scripts/analyse-9p-simpletrace.py
>>> @@ -3,7 +3,6 @@
>>>  =C2=A0 # Usage: ./analyse-9p-simpletrace <trace-events> <trace-pid>
>>>  =C2=A0 #
>>>  =C2=A0 # Author: Harsh Prateek Bora
>>> -from __future__ import print_function
>>>  =C2=A0 import os
>>>  =C2=A0 import simpletrace
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>=20
> Are you queueing this too?

Yes, patch applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


