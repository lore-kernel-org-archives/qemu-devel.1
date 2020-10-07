Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A8C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519972173E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+AoxciV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519972173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQE0i-0006Ul-8V
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQDzT-0005u6-2K
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQDzQ-0006g9-Nu
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602094595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKiNiKEfMsdl5Zwitb5jKzxZgU2z1khYz0F3EdKbn60=;
 b=A+AoxciVYpBQ/eZowl+rABSWqQQoqKkur38w7NeX00vh3Jr3a6F+lfX886KeuenbLJyw7q
 DDBiFc1F+lRgNKTK6vqBR2xK4CX2eepM69YyGgmY5+sm1OhzAixJJtcktk5Q+u+El06C2I
 nr8HjcQpzm8+7VKe5KARjYDWGqHk0o0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-KlUPyNCROgSG1uyb1q5-og-1; Wed, 07 Oct 2020 14:16:33 -0400
X-MC-Unique: KlUPyNCROgSG1uyb1q5-og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C0384A5E1;
 Wed,  7 Oct 2020 18:16:32 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFBC65D9DD;
 Wed,  7 Oct 2020 18:16:31 +0000 (UTC)
Subject: Re: [PATCH 03/20] python/machine.py: reorder __init__
To: Kevin Wolf <kwolf@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-4-jsnow@redhat.com>
 <20201007094337.GA7212@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <4f126513-f7ae-143e-251d-d1dfa0cf6bd9@redhat.com>
Date: Wed, 7 Oct 2020 14:16:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201007094337.GA7212@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 5:43 AM, Kevin Wolf wrote:
> Am 07.10.2020 um 01:58 hat John Snow geschrieben:
>> Put the init arg handling all at the top, and mostly in order (deviating
>> when one is dependent on another), and put what is effectively runtime
>> state declaration at the bottom.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/qemu/machine.py | 44 ++++++++++++++++++++++++------------------
>>   1 file changed, 25 insertions(+), 19 deletions(-)
>>
>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>> index 3017ec072df..71fe58be050 100644
>> --- a/python/qemu/machine.py
>> +++ b/python/qemu/machine.py
>> @@ -84,42 +84,54 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>>           @param monitor_address: address for QMP monitor
>>           @param socket_scm_helper: helper program, required for send_fd_scm()
>>           @param sock_dir: where to create socket (overrides test_dir for sock)
>> -        @param console_log: (optional) path to console log file
>>           @param drain_console: (optional) True to drain console socket to buffer
>> +        @param console_log: (optional) path to console log file
>>           @note: Qemu process is not started until launch() is used.
>>           '''
>> +        # Direct user configuration
>> +
>> +        self._binary = binary
>> +
>>           if args is None:
>>               args = []
>> +        # Copy mutable input: we will be modifying our copy
>> +        self._args = list(args)
>> +
>>           if wrapper is None:
>>               wrapper = []
>> -        if name is None:
>> -            name = "qemu-%d" % os.getpid()
>> -        if sock_dir is None:
>> -            sock_dir = test_dir
>> -        self._name = name
>> +        self._wrapper = wrapper
>> +
>> +        self._name = name or "qemu-%d" % os.getpid()
>> +        self._test_dir = test_dir
>> +        self._sock_dir = sock_dir or self._test_dir
>> +        self._socket_scm_helper = socket_scm_helper
> 
> Interesting that you use a shortcut with 'or' for name and sock_dir,
> but you don't have 'wraper or []' and 'args or []' above.
> 
> It's not wrong, of course, but if you have to respin for another reason,
> maybe an inconsistency to address.
> 

This winds up being because ... I delete those lines of code later. I 
very often have this problem where I clean up a bunch of stuff, and then 
split out that giant commit into a series.

Sometimes that causes stuff like this.

> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> 

Thanks!


