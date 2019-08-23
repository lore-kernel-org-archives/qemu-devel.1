Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D485C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1419D22CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1419D22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i163X-000451-7d
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i15zI-0000oz-R0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i15zG-0006o3-HZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i15z9-0006jb-RO; Fri, 23 Aug 2019 05:35:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F16F8C050061;
 Fri, 23 Aug 2019 09:35:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-236.ams2.redhat.com [10.36.116.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E1F56092D;
 Fri, 23 Aug 2019 09:35:52 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190823084203.29734-1-thuth@redhat.com>
 <CAFEAcA9bqzoT01E3tQREeAb1U3UJU0t8rOeX3E=pjmCM3J+O0g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <3ccbd1c5-b60a-eb0b-6870-f6320bcbbbae@redhat.com>
Date: Fri, 23 Aug 2019 11:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bqzoT01E3tQREeAb1U3UJU0t8rOeX3E=pjmCM3J+O0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 23 Aug 2019 09:35:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/check-block: Skip iotests when
 sanitizers are enabled
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 11:04 AM, Peter Maydell wrote:
> On Fri, 23 Aug 2019 at 09:43, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The sanitizers (especially the address sanitizer from Clang) are
>> sometimes printing out warnings or false positives - this spoils
>> the output of the iotests, causing some of the tests to fail.
>> Thus let's skip the automatic iotests during "make check" when the
>> user configured QEMU with --enable-sanitizers.
>=20
> Do you have a log of what the sanitizer is saying?

https://patchew.org/logs/QEMU/testing.asan/?type=3Dproject

Example:

+Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
+    #0 0x562a2ffc3c4e in calloc
(TEST_DIR/build/x86_64-softmmu/qemu-system-x86_64+0x1a16c4e)
+    #1 0x7fca6acf3cf0 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55cf0)
+    #2 0x562a3200c3d0 in bdrv_refresh_filename TEST_DIR/src/block.c:6416=
:12
+    #3 0x562a3200b8f7 in bdrv_refresh_filename TEST_DIR/src/block.c:6388=
:9
+    #4 0x562a3200b8f7 in bdrv_refresh_filename TEST_DIR/src/block.c:6388=
:9
+    #5 0x562a31ffa461 in bdrv_backing_attach TEST_DIR/src/block.c:1064:5
+    #6 0x562a320212c6 in bdrv_replace_child_noperm
TEST_DIR/src/block.c:2283:13
+    #7 0x562a3201ed50 in bdrv_replace_node TEST_DIR/src/block.c:4210:9
+    #8 0x562a32021649 in bdrv_append TEST_DIR/src/block.c:4250:5
+    #9 0x562a3234e573 in commit_start TEST_DIR/src/block/commit.c:307:5
+    #10 0x562a30cc6cce in qmp_block_commit TEST_DIR/src/blockdev.c:3480:=
9
+    #11 0x562a31dceb33 in qmp_marshal_block_commit
TEST_DIR/build/qapi/qapi-commands-block-core.c:407:5
+    #12 0x562a3260be28 in do_qmp_dispatch
TEST_DIR/src/qapi/qmp-dispatch.c:131:5
+    #13 0x562a3260b105 in qmp_dispatch
TEST_DIR/src/qapi/qmp-dispatch.c:174:11
+    #14 0x562a31cd1b15 in monitor_qmp_dispatch
TEST_DIR/src/monitor/qmp.c:120:11
+    #15 0x562a31ccfd45 in monitor_qmp_bh_dispatcher
TEST_DIR/src/monitor/qmp.c:209:9
+    #16 0x562a327a91ea in aio_bh_call TEST_DIR/src/util/async.c:89:5
+    #17 0x562a327a9902 in aio_bh_poll TEST_DIR/src/util/async.c:117:13
+    #18 0x562a327cb590 in aio_dispatch TEST_DIR/src/util/aio-posix.c:459=
:5
+    #19 0x562a327ae933 in aio_ctx_dispatch TEST_DIR/src/util/async.c:260=
:5
+    #20 0x7fca6acededc in g_main_context_dispatch
(/lib64/libglib-2.0.so.0+0x4fedc)

Since there are also lots of these warnings in the output:

+=3D=3D24683=3D=3DWARNING: ASan doesn't fully support makecontext/swapcon=
text
functions and may produce false positives in some cases!

... I'm really not sure whether it makes sense to go bug hunting here.

> (There are quite a lot of sanitizer warnings on running
> the main build too -- at the moment we don't have anything
> in the CI that runs the sanitizers, except that patchew
> does for a limited (x86-targets-only) config, to defend
> the parts that we've managed to make warning-free. But
> I think that the warnings I've looked at are mostly for
> real-but-unimportant leaks, rather than false positives.)

OK. Anyway, since there are also these "WARNING: ASan doesn't fully
support ..." messages in the output, it simply does not make sense to
run the iotests automatically in this case, since the output of the
tests gets spoiled and thus the tests are failing.

 Thomas

