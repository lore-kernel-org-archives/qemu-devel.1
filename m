Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8AC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D7620575
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="uH/3Bmx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D7620575
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jToPm-0003pA-D1
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jToPE-0003NH-V3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jToPD-0003Cg-RR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:13:48 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:53026)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jToPD-0003CY-0m
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:13:47 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
 by mail1.hostfission.com (Postfix) with ESMTP id C5F944F065;
 Thu, 30 Apr 2020 01:13:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1588173224;
 bh=s154aJS3KOt0aIBxSGcgSziVD3WU+OJWlcaVJIlpXlY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uH/3Bmx6KenTSvivM7TT1HsDEu4yi0qBS/gwWAmL2vL9x4j2tjZGodU8FWOVHAIRp
 1dFwr3Tm5iyURIZnbeAclwJCBKGtgotK0/gQranRyjQlCD+4SyAzYtg4Am3vYY4nY0
 ll6xGny/oGi70eh2DTfwdGo8ZXb/ztRuY8sWj6P4=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
 by www1.hostfission.com (Postfix) with ESMTP id B9DF580B8A;
 Thu, 30 Apr 2020 01:13:44 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Apr 2020 01:13:44 +1000
From: Geoffrey McRae <geoff@hostfission.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] audio/jack: add JACK client audiodev
In-Reply-To: <ad3a2a08-1995-62cb-edf6-b8f25e78b121@redhat.com>
References: <20200429073149.6A1953C0D11@aeryn.lan.ktmba>
 <ad3a2a08-1995-62cb-edf6-b8f25e78b121@redhat.com>
Message-ID: <2715dfcd7c13ea591cb0250709e6b1d1@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 11:13:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 139.99.139.48
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020-04-29 22:59, Eric Blake wrote:
> On 4/29/20 12:53 AM, Geoffrey McRae wrote:
>> This commit adds a new audiodev backend to allow QEMU to use JACK as
>> both an audio sink and source.
>> 
>> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
>> ---
>>   audio/Makefile.objs    |   5 +
>>   audio/audio.c          |   1 +
>>   audio/audio_template.h |   2 +
>>   audio/jackaudio.c      | 615 
>> +++++++++++++++++++++++++++++++++++++++++
>>   configure              |  17 ++
>>   qapi/audio.json        |  50 +++-
> 
> Focusing just on UI:
> 
>> +++ b/qapi/audio.json
>> @@ -152,6 +152,51 @@
>>       '*out':     'AudiodevPerDirectionOptions',
>>       '*latency': 'uint32' } }
>>   +##
>> +# @AudiodevJackPerDirectionOptions:
>> +#
>> +# Options of the JACK backend that are used for both playback and
>> +# recording.
>> +#
>> +# @server_name: select from among several possible concurrent server 
>> instances.
>> +# If unspecified, use "default" unless $JACK_DEFAULT_SERVER is 
>> defined in the
>> +# process environment.
> 
> Our convention is to prefer '-' over '_' except in cases of
> pre-existing consistency.  This should be 'server-name' unless you
> have an example of what we have to be consistent with.

No reason at all just didn't think about it, I will correct it :)

> 
>> +#
>> +# @client_name: the client name to use. The server will modify this 
>> name to
>> +# create a unique variant, if needed unless @exact_name is true.
>> +#
>> +# @start_server: set to true to start a jack server instance if one 
>> is not
>> +# present.
>> +#
>> +# @exact_name: use the exact name requested otherwise JACK 
>> automatically
>> +# generates a unique one, if needed.
> 
> Ditto for these three.
> 
>> +#
>> +# Since: 4.0
> 
> The earliest this will be added is 5.1, not 4.0.

Yup, copy & paste error :)

> 
>> +##
>> +{ 'struct': 'AudiodevJackPerDirectionOptions',
>> +  'base': 'AudiodevPerDirectionOptions',
>> +  'data': {
>> +    '*server_name':  'str',
>> +    '*client_name':  'str',
>> +    '*start_server': 'bool',
>> +    '*exact_name':   'bool' } }
>> +
>> +##
>> +# @AudiodevJackOptions:
>> +#
>> +# Options of the JACK audio backend.
>> +#
>> +# @in: options of the capture stream
>> +#
>> +# @out: options of the playback stream
>> +#
>> +# Since: 4.0
> 
> 5.1
> 
>> +##
>> +{ 'struct': 'AudiodevJackOptions',
>> +  'data': {
>> +    '*in':  'AudiodevJackPerDirectionOptions',
>> +    '*out': 'AudiodevJackPerDirectionOptions' } }
>> +
>>   ##
>>   # @AudiodevOssPerDirectionOptions:
>>   #
>> @@ -300,8 +345,8 @@
>>   # Since: 4.0
>>   ##
>>   { 'enum': 'AudiodevDriver',
>> -  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 
>> 'sdl',
>> -            'spice', 'wav' ] }
>> +  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'jack', 'oss', 
>> 'pa',
>> +            'sdl', 'spice', 'wav' ] }
> 
> It's worth adding a doc comment that @jack was added in 5.1 (I didn't
> check if audio.json has an example of adding to an enum, but other
> .json files do)

No worries, I will see if I can figure this out.

-Geoff

