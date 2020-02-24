Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7E6C35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D1D2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGDiwiYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D1D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6C67-0001VH-Qf
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6C5D-0000dW-Ug
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6C5B-0007LN-VS
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:39:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6C5A-0007Ks-6r
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582544367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tld274PxuEdRWCHH/mrUXPjW9GX3dRl0u3qG16b7hLA=;
 b=WGDiwiYJwhuSBmMGciUfZgQopZykSKmqAkr74YwE1BvuV5xDjoaBV+zm89StIKo+4+uf4i
 j5Q4uI/hQkGbOjJdketas3oMu7qMw4U34fBWT1hsqclqx/xufssj6zCHTTmKF5nkOXSPkc
 WOadlOCFoXW7x9/ncGXOI1DMwqzisIE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-FsxjT4ZoPdmRUo5CWN3aSw-1; Mon, 24 Feb 2020 06:39:25 -0500
X-MC-Unique: FsxjT4ZoPdmRUo5CWN3aSw-1
Received: by mail-wr1-f70.google.com with SMTP id e5so3843526wro.12
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 03:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=67jicjQ4EaxBoxwDhhlBAQ9tzq/en4rNlfvk/h89pvI=;
 b=Tw8xCNWqD3+0wHe6gFBA9RQQxnYVdeXgmCCmTQjQZhbsFTW7tQGSASCaaiKOcD3f8/
 TyLqtmdEbYGOiVYsQEdG065pYZDss0t3aC/Y4EcxI/ZohvCJythcDBDgfaNFw5qKW0zn
 N6CFXlEU5Ev3kv+R1IFYTMSXowB9K34RTqW2VH6vBoLXFdlHHW1AGuOX79LRUXmOGizK
 LKAhEryWcnHdZcsDAVcAImuNwQk3dy/S9vWWEhnJ/pS/0HGoHhDcZurP67beL6+Mczyi
 9y72ZcossTGCk9JUG1XSgpI3b5QzeRzsn73D1uHiJYU6jy3M+c2zk74pladAU2qXZKBN
 l1zQ==
X-Gm-Message-State: APjAAAVLeTSOXF3h9Rl3EyZRcS4DWDGXN5gjMI2OiLSnLIc96CmEpEgQ
 +r33LydTMAl378GIFYbDvsr2wHw7z8hJcHj4PuQY++rochGB4iJTz2JHE16ispIr1KFM+Ic51iw
 f4q5VDtCsUmZw+6U=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr63933168wrn.133.1582544364253; 
 Mon, 24 Feb 2020 03:39:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXQZ2rE+IB9t8N2+0W4jX+m0fi5cVqAngd6Q1QifebsVcnR53Kun3bMK5w1SyvLq4+7N7fJw==
X-Received: by 2002:adf:ec83:: with SMTP id z3mr63933144wrn.133.1582544363995; 
 Mon, 24 Feb 2020 03:39:23 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id z6sm18810813wrs.96.2020.02.24.03.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 03:39:23 -0800 (PST)
Subject: Re: [PATCH v6 00/79] refactor main RAM allocation to use hostmem
 backend
To: Igor Mammedov <imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
 <09a2f9da-998c-545b-ea15-f1ae3490fb54@redhat.com>
 <20200224123342.14b67e6d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <09c404a5-6207-f019-d7da-edcf146f2899@redhat.com>
Date: Mon, 24 Feb 2020 12:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224123342.14b67e6d@redhat.com>
Content-Language: en-US
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 12:33 PM, Igor Mammedov wrote:
> On Mon, 24 Feb 2020 09:45:11 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> Hi Igor,
>>
>> On 2/19/20 5:08 PM, Igor Mammedov wrote:
>> [...]
>>> Series removes ad hoc RAM allocation API (memory_region_allocate_system=
_memory)
>>> and consolidates it around hostmem backend. It allows to
>>>    * resolve conflicts between global -mem-prealloc and hostmem's "poli=
cy" option
>>>      fixing premature allocation before binding policy is applied
>>>    * simplify complicated memory allocation routines which had to deal =
with 2 ways
>>>      to allocate RAM.
>>>    * it allows to reuse hostmem backends of a choice for main RAM witho=
ut adding
>>>      extra CLI options to duplicate hostmem features.
>>>      Recent case was -mem-shared, to enable vhost-user on targets that =
don't
>>>      support hostmem backends [1] (ex: s390)
>>>    * move RAM allocation from individual boards into generic machine co=
de and
>>>      provide them with prepared MemoryRegion.
>>>    * clean up deprecated NUMA features which were tied to the old API (=
see patches)
>>>       - "numa: remove deprecated -mem-path fallback to anonymous RAM"
>>>       - (POSTPONED, waiting on libvirt side) "forbid '-numa node,mem' f=
or 5.0 and newer machine types"
>>>       - (POSTPONED) "numa: remove deprecated implicit RAM distribution =
between nodes"
>>>
>>> Conversion introduces a new machine.memory-backend property and wrapper=
 code that
>>> aliases global -mem-path and -mem-alloc into automatically created host=
mem
>>> backend properties (provided memory-backend was not set explicitly give=
n by user).
>>> And then follows bulk of trivial patches that incrementally convert ind=
ividual
>>> boards to using machine.memory-backend provided MemoryRegion.
>>>
>>> Board conversion typically involves:
>>>    * providing MachineClass::default_ram_size and MachineClass::default=
_ram_id
>>>      so generic code could create default backend if user didn't explic=
itly provide
>>>      memory-backend or -m options
>>>    * dropping memory_region_allocate_system_memory() call
>>>    * using convenience MachineState::ram MemoryRegion, which points to =
MemoryRegion
>>>      allocated by ram-memdev
>>> On top of that for some boards:
>>>    * added missing ram_size checks (typically it were boards with fixed=
 ram size)
>>>    * ram_size fixups were replaced by checks and hard errors, forcing u=
ser to
>>>      provide correct "-m" values instead of ignoring it and continuing =
running.
>>>
>>> After all boards are converted the old API is removed and memory alloca=
tion
>>> routines are cleaned up.
>>
>> I wonder about the pre-QOM machines. As they don't call
>> memory_region_allocate_system_memory(), the conversion is not required?
>> (See for example pxa270_init).
> Since they weren't using memory_region_allocate_system_memory(), they are
> out of scope of this series.
>=20
> As for the future, I'd only make boards that support user configurable
> ram size to accept "-m".

Good cleanup.

>=20
> For fixed size boards -m/memdev is overkill and we need to decide what to=
 do
> with them. I see following options (in order of my preference):
>    1. Non popular: error out if -m is specified (it used to work, but not
>       anymore when check is added, i.e similar to size checks
>       introduced in this series so users have to adapt their CLI).
>       It can still use automatically created memdev but I'd ditch it on
>       those boards and use plain memory_region_init_ram().
>       This is matches well SoCs that have embedded RAM and don't really
>       care about what user may specify with -m. It would simplify
>       simple boards.

LGTM.

>=20
>    2. a path of least resistance: continue support -m and generalize
>       ram_size checks for such boards. This could use memdev since it
>       comes for free with -m support. I don't expect complications
>       with generalizing it (but one would only know for sure when
>       it's coded)
>=20
> The next this I plan to do is to clean up ram_size global and
> hopefully get rid of MachineState:ram_size as well.
>=20


