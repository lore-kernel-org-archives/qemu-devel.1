Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED9DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F17A20720
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="tML3QVBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F17A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmCYj-0007vf-Rb
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 04:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jmCY7-0007Qq-0r; Fri, 19 Jun 2020 04:38:59 -0400
Received: from mail-eopbgr20110.outbound.protection.outlook.com
 ([40.107.2.110]:41445 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jmCY2-0005Gx-UX; Fri, 19 Jun 2020 04:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgJejUm33A6H4juqXz/xez7+CAiP4QUounQcRAiqF1SBpSNDhtEquj6bVN9Js5ZMawqPh0Tf6bPsMqk8QDQDct3FuuysCdvWIYQf9+uYi5JGW9JhEuf2lEF8vjR6fBxuglqHQtBkohqHauanLl7JMlPKoE5QR8vItlK81quk8EYySH4DF9+9DYOY0hvGD6+0kgb86dvfYvF6OMOqHTUVWwRhoxunI7bZA7kDthv6GtYrmWpnGj36ZsbkrHeRsLwM8dywnew4uYtwywbclmq7dAD7ghHTfE7FVmBBLpL85LWyVGpXbNu+zHz1TkMmLSj06hN/Foy2RbzjSZMm8ih1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elxycdl+BGO8RlIjWOfTZZFgZrR/Snh+Hulb+b6QLow=;
 b=Nxd8Ovp+MpCEW0YZLZDnYplI+0sOGG+bEEJbvUWB4N0npgfa5VjxmD91ahdKRETJ6TcFaMVP/bIpmVkJa0q8AJZkBAFvhjJYAacKHlANS8zQuL1e0FxTKpKkofkIPK7822ZORje1ve2vlTcZK9vvsoi9Nt62PXYsx1YP1BOqbCaNUAWodTII+PGCIATANjF3p+/zSbgFyUejQLMw3SMjCMBzihMIvPIeOmrVfZrzYt1xvhnTi4iYm4KIFkTFAMWWfozaE54dSxHgsCjC7ZeuI4vRPawZGTG6qPSWeUiYlnXssoCAoaKj3xNCGSIgOTT+9Sd1RhTsEhEBlZuff/5BEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elxycdl+BGO8RlIjWOfTZZFgZrR/Snh+Hulb+b6QLow=;
 b=tML3QVBsL/kYahlO3ROAXYXtPQTr41POPGefgNIjSkf36E4/HhTRvweHmErbzyVwnDS/H9I3YxLLY5SaNNSkhlLnzLejsCxzWBj31Td7xkheZpbvAS1hKZGU9TKjoFi5CtJVHbbm5/zQc6b9Df4eVfKRmTKOoDK3msNMZMIJ+Mk=
Authentication-Results: euphon.net; dkim=none (message not signed)
 header.d=none;euphon.net; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3863.eurprd08.prod.outlook.com (2603:10a6:20b:8b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 08:38:50 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 08:38:50 +0000
Subject: Re: pls consider this is [v3] Re: [PATCH 0/2] block: propagate
 discard alignment from format drivers to the guest
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200611171608.22052-1-den@openvz.org>
 <2b9a0ce7-c06b-4b12-2e20-81fd187adadd@openvz.org>
Message-ID: <20754bfd-e3b9-d71f-8a58-2c0e9fc42882@openvz.org>
Date: Fri, 19 Jun 2020 11:38:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <2b9a0ce7-c06b-4b12-2e20-81fd187adadd@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:3:76::12) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0301CA0002.eurprd03.prod.outlook.com (2603:10a6:3:76::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 08:38:49 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 402d7299-2b16-460e-a1cd-08d8142c3106
X-MS-TrafficTypeDiagnostic: AM6PR08MB3863:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3863F1D61BA56DA188CEEAADB6980@AM6PR08MB3863.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgPrIt+CBdjwqNlmZj2aL3nESzwXHl9peESUUTIM2A+oiJLbYThkx3FTZDS8DUtHVa//I1IGDewN8OQn0G6LtQDkaDrv2c0AwG0hAh+J/aV6lKilzqbuXf/vt8UfFXl8s59oF07SWvP5l2sDUIveCH9I6OmeBp1jArCMw56Siq63Br8hFo+X+W4lajDWCadVHc8H3ZMTRf0l4cj2sp6YqyqaVL9NA7YUwJ9ZkGNx21f62O9bUKbXYbC19kWq52KO4OIfd5e5xauQUK5ymScqXr03sdVR/zsPGHyPxWpirXOiqhv1ZSc4i9eyAjbs/DiXDviIPeGuCWfzvWf/GIYn1XyasZrKy3ysd7zRnQNB1e9yT/H/iEcf+d9U8WnkHwkb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39840400004)(376002)(136003)(396003)(83380400001)(52116002)(16576012)(4326008)(316002)(83170400001)(5660300002)(2616005)(956004)(186003)(26005)(8676002)(66476007)(8936002)(66556008)(53546011)(66946007)(16526019)(31696002)(42882007)(36756003)(478600001)(6666004)(6486002)(54906003)(31686004)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eB/naRK6iWrqtnIPmnDQflpPjs7lkP5kPRCXL8p+OdZKuUQSGx8S58LnORqQywInIOcbhAI3hMCB7d9/5gDLMIrlUB6FDbvweV3bI02GljZ98eLNlayRfaTLqpBDVs82M/tOuB3E2QY+u/JxIaXVqb5fzOF6K0eyVj1TpVNc+rpCLk4+CK6usOctcsImaCuI3T3WlNt20Tw511XYdQ3MuGD/uH6UumOlssdsD3832BnXcU63DDaNWYpPa3YzbSh0nA2ibZq29dfQFH7ILtfvVmGkcdg49x6MM6q+R6skymIOLPZTQ1FqmyXqKwArieq/5n87IqG8FDZLHDD4vyyLvbbKl0er82u7htrO5oAfhVpLt4LvESWm89n3ik7+Ik1frAm8AJpb/G4SMYC5mLAcHFY1WFD/zjqVzI9LLui/G8xHRHqWGTRxaLxUO1leFzGXEUJ/OCm38jR0I7Goeyx0oMa2fibL3D7Gqzyeqr/NL3jtdQLof4nY2ibQ48GAUhqe
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 402d7299-2b16-460e-a1cd-08d8142c3106
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 08:38:50.7759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM2Mo0jhx1RpEkeVFff51SWP+C0YhElS9vqNHLNpUvgtJKw3kyjWD7y8vGmoVDTSgaJYu93IZ1xwiLnKep0Png==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3863
Received-SPF: pass client-ip=40.107.2.110; envelope-from=den@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 04:38:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 8:21 PM, Denis V. Lunev wrote:
> On 6/11/20 8:16 PM, Denis V. Lunev wrote:
>> Nowaday SCSI drivers in guests are able to align UNMAP requests before
>> sending to the device. Right now QEMU provides an ability to set
>> this via "discard_granularity" property of the block device which could
>> be used by management layer.
>>
>> Though, in particular, from the point of QEMU, there is
>> pdiscard_granularity on the format driver level, f.e. on QCOW2 or iSCSI.
>> It would be beneficial to pass this value as a default for this
>> property.
>>
>> Technically this should reduce the amount of use less UNMAP requests
>> from the guest to the host. Basic test confirms this. Fedora 31 guest
>> during 'fstrim /' on 32 Gb disk has issued 401/415 requests with/without
>> proper alignment to QEMU.
>>
>> Changes from v2:
>> - 172 iotest fixed
>>
>> Changes from v1:
>> - fixed typos in description
>> - added machine type compatibility layer as suggested by Kevin
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Eduardo Habkost <ehabkost@redhat.com>
>> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> CC: John Snow <jsnow@redhat.com>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Fam Zheng <fam@euphon.net>
>>
>>
> Sorry for missed v3 tag in the subject :(
ping

