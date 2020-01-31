Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787B7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4219620705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euXXSBJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4219620705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixWdb-0004nj-E6
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixWcv-0004MU-8L
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixWcs-00072U-MR
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:46:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixWcs-0006ys-Ei
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580478385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YrAxMy1LJJA4ZNtF7ua7xyxcnOesCrS1xcjWttmltas=;
 b=euXXSBJv80z8xOD9qovXDrei/W69WTyJp7wQyCFq3VxHzI8ZTmEJNLjWeR+gAWzHTeBpAd
 pfSTxHy9w1YnHOFYyGQQ0yoHoPvE6oYsQ+KSmnunrOl3H8JjyMhh+14sLT9WzTfVjqRx21
 DIWNeOxe0lka3V8JD2RzvMYzzANaB88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Wv0xjWdNOSG-r6xWVI6IoA-1; Fri, 31 Jan 2020 08:46:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D59C61005502;
 Fri, 31 Jan 2020 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D917B1001B28;
 Fri, 31 Jan 2020 13:46:11 +0000 (UTC)
Subject: Re: [PATCH v2 29/29] MAINTAINERS: Add Acceptance tests reviewers
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-30-philmd@redhat.com>
 <0eda4471-7daa-c578-dbac-54817d1f40b1@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <d8ac6389-f4d3-7886-37f7-decd4676d8e1@redhat.com>
Date: Fri, 31 Jan 2020 11:46:09 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0eda4471-7daa-c578-dbac-54817d1f40b1@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Wv0xjWdNOSG-r6xWVI6IoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/30/20 6:41 AM, Thomas Huth wrote:
> On 29/01/2020 22.23, Philippe Mathieu-Daud=C3=A9 wrote:
>> Acceptance tests can test any piece of the QEMU codebase.
>> As such, the directory holding them does not belong to a specific
>> subsystem with designated maintainers.
>>
>> Each subsystem covered by a test is welcomed to add the test path
>> to its section.
>> See for example commits 71b290e70, b11785ca2 or 5d480ddde.
>>
>> Since Eduardo, Cleber and Philippe have been reviewing the patches
>> on the list, add them as reviewers.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Wainer do you want to be listed?

Yes sir, please consider my name for reviewer of all tests/acceptance.

>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index efd3f3875f..4a3cc3f137 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2733,6 +2733,12 @@ S: Maintained
>>   F: tests/tcg/Makefile
>>   F: tests/tcg/Makefile.include
>>  =20
>> +Acceptance Tests
>> +R: Eduardo Habkost <ehabkost@redhat.com>
>> +R: Cleber Rosa <crosa@redhat.com>
>> +R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> +F: tests/acceptance/
> Many files under tests/acceptance/ are not covered by a maintainer at
> all, e.g.:
>
>   $ scripts/get_maintainer.pl -f tests/acceptance/boot_linux_console.py
>   get_maintainer.pl: No maintainers found, printing recent contributors.

I'll maintain tests/acceptance/linux_initrd.py, that I created.

Also I feel comfortable on co-maintaining=20
tests/acceptance/avocado_qemu/. Cleber?

The migration.py, virtio_version.py, version.py,=20
virtio_seg_max_adjust.py tests can be put in my account if no one else=20
step up.


> ... so I think it would be good to have someone who feels at least a
> little bit responsible to do the maintainers work here and picks up
> patches to put them into a pull request. Any volunteers?

Cleber has pulled the Python + Acceptance patches. Maybe we just need to=20
turn it official in the MAINTAINERS?

Thanks,

Wainer

>
>   Thomas


