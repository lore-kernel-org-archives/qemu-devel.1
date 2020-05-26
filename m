Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F41C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2351D20787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnQviRad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2351D20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcSH-0003GD-AY
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcQh-00011X-Dc
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:27:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcQf-0001Td-4v
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590510467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8RiUdp4UtY7imz0c0+ZlJIjYzT4VB53SY0luOLORZ4=;
 b=gnQviRadUuPzCplFdMJ3r8IuYZJg7unTO46/ojQwVGvuX04FMdBF810cJz+jK6wQRhl6lg
 U1GOv7ZAFtuMfy4edihvLjv3FjFFn+XMtfvXZ2L4FgI1qq9f+KMKXxAe/TPCubwVI7vzfX
 Z5pqxX6aEj0uVX2OPM7oxbC2RG2FkBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-aCLaN0h1NYWff9unM_rfGg-1; Tue, 26 May 2020 12:27:42 -0400
X-MC-Unique: aCLaN0h1NYWff9unM_rfGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF6B107ACCD;
 Tue, 26 May 2020 16:27:41 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAB0A5D9E5;
 Tue, 26 May 2020 16:27:40 +0000 (UTC)
Subject: Re: [PATCH v6 4/5] qemu-img: Add convert --bitmaps option
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200521192137.1120211-1-eblake@redhat.com>
 <20200521192137.1120211-5-eblake@redhat.com>
 <365251de-7e67-afcb-475c-98a57fdc2568@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e0e665de-8567-233d-af60-420355cea1cf@redhat.com>
Date: Tue, 26 May 2020 11:27:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <365251de-7e67-afcb-475c-98a57fdc2568@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/25/20 2:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 21.05.2020 22:21, Eric Blake wrote:
>> Make it easier to copy all the persistent bitmaps of (the top layer
>> of) a source image along with its guest-visible contents, by adding a
>> boolean flag for use with qemu-img convert.  This is basically
>> shorthand, as the same effect could be accomplished with a series of
>> 'qemu-img bitmap --add' and 'qemu-img bitmap --merge -b source'
>> commands, or by their corresponding QMP commands.
>>
>> Note that this command will fail in the same scenarios where 'qemu-img
>> measure' omits a 'bitmaps size:' line, namely, when either the source
>> or the destination lacks persistent bitmap support altogether.
>>
>> See also https://bugzilla.redhat.com/show_bug.cgi?id=1779893
>>
>> While touching this, clean up a couple coding issues spotted in the
>> same function: an extra blank line, and merging back-to-back 'if
>> (!skip_create)' blocks.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
> 

>> @@ -2573,6 +2632,13 @@ static int img_convert(int argc, char **argv)
>>       }
>>       out_bs = blk_bs(s.target);
>>
>> +    if (nbitmaps > 0 && 
>> !bdrv_supports_persistent_dirty_bitmap(out_bs)) {
> 
> We will not fail, if target doesn't support bitmaps, source supports 
> them but has no bitmaps? Doesn't seem to be a problem, but a bit less 
> strict than you write in commit message.
> 
> So, maybe, s/nbitmaps > 0/bitmaps/

In fact, nbitmaps is not needed at all (it was useful in earlier 
iterations, but as the series has morphed, it is no longer buying me 
anything useful).

> 
>> +        error_report("Format driver '%s' does not support bitmaps",
>> +                     out_fmt);
> 
> Hmm seems, out_fmt may be NULL at this point, consider the path:
> const char *out_fmt = NULL
> ...
> [no -O option]
> --target-image-opts, so out_fmt doesn't default to "raw" but remains NULL
> ...
> 
> So, with s/out_fmt/out_bs->drv->format_name/ (and with or without 
> s/nbitmaps > 0/bitmaps/):
> 
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Okay, I'm squashing this in, and adding your R-b.  Pull request coming 
shortly.

diff --git i/qemu-img.c w/qemu-img.c
index 8ecebe178890..d7e846e60742 100644
--- i/qemu-img.c
+++ w/qemu-img.c
@@ -2196,7 +2196,6 @@ static int img_convert(int argc, char **argv)
      bool force_share = false;
      bool explict_min_sparse = false;
      bool bitmaps = false;
-    size_t nbitmaps = 0;

      ImgConvertState s = (ImgConvertState) {
          /* Need at least 4k of zeros for sparse detection */
@@ -2565,10 +2564,8 @@ static int img_convert(int argc, char **argv)
          }
      }

-    /* Determine how many bitmaps need copying */
+    /* Determine if bitmaps need copying */
      if (bitmaps) {
-        BdrvDirtyBitmap *bm;
-
          if (s.src_num > 1) {
              error_report("Copying bitmaps only possible with single 
source");
              ret = -1;
@@ -2579,11 +2576,6 @@ static int img_convert(int argc, char **argv)
              ret = -1;
              goto out;
          }
-        FOR_EACH_DIRTY_BITMAP(blk_bs(s.src[0]), bm) {
-            if (bdrv_dirty_bitmap_get_persistence(bm)) {
-                nbitmaps++;
-            }
-        }
      }

      /*
@@ -2632,9 +2624,9 @@ static int img_convert(int argc, char **argv)
      }
      out_bs = blk_bs(s.target);

-    if (nbitmaps > 0 && !bdrv_supports_persistent_dirty_bitmap(out_bs)) {
+    if (bitmaps && !bdrv_supports_persistent_dirty_bitmap(out_bs)) {
          error_report("Format driver '%s' does not support bitmaps",
-                     out_fmt);
+                     out_bs->drv->format_name);
          ret = -1;
          goto out;
      }
@@ -2700,7 +2692,7 @@ static int img_convert(int argc, char **argv)
      ret = convert_do_copy(&s);

      /* Now copy the bitmaps */
-    if (nbitmaps > 0 && ret == 0) {
+    if (bitmaps && ret == 0) {
          ret = convert_copy_bitmaps(blk_bs(s.src[0]), out_bs);
      }



-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


