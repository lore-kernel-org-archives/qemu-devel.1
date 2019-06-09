Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE944C28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 19:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D5C206BB
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 19:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3X8LFHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D5C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha3mu-00005H-DU
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 15:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35575)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.weiyang@gmail.com>) id 1ha3m9-00084z-6y
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 15:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1ha3m7-0001mK-TY
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 15:46:45 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1ha3m7-0001lL-Gi
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 15:46:43 -0400
Received: by mail-ed1-x544.google.com with SMTP id k8so9935332eds.7
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=C3N6OgnvfWn1kKiu3RV2wgW34LrK59aETmt8VcOs49k=;
 b=F3X8LFHGSY7bmto/EUzEaHOyL9QGQZkoFsi8Xrv9C/0AlRjoHSoOdvcQ6/3bA6uqqe
 GNhTYQptJ/jdSk3ONW8dRUMO+2evKnKJgfX8Nv/x5fIgJy/NqZb0cPQDT7IB6UCfG1b3
 YvbMvqi3gvva2XAbSmoTHZG33U9CMRS0kRZhRJC+YvD4ye5i46hk/vXoJ6V3vx2IAZf9
 MIgUncGeuD+Rx3Boga7SzZPksAZwO+RtazBoHaqIBkcH1+vU4LurdGxdQHWTP3FiVqYV
 0/XoqbHg/t00q/ll/++wwYlVZaszKOukOGZ5S86r895kwaAYJjMkzaSvZDngFkgjSGnr
 Qqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=C3N6OgnvfWn1kKiu3RV2wgW34LrK59aETmt8VcOs49k=;
 b=GJ7KQFewKgAzIV6VSLgpkN82tyLvCkSM/mt3tfcET4lZMNfaNx5Uejdd7RKBRuikSU
 I94o8I1AfV6+Nu9DSiMnbSveL6c1XpUKMmdOLlSj4YIE8q0uxEcoaWRXh0ggcbfg3BFc
 XR3BM6ppR7piHNkHnX21EyLYcmlV8fdymFRrzkWALlNjJtRjfraYSuSpLU9ogDUQZi2j
 NUJ8UTjhbSWomLzfom0260bWhPAL5pwqRiaOHedkvg6LISb50wur4JFoSpqBCOcpzgOS
 qk9rRTDp51c/JZ6lFbDaS/pQhYR0AhbcBIO6oAdKpFC9teWVVq4Hubz+91ji8WQxEYKd
 SWWw==
X-Gm-Message-State: APjAAAXYkejeX5TMVpezI+GduANFZDjSjp5U0ZKM3K6PCM4rK+oXJmYB
 YZeqDv6ptvBgkb7W8O2S/Rk=
X-Google-Smtp-Source: APXvYqywPUUEZx2XVpsyj+lRi1kMAThcOYqLjOWycwYSb0eYn5bWA1O2NERMZ5gprnMhPfDhkYZDfA==
X-Received: by 2002:a50:f286:: with SMTP id f6mr31071028edm.44.1560109601795; 
 Sun, 09 Jun 2019 12:46:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id i6sm200168eda.79.2019.06.09.12.46.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Jun 2019 12:46:40 -0700 (PDT)
Date: Sun, 9 Jun 2019 19:46:39 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190609194639.h6elitk3sbvd3irh@master>
References: <20190606013138.13312-1-richardw.yang@linux.intel.com>
 <20190606013138.13312-2-richardw.yang@linux.intel.com>
 <20190607185734.GZ2631@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607185734.GZ2631@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 1/2] migration/xbzrle: update cache and
 current_data in one place
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 07:57:34PM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> When we are not in the last_stage, we need to update the cache if page
>> is not the same.
>> 
>> Currently this procedure is scattered in two places and mixed with
>> encoding status check.
>> 
>> This patch extract this general step out to make the code a little bit
>> easy to read.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>This function is actually quite subtle, and I think your change will
>work, but it has changed the behaviour slightly.
>
>When we enter the function the *current_data is pointing at actual guest
>RAM and is changing as we're running.
>It's critical that the contents of the cache match what was actually
>sent, so that in the next cycle the correct delta is generated;
>thus the reason for the two memcpy's is actually different.
>
>> ---
>>  migration/ram.c | 19 +++++++++----------
>>  1 file changed, 9 insertions(+), 10 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index e9b40d636d..878cd8de7a 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1594,25 +1594,24 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>>      encoded_len = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
>>                                         TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
>>                                         TARGET_PAGE_SIZE);
>> +
>> +    /*
>> +     * we need to update the data in the cache, in order to get the same data
>> +     */
>> +    if (!last_stage && encoded_len != 0) {
>> +        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
>> +        *current_data = prev_cached_page;
>> +    }
>> +
>>      if (encoded_len == 0) {
>>          trace_save_xbzrle_page_skipping();
>>          return 0;
>>      } else if (encoded_len == -1) {
>>          trace_save_xbzrle_page_overflow();
>>          xbzrle_counters.overflow++;
>> -        /* update data in the cache */
>> -        if (!last_stage) {
>> -            memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
>> -            *current_data = prev_cached_page;
>> -        }
>>          return -1;
>
>In this case, we've not managed to compress, so we're going to have to
>transmit the whole page; but remember the guest is still writing. So we
>update the cache, and then update *current_data to point to the cache
>so that the caller sends from the cache directly rather than the guest
>RAM, this ensures that the thing that's sent matches the cache contents.
>
>However, note the memcpy is from *current_data, not XBZRLE.current_buf,
>so it might be slightly newer  - this is the first change you have made;
>you might be sending data that's slightly older; but it's safe because
>the data sent does match the cache contents.
>
>>      }
>>  
>> -    /* we need to update the data in the cache, in order to get the same data */
>> -    if (!last_stage) {
>> -        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
>> -    }
>> -
>
>This memcpy is slightly different.
>Here we've managed to do the compress; so now we update the cache based
>on what was compressed (current_buf).  *current_data isn't used by the
>caller in this case because it's actually sending the compressed data.
>So it's safe for you to update it.

Yes, you are right. My change will alter the behavior a little. To be
specific, when we didn't manage to compress content, the content we sent will
be a little *old*.

>
>So I think we need to add comments like that, how about:
>
>       /*
>        * Update the cache contents, so that it corresponds to the data
>        * sent, in allc ases except where we skip the page.
>        */
>> +    if (!last_stage && encoded_len != 0) {
>> +        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
>       /*
>        * In the case where we couldn't compress, ensure that the caller
>        * sends the data from the cache, since the guest might have
>        * changed the RAM since we copied it.
>        */
>
>> +        *current_data = prev_cached_page;
>> +    }
>>      /* Send XBZRLE based compressed page */
>>      bytes_xbzrle = save_page_header(rs, rs->f, block,
>>                                      offset | RAM_SAVE_FLAG_XBZRLE);

Yep, I agree with this comment.

Let me add this in v2.

Thanks :-)

>
>Dave
>
>> -- 
>> 2.19.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

