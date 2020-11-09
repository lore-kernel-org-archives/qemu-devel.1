Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEEEC4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A967206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rwzby3yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A967206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc35g-0006U7-DC
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc33i-0004oP-FD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc33f-0004NZ-Ns
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLYQAJPSPktNj5DggqUTqi+9jWIuZagVp3ExwXuFdYE=;
 b=Rwzby3ycNVnIURufp+7ogMis9OquQQXNscJZkoDdMm+d37N3rv8XPIUxDbnvkjprbu9Fhz
 lCwgcQlYxHfn2PiKp5f7NaxRx3IaIxqvPiEc7K/dfZHyp0vr39TEQPXDERPmr8P8Ou68ZH
 oOxA6uGc0x5qEh90IPEMm/ULef8Z/C0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-faGU0AwSOFuQqb3n4rRccA-1; Mon, 09 Nov 2020 04:01:48 -0500
X-MC-Unique: faGU0AwSOFuQqb3n4rRccA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 041BE106B20A
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 09:01:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6D355C1D7;
 Mon,  9 Nov 2020 09:01:40 +0000 (UTC)
Subject: Re: [PATCH] meson: always include contrib/libvhost-user
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20201106210340.698771-1-stefanha@redhat.com>
 <21c2fe85-1715-772e-e1f6-fbbf8157fcbe@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ff81fdfe-72a2-1d14-e46a-9a69b22a059d@redhat.com>
Date: Mon, 9 Nov 2020 10:01:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <21c2fe85-1715-772e-e1f6-fbbf8157fcbe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2020 16.54, Philippe Mathieu-Daudé wrote:
> On 11/6/20 10:03 PM, Stefan Hajnoczi wrote:
>> libvhost-user is needed when CONFIG_LINUX is set. The CONFIG_VHOST_USER
>> check in meson.build is incorrect.
>>
>> In fact, no explicit check is needed since this dependency is not built
>> by default. If something declares a dependency on libvhost-user then it
>> will be built, otherwise it won't be built (i.e. on non-Linux hosts).
>>
>> This fixes ./configure --disable-vhost-user && make.
>>
>> Fixes: bc15e44cb2191bbb2318878acdf5038134e56394 ("configure: introduce --enable-vhost-user-blk-server")
>> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reported-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  meson.build | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index f5175010df..b473620321 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1450,11 +1450,7 @@ trace_events_subdirs += [
>>    'util',
>>  ]
>>  
>> -vhost_user = not_found
>> -if 'CONFIG_VHOST_USER' in config_host
>> -  subdir('contrib/libvhost-user')
>> -endif
>> -
>> +subdir('contrib/libvhost-user')
> 
> I haven't reviewed what this code does, but testing it I see:
> 
>  $ ../configure --disable-vhost-user
> 
>         vhost-user support: YES
> 
> which doesn't look correct...

I think it's a bug in meson.build: It says "vhost-user" but then uses the
CONFIG_VHOST_KERNEL switch instead. I just sent a patch to fix this.

 Thomas


