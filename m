Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04849C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3EF320714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTCt5+B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3EF320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6FiJ-0007eE-0q
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 10:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6FhH-0007Ac-8H
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6FhD-0003Dx-Jy
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:31:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6FhD-0003Dn-9x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582558258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmoEq3RXWdI8CGFYdBJSvwVVvYJ2ve0Vi7IHeg5zS4I=;
 b=GTCt5+B41xHo64rxJll6bNXbZWvAY2WSkJdwO/8ISLKi9gHPKL5U3UgIGEVv7F/5qk9eCA
 1L9tYMqkZWj6rx65iAipvOL8+5GKjmSjwPO4pPknFD1FywJPf4vFh/7QFL3lahy2lXU6n5
 CgV16aJuUdcVu/CXZMMIureG0oWmE24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Zj0_nHJgPGK5RwQpc3SJSA-1; Mon, 24 Feb 2020 10:30:56 -0500
X-MC-Unique: Zj0_nHJgPGK5RwQpc3SJSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6CC618B9FC1;
 Mon, 24 Feb 2020 15:30:55 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 720778B77E;
 Mon, 24 Feb 2020 15:30:52 +0000 (UTC)
Subject: Re: [PATCH v31 20/22] Add rx-softmmu
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200223065102.61652-1-ysato@users.sourceforge.jp>
 <20200223065102.61652-21-ysato@users.sourceforge.jp>
 <da7b0c50-4466-a491-8487-2c3a11984077@redhat.com>
 <598cc17a-9686-e9c5-72b5-5153d29d5a52@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fa92ac6a-fff9-e2be-ba7e-2463eec01c6c@redhat.com>
Date: Mon, 24 Feb 2020 09:30:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <598cc17a-9686-e9c5-72b5-5153d29d5a52@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: richard.henderson@linaro.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 9:15 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/24/20 4:11 PM, Eric Blake wrote:
>> On 2/23/20 12:51 AM, Yoshinori Sato wrote:
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Message-Id: <20190607091116.49044-17-ysato@users.sourceforge.jp>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> pick ed65c02993 target/rx: Add RX to SysEmuTarget
>>> pick 01372568ae tests: Add rx to machine-none-test.c
>>> [PMD: Squashed patches from Richard Henderson modifying
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/common.json and tests/machine=
-none-test.c]
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>
>>> +++ b/qapi/machine.json
>>> @@ -26,7 +26,7 @@
>>> =C2=A0=C2=A0=C2=A0 'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa'=
, 'i386',=20
>>> 'lm32',
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>>
>> Missing mention of the new enum member with a 'since 5.0' designation=20
>> in the documentation.
>=20
> Is this something we can automate? Maybe dumping all the qapi data when=
=20
> we do a release, then check the differences before the next release?

Probably. It's already easy to automate a dump of qmp introspection data=20
from an arbitrary commit, and diffing the output between the previous=20
commit release point and the current proposed release should be=20
technically possible.  Our QAPI generator also generates the docs, which=20
means it can be enhanced to denote which doc elements are tagged to=20
which versions.  Might make a good GSOC project.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


