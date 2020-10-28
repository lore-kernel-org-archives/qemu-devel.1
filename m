Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF54C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017AC20809
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmP4FV8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017AC20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXeNt-0003Z5-W4
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXeMc-0002Y8-BK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 01:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXeMa-0007bb-9W
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 01:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603864270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6Q7TISp5e+cL6yW8CiWC3DDem7hGpA6tSPIFUBIeRE=;
 b=FmP4FV8ple2PtLJvqEv74uB+k4Dsw4ze/0Y/mPVnk+hqRTxV+DpheHLrqe9Px38F41wV7C
 /UXbdVLhBnPRhH1wF97GeBwqLPn5tqi1OpsCNauWMN5bETA7z2tw26GLgM5k9Zu1p7hB63
 FjpzG+GSYXs8vYIOgQc9gZIAUCAQ60Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-yBS8p-YFNlS5xLcGrvSUyQ-1; Wed, 28 Oct 2020 01:51:07 -0400
X-MC-Unique: yBS8p-YFNlS5xLcGrvSUyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E823A760C4;
 Wed, 28 Oct 2020 05:51:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-124.ams2.redhat.com [10.36.112.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09B3C5D9F1;
 Wed, 28 Oct 2020 05:51:01 +0000 (UTC)
Subject: Re: [PATCH v4 04/12] libqos/qgraph: add qos_dump_graph()
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
 <5f493b816595f0f6fe50a3f83e46432ab48d881b.1602182956.git.qemu_oss@crudebyte.com>
 <8c8c8cf1-ed97-3f27-2d0e-7440433169f7@redhat.com> <6217010.FX5ceaG2Km@silver>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <11a4d5e3-cb5d-b74d-df7e-6e5a659c63a4@redhat.com>
Date: Wed, 28 Oct 2020 06:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6217010.FX5ceaG2Km@silver>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/2020 13.24, Christian Schoenebeck wrote:
> On Samstag, 24. Oktober 2020 08:04:20 CEST Thomas Huth wrote:
>> On 08/10/2020 20.34, Christian Schoenebeck wrote:
>>> This new function is purely for debugging purposes. It prints the
>>> current qos graph to stdout and allows to identify problems in the
>>> created qos graph e.g. when writing new qos tests.
>>>
>>> Coloured output is used to mark available nodes in green colour,
>>> whereas unavailable nodes are marked in red colour.
>>>
>>> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>> ---
>>>
>>>  tests/qtest/libqos/qgraph.c | 56 +++++++++++++++++++++++++++++++++++++
>>>  tests/qtest/libqos/qgraph.h | 20 +++++++++++++
>>>  2 files changed, 76 insertions(+)
>>>
>>> diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
>>> index 61faf6b27d..af93e38dcb 100644
>>> --- a/tests/qtest/libqos/qgraph.c
>>> +++ b/tests/qtest/libqos/qgraph.c
>>> @@ -805,3 +805,59 @@ void qos_delete_cmd_line(const char *name)
>>>
>>>          node->command_line = NULL;
>>>      
>>>      }
>>>  
>>>  }
>>>
>>> +
>>> +#define RED(txt) (    \
>>> +    "\033[0;91m" txt  \
>>> +    "\033[0m"         \
>>> +)
>>> +
>>> +#define GREEN(txt) (  \
>>> +    "\033[0;92m" txt  \
>>> +    "\033[0m"         \
>>> +)
>>
>> I don't think this is very portable - and it will only make logs ugly to
>> read in text editors. Could you please simply drop these macros?
>>
>>  Thomas
> 
> The precise way I did it here is definitely unclean. And the use case is 
> trivial, so on doubt I could just drop it of course.
> 
> But allow me one attempt to promote coloured terminal output in general: These 
> are ANSI color escape sequences, a standard with its youngest revision dating 
> back to 1991. It is a well supported standard on all major platforms nowadays:
> 
> 	https://en.wikipedia.org/wiki/ANSI_escape_code
> 
> It works on macOS's standard terminal for at least 20 years, with cmd.exe on 
> Windows 10, on essentially all Linux and BSD distros, and even on many web 
> based CI platforms.
> 
> So what about introducing some globally shared macros for coloured output 
> instead? Then there would be one central place for changing coloured output 
> support for the entire code base; and I would change the macros to fallback to 
> plain text output if there is any doubt the terminal would not support it.
> 
> Besides, QEMU just switched to meson which uses coloured output as well, as do 
> clang, GCC, git and many other tools in your build chain.

Sure, colored output is nice, but we certainly also need a way to disable
it, e.g. if you want to collect the log in a file and then have a look at it
in a text editor.

 Thomas


