Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7439FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D00120657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cW9YW0La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D00120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jal7M-0003px-DM
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jal6l-0003NV-IZ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:07:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jal6d-0003Cc-Kh
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589828837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAr1TNMV+Sis+fk5c59Z21sKhjqff1V2LJoU+Mdod6k=;
 b=cW9YW0La7XuuUFl8mxD8313Ono6yjQXOff8L2V1b2mw0aQk8KusPzjJaiN9bOGYMjd1Jhw
 uxHLYr/AmVrhW2L2t/Y5QkDwYpd01iX+Ptj8ELlJLqfRfWm91yhfkXIMNByY3lusbgDgD5
 PvOxyCm5pGAIj0LM6G6MLLjwxB+HVHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-LCpbwamANf-Gi3XZEOIMwQ-1; Mon, 18 May 2020 15:07:13 -0400
X-MC-Unique: LCpbwamANf-Gi3XZEOIMwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D1F764ACA;
 Mon, 18 May 2020 19:07:12 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B32F56297D;
 Mon, 18 May 2020 19:07:11 +0000 (UTC)
Subject: Re: [PATCH v4 6/9] qemu-img: Add bitmap sub-command
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-7-eblake@redhat.com>
 <92016f3f-a7c1-5384-5968-b89de5f01ecb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <54ab6b66-d22d-820b-f4ad-2859f856de92@redhat.com>
Date: Mon, 18 May 2020 14:07:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <92016f3f-a7c1-5384-5968-b89de5f01ecb@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:42 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.05.2020 04:16, Eric Blake wrote:
>> Include actions for --add, --remove, --clear, --enable, --disable, and
>> --merge (note that --clear is a bit of fluff, because the same can be
>> accomplished by removing a bitmap and then adding a new one in its
>> place, but it matches what QMP commands exist).  Listing is omitted,
>> because it does not require a bitmap name and because it was already
>> possible with 'qemu-img info'.  A single command line can play one or
>> more bitmap commands in sequence on the same bitmap name (although all
>> added bitmaps share the same granularity, and and all merged bitmaps
>> come from the same source file).  Merge defaults to other bitmaps in
>> the primary image, but can also be told to merge bitmaps from a
>> distinct image.
>>
>> While this supports --image-opts for the file being modified, I did
>> not think it worth the extra complexity to support that for the source
>> file in a cross-file merges.  Likewise, I chose to have --merge only
>> take a single source rather than following the QMP support for
>> multiple merges in one go (although you can still use more than one
>> --merge in the command line); in part because qemu-img is offline and
>> therefore atomicity is not an issue.
>>

>> +
>> +    blk = img_open(image_opts, filename, fmt, BDRV_O_RDWR, false, false,
>> +                   false);
> 
> fit in one line

That line would be exactly 80; I tend to wrap at 79 or earlier rather 
than exactly on 80.

> 
>> +    if (!blk) {
>> +        goto out;
>> +    }
>> +    bs = blk_bs(blk);
>> +    if (src_filename) {
>> +        src = img_open(NULL, src_filename, src_fmt, 0, false, false,
>> +                       false);
> 
> s/NULL/false/

D'oh.  And yet it still compiles.  Fixing.

> 
> also, fit in one line

Yes, this one's shorter.  Fixing.


>> +
>> +        if (err) {
>> +            error_reportf_err(err, "Operation %s on bitmap %s failed",
> 
> s/failed/failed: /
> 
>> +                              op, bitmap);
>> +            ret = -1;
> 
> dead assignment: you never set ret after first initialization to -1.

Fixing both.

> 
>> +            goto out;
>> +        }
>> +        g_free(act);
>> +    }
>> +
>> +    ret = 0;
>> +
>> + out:
>> +    blk_unref(src);
>> +    blk_unref(blk);
>> +    qemu_opts_del(opts);
>> +    if (ret) {
>> +        return 1;
>> +    }
>> +    return 0;
> 
> Hmm, as it's the only usage of ret, you may initialize it to 1 at 
> function start, and here just "return ret;"

Yep, done.

>> +DEF("bitmap", img_bitmap,
>> +    "bitmap (--merge SOURCE | --add | --remove | --clear | --enable | 
>> --disable)... [-b source_file [-F source_fmt]] [-g granularity] 
>> [--object objectdef] [--image-opts | -f fmt] filename bitmap")
>> +SRST
>> +.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | 
>> --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g 
>> GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> 
> Not about this patch, but it's a pity that we have triple duplications 
> (triplications ?) of such lines..

Yes, it is annoying.  But as you say, it's a cleanup for another day, 
for someone who is interested.

> 
> With at least s/NULL/false/ and s/failed/failed: / (or with all my tiny 
> suggestions):
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks; squashing in:

diff --git i/qemu-img.c w/qemu-img.c
index 8c99e68ba8aa..f940137cb0e5 100644
--- i/qemu-img.c
+++ w/qemu-img.c
@@ -4493,7 +4493,7 @@ typedef struct ImgBitmapAction {
  static int img_bitmap(int argc, char **argv)
  {
      Error *err = NULL;
-    int c, ret = -1;
+    int c, ret = 1;
      QemuOpts *opts = NULL;
      const char *fmt = NULL, *src_fmt = NULL, *src_filename = NULL;
      const char *filename, *bitmap;
@@ -4641,8 +4641,7 @@ static int img_bitmap(int argc, char **argv)
      }
      bs = blk_bs(blk);
      if (src_filename) {
-        src = img_open(NULL, src_filename, src_fmt, 0, false, false,
-                       false);
+        src = img_open(false, src_filename, src_fmt, 0, false, false, 
false);
          if (!src) {
              goto out;
          }
@@ -4695,9 +4694,8 @@ static int img_bitmap(int argc, char **argv)
          }

          if (err) {
-            error_reportf_err(err, "Operation %s on bitmap %s failed",
+            error_reportf_err(err, "Operation %s on bitmap %s failed: ",
                                op, bitmap);
-            ret = -1;
              goto out;
          }
          g_free(act);
@@ -4709,10 +4707,7 @@ static int img_bitmap(int argc, char **argv)
      blk_unref(src);
      blk_unref(blk);
      qemu_opts_del(opts);
-    if (ret) {
-        return 1;
-    }
-    return 0;
+    return ret;
  }

  #define C_BS      01

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


