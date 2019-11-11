Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502CC20679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR3TYvCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502CC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUBuW-0006ek-G8
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 10:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1iUBtn-00069q-JC
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1iUBtm-00039M-FE
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:46:39 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1iUBtj-00036B-VS; Mon, 11 Nov 2019 10:46:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id a17so184927wmb.0;
 Mon, 11 Nov 2019 07:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5wBPsLuiDPtO8uLbb7XLHTQq5udq31B0NEzHpamjLm8=;
 b=CR3TYvCcGCVFgpxF/uKvZC1AAK+WQBzmzSNIkmuwBpi/Mz5L+6nmcheGWFzUne7kcF
 xDfrA4GYEzWmzBYM2ILFUTy+B2HMpxjLAmF6f0Bs0zM4esqfX5ECiCcJWfoEYx0b0Jmz
 TfUwpb5S56T6fnqhQKtOb7chBPbmTy+FoOJPGR2+MjD90zrI4H71FoMLPF0sccIsbXIy
 u9ZfRDEg862TtBi2wmRhZDiCIxtXyvLpLezow2m5pojQrUFDgzyT32oOwRbxTu3Psehp
 2/Kk/TAtLV1uDQTS1p2cEfe0Rsln8ucLDMpRCTbhM/Ckl7dQUmrf1mnVEyR8afP8ZQcH
 T2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=5wBPsLuiDPtO8uLbb7XLHTQq5udq31B0NEzHpamjLm8=;
 b=l3AggbfDtYOHs/X2LrRQVLO3isqE/9JLO3iWRjT8voFLqybAgB5P1mUk/y9nkvsAdZ
 OSwYq42f8lQfGTRp1IhNDjy50hUrf0uTomuuzIFt4sLHO3fNjDGnrwCVi2vRZVq5hYPK
 l1r2EAjY2DqveX9mYHydhpisadR8qFDbTA11spVIUtmYNpufUayXwZm4IMEcYno7S9DA
 tjs7QnXZVLN1Mgl4zQ0B4yvP7MqQI86YIokZ0Tjn1yIgn8HM4kaELXY1uyHnYZjzlqmu
 YWQ5bB4x//KPOsnB6a42pbXFm6m9XW+gxYvC185xsgbFYhE1h2Q27jGGwiTcKZZrGmRb
 S17w==
X-Gm-Message-State: APjAAAWCvMcEDzfpiQ1RrR2KwoxZ3cXJLvemvfCfePEV2q3SzkFisWvO
 eluXBCkdjxSHagGx2nvD8gE=
X-Google-Smtp-Source: APXvYqxKhmxFJ1H10FpiWpb1w3wBNAkkr3cWiizqH7tHY90pYHdtqMX1ORlkmEWBHpVNCjrqcB+H2Q==
X-Received: by 2002:a1c:96c9:: with SMTP id y192mr22066308wmd.8.1573487194512; 
 Mon, 11 Nov 2019 07:46:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id i13sm15201591wrp.12.2019.11.11.07.46.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Nov 2019 07:46:33 -0800 (PST)
Date: Mon, 11 Nov 2019 15:46:32 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 2/2] core: replace sysconf(_SC_PAGESIZE) with
 qemu_real_host_page_size
Message-ID: <20191111154632.2nxjsdirbl2xz4no@master>
References: <20191015031350.4345-1-richardw.yang@linux.intel.com>
 <20191015031350.4345-3-richardw.yang@linux.intel.com>
 <20191111100641.uvi47rjjb3ink5jl@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111100641.uvi47rjjb3ink5jl@steredhat>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, mreitz@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 11:06:41AM +0100, Stefano Garzarella wrote:
>Why "core:" in the commit title?
>
>Perhaps to indicate that the patch concerns different subsystems,
>I'd use "qemu: ", but I'm not sure :-)
>

I didn't find a better one. Maybe "qemu" is better :-)

>On Tue, Oct 15, 2019 at 11:13:50AM +0800, Wei Yang wrote:
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Suggested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> CC: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  block/file-posix.c              | 2 +-
>>  net/l2tpv3.c                    | 2 +-
>>  tests/tcg/multiarch/test-mmap.c | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/block/file-posix.c b/block/file-posix.c
>> index 5d1995a07c..853ed42134 100644
>> --- a/block/file-posix.c
>> +++ b/block/file-posix.c
>> @@ -2562,7 +2562,7 @@ static void check_cache_dropped(BlockDriverState *bs, Error **errp)
>>      off_t end;
>>  
>>      /* mincore(2) page status information requires 1 byte per page */
>> -    page_size = sysconf(_SC_PAGESIZE);
>> +    page_size = qemu_real_host_page_size;
>>      vec = g_malloc(DIV_ROUND_UP(window_size, page_size));
>>  
>>      end = raw_getlength(bs);
>> diff --git a/net/l2tpv3.c b/net/l2tpv3.c
>> index 55fea17c0f..5f843240de 100644
>> --- a/net/l2tpv3.c
>> +++ b/net/l2tpv3.c
>> @@ -41,7 +41,7 @@
>>   * chosen to be sufficient to accommodate one packet with some headers
>>   */
>>  
>> -#define BUFFER_ALIGN sysconf(_SC_PAGESIZE)
>> +#define BUFFER_ALIGN qemu_real_host_page_size
>>  #define BUFFER_SIZE 2048
>>  #define IOVSIZE 2
>>  #define MAX_L2TPV3_MSGCNT 64
>> diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
>> index 9ea49e2307..370842e5c2 100644
>> --- a/tests/tcg/multiarch/test-mmap.c
>> +++ b/tests/tcg/multiarch/test-mmap.c
>> @@ -466,7 +466,7 @@ int main(int argc, char **argv)
>>      if (argc > 1) {
>>          qemu_strtoul(argv[1], NULL, 0, &pagesize);
>>      } else {
>> -        pagesize = sysconf(_SC_PAGESIZE);
>> +        pagesize = qemu_real_host_page_size;
>>      }
>>  
>>      /* Assume pagesize is a power of two.  */
>
>The patch LGTM:
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Thanks,
>Stefano
>

-- 
Wei Yang
Help you, Help me

