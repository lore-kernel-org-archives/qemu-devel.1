Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC736C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 16:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B59C721670
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 16:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWKXQOdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59C721670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Yi6-0007yN-Se
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 12:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i1Yh8-0007Rn-0X
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 12:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i1Yh6-0004m5-Qs
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 12:15:13 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i1Yh6-0004lQ-IS
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 12:15:12 -0400
Received: by mail-ed1-x544.google.com with SMTP id t50so18918311edd.2
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ysQWgmEEtCngWE9S2MjrnXAGdImHdUiNLmf5P108tr4=;
 b=aWKXQOdHpdi7Fqd2cQOu7IZPffv6xJZchK+865LF1MjyY4RYgAxaxs97JFHTNZfrfF
 7TN0yMIbqlSqdPABeeWYaxrD42Ac6wwJ0uADsMOexqROaUTjZ4u9Ti0h/YkE2M09k9xH
 bV77Buq5S2LD/c7Pro0Z8YshYppsyUXqRBiWCBi4ixVQ8poS55R8360jr8VL53SRukh3
 mkt6sm8ZYStyMow3VoiYIbllHqqvaSZrcgxphrRa5l97OmJQZXTIgQGph2qb7jiACIst
 P89fxlgEfwOZrwdfrZfVrZH/0sD6rwLbYd6deaYUNxVm4+yGYpYKxkuI6qRa11FAAzeX
 F/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=ysQWgmEEtCngWE9S2MjrnXAGdImHdUiNLmf5P108tr4=;
 b=MhGvEtlcbPGAA5rn0RVQDd5CWBf19TxIqm5e6bfUTdGBrCMJ5rX1TBBorp/0g8CnZK
 PrqUxlo/JfxivJcEZjY5lCIwsTQEEdeQQ7yNzuP0RncvzcPI6kpoHDsXTBLXvJQW8KZk
 xivELWYEgV5q4L5TLW9eykhfA9TvrvUKttjKDX56eQZA1zM/z441RB/XRVHlvy5V/U+w
 i0X+vcYwlhna2MG/5lgHhMQ9Bdwcltsst6IkEojwtTQFxIq0rbJoZ83ust8htNoessrz
 wnHu5MlOMTuWmXIamjfy9VE+vEAZ4FmzBrKrdNlLxaYF5lOAXyIUoR2aZkzSFmHKFyvH
 Ph9g==
X-Gm-Message-State: APjAAAU3LIhPXmqwEVMJbVCVUmn5qrGBRbAXH4PlMyc1UUr1dUr8MFuG
 WhU6zO8MQ7zG/QR4+NebiQg=
X-Google-Smtp-Source: APXvYqzFRuNlxQlaFoUMBJHc0uSlOXN/8GlNX4a5rYVySocpDfnxYCoLWCWBNDqyjocBRGSdZi324Q==
X-Received: by 2002:a05:6402:28e:: with SMTP id
 l14mr10220416edv.133.1566663310711; 
 Sat, 24 Aug 2019 09:15:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id s4sm1290130ejq.72.2019.08.24.09.15.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 24 Aug 2019 09:15:09 -0700 (PDT)
Date: Sat, 24 Aug 2019 16:15:09 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190824161509.xtm65qu6k6amrjk6@master>
References: <20190731144225.3784-1-richardw.yang@linux.intel.com>
 <20190731144225.3784-3-richardw.yang@linux.intel.com>
 <20190823110609.GF2784@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823110609.GF2784@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/qemu-file: fix potential buf
 waste for extra buf_index adjustment
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
Cc: quintela@redhat.com, berrange@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 12:06:09PM +0100, Dr. David Alan Gilbert wrote:
>(Copying Dan in)
>
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
>> this happens, buf_index is reset. Currently, this is not checked and
>> buf_index would always been adjust with buf size.
>> 
>> This is not harmful, but will waste some space in file buffer.
>
>That's a nice find.
>
>> This patch make add_to_iovec() return 1 when it has flushed the file.
>> Then the caller could check the return value to see whether it is
>> necessary to adjust the buf_index any more.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>(I wonder if there's a way to wrap that little add_to_iovec, check, add
>to index, flush in a little wrapper).
>
>Dave
>
>> ---
>>  migration/qemu-file.c | 42 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 28 insertions(+), 14 deletions(-)
>> 
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 35c22605dd..05d9f42ddb 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -343,8 +343,16 @@ int qemu_fclose(QEMUFile *f)
>>      return ret;
>>  }
>>  
>> -static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> -                         bool may_free)
>> +/*
>> + * Add buf to iovec. Do flush if iovec is full.
>> + *
>> + * Return values:
>> + * 1 iovec is full and flushed
>> + * 0 iovec is not flushed
>> + *
>> + */
>> +static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>> +                        bool may_free)
>>  {
>>      /* check for adjacent buffer and coalesce them */
>>      if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
>> @@ -362,7 +370,10 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>>  
>>      if (f->iovcnt >= MAX_IOV_SIZE) {
>>          qemu_fflush(f);
>> +        return 1;
>>      }
>> +
>> +    return 0;
>>  }
>>  
>>  void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
>> @@ -391,10 +402,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>>          }
>>          memcpy(f->buf + f->buf_index, buf, l);
>>          f->bytes_xfer += l;
>> -        add_to_iovec(f, f->buf + f->buf_index, l, false);
>> -        f->buf_index += l;
>> -        if (f->buf_index == IO_BUF_SIZE) {
>> -            qemu_fflush(f);
>> +        if (!add_to_iovec(f, f->buf + f->buf_index, l, false)) {
>> +            f->buf_index += l;
>> +            if (f->buf_index == IO_BUF_SIZE) {
>> +                qemu_fflush(f);
>> +            }

You mean put these four lines into a wrapper?

Name it as add_buf_to_iovec?

>>          }
>>          if (qemu_file_get_error(f)) {
>>              break;
>> @@ -412,10 +424,11 @@ void qemu_put_byte(QEMUFile *f, int v)
>>  
>>      f->buf[f->buf_index] = v;
>>      f->bytes_xfer++;
>> -    add_to_iovec(f, f->buf + f->buf_index, 1, false);
>> -    f->buf_index++;
>> -    if (f->buf_index == IO_BUF_SIZE) {
>> -        qemu_fflush(f);
>> +    if (!add_to_iovec(f, f->buf + f->buf_index, 1, false)) {
>> +        f->buf_index++;
>> +        if (f->buf_index == IO_BUF_SIZE) {
>> +            qemu_fflush(f);
>> +        }
>>      }
>>  }
>>  
>> @@ -717,10 +730,11 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>>      }
>>  
>>      qemu_put_be32(f, blen);
>> -    add_to_iovec(f, f->buf + f->buf_index, blen, false);
>> -    f->buf_index += blen;
>> -    if (f->buf_index == IO_BUF_SIZE) {
>> -        qemu_fflush(f);
>> +    if (!add_to_iovec(f, f->buf + f->buf_index, blen, false)) {
>> +        f->buf_index += blen;
>> +        if (f->buf_index == IO_BUF_SIZE) {
>> +            qemu_fflush(f);
>> +        }
>>      }
>>      return blen + sizeof(int32_t);
>>  }
>> -- 
>> 2.17.1
>> 
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

