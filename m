Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78876C35677
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F394246A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 13:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Isc/h6RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F394246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7JPA-0003ij-EF
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 08:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7JOU-0003C5-Uj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7JOT-0003p6-Mb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:40:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42192
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7JOT-0003ol-6d
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 08:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582810800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00Xvvcne0a2bZP24xRLFlqa6OkLbBnvYnXi7BQeWfLg=;
 b=Isc/h6RMCI9z1+S5jahbJH9J26VkUGjfbFTZCFP0x++s3EbmLYRc3GYrdRq4J/Y0BR1Ysc
 EyHygEiHPjrhYdQJyPQL50YWm+oq1uEkszeUEcJsqeFEKX8D2oSJu0aV7E3/g1Dx/UG3KV
 p5ehVxSKjHUH/5rxpeGkUN7qq7Rrdog=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-OkmnqGRNObuTN7nxz0M8yg-1; Thu, 27 Feb 2020 08:39:58 -0500
X-MC-Unique: OkmnqGRNObuTN7nxz0M8yg-1
Received: by mail-wr1-f70.google.com with SMTP id m13so1333639wrw.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 05:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U3Ga6jqRiKmpuG2rdpslMT7u0tkzi8JnTkkvU2/aVPs=;
 b=OBJYr0PzqELn1rAE9FKcglEITE4F/uM7Ig3TKwe0ts6XRkee9IqKMYZjmhmQf3FVvf
 AiaecgT9OziFMHEZCXaqJ2BVRI0sl2KzZNC9xegxs/Ddr6iYl0CGu0DYcnhyOApWNscM
 S430HGoUb0ECC8aP9awFzUXWDaj2PoTKn6LvxnPD8izkZ+I/kIM0nRSm2Z/vOstW2T+M
 BohSJabrhZ+tV5WBfmFFbSfuLhVQU1vWeJZpUaVvi5FrCe+eQCFNRwY8HRAVZDxYKC08
 JagRch0STBSHEiTQWZycdd6h0tWTD24OuAH+S581fk9MyrnkHLDufnm8lrA2GSyBG3SP
 1Eqg==
X-Gm-Message-State: APjAAAX34m9kmnFS86jHSldhPZ6xft/Dld2/SMIdJOEt+qklRmhdl4uH
 9NeWpCVk63aK/jPN03b4mQAOmhbL4O6HoRVHejlLpn2yo37oLrfRkJ5NU/d7ZW1LvfeW1Ti4P2D
 zuet7uOFH1LfL5L8=
X-Received: by 2002:a7b:c939:: with SMTP id h25mr5397213wml.106.1582810797477; 
 Thu, 27 Feb 2020 05:39:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFpana2wmSzYHblBMH7fAhFiicW+KQ23F92/rIg3U0DP1d96rrIltvbb3vh/I55ZrZL9cQAA==
X-Received: by 2002:a7b:c939:: with SMTP id h25mr5397192wml.106.1582810797202; 
 Thu, 27 Feb 2020 05:39:57 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id d4sm6562842wmb.48.2020.02.27.05.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 05:39:56 -0800 (PST)
Subject: Re: [PATCH] qapi/machine: Place the 'Notes' tag after the 'Since' tag
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org
References: <20200227104153.29425-1-philmd@redhat.com>
 <24ca5661-7707-1413-c910-e531e89488b0@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f910e96d-cef9-e001-ead8-69e3ef3125d1@redhat.com>
Date: Thu, 27 Feb 2020 14:39:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24ca5661-7707-1413-c910-e531e89488b0@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 12:59 PM, Liam Merwick wrote:
> On 27/02/2020 10:41, Philippe Mathieu-Daud=C3=A9 wrote:
>> This fixes when adding a 'Since' tag:
>>
>> =C2=A0=C2=A0 In file included from qapi/qapi-schema.json:105:
>> =C2=A0=C2=A0 qapi/machine.json:25:1: '@arch:' can't follow 'Notes' secti=
on
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 qapi/machine.json | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 6c11e3cf3a..2b4f5f0962 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -16,11 +16,11 @@
>> =C2=A0 # individual target constants are not documented here, for the ti=
me
>> =C2=A0 # being.
>> =C2=A0 #
>> +# Since: 3.0
>> +#
>> =C2=A0 # Notes: The resulting QMP strings can be appended to the=20
>> "qemu-system-"
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefix to produce the=
 corresponding QEMU executable name. This
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is true even for "qem=
u-system-x86_64".
>> -#
>> -# Since: 3.0
>> =C2=A0 ##
>> =C2=A0 { 'enum' : 'SysEmuTarget',
>> =C2=A0=C2=A0=C2=A0 'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa',=
 'i386', 'lm32',
>>
>=20
>=20
> Does the same issue occur for @CpuInstanceProperties: at line 829?
> The 'Since:' follows a 'Note:' section (but maybe the singular usage is=
=20
> intended).

Ah thanks for checking other cases. Yes, the same error should occur.

>=20
> otherwise
>=20
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Thanks! I'll respin with the other entry fixed.


