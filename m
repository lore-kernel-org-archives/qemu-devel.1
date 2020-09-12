Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C34C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C9C214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 22:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C9C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHE0w-0008Rp-Vw
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 18:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1kHE0R-00082W-O6; Sat, 12 Sep 2020 18:28:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:59354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1kHE0P-0002g7-Qq; Sat, 12 Sep 2020 18:28:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 575B5AC26;
 Sat, 12 Sep 2020 22:28:38 +0000 (UTC)
Subject: Re: [PATCH] iotests: Allow running from different directory
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20200902110326.257115-1-kwolf@redhat.com>
 <170e9e09-5d81-f75b-fbb1-b60ed0d2e776@redhat.com>
 <20200903172146.GF8835@linux.fritz.box>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <87d167cb-27d2-02ac-9c68-f478097392ac@suse.de>
Date: Sun, 13 Sep 2020 00:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903172146.GF8835@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 23:23:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.543,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 7:21 PM, Kevin Wolf wrote:
> Am 03.09.2020 um 14:54 hat Max Reitz geschrieben:
>> On 02.09.20 13:03, Kevin Wolf wrote:
>>> It is convenient to be able to edit the tests and run them without
>>> changing the current working directory back and forth. Instead of
>>> assuming that $PWD is the qemu-iotests build directory, derive the build
>>> directory from the executed script.
>>>
>>> This allows 'check' to find the required files even when called from
>>> another directory. The scratch directory will still be in the current
>>> working directory.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/check | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>>> index 3ab859ac1a..22ada6a549 100755
>>> --- a/tests/qemu-iotests/check
>>> +++ b/tests/qemu-iotests/check
>>> @@ -44,7 +44,7 @@ then
>>>          _init_error "failed to obtain source tree name from check symlink"
>>>      fi
>>>      source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
>>> -    build_iotests=$PWD
>>> +    build_iotests=$(dirname "$0")
>>
>> This breaks running check from the build tree.
>> (i.e. cd $build/tests/qemu-iotests; ./check)
>>
>> The problem is that to run the test, we do cd to the source directory
>> ($source_iotests), and so $build_iotests then becomes invalid if it’s
>> just a relative path.  In my case, this leads to the following error:
>>
>> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>> +./common.rc: line 139: $QEMU/tests/qemu-iotests/../../qemu-img: No such
>> file or directory
> 
> Ah, my symlinks in the source tree made it work for me.
> 
>> I think this could be resolved by wrapping the $(dirname) in
>> $(realpath), i.e.
>>
>> build_iotests=$(realpath "$(dirname "$0")")
> 
> Sounds good, I'll update it in my tree.
> 
> Kevin
> 

Hello Kevin,

the committed patch in master is now (not sure where it changed):

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 3ab859ac1a..e14a1f354d 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -44,7 +44,7 @@ then
         _init_error "failed to obtain source tree name from check symlink"
     fi
     source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
-    build_iotests=$PWD
+    build_iotests=$(readlink -f $(dirname "$0"))
 else
     # called from the source tree
     source_iotests=$PWD

-----

This seems to break the MacOS build (Cirrus-ci) though:

readlink: illegal option -- f
usage: readlink [-n] [file ...]
./check: line 60: /common.env: No such file or directory
check: failed to source common.env (make sure the qemu-iotests are run from tests/qemu-iotests in the build tree)
gmake: *** [/private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/tests/Makefile.include:144: check-block] Error 1
Exit status: 2

Ciao,

Claudio

