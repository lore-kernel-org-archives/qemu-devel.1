Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F89AC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350E3214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 17:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350E3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgBze-0005to-4R
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 13:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgBy8-0005G0-Gv
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:44:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgBy4-000580-6K
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:44:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgBy2-00054r-G2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 13:44:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so2950630wma.4
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 10:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zDGCPfWr/LJdpehnnuRDYEz90rfUeUQj6/NKawLKErg=;
 b=lpB6VhMlUdO5FyG9oL/HfJ1jQ3M6/a3ljMehjNT28tfpZbq0ocjUMpZ550olR/9s0H
 bVa73wi3pz0gWggB3Rybh4bf4nHBqDlPJp+zsHliqYWIrLKJH80H7dTYxtaUnM0F2nmj
 J7MOITQSFpD6suQ7Xsoi1ni+D5RRjf1sSGliZbWQeubOpvHDafXMmOCxCkpI1M3FBnxV
 jMyKAQE2DxJZZHgpwmwRbwN7ArwwTU+77ZCxZf9+DkGne/vP9FthjfHDYZWiarTJGytf
 NxPdUGLCSXsJjqibmDwJLhgxkFnTP6+PlPIGgnkZUmb3mjAQbA+WCGu2TXA1Ql1hHdds
 Nbmw==
X-Gm-Message-State: APjAAAXvVWFopveBufQnzu1/ZMHLalIOmGM3dbFpqNFc2nGn/v5ukT41
 +DgPcEQo7LIi1M3SbcPVtGQ+Ew==
X-Google-Smtp-Source: APXvYqy75Lvm0rt4DWdL++JuE21YNiRCtGr+jlgD5X/nBytF/BXzWBWpAPwOpx7nFLMpqibEVm2gdg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr112228wma.123.1561571059654;
 Wed, 26 Jun 2019 10:44:19 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z17sm14938624wru.21.2019.06.26.10.44.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 10:44:19 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>
References: <20190625123905.25434-1-dinechin@redhat.com>
 <20190626164913.dn2vfv4rji7xsk5k@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0458fb96-33d8-05eb-cb41-cf19086f986b@redhat.com>
Date: Wed, 26 Jun 2019 19:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626164913.dn2vfv4rji7xsk5k@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2] Fix build error when VNC is configured
 out
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 6:49 PM, Stefano Garzarella wrote:
> On Tue, Jun 25, 2019 at 02:39:05PM +0200, Christophe de Dinechin wrote:
>> In hmp_change(), the variable hmp_mon is only used
>> by code under #ifdef CONFIG_VNC. This results in a build
>> error when VNC is configured out with the default of
>> treating warnings as errors:
>>
>> monitor/hmp-cmds.c: In function ‘hmp_change’:
>> monitor/hmp-cmds.c:1946:17: error: unused variable ‘hmp_mon’ [-Werror=unused-variable]
>> 1946 |     MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
>>      |                 ^~~~~~~
>>
>> v2: Move variable down as suggested by Philippe Mathieu-Daudé
> 
> Should we move out this line from the commit message?
> (Maybe Dave can remove it when apply)

Yes please :) It was meant to go after the '---' separator.

>>
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>>  monitor/hmp-cmds.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

