Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6383C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB3720896
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 21:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB3720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50127 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPCsv-0006RH-Oz
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 17:16:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hPCrv-0005wo-St
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hPCru-000511-DJ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:15:51 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hPCru-000503-6W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 17:15:50 -0400
Received: by mail-oi1-f174.google.com with SMTP id v2so2116692oie.6
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 14:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=35IeoSCSHMgwNqlDgzQKgC46QY1T04kechgEPuAEDqw=;
	b=WVE0sJmwBgb1uMvnmoIb1v3gytUGWGdIqPxlKiDFXofldcRIkkuz8flulx1+dXslKN
	42VMnY+rOGR7pP4cqy34U3sxqrZrAG6s2Gucdd3jQRndzqUTuTm/mm1WQELR+edH6Ylf
	p8RhQdduS/nD0oE4ZHmjO9WHsrQi08TbxFjmy4T+vM52o3JaWPawN84yUdHAUa/xmMIj
	J5tFTSZHDAnmShc1t//lLhOrLPz6yitiBBzEYdHbm+ZkT3ivDUFgaxC7Q3smyxycvzbm
	7qkmBS4W1lbS5MauI+ewPZrZtCU4LDsalZWKWy3vrKsMGgIPIrFYujJVURspgHHfOWmY
	zziA==
X-Gm-Message-State: APjAAAVYm3eU8PLC5ehF7gXI256Llkm7Bt9cKPre9I43/PvNavBrv1bp
	87A/qO9JYh2OYQZwCoDdsKLJ7e/nZ6tWD3B+F40w2Q==
X-Google-Smtp-Source: APXvYqzz2QO/9jQK5l/NOi6BQ5qxsvNbxNZsvrS38OQlLnsBshOkwSPnktlYdEwvCNnfn4ayrJdxz/ITyhM7eBHVyTg=
X-Received: by 2002:a54:4d9d:: with SMTP id y29mr6448784oix.135.1557522948143; 
	Fri, 10 May 2019 14:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
	<61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
	<67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
	<CAMr-obv28mp9bABmm906tnwfkBp93ATeEsuaUt-o=Ti75N_1DQ@mail.gmail.com>
In-Reply-To: <CAMr-obv28mp9bABmm906tnwfkBp93ATeEsuaUt-o=Ti75N_1DQ@mail.gmail.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 11 May 2019 00:15:34 +0300
Message-ID: <CAMRbyyv7etEykB456u9-MVWtBo97kUhsCOGrOXM+UPo-p9f6qA@mail.gmail.com>
To: Nir Soffer <nirsof@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.174
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-block] Failing QEMU iotest 175
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 4, 2019 at 12:32 AM Nir Soffer <nirsof@gmail.com> wrote:

>
>
> On Fri, May 3, 2019, 23:21 Eric Blake <eblake@redhat.com> wrote:
>
>> ...
>> >>>  == creating image with preallocation off ==
>> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>> preallocation=off
>> >>> -size=1048576, blocks=0
>> >>> +size=1048576, blocks=2
>> >>>
>> >>>  == creating image with preallocation full ==
>> >>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>> preallocation=full
>> >>> -size=1048576, blocks=2048
>> >>> +size=1048576, blocks=2050
>> >>
>> >> 2048/2050, so we DO have some indication of whether the file is sparse
>> >> or fully allocated.
>> >
>> > Maybe we could check that the value after "blocks=" is a single digit in
>> > the first case, and matches "blocks=20.." in the second case?
>>
>> I wonder if 'qemu-img map --output=json $TEST_IMG' might be any more
>> reliable (at least for ignoring any extra block allocations associated
>> with the file, if it is some journaling option or xattr or other reason
>> why your files seem to occupy more disk sectors than just the size of
>> the file would imply).
>>
>
> I think it should work better and is more correct, testing actual
> sparsness instead of underlying file system implementation.
>
> I can send a fix next week.
>

I tested this change:

$ git diff
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index d0ffc495c2..0e3faa50e4 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -43,17 +43,17 @@ _supported_os Linux
 size=1m

 echo
 echo "== creating image with default preallocation =="
 _make_test_img $size | _filter_imgfmt
-stat -c "size=%s, blocks=%b" $TEST_IMG
+$QEMU_IMG map -f $IMGFMT --output json "$TEST_IMG"

 for mode in off full falloc; do
     echo
     echo "== creating image with preallocation $mode =="
     IMGOPTS=preallocation=$mode _make_test_img $size | _filter_imgfmt
-    stat -c "size=%s, blocks=%b" $TEST_IMG
+    $QEMU_IMG map -f $IMGFMT --output json "$TEST_IMG"
 done

 # success, all done
 echo "*** done"
 rm -f $seq.full

It almost works:
$ ./check -raw 175
QEMU          --
"/home/nsoffer/src/qemu/build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
-nodefaults -machine accel=qtest
QEMU_IMG      --
"/home/nsoffer/src/qemu/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/nsoffer/src/qemu/build/tests/qemu-iotests/../../qemu-io"  --cache
writeback -f raw
QEMU_NBD      --
"/home/nsoffer/src/qemu/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- raw
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 lean 5.0.11-100.fc28.x86_64
TEST_DIR      -- /home/nsoffer/src/qemu/build/tests/qemu-iotests/scratch
SOCKET_SCM_HELPER --
/home/nsoffer/src/qemu/build/tests/qemu-iotests/socket_scm_helper

175         - output mismatch (see 175.out.bad)
--- /home/nsoffer/src/qemu/tests/qemu-iotests/175.out 2019-03-23
18:35:17.788177871 +0200
+++ /home/nsoffer/src/qemu/build/tests/qemu-iotests/175.out.bad 2019-05-11
00:06:09.515873624 +0300
@@ -2,17 +2,17 @@

 == creating image with default preallocation ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-size=1048576, blocks=0
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false,
"offset": 0}]

 == creating image with preallocation off ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=off
-size=1048576, blocks=0
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false,
"offset": 0}]

 == creating image with preallocation full ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 preallocation=full
-size=1048576, blocks=2048
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true,
"offset": 0}]

 == creating image with preallocation falloc ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
preallocation=falloc
-size=1048576, blocks=2048
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false,
"offset": 0}]
The "falloc" test looks exactly like "off", qemu-img map does not report
the allocation
status.
Nir
