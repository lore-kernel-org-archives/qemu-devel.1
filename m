Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344ACC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC87C207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="c2iPCb6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC87C207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6zv-0006aH-TU
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kD6yw-0004Th-Dd
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:09:54 -0400
Received: from mail-db8eur05on2104.outbound.protection.outlook.com
 ([40.107.20.104]:25344 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kD6yt-0003fQ-16
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbvynnQxPaY7fg84x9YyU3Owako/NjNQIZppuHMHT8uOidEuljR4f/A1uOaKwzshpJ52MHPeK0Q8YVyeJrnpRfE/4DIjxMWdSZi+FACYq6DQH3ah6Q0EqAIAwsHwUUUbLZOEUo63tyCrI1On4YsShMu3rKiAe0yte0qqpJPv8JcMXOniOz9TnxS3TCXPzsgVavktJj8umN1612g/XTS6qmQMS6btf9asY1kL3BtDtsXTkLaS7jiiRp/emmFGu17WNsNapxz3Yiqd+Lbw8apmGu79ClTJZ8RvoyUw9mQMf8J0LrBS6czGTvrWdwjD+S1eEbKOPu3mWgfm22TD3s9XKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWqQwJE+qz+y4F6oTp1pNhvpb7mWIhqld/lH789rufg=;
 b=RxjpZBiTMUY+6ZtG/wwMlKFBxqogDIt5DbLus9rwqsbzrIB3zC8iEnqSey+lQ+f5SPLeRDLEK/UuUmqX23dFNzET4HeeZ3agkToBcSOx+I79k5MFN1SquZ2WAmZTrmZ2Dkg3O0OaNCMeh9mWcpjv8Q4snk6qR5kTclhLLgrOoqpDtirPRNMir8aVg/xG5a1CcuC65HP9osaw476nQFJYOx1Sj0MVc71Ed63iZz5CGqACb4stm7VTKJ/WB4CIPoDg5FRfRGiZHd8dHZiSvE48PaFrs/YG9sCAGeHc3VoMuCLcpUdMy58Q8etIAd6tL/Zgq4ivLU8mMXyL5vz+x54d0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWqQwJE+qz+y4F6oTp1pNhvpb7mWIhqld/lH789rufg=;
 b=c2iPCb6Ra4pq/atB1uQS6B0eioOdKgShI1oWF2HovWgsFeXXOnJKLEEEc1cTjLvZEVAaUCTXXE7YYAK7XJTNVv9JrWXrP0c6KpWXcvEGV8ttbIXumy+nbQK3LmbgsEfdVy+aOetdOc4yDUqrCBCK4U1AZ9ZTnJOeL68hGSRHDGI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB6414.eurprd03.prod.outlook.com (2603:10a6:800:19e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 13:54:43 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Tue, 1 Sep 2020
 13:54:43 +0000
Subject: Re: [PULL 0/8] Linux user for 5.2 patches
To: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20200831110716.536808-1-laurent@vivier.eu>
 <CAFEAcA88ZzORi0FYKevoGkoRAoUHuT=-GXKuYjvx-uBCNJBeyg@mail.gmail.com>
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
Message-ID: <a0b66223-659e-6870-1402-2ed4de451b5e@syrmia.com>
Date: Tue, 1 Sep 2020 15:54:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAFEAcA88ZzORi0FYKevoGkoRAoUHuT=-GXKuYjvx-uBCNJBeyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::33) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.101] (147.91.217.237) by
 AM0P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Tue, 1 Sep 2020 13:54:42 +0000
X-Originating-IP: [147.91.217.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c6bd888-355f-4665-933e-08d84e7e9444
X-MS-TrafficTypeDiagnostic: VI1PR03MB6414:
X-Microsoft-Antispam-PRVS: <VI1PR03MB641449A1DB03FE7CD34A40FAEB2E0@VI1PR03MB6414.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBEJBLcaLHa0pfAt2s3uHzDFSQUDzJowIj0qhQ7T2HTnaD4uGknnPBs6k9vvCfFfmCSbYe5yzKAjFDc3Ow+s7yB+k3MFkBOn5Fvr99RhlPdde0XsIO3Q7SJg/XfNrilU4AuWuL6HZDU08tTfvIK6V52cv9Bqih00ypW+x3Zzogk6Csj2Yt9xo9+nJP9fiPbRgU2+8ncs57YJ5KDYfckFnbURuoZAH94psPIm/vbB1RN/kIVUJ9V2vcgL08DsIDz08KrhmwTvx+FYSVZgvW/JnQ/Hq5g6s6h3UF+Zvbow/UR1PTACJCL8eNO+0+uFNHEfr71/l3Yw/oAW01dO78hRSGgkX8qW8IN65LuswXIXibywUJrlG/8lrG8oqQVa/YkPX/TT4H9UsB/VX1ZROQ7RvXmN5gG12bu9ZFjBg+YP65VWD1jncZqzaFiAxnJ5pb6J5/NGaXiDUdDYx7OYAPtthw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(376002)(346002)(39830400003)(396003)(8936002)(2906002)(4326008)(5660300002)(6486002)(966005)(956004)(478600001)(31696002)(36756003)(110136005)(2616005)(26005)(186003)(66556008)(66476007)(52116002)(66946007)(316002)(16576012)(8676002)(16526019)(86362001)(83380400001)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fIWs7aoth+2Kldt9MlIfUGkivm0fnhOSALDfeKtKOLzkPGrXP1FiuqKD555NEU4B3fj7dj/1cjRXdDuMepuyesp/TuxdLSosZQJy3paCft+ok4SWSh0k8uieLxKbOH4DzZo9KKcp4yn8MqxNll0bhbd/QzJAjUj6uhiOkulsgNKl4se7FuekeyInSCLvqr4DLvNJe8j1ajQod6THPtZ99jQu07COXfogkEka4yvvoYv9LFaHhWPIWpTPmg4I1DkE4hGO0CYnQxD9k1OR4UxxwFpNVGUYZzTV3fHsJHtsvlapv+xZHfKfhcv32LdA9nlJ8KY/swPTLc80KK6UyM6eUgfP1f3jUD8mSLjkAbWrkJQvi9+zjPzW5Aou9ncfy9WYvyYaXWfFP+gS1j3MfEIG8ZI+B8cRFd/zS2JakfsyQnDm6hkcrrkkLM2Lkzm9FCC0tS/DnsW6w8kb0qOpl1tActUEJm1d/aE99lQbfFVuSdSxQfoNFB6CqmUuEMcnj6ZwkZ/GMnl04JpWNzhFLxT6Tk02yhcBQDQTA3cNpwNKAK/v/lOQYzCM7YdMjadooko7OEIRND0g//0Haa4EzYLKHYPm9y7NwyBOcbsAM5NVqXvulpkebDbFexwmJ9j+OR0tyizk72L/Fph8dH2tGE81EQ==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6bd888-355f-4665-933e-08d84e7e9444
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 13:54:43.5991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmHh0aGVO5RekSoBMRDgjuZDr6JVSIIcqrIS+z1XkQrA+cwG+AIjG00/FxrSxO775ImFKqXGbeVRE59wfQHn+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6414
Received-SPF: pass client-ip=40.107.20.104;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:09:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1.9.20. 15:06, Peter Maydell wrote:
> On Mon, 31 Aug 2020 at 12:08, Laurent Vivier <laurent@vivier.eu> wrote:
>> The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:
>>
>>    Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-=
>> request' into staging (2020-08-28 22:30:11 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>>
>> for you to fetch changes up to d6676fc62a52e020df32abf927c2e7183781a2e3:
>>
>>    linux-user: Add support for btrfs ioctls used to scrub a filesystem (2020-0=
>> 8-29 10:14:52 +0200)
>>
>> ----------------------------------------------------------------
>> Add btrfs support
> Fails to build with clang, I'm afraid:
>
> In file included from ../../linux-user/syscall.c:4561:
> ../../linux-user/syscall_types.h:485:33: error: implicit conversion
> from enumeration type 'enum btrfs_dev_stat_values' to different
> enumeration type 'argtype' (aka 'enum argtype')
> [-Werror,-Wenum-conversion]
>         MK_ARRAY(TYPE_ULONGLONG, BTRFS_DEV_STAT_VALUES_MAX), /* values */
>         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/petmay01/linaro/qemu-for-merges/include/exec/user/thunk.h:45:42:
> note: expanded from macro 'MK_ARRAY'
> #define MK_ARRAY(type, size) TYPE_ARRAY, size, type
>                                           ^~~~
> ../../linux-user/syscall.c:4559:79: note: expanded from macro 'STRUCT'
> #define STRUCT(name, ...) static const argtype struct_ ## name ##
> _def[] = {  __VA_ARGS__, TYPE_NULL };
>
>      ~  ^~~~~~~~~~~
> 1 error generated.

There seems to be a problem because 'BTRFS_DEV_STAT_VALUES_MAX' is not a 
predefined value but an enum value from from 'enum btrfs_dev_stat_values':

https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L668

The build problem arises probably when 'thunk_convert()' tries to 
convert this enum value to the thunk enum values 'argtype'. I will see 
about finding a work around for this or maybe use a STRUCT_SPECIAL() for 
'struct btrfs_ioctl_get_dev_stats' to define an explicit converting 
function.

Just curious, on what linux distro are you building on? I didn't come 
accross this build issue on my system.

>
> thanks
> -- PMM
>

