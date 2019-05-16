Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8920C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848E420833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 11:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPsCK35B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848E420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52621 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hREoO-0007SJ-J2
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 07:44:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hREmu-0006YE-Iz
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hREms-0000Nw-Sg
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:43:04 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hREmo-000064-Qw; Thu, 16 May 2019 07:42:59 -0400
Received: by mail-qt1-x842.google.com with SMTP id j53so3405598qta.9;
	Thu, 16 May 2019 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language;
	bh=hvHKe1u/cchcovJYWkFiEWZLRXk5negZGjQZ24ADDG8=;
	b=MPsCK35BHS7cBNwvOVJPmPbWPhqdoIM97s9HVpRxPrIAdLM1VzVBsDyIFBPs8djeH6
	fCE0pfV4f6KE8TDCeMnLBu14CBU/xR1JK/2a3s6dpWJDWmSEqIJEvk0rp2J1FLUkDuHc
	/DbikpmU7rBXV1xirAaOlyfP/JDqHiBzVxSz4vzk45KM78X3aBXY1IKSZ4/ZzdgcQxcq
	FeQqSss7aluTnqLL6JgjRjwvdP8xHzdiFyzQNIJKTGJMwoSUd3LUrargt3EtmtYYnlzp
	8fxUz4WvmdgTSBGVb1naDE5/PTBbj0E1lli9iCrs03EOmshfSNPIKAjJIlLGkwYdctZm
	vMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language;
	bh=hvHKe1u/cchcovJYWkFiEWZLRXk5negZGjQZ24ADDG8=;
	b=L4GyEGjadN1PlTxbbOoF9imilNuEfuc4nON6qw63GVQJdIl963c41pC1ZsDClhn5aJ
	cf1oHQyErz1IexEyoFPzhN/BCEo3Bxm5nu2y48v2jOmCOUf+6bEzxcVmA/OAIWFN0qpp
	24h8ZJUeGdQjjx6nT6HCKGS3HPepMtzQPaaWt3QQkP8FpGaf9StbUS599YDpa/0KJKj6
	LJyNuABAC8rbyS1MgOssnv5r8qcsDz53c2ApmgG4M+IID3SKP7Krsv2bDhNpbaCh0v2S
	tSxzlqnegvO3nkj9q2lPjVSnzDKeG1yWskcWkIkleFyhsTfcTM5AOI0aGbWkVMURWuqG
	AiHQ==
X-Gm-Message-State: APjAAAUATO24WANhCzPTlERowSNFNwkfzh0bAOzZr9qARCRwIqBggyle
	HekenSGIpluu2G7WNiboPGU=
X-Google-Smtp-Source: APXvYqxYPak+Ptt1vsyUczwkeVIZBcjQjz5DAqQdbWorgAvsKc0HDqn3kIVI3IYhpmSHVqkiZa4vDA==
X-Received: by 2002:a0c:95d5:: with SMTP id t21mr32539065qvt.215.1558006974947;
	Thu, 16 May 2019 04:42:54 -0700 (PDT)
Received: from ?IPv6:2804:431:f701:9e22:ebb5:4019:e2bd:55e4?
	([2804:431:f701:9e22:ebb5:4019:e2bd:55e4])
	by smtp.gmail.com with ESMTPSA id j62sm775137qte.89.2019.05.16.04.42.52
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 04:42:54 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190326211742.26140-1-danielhb413@gmail.com>
	<20190326211742.26140-2-danielhb413@gmail.com>
	<996f1818-a255-62e2-1b33-f2ca69cfc6d0@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <d9f201e4-4aac-3750-f515-646fc3f1c3c1@gmail.com>
Date: Thu, 16 May 2019 08:42:50 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <996f1818-a255-62e2-1b33-f2ca69cfc6d0@redhat.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 1/3] block: introducing
 'bdrv_co_delete_file' interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John,

On 5/13/19 4:47 PM, John Snow wrote:
> It looks like this one has gone un-noticed for a little while.
>
> On 3/26/19 5:17 PM, Daniel Henrique Barboza wrote:
>> Adding to Block Drivers the capability of being able to clean up
>> its created files can be useful in certain situations. For the
>> LUKS driver, for instance, a failure in one of its authentication
>> steps can leave files in the host that weren't there before.
>>
>> This patch adds the 'bdrv_co_delete_file' interface to block
>> drivers and add it to the 'file' driver in file-posix.c. The
>> implementation is given by 'raw_co_delete_file'. The helper
>> 'bdrv_path_is_regular_file' is being used only in raw_co_delete_file
>> at this moment, but it will be used inside LUKS in a later patch.
>> Foreseeing this future use, let's put it in block.c and make it
>> public.
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   block.c                   | 11 +++++++++++
>>   block/file-posix.c        | 28 ++++++++++++++++++++++++++++
>>   include/block/block.h     |  1 +
>>   include/block/block_int.h |  6 ++++++
>>   4 files changed, 46 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index 0a93ee9ac8..227362b282 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -621,6 +621,17 @@ int get_tmp_filename(char *filename, int size)
>>   #endif
>>   }
>>   
>> +/**
>> + * Helper that checks if a given string represents a regular
>> + * local file.
>> + */
>> +bool bdrv_path_is_regular_file(const char *path)
>> +{
>> +    struct stat st;
>> +
>> +    return (stat(path, &st) == 0) && S_ISREG(st.st_mode);
>> +}
>> +
>>   /*
>>    * Detect host devices. By convention, /dev/cdrom[N] is always
>>    * recognized as a host CDROM.
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index d102f3b222..09d84bab37 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2342,6 +2342,33 @@ static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
>>       return raw_co_create(&options, errp);
>>   }
>>   
>> +/**
>> + * Co-routine function that erases a regular file.
>> + */
>> +static int coroutine_fn raw_co_delete_file(const char *filename,
>> +                                           Error **errp)
> Do we need to mark functions that make no use of coroutines as
> coroutine_fn? I guess this way the interface is *allowed* to be a
> coroutine if other drivers need to make use of that.

This function is used in a coroutine in patch 2. But to be honest, what I
did here was to emulate the existing behavior of bdrv_create. Which
is kind of lame if bdrv_create happens to have design problems or
inconsistencies, but at least it's based on something that's already
working.


>
>> +{
>> +    int ret;
>> +
>> +    /* Skip file: protocol prefix */
>> +    strstart(filename, "file:", &filename);
>> +
> This sticks out as fragile to me, but I guess that's exactly how create
> works, so... OK.

Yep, create does the same thing.



Thanks,


DHB

>
>> +    if (!bdrv_path_is_regular_file(filename)) {
>> +        ret = -ENOENT;
>> +        error_setg_errno(errp, -ret, "%s is not a regular file", filename);
>> +        goto done;
>> +    }
>> +
>> +    ret = unlink(filename);
>> +    if (ret < 0) {
>> +        ret = -errno;
>> +        error_setg_errno(errp, -ret, "Error when deleting file %s", filename);
>> +    }
>> +
>> +done:
>> +    return ret;
>> +}
>> +
>>   /*
>>    * Find allocation range in @bs around offset @start.
>>    * May change underlying file descriptor's file offset.
>> @@ -2867,6 +2894,7 @@ BlockDriver bdrv_file = {
>>       .bdrv_co_block_status = raw_co_block_status,
>>       .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
>>       .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
>> +    .bdrv_co_delete_file = raw_co_delete_file,
>>   
>>       .bdrv_co_preadv         = raw_co_preadv,
>>       .bdrv_co_pwritev        = raw_co_pwritev,
>> diff --git a/include/block/block.h b/include/block/block.h
>> index e452988b66..820643f96d 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -363,6 +363,7 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
>>                                 Error **errp);
>>   void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
>>   
>> +bool bdrv_path_is_regular_file(const char *path);
>>   
>>   typedef struct BdrvCheckResult {
>>       int corruptions;
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 01e855a066..74abb78ce7 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -309,6 +309,12 @@ struct BlockDriver {
>>        */
>>       int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
>>   
>> +    /*
>> +     * Delete a local created file.
>> +     */
>> +    int coroutine_fn (*bdrv_co_delete_file)(const char *filename,
>> +                                            Error **errp);
>> +
>>       /*
>>        * Flushes all data that was already written to the OS all the way down to
>>        * the disk (for example file-posix.c calls fsync()).
>>
> Seems alright at a glance, if we want this interface.
>
> Kevin, do we?
>
> --js

