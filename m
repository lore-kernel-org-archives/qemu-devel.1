Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02B7C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD3320B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD3320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCyx-0004Aj-Tm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZBtS-0002wq-P2
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZBtR-0007wq-Dc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:14:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZBtR-0007p4-7P
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:14:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so3734354wme.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 03:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w6MLFdyXzsxswSaJ+3Smo2OE+iR0K0ijlSTDGRKcR80=;
 b=tN6/p7yOpOI3rzCRV05HLaam8uPcU02AQav0/7kwjXGdevYdPQzvQyI7N4QtoqWuG2
 xBCTM//5k4WGCRb7qJLwXZwGz173IQ58lzENBmkjqDNWAQ2MsjYtLDNsVHVDxumAT1i+
 kUjfgfCKg00ZOogTqFlKkzmPkoFKnradadybjwiFgtW43v1fxhbVVfw4AFuLKhS95FmK
 6YHnaAZ/gDJcqag9ZLvEXOGzMMQma647t2NB0GMuHj89ZcKan0ZaeONdimBLgJk1pZAj
 Wdd/83BpEov2YWXhA7YANzaMOiCglGnqEBlYXxCuuLMovb4C51bFVmusnmmJRftriC+T
 B5OA==
X-Gm-Message-State: APjAAAXAPLMFpgIDB2qDVj53bX1N5MGRcqvaf47uZd4MWUzcVgrzhdMG
 yKWkRbX99Bk6yZYHzxVY36ZsBA==
X-Google-Smtp-Source: APXvYqw+0Ac2W3IV/Nwj+kueolIOI5HdHLnc8ARXjZOaXFv8OxYbKnX+WCQc18kAd7ov154rfIC+Zg==
X-Received: by 2002:a1c:a648:: with SMTP id p69mr2975070wme.155.1559902478856; 
 Fri, 07 Jun 2019 03:14:38 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id s11sm1286044wro.17.2019.06.07.03.14.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 03:14:38 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Pino Toscano <ptoscano@redhat.com>
References: <20190605213654.9785-1-ptoscano@redhat.com>
 <20190606111232.GG14300@redhat.com>
 <3631777.4JPVOlAZr6@lindworm.usersys.redhat.com>
 <20190607100810.GB28838@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a42dbdce-3e03-d27c-7d28-f15d668848ae@redhat.com>
Date: Fri, 7 Jun 2019 12:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607100810.GB28838@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v6] ssh: switch from libssh2 to libssh
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
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, rjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 12:08 PM, Daniel P. Berrangé wrote:
> On Thu, Jun 06, 2019 at 07:51:15PM +0200, Pino Toscano wrote:
>> On Thursday, 6 June 2019 13:12:32 CEST Daniel P. Berrangé wrote:
>>> On Wed, Jun 05, 2019 at 11:36:54PM +0200, Pino Toscano wrote:
>>>> Rewrite the implementation of the ssh block driver to use libssh instead
>>>> of libssh2.  The libssh library has various advantages over libssh2:
>>>> - easier API for authentication (for example for using ssh-agent)
>>>> - easier API for known_hosts handling
>>>> - supports newer types of keys in known_hosts
>>>>
>>>> Use APIs/features available in libssh 0.8 conditionally, to support
>>>> older versions (which are not recommended though).
>>>
>>>
>>>>
>>>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>>>> ---
>>>>
>>>> Changes from v5:
>>>> - adapt to newer tracing APIs
>>>> - disable ssh compression (mimic what libssh2 does by default)
>>>> - use build time checks for libssh 0.8, and use newer APIs directly
>>>>
>>>> Changes from v4:
>>>> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
>>>> - fix few return code checks
>>>> - remove now-unused parameters in few internal functions
>>>> - allow authentication with "none" method
>>>> - switch to unsigned int for the port number
>>>> - enable TCP_NODELAY on the socket
>>>> - fix one reference error message in iotest 207
>>>>
>>>> Changes from v3:
>>>> - fix socket cleanup in connect_to_ssh()
>>>> - add comments about the socket cleanup
>>>> - improve the error reporting (closer to what was with libssh2)
>>>> - improve EOF detection on sftp_read()
>>>>
>>>> Changes from v2:
>>>> - used again an own fd
>>>> - fixed co_yield() implementation
>>>>
>>>> Changes from v1:
>>>> - fixed jumbo packets writing
>>>> - fixed missing 'err' assignment
>>>> - fixed commit message
>>>>
>>>>  block/Makefile.objs        |   6 +-
>>>>  block/ssh.c                | 610 +++++++++++++++++++------------------
>>>>  block/trace-events         |  14 +-
>>>>  configure                  |  62 ++--
>>>>  tests/qemu-iotests/207.out |   2 +-
>>>>  5 files changed, 351 insertions(+), 343 deletions(-)
>>>
>>>
>>>> diff --git a/configure b/configure
>>>> index b091b82cb3..bfdd70c40a 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>
>>>> @@ -3914,43 +3914,17 @@ EOF
>>>>  fi
>>>>  
>>>>  ##########################################
>>>> -# libssh2 probe
>>>> -min_libssh2_version=1.2.8
>>>
>>> The commit message says we're conditionally using APIs from 0.8.0,
>>> but doesn't say what minimum version we actually need and there's
>>> no check here.
>>
>> When I started to work on this, the libssh version available was
>> 0.6.x IIRC, which is very old.  This v6 uses APIs added in 0.8
>> conditionally, so it will still build with libssh < 0.8 -- of course,
>> using an older libssh results in a less performant ssh driver, although
>> I would think this can be considered somehow acceptable.
>>
>>> In terms of our supported build platforms, the oldest libssh I
>>> see is RHEL-7 with 0.7.1.
>>>
>>> So assume it does actually compile on RHEL-7, then it is desirable
>>> to have a min_libssh_Version=0.7.1 set here & checked below.
>>
>> For now I do not see the need to enforce a minimum version required;
>> it can be easily added in the future in case we need to use an API only
>> available starting from some version, and there is no fallback way for
>> older versions.
> 
> In general we aim to set a clear minimum version for all our third
> party deps based on our platform support policy. We don't want to
> keep backcompat code around forever even if it is posisble to add
> fallback with #ifdefs. So even if we might still work with 0.6.x,
> we should declare 0.7.1 our min version IMHO.

With our CI setup we use:

Trusty (Ubuntu 14.04.5 LTS)
Source: libssh
Version: 0.6.1-0ubuntu3
Replaces: libssh-2-dev

Xenial
Source: libssh
Version: 0.6.3-4.3
Replaces: libssh-2-dev

The distrib packages do not allow dual use.

> Incidentally that reminds me that it is desirable to modify the
> various native arch tests/docker/dockerfiles/*docker files to
> list libssh as a package to install so that we get compile testing
> coverage.

I'm testing Pino patch and already did that :)

