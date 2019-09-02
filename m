Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06149C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 18:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99A4208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 18:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocsZnJ0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99A4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4r2x-0006aA-Mt
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 14:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i4r1x-0005vQ-Co
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 14:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i4r1w-00087C-7V
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 14:26:21 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:41568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i4r1w-00086x-3S
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 14:26:20 -0400
Received: by mail-qt1-x842.google.com with SMTP id i4so16467920qtj.8
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zikoXGI6oAPEStxiF6T2yMpknJYFavgILZtIJRjQr9k=;
 b=ocsZnJ0lSiD9bAo8iT8kgnuWUaP+V3H5lFn0ex3+LUOrYB1ze2nQ1xkH0haseQBU70
 jYKF6OUlWA4LQEjq8xZENkzQETIT8GHjD8w2Fvtu/JQRlXL0CFQDBPjbTvTV57n2docF
 3wYhmYcz8uF5zhNMvpFq6JWQKJKUPZf4lPwObs3YdjBTFTM3jK246B+cvluWeCQwPkf+
 2N2dLRznrfc9matKlEp+57ToQ3kVZVtpByXqzJ2k1noelb96AVi/JJzrga1rJZyn2CQb
 VdfruIdXzgsvpoqbnzJgr+fzegR4a2Xwb4c/63TnqNFIIPa6UywsJw47L/bGjQUqnBW7
 kjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zikoXGI6oAPEStxiF6T2yMpknJYFavgILZtIJRjQr9k=;
 b=PrykA3vDuLVIibSD29EzY/3PP4I7yT8Oe+x/+FiTFN4bHbI4fYyWC7TAXhELDm4Acd
 mKDWZfU4vZ+MvHbwzi8Mb+C249lQ5/kytlc8GUnbRam6gv2+QN2PNsL9W/Qil22kWbM9
 YGhTFzNmbmCw3KrHfN2BhBRUNwVtN/DEB48CuZ3a8DusSvXbp2qgJojxI53pjP0CNCEL
 YYQrP3tGuX+eBDwPjybWU2AjLj+gNojEAB8a+tmHxKQhOJx5GTkCDzMjYwHfleTRJ5G5
 Eh3HlL67nxUjewop4TXRdLJVt9+dx6hTV1tYCm1WuSbx7zun3/RWClnhvSH0ZA4zkt5Z
 nxOg==
X-Gm-Message-State: APjAAAVMzWqonfbKuaal9N5t3hT4ij+ThqpgtlWk5/mxs0kEiT0g1JoW
 J0M2QoL/WAuTCZXCOs+V07s=
X-Google-Smtp-Source: APXvYqzvsD0PkMGpMCuOei7GM9KxhAsS4O4JWxhbHFrkL9w8lHs3n2BLrnK7t1Qifo62RzxJi4a4Ow==
X-Received: by 2002:a05:6214:80d:: with SMTP id
 df13mr7302039qvb.161.1567448779424; 
 Mon, 02 Sep 2019 11:26:19 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:9589:1351:c7eb:87b:c9d5?
 ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id b5sm6772180qkk.78.2019.09.02.11.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2019 11:26:18 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190807142114.17569-1-danielhb413@gmail.com>
 <20190807142114.17569-4-danielhb413@gmail.com>
 <30e39135-a023-2257-4718-747c94ae85ee@redhat.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <f4f8449a-48ec-2312-33ef-7b556f127b66@gmail.com>
Date: Mon, 2 Sep 2019 15:26:15 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <30e39135-a023-2257-4718-747c94ae85ee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH v5 3/4] crypto.c: cleanup created file when
 block_crypto_co_create_opts_luks fails
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
Cc: kwolf@redhat.com, Srikanth Aithal <bssrikanth@in.ibm.com>,
 berrange@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/28/19 11:10 PM, John Snow wrote:
>
> On 8/7/19 10:21 AM, Daniel Henrique Barboza wrote:
>> When using a non-UTF8 secret to create a volume using qemu-img, the
>> following error happens:
>>
>> $ qemu-img create -f luks --object secret,id=vol_1_encrypt0,file=vol_resize_pool.vol_1.secret.qzVQrI -o key-secret=vol_1_encrypt0 /var/tmp/pool_target/vol_1 10240K
>>
>> Formatting '/var/tmp/pool_target/vol_1', fmt=luks size=10485760 key-secret=vol_1_encrypt0
>> qemu-img: /var/tmp/pool_target/vol_1: Data from secret vol_1_encrypt0 is not valid UTF-8
>>
>> However, the created file '/var/tmp/pool_target/vol_1' is left behind in the
>> file system after the failure. This behavior can be observed when creating
>> the volume using Libvirt, via 'virsh vol-create', and then getting "volume
>> target path already exist" errors when trying to re-create the volume.
>>
>> The volume file is created inside block_crypto_co_create_opts_luks(), in
>> block/crypto.c. If the bdrv_create_file() call is successful but any
>> succeeding step fails*, the existing 'fail' label does not take into
>> account the created file, leaving it behind.
>>
>> This patch changes block_crypto_co_create_opts_luks() to delete
>> 'filename' in case of failure. A failure in this point means that
>> the volume is now truncated/corrupted, so even if 'filename' was an
>> existing volume before calling qemu-img, it is now unusable. Deleting
>> the file it is not much worse than leaving it in the filesystem in
>> this scenario, and we don't have to deal with checking the file
>> pre-existence in the code.
>>
>> * in our case, block_crypto_co_create_generic calls qcrypto_block_create,
>> which calls qcrypto_block_luks_create, and this function fails when
>> calling qcrypto_secret_lookup_as_utf8.
>>
>> Reported-by: Srikanth Aithal <bssrikanth@in.ibm.com>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>> ---
>>   block/crypto.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/block/crypto.c b/block/crypto.c
>> index 8237424ae6..8ffca81df6 100644
>> --- a/block/crypto.c
>> +++ b/block/crypto.c
>> @@ -30,6 +30,7 @@
>>   #include "qapi/error.h"
>>   #include "qemu/module.h"
>>   #include "qemu/option.h"
>> +#include "qemu/cutils.h"
>>   #include "crypto.h"
>>   
>>   typedef struct BlockCrypto BlockCrypto;
>> @@ -575,6 +576,25 @@ fail:
>>       bdrv_unref(bs);
>>       qapi_free_QCryptoBlockCreateOptions(create_opts);
>>       qobject_unref(cryptoopts);
>> +
>> +    /*
>> +     * If an error occurred, delete the file. Even if the file existed
>> +     * beforehand, it has been truncated and corrupted in the process.
>> +     */
>> +    if (ret) {
>> +        Error *local_err;
>> +        int r_del = bdrv_delete_file(filename, &local_err);
>> +        /*
>> +         * ENOTSUP will happen if the block driver doesn't support
>> +         * 'bdrv_co_delete_file'. ENOENT will happen if the file
>> +         * doesn't exist. Both are predictable and shouldn't be
>> +         * reported back to the user.
>> +         */
> Hm, actually, didn't you use ENOENT to mean that we couldn't figure out
> which driver to use?


True. In this context though I am referring to the co_routine function
that deletes the file:

-------
(file-posix.c)
static int coroutine_fn raw_co_delete_file(BlockDriverState *bs,
                                            Error **errp)
{
     struct stat st;
     int ret;

     if (!(stat(bs->filename, &st) == 0) || !S_ISREG(st.st_mode)) {
         ret = -ENOENT;
         error_setg_errno(errp, -ret, "%s is not a regular file",
                          bs->filename);
         goto done;
     }
(...)
-----


I'll make it clearer in the comment where ENOENT is coming from.

(In fact, this is a good reason to change the !drv error in patch 2 from
ENOENT to ENOMEDIUM ....)







>
>> +        if ((r_del < 0) && (r_del != -ENOTSUP) && (r_del != -ENOENT)) {
>> +            error_reportf_err(local_err, "%s: ", bs->filename);
>> +        }> +    }
>> +
>>       return ret;
>>   }
>>   
>>


