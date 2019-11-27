Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CCC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164A42068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN69h//r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164A42068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZy9Y-0004lP-0T
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iZy84-00031A-7P
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iZy2U-0002OT-IV
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:11:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iZy2U-0002No-FC
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574863890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N0ObXoAIb4su5pxa/7XAiP9rWTPCAiRGcYijo4fSzgk=;
 b=HN69h//rkWwnrdjjeScKU5b7CIon8OxChMO+58G6OtxD0OXyBrmthywV/KfBZpjdaWGcHT
 Z+R2KEqYrRTXuKn0g0WLcEhzsQXA5siYlpQp96TxJGh8AetEjv+rEXzMDBjCqmIdMHmjDv
 XEc7BDR71QuyIiIfWXBwmOCuQXo3FDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Y_41d09sM0SV3f7EH7YsVw-1; Wed, 27 Nov 2019 09:11:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C97D6107B7F6;
 Wed, 27 Nov 2019 14:11:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-186.ams2.redhat.com [10.36.117.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62BF5600C8;
 Wed, 27 Nov 2019 14:11:21 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] iotests: Enable more tests in the 'auto' group to
 improve test coverage
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191022072135.11188-1-thuth@redhat.com>
 <20191022072135.11188-6-thuth@redhat.com> <87ftjimm3x.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <560628a7-56ff-ff5f-a716-1edc50abba23@redhat.com>
Date: Wed, 27 Nov 2019 15:11:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87ftjimm3x.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Y_41d09sM0SV3f7EH7YsVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/2019 13.14, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
> <snip>
>>
>> According to Max, it would be good to have a test for iothreads and
>> migration. 127 and 256 seem to be good candidates for iothreads. For
>> migration, let's enable 091, 181, and 203 (which also tests iothreads).
> <snip>
>> @@ -112,7 +112,7 @@
>>   088 rw quick
>>   089 rw auto quick
>>   090 rw auto quick
>> -091 rw migration
>> +091 rw auto migration
>=20
>=20
> This is breaking consistently on my ZFS machine:
>=20
> TEST    iotest-qcow2: 091 [fail]

OK, I'll drop 091 again from the auto group in the next version of this=20
series.

  Thomas


