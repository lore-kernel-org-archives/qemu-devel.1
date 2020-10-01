Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0909EC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577442087D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J9TUgF4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577442087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNz4p-000744-E9
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kNz49-0006V2-76; Thu, 01 Oct 2020 09:56:13 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:28833 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kNz45-0004Gy-0h; Thu, 01 Oct 2020 09:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2hk0nyhDS3T6cTVOwZ41fkX2+hbifZUUaojogTHvMced5x4h/ZMvmlAESVoOEPJCXYvDws3Yd18DYPwn1Bc9QJCLsYIM3kqLDbw8oKRxklW6peKsYrLaz3EeMJdTXHnSISDCGyg4Y2tAsIPedSlFtznuGL8CoZGRvnvoZxeKFI+J4+2lSPd8KCuqn0Y5FaJTcu6QEu6Ix4GEwapzUDANV7kJSu+bzm37ZB4yc7oOfryq2OpirOsnNy5W0ABdv/8ZQmWAMLoslBixULJsPlR5eWAXNDT0tsaP+FF3c8VgQ7Qd9U9DHVhbZio5pgHoU2EzDmRIDeEx9phaA5ytOr6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0ZUXsVhSIrkATOHbH8JmYE+gcrvJtAXes2Dmwfeeng=;
 b=nHcZKwRk6Xoi3XO5l0M/q+O8DSjy7PBcWMycCqGBQ28Mz+33qp4oNcxRDtIznA2pUOgPCqBvkZLBGIaOWODHWWCY0gocWrfdIi3+JiSSOhSK374YJKHNyDa+MgHcsmH1GOdT4S8kmWS6PymQSFWQHigjXOtnes4dAE7FfU4h2G1lT34VEwcgcUuoX15ANwoSVavpBabR5iQT3B9h8+fS6+c0zx4UzhmiUt8hiw918IZvRjDiqbd7zsdV57bsAYsTzaZ7i8v+GTBRrYYBJEB9mCjdEBTnwREbcGLAGH911ZptnuvNf6CQVZvJ+ydSmWkS6Ofs/SThVLs1SbwlDpkMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0ZUXsVhSIrkATOHbH8JmYE+gcrvJtAXes2Dmwfeeng=;
 b=J9TUgF4y44NyCmEH6J5MAyDxe0l8P2JMyoKHswA8/8z0gT7jdRx19L3TQ/y4zmzA36XdB8cNQM6tJ7tUAdqoZ8TuZ7FZE45q4lRt28yhQcROfzdVZBHjPUc8LE7dmkJ6tKKfVL0JZn2jT06ZBUpRWrZEB+zwIIvZZhb0BLKt8Ck=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5384.eurprd08.prod.outlook.com (2603:10a6:20b:10c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 13:56:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 13:56:03 +0000
Subject: Re: [PULL 00/17] Block patches
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20200930101305.305302-1-stefanha@redhat.com>
 <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <137a2b00-88df-a3ab-dd2b-b053a94ee85f@virtuozzo.com>
Date: Thu, 1 Oct 2020 16:56:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <CAFEAcA87+50vkXLkLwVtrtNn4No4Fvsjd+LDEEu2cmhJcQdZ=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR04CA0032.eurprd04.prod.outlook.com
 (2603:10a6:208:122::45) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM0PR04CA0032.eurprd04.prod.outlook.com (2603:10a6:208:122::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend
 Transport; Thu, 1 Oct 2020 13:56:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ebe77e0-e87f-4c35-fb8b-08d86611bc1d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5384:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53849A7A69C72A371CFA9C8CC1300@AM7PR08MB5384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fuXTwTCSpKsy8nq+W93J183apJocVM5FUhIuoH+DVNJWbtGWnsWRqRCl+ryqdwJeLJht2SISsxU5qvHUWABCfSu1o3U6++iZ4iURaKBuoYRM3Hf3tt4/spJjNiyAHymnnW4wPpVCs+Z6af+lhpBZkZr/fqslsYhw56eRIvmZaFZNJMO7eetgxgzLdfss+mufwxuqZCD+6nYE1YebCXv8L+uGkAEeXbpmnI+mJCoTlTYGgVrfzYJzV0fcHJtFuxTgzbx2IRuczVx5rLEANCgkNgWy/Oi6N7xOConWoSp/rjfILvYecM98P8Cor9LdLx2tVwxopl6ZWvZ1hQihr737LxkcdiWXFKEw97T5cV84ErflyIZ8bPe2oP70NFGgbFUaKQ1tFgsmj1KaFlUAIYyEaD1xCQ8InyguhT2t+k/wAFcUXl+bjQReB3yi4lGwnF+lfqqZnT1eYfvnQNmIgwcw7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39830400003)(376002)(8936002)(316002)(956004)(26005)(2616005)(16526019)(186003)(31686004)(83380400001)(2906002)(966005)(4326008)(6486002)(8676002)(478600001)(36756003)(52116002)(66946007)(66556008)(66476007)(5660300002)(31696002)(83080400001)(54906003)(86362001)(16576012)(110136005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: YoNaXdSdqifb0wFEOTiVdX6Lke/VHU2XrjdeEc+ckDcSau3NW1cxpTonva7NjGd78XU1ttRLv77Vs2IINa78Vlt43LkTDHG+I5AdrJtHSM/BBE6UnEdMd9Tw9gD8zeb2XmjWvlPPOpeebppZGDZnKetyVB3F7JHXq5EF8NKpGNeDijJwKDw2q9/70ULZooOArGumwEGzekJOqVeRPanrj7MPjt/BEoblvX17yOkXssCUJ2U/zyJlmzqvzje/ZW+/cjWMuFjlvGF6ub6bxTfGXzOl2rMZ6tNkUJRP4ku16kpw3UgemmL/IiChh4NTLge1q6wXmpbAB4FgmgeB11rVvxzr7m8fcqJKZAciGIEYQsiXyktLs1SG1niw3Lk3Ibkajq8Dnk+3yuhuAFaR7nsmh0YBVk9N674wDv0I/8/d4FWQFHJHPrXDMUu4vfpEmajdDd59zqjiz6u/W4LikuQBlG6M/jaaeCZRfyuXDcXJV7CPgg7+x6Ef3YwzL9gY4JqCKQWRr4ulUdA40OIEqVD0OGNMPm5jzojlGOP1pAHi6ysz56IQ0pcOcT+Z3rFT8G8iNTmgogJ2CY1pOVXG0IxzvYt0OJ5qa/59WzGCga9pyyqst5yPu/38n45Ns+xa5BwJkwZklK5lgo1lPFfMD+HHYQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebe77e0-e87f-4c35-fb8b-08d86611bc1d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 13:56:03.3058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0NS+AsgLZUyf1xWUoIrP2W5TauKkcaXUivNgGA9/zu04e9BMAWVctsFtUGTevAR8zCHCgek1tIwedliV7Xlk8AHdufhfwgXre5LFFWqiYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5384
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 09:56:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

01.10.2020 14:23, Peter Maydell wrote:
> On Wed, 30 Sep 2020 at 11:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> The following changes since commit b150cb8f67bf491a49a1cb1c7da151eeacbdbcc9:
>>
>>    Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 13:18:54 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>>
>> for you to fetch changes up to bc47831ff28d6f5830c9c8d74220131dc54c5253:
>>
>>    util/vfio-helpers: Rework the IOVA allocator to avoid IOVA reserved regions (2020-09-30 10:23:05 +0100)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> Note I have switched from GitHub to GitLab.
>>
>> ----------------------------------------------------------------
> 
> This produces this error message on ppc64be Linux:
> 
> make: Entering directory `/home/pm215/qemu/build/all'
> make[1]: Entering directory `/home/pm215/qemu/slirp'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/home/pm215/qemu/slirp'
> Generating qemu-version.h with a meson_exe.py custom command
> Generating qemu-options.def with a meson_exe.py custom command
> Generating block-gen.c with a custom command
> YAML:1:83: error: unknown enumerated scalar
> {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> "BreakBeforeBraces": "Custom", "SortIncludes": false,
> "MaxEmptyLinesToKeep": 2}
> 
>             ^~~~~~~~
> Error parsing -style: Invalid argument, using LLVM style
> YAML:1:83: error: unknown enumerated scalar
> {"IndentWidth": 4, "BraceWrapping": {"AfterFunction": true},
> "BreakBeforeBraces": "Custom", "SortIncludes": false,
> "MaxEmptyLinesToKeep": 2}
> 
>             ^~~~~~~~
> Error parsing -style: Invalid argument, using LLVM style
> Compiling C object libqemuutil.a.p/util_qemu-error.c.o
> Compiling C object libqemuutil.a.p/util_qemu-sockets.c.o
> Compiling C object libqemuutil.a.p/util_aio-posix.c.o
> Compiling C object libqemuutil.a.p/util_osdep.c.o
> 
> The error does not cause the build to fail, which seems
> like it's also a bug...

YAML:1:83 is most probably "Custom" value for "BeakBeforeBraces" key,
which is needed to enable custom brace wrapping, set with separate
BraceWrapping key.

Not simple to find the version of clang which is first to support "Custom'
here, but at least clang 3.6.1 doesn't support it.

Hm, I can "reproduce" like this:

[root@kvm work]# clang-format -style='{"BreakBeforeBraces": "Mega"}'
int c() {}
YAML:1:23: error: unknown enumerated scalar
{"BreakBeforeBraces": "Mega"}
                       ^~~~~~
Error parsing -style: Invalid argument
[root@kvm work]# echo $?
1

.

Build doesn't fail because clang-formatting of generated code is optional,
and error is ignored. But stderr output of clang-format is still printed
and this is wrong.

To fix we need:

diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index 505e070660..1f66eb903b 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -43,7 +43,7 @@ def prettify(code: str) -> str:
          })
          p = subprocess.run(['clang-format', f'-style={style}'], check=True,
                             encoding='utf-8', input=code,
-                           stdout=subprocess.PIPE)
+                           stdout=subprocess.PIPE, stderr=subprocess.PIPE)
          return p.stdout
      except FileNotFoundError:
          return code



I can send a separate patch if it is convenient.


> 
> (My guess is this is due to some script implicitly wanting
> a newer version of something or other than the PPC box
> happens to have installed, rather than being an endianness
> issue.)
> 
> thanks
> -- PMM
> 


-- 
Best regards,
Vladimir

