Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4747820709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9Q+0oT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4747820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXEG-0006Ih-Hc
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZXA9-0001KG-8X
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:01:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54757
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZXA6-0006l6-O6
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589536908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=bTeCTGlmh/Dp4Gi8hbaNwFnuBpD45q2MR6XmJ7j/PRQ=;
 b=J9Q+0oT5sfLbuQx2u2UF1sRo97yOc/EoNRh6vyhzy8f5YH0hkt/Kuc9tUpGwLd2hGD4Geq
 j2xr8oJ339lSMp6MexikD4G85Zn2xvnhF7oH9BpVXSBHvyvJ2NZoN4166WZfwAd6RQsJxW
 9OEHLCtEX+yr3vkqvP1dtZvcT2Y+IuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-qtWwUGgZP2y-22zpaw9nvg-1; Fri, 15 May 2020 06:01:46 -0400
X-MC-Unique: qtWwUGgZP2y-22zpaw9nvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8AE58015CE;
 Fri, 15 May 2020 10:01:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-42.ams2.redhat.com [10.36.113.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D2CE1059583;
 Fri, 15 May 2020 10:01:43 +0000 (UTC)
Subject: Re: [PATCH 2/3] docs/s390x: document 3270
To: Cornelia Huck <cohuck@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
 <20200505135025.14614-3-cohuck@redhat.com>
 <4ea47ea1-04d5-3073-fef6-5af07f06a4d6@redhat.com>
 <20200515110007.1676b17d.cohuck@redhat.com>
 <b6acb966-16f2-605d-6d01-70f6085bfa79@redhat.com>
 <20200515114511.2ac852f3.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d266a6a4-09c6-ee70-2d7c-f01dc0468cf5@redhat.com>
Date: Fri, 15 May 2020 12:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515114511.2ac852f3.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/2020 11.45, Cornelia Huck wrote:
> On Fri, 15 May 2020 11:14:40 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 15/05/2020 11.00, Cornelia Huck wrote:
>>> On Fri, 15 May 2020 09:29:42 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>   
>>>> On 05/05/2020 15.50, Cornelia Huck wrote:  
>>>>> Add some basic info how to use 3270 devices.
>>>>>
>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>> ---
>>>>>  docs/system/s390x/3270.rst   | 32 ++++++++++++++++++++++++++++++++
>>>>>  docs/system/target-s390x.rst |  1 +
>>>>>  2 files changed, 33 insertions(+)
>>>>>  create mode 100644 docs/system/s390x/3270.rst
>>>>>
>>>>> diff --git a/docs/system/s390x/3270.rst b/docs/system/s390x/3270.rst
>>>>> new file mode 100644
>>>>> index 000000000000..e367a457e001
>>>>> --- /dev/null
>>>>> +++ b/docs/system/s390x/3270.rst
>>>>> @@ -0,0 +1,32 @@
>>>>> +3270 devices
>>>>> +============
>>>>> +
>>>>> +With the aid of the ``x3270`` emulator, QEMU provides limited support
>>>>> +for making a single 3270 device available to a guest. Note that this
>>>>> +supports basic features only.    
>>>>
>>>> The first sentence sounds somewhat confusing. Maybe rather something like:
>>>>
>>>> QEMU can emulate a 3270 device attached to a guest, which then can be
>>>> used with a program like ``x3270`` to get a traditional 3270 terminal
>>>> for your guest.  
>>>
>>> But QEMU actually relies on x3270 (or a comparable program). It only
>>> emulates the basic ccw plumbing; for the actual protocol (beyond
>>> negotiating tn3270), it relies on the emulation done by x3270.  
>>
>> Ok, makes sense now. Maybe something like:
>>
>> QEMU provides the possibility to connect an external 3270 terminal
>> emulator (like ``x3270``) to a guest?
> 
> Hm...
> 
> "QEMU supports connecting an external 3270 terminal emulator (such as
> ``x3270``) to make a single 3270 device available to a guest. Note that
> this supports basic features only."
> 
> ?

Yes, that sounds good!

 Thanks,
  Thomas



