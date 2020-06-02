Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2061D206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6zZGSqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2061D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAqU-0007OS-Bk
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgApf-00065g-Iv
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:36:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgApd-0006As-Sp
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591119368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daGZQVL1EnsEaUYs5+OmeOjxhTo92oCx+3VSrC87WRQ=;
 b=f6zZGSqgtiLUaHMLcUUAueSwzuDjQhfa0KwlcDz2b/Ut073e50Iu4FSaNeApUOjjO4BeQ7
 uYyTwcG4pei5giG6XJ3ON2jMHXaUBZ+W7pFfcJ+w73MGO8T2jMWZQAzzTulQRnjikZtMxk
 pEhzrP8Gpz8XYY5lb2oe1y0wDmZLW5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-W-9pImPgPeicB_OV0REAww-1; Tue, 02 Jun 2020 13:36:02 -0400
X-MC-Unique: W-9pImPgPeicB_OV0REAww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9017C461;
 Tue,  2 Jun 2020 17:36:01 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC71319C4F;
 Tue,  2 Jun 2020 17:36:00 +0000 (UTC)
Subject: Re: [PATCH v3 4/6] iotests: Dump bitmap directory info with qcow2.py
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1591019293-211155-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b9b51392-055e-d947-7ca0-91878f817587@redhat.com>
Date: Tue, 2 Jun 2020 12:35:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591019293-211155-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:49:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 8:48 AM, Andrey Shinkevich wrote:
> Read and dump entries from the bitmap directory of QCOW2 image with the
> script qcow2.py.
> 
> Header extension:         Bitmaps
> ...
> Bitmap name               bitmap-1
> flag                      auto
> bitmap_table_offset       0xf0000
> bitmap_table_size         8
> flag_bits                 2
> type                      1
> granularity_bits          16
> name_size                 8
> extra_data_size           0
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2.py | 104 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 103 insertions(+), 1 deletion(-)
> 

> +        self.bitmap_flags = []
> +        BME_FLAG_IN_USE = 1
> +        BME_FLAG_AUTO = 1 << 1

Would it be worth using '1 << 0' for BME_FLAG_IN_USE, to make it obvious 
that these are consecutive bits, especially if we later add a third bit?


> +        for n in range(self.nb_bitmaps):
> +            buf = fd.read(buf_size)
> +            dir_entry = Qcow2BitmapDirEntry(buf)
> +            fd.seek(dir_entry.extra_data_size, 1)
> +            bitmap_name = fd.read(dir_entry.name_size)
> +            dir_entry.name = bitmap_name.decode('ascii')
> +            self.bitmaps.append(dir_entry)
> +            entry_raw_size = dir_entry.bitmap_dir_entry_raw_size()
> +            shift = ((entry_raw_size + 7) & ~7) - entry_raw_size
> +            fd.seek(shift, 1)

Is there a symbolic constant instead of the magic '1' for fd.seek()?


> @@ -157,7 +256,10 @@ class QcowHeader:
>               else:
>                   padded = (length + 7) & ~7
>                   data = fd.read(padded)
> -                self.extensions.append(QcowHeaderExtension(magic, length, data))
> +                self.extensions.append(QcowHeaderExtension(magic, length,
> +                                                           data))

Should this reformatting be done earlier in the series to minimize churn?

> +        for ex in self.extensions:
> +            ex.load(fd)
>   
>       def update_extensions(self, fd):
>   
> 

Fixing the things I pointed out does not seem major, so
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


