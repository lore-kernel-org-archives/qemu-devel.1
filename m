Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8DBC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE09C221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eB4UmWlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE09C221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8g3-0004hH-76
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV8f5-0003iI-LQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV8f3-00050E-DW
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603265751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OW9JVv7OxWuX4l8G++hvCB2kH9NwpTaC7OPnfwAXnWw=;
 b=eB4UmWlEeErQHSo6UZnVq4n1sZE4SP+lZJZJj9yfzs20nzOLF+ZDKS4UXCRYHKVUcxKksR
 o/17Rso1CRd2uq2sB7cwaks0q3fKz69Qhz88MX7QGnyd3+b0Q0aIyuXDlYvUhLfuvYQfYi
 kc9W+oX3C1O1NbxnnDgIdBIbsyFOGl8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-I6NkRrp3O4G284Eze9wCCQ-1; Wed, 21 Oct 2020 03:35:49 -0400
X-MC-Unique: I6NkRrp3O4G284Eze9wCCQ-1
Received: by mail-wr1-f71.google.com with SMTP id t17so1127107wrm.13
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 00:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OW9JVv7OxWuX4l8G++hvCB2kH9NwpTaC7OPnfwAXnWw=;
 b=E04ZV5SoaPLxAfYIuMN4KtRb5fYH9rRcIAeVqggnj0WeKLOUOgtb7qs+btK+DbmzOD
 9jb3QQSFZBTBh/ljtgkgV2isL8pVv1VF7RaACMYKyvAbpL0XCCgZx1Q71VSODu1B8Fcu
 tlDo+wjfX4LofESpXQB1SNa89QaJXEFOlR/1TbAkDBtEOKwGTFWX9Nn/BWWZ2CjMAUCK
 kqL1eeFNfQNIPT1zQytMjPRd7kTBUKciqCO3IeonOSh/v7OX6LqsborSMYzA9H75GqOS
 byYOhmFVBis62mLx1MtmDmM726UwF/GiBmgboqa1k2XIjkD6aIcGJ3xi73n/m2wQEks5
 fjNA==
X-Gm-Message-State: AOAM532eh5LmEImpYCuFgHND4XvZhSXt9nK5ALxMP5Na2Hujka+DMBEm
 BWlKp2MKpzkkeirTf9FRg9tolmiwLM4ATcQKXvSCl35Q8fjMgtsyIcY7V85Cs2ukiktokbIhntF
 xaOxiHurHPL3cghk=
X-Received: by 2002:a1c:2803:: with SMTP id o3mr1685443wmo.97.1603265748197;
 Wed, 21 Oct 2020 00:35:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8oibj/d1UcTNkQ/cF3VZKk22ESGQvx19oqFHN0cO9XasW/odtVt/3Uo/HCy+d7VDKIG8UIg==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr1685429wmo.97.1603265748002;
 Wed, 21 Oct 2020 00:35:48 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 24sm1929576wmg.8.2020.10.21.00.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 00:35:47 -0700 (PDT)
Subject: Re: [PATCH 4/4] qga: Flatten simple union GuestDeviceId
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201021071520.2168877-1-armbru@redhat.com>
 <20201021071520.2168877-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9e47fde8-dd66-d0c0-e4e8-cd33e764a81f@redhat.com>
Date: Wed, 21 Oct 2020 09:35:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021071520.2168877-5-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 9:15 AM, Markus Armbruster wrote:
> Simple unions are simpler than flat unions in the schema, but more
> complicated in C and on the QMP wire: there's extra indirection in C
> and extra nesting on the wire, both pointless.  They should be avoided
> in new code.
> 
> GuestDeviceId was recently added for guest-get-devices.  Convert it to
> a flat union.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/qapi-schema.json | 8 ++++++++
>   qga/commands-win32.c | 9 ++++-----
>   2 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


