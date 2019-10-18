Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CD7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4612070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4612070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMWC-0004qA-1e
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mszeredi@redhat.com>) id 1iLMVH-0004ON-Iy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mszeredi@redhat.com>) id 1iLMVG-0004mV-Hq
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mszeredi@redhat.com>) id 1iLMVG-0004lD-1B
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:16:50 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAD347BDAE
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:16:48 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id g15so7524579ioc.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 00:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jVwdqHmcYxGVKpfYum8RxEO9PGKsRCEyT+f78UPqT4k=;
 b=I9F20PKnbdEyYk5N35omBJAm4p216+f0E327xRdhyZBp6WR2Og1vb1bI4UbnZJvST8
 bmHieVe6Iv2ZSOz+cbRBQEmAy4z+Nfs9XH9SuXabGWTTx6k2TBHqRZP2tE2tb/4zssil
 YewMXFq/Efk9fRDHt5/N7Kkqczi+mn3uqh8WbjCkBGoLvMq8cnfs8jr1rePJBY1cDqKx
 tooGbzz8j2ERkmmR2fMY4nNLk1pazkKVueIQsmna5JFRrgeOZ9+Py6ZlpR+8TVT4KmhC
 tvuuTxx8r1IT3DeAa6NqMUEWie1Jwx9zapuZWBtNvVd2zCTIJ4m1UnzY9DimMDj2gG2s
 Y9BA==
X-Gm-Message-State: APjAAAWvNPqat5o/ZuKZXEScOxn5vOJmRtEh3A79y+Q5m9VMetJfjgpA
 um3gBBvn1HollJ6shwmrgTmry0d86tkYv4zaJvFTEPtlOxFuVc2K7S8u8kOAMjWaJ8ll1C8sn8+
 byfnwLZs43eD2nX+sPbYHjgZ2YDx5ZR4=
X-Received: by 2002:a5d:8991:: with SMTP id m17mr7295545iol.104.1571383008330; 
 Fri, 18 Oct 2019 00:16:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxK+LA4SPsa9rjCN1Nv1WBT2+/h03zOJgOVYvz0JW1WHkZizzMy6CjEp53TyLDPfhsH/98jfgfbGHFeksMueDo=
X-Received: by 2002:a5d:8991:: with SMTP id m17mr7295530iol.104.1571383008103; 
 Fri, 18 Oct 2019 00:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191016103754.2047-1-misono.tomohiro@jp.fujitsu.com>
 <20191017100528.GA24790@stefanha-x1.localdomain>
 <CAOssrKfR=sfE1RzOXzvPbdQg-g7i5-f8W9y8bWFnO=gyJ2VMsg@mail.gmail.com>
 <20191017160953.GC1266@stefanha-x1.localdomain>
 <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
In-Reply-To: <CAOssrKejcfVWXw6Nu1owyEeofTdVp6BNx4bL91ma2g7bg9-nmg@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Fri, 18 Oct 2019 09:16:36 +0200
Message-ID: <CAOssrKdbAT5s=CYG6PBtE6OYdqgwG8vp9T6QMJpwZ7X3tKjPmg@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH 0/2] virtiofsd: Two fix for xattr operation
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000001b63d05952a1eed"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: virtio-fs@redhat.com, Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000001b63d05952a1eed
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 17, 2019 at 6:48 PM Miklos Szeredi <mszeredi@redhat.com> wrote:

> Even simpler: allow O_PATH descriptors for f*xattr().

Attached patch.  Will post shortly.

However, I think it would make sense to fix virtiofsd as well, as this
will take time to percolate down, even if Al doesn't find anything
wrong with it.

Doing unshare(CLONE_FS) after thread startup seems safe, though must
be careful to change the working directory to the root of the mount
*before* starting any threads.

Thanks,
Miklos

--00000000000001b63d05952a1eed
Content-Type: text/x-patch; charset="US-ASCII"; name="xattr-allow-o_path-descriptors.patch"
Content-Disposition: attachment; 
	filename="xattr-allow-o_path-descriptors.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1vspdh90>
X-Attachment-Id: f_k1vspdh90

ZGlmZiAtLWdpdCBhL2ZzL3hhdHRyLmMgYi9mcy94YXR0ci5jCmluZGV4IDkwZGQ3OGYwZWIyNy4u
ZmQxMzM1Yjg2ZTYwIDEwMDY0NAotLS0gYS9mcy94YXR0ci5jCisrKyBiL2ZzL3hhdHRyLmMKQEAg
LTQ5NSw3ICs0OTUsNyBAQCBTWVNDQUxMX0RFRklORTUobHNldHhhdHRyLCBjb25zdCBjaGFyIF9f
dXNlciAqLCBwYXRobmFtZSwKIFNZU0NBTExfREVGSU5FNShmc2V0eGF0dHIsIGludCwgZmQsIGNv
bnN0IGNoYXIgX191c2VyICosIG5hbWUsCiAJCWNvbnN0IHZvaWQgX191c2VyICosdmFsdWUsIHNp
emVfdCwgc2l6ZSwgaW50LCBmbGFncykKIHsKLQlzdHJ1Y3QgZmQgZiA9IGZkZ2V0KGZkKTsKKwlz
dHJ1Y3QgZmQgZiA9IGZkZ2V0X3JhdyhmZCk7CiAJaW50IGVycm9yID0gLUVCQURGOwogCiAJaWYg
KCFmLmZpbGUpCkBAIC01ODcsNyArNTg3LDcgQEAgU1lTQ0FMTF9ERUZJTkU0KGxnZXR4YXR0ciwg
Y29uc3QgY2hhciBfX3VzZXIgKiwgcGF0aG5hbWUsCiBTWVNDQUxMX0RFRklORTQoZmdldHhhdHRy
LCBpbnQsIGZkLCBjb25zdCBjaGFyIF9fdXNlciAqLCBuYW1lLAogCQl2b2lkIF9fdXNlciAqLCB2
YWx1ZSwgc2l6ZV90LCBzaXplKQogewotCXN0cnVjdCBmZCBmID0gZmRnZXQoZmQpOworCXN0cnVj
dCBmZCBmID0gZmRnZXRfcmF3KGZkKTsKIAlzc2l6ZV90IGVycm9yID0gLUVCQURGOwogCiAJaWYg
KCFmLmZpbGUpCkBAIC02NjIsNyArNjYyLDcgQEAgU1lTQ0FMTF9ERUZJTkUzKGxsaXN0eGF0dHIs
IGNvbnN0IGNoYXIgX191c2VyICosIHBhdGhuYW1lLCBjaGFyIF9fdXNlciAqLCBsaXN0LAogCiBT
WVNDQUxMX0RFRklORTMoZmxpc3R4YXR0ciwgaW50LCBmZCwgY2hhciBfX3VzZXIgKiwgbGlzdCwg
c2l6ZV90LCBzaXplKQogewotCXN0cnVjdCBmZCBmID0gZmRnZXQoZmQpOworCXN0cnVjdCBmZCBm
ID0gZmRnZXRfcmF3KGZkKTsKIAlzc2l6ZV90IGVycm9yID0gLUVCQURGOwogCiAJaWYgKCFmLmZp
bGUpCkBAIC03MjcsNyArNzI3LDcgQEAgU1lTQ0FMTF9ERUZJTkUyKGxyZW1vdmV4YXR0ciwgY29u
c3QgY2hhciBfX3VzZXIgKiwgcGF0aG5hbWUsCiAKIFNZU0NBTExfREVGSU5FMihmcmVtb3ZleGF0
dHIsIGludCwgZmQsIGNvbnN0IGNoYXIgX191c2VyICosIG5hbWUpCiB7Ci0Jc3RydWN0IGZkIGYg
PSBmZGdldChmZCk7CisJc3RydWN0IGZkIGYgPSBmZGdldF9yYXcoZmQpOwogCWludCBlcnJvciA9
IC1FQkFERjsKIAogCWlmICghZi5maWxlKQo=
--00000000000001b63d05952a1eed--

