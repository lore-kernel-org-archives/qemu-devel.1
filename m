Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FEFC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 10:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAA82070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 10:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vMxODyzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAA82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQBp-0001b7-Jp
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 06:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1jHQAx-000175-Si
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1jHQAw-0000UF-TS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 06:55:51 -0400
Received: from mail-eopbgr60107.outbound.protection.outlook.com
 ([40.107.6.107]:32230 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1jHQAs-0000Rj-EW; Thu, 26 Mar 2020 06:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmJ6UHLlRgOa4/3+u33fdFjaCf/f9dkefmJD5BNPyEfffOarlUeDZyOnjuA5n6KNmPre7LcehIVPUzDtEgcOJ6M9KNiCZxs9klla5GIvZS1sCOYceaVYFXl/ApP3amvlC67ECk1dxl/2+4joXBQylWLLfzKImjz4qoiuFvNmllX8lpoCmr2cxArIYQCKFQJLUMzLSQCuQSrZ9JO/okWmWRbUMP7xZXK35GfE5SsCt2DG/i+FPiZ16VJ6HUXLj/2pcObmIu26EjKvCRkr5cYmUCA8A85XdPbTVqOoZHyThIiiv8GPYPqLxebeIOx6ktp7iFmgCFSqm+isaFABMjA2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3asaRfWhHaCUvWulAQo9w5X4AqtlfMvZlLKulBCYG6U=;
 b=HmBguO7QUI7nVg8J1DjsuJVjS2s2pUM5BmGUmAohh+5v7rCGhdaBWoWzQEr4sgUwdJ8VMwFaqT4CkEe5s7UkZLe/l5KG3DWyZai8gagkr2eNukGP/SDK/5QWcoKXs2NdfW5sqxpyIUfkH3YAcu2F3yWAkjnEt3GG62vaacvnWWlffgqjqjyfQgOlHB+3+lBFUe46UuezJZx48WhwYARJCW6nZO20rAPCPB7SdLLgOIyzt5q8AEG5+xzoODa4KtcCu9m/7KsVxk+rtV6boLRVeMyixqwwxDTk6QTv/T3Dfu8ZE1nyj1XDsKM1ok8DCBum2iRJPstHNNZsQjp1pndW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3asaRfWhHaCUvWulAQo9w5X4AqtlfMvZlLKulBCYG6U=;
 b=vMxODyzyn3Fktt863+usb5YVcbN2vzsx6/lkY9Do+wVB6qrFephEE3lAD9ugmaXqAzhPbOtXKvu55TE+RS3rAN9Z7UwY8PW0a4SGrbtA3nYdOSL94YzrHG7UFRBTUkhRdf8IGp/YzsDVapwS4ptjINGeNqrjJ7IcpIpeGJaoocI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
Received: from DB8PR08MB5276.eurprd08.prod.outlook.com (20.179.15.209) by
 DB8PR08MB5339.eurprd08.prod.outlook.com (52.133.240.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Thu, 26 Mar 2020 10:55:43 +0000
Received: from DB8PR08MB5276.eurprd08.prod.outlook.com
 ([fe80::4de4:7518:6223:5c6b]) by DB8PR08MB5276.eurprd08.prod.outlook.com
 ([fe80::4de4:7518:6223:5c6b%6]) with mapi id 15.20.2835.025; Thu, 26 Mar 2020
 10:55:43 +0000
Subject: Re: [PATCH 0/2] Fix the generic image creation code
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200326011218.29230-1-mlevitsk@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e88167d9-0173-f146-e142-a462dbe5a3c3@openvz.org>
Date: Thu, 26 Mar 2020 13:55:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200326011218.29230-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0060.eurprd05.prod.outlook.com
 (2603:10a6:208:be::37) To DB8PR08MB5276.eurprd08.prod.outlook.com
 (2603:10a6:10:bf::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.45] (31.148.204.195) by
 AM0PR05CA0060.eurprd05.prod.outlook.com (2603:10a6:208:be::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Thu, 26 Mar 2020 10:55:42 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aac5681f-715c-4c2d-c715-08d7d1743b27
X-MS-TrafficTypeDiagnostic: DB8PR08MB5339:
X-Microsoft-Antispam-PRVS: <DB8PR08MB533936F997D940D95381C4BCB6CF0@DB8PR08MB5339.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39850400004)(396003)(376002)(366004)(136003)(5660300002)(2906002)(36756003)(66946007)(52116002)(54906003)(316002)(16576012)(31686004)(4326008)(81156014)(2616005)(66476007)(16526019)(53546011)(81166006)(7416002)(42882007)(31696002)(8676002)(956004)(66556008)(478600001)(186003)(6486002)(26005)(8936002)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5339;
 H:DB8PR08MB5276.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XPZnEpo8qwpS/3yClYB2TVDJbuDpkrxl2X+I2lFltXTvlV+B1krCM+MxF7UDrPLt50N+s+BsC2vBfXkALu35/eCd82q1w9Ic9HQlE5djPZm5n8/WSulr4hNdkHjUIKO6YYvFJLt4YOKwknIsCf/x0okreya1PTygyI53FJ+JpNAXJVL5L5ue5upz5fjbKBl2abAC269iEK/T13m6OED2oh1Q3QNgP71iUkIV3MBB+Abo4Ou3UQDJD2+TIRJeN7WdBxAy+cQLM5Jls2AkjkDWjqUmGCT1NnSfnsbK64QRVGxoRWFSB+nc4OXCimjnGze0R/FOzsotDgXPPRYUo6l2BOotQggaABlQ0hckB/MvBM6+uEvCFvgZ6xrq6jpMAD6Ei6YjA/aYeOwWiF04ANXVO4k4t6cPCCP319wVbeeNKBH64gVhoK90tt+xz30kLbRVkSdRI2/5HndNr7TYns3jxbygkcao9GtEdbwOayh2ZdhUawBRs6v33mPnq0nWrbi
X-MS-Exchange-AntiSpam-MessageData: hUTRNbyO/g9PDx+G6WUW9ROBt6nvlSpmJGCqSRZPbUL6hEr3ys1JhIJeWYEK0wAm9Qvi2kf2HWI0mSNNAAd8dNrFbtnSbe/YjaSXN+ui/M4RKT9wdLKocXbpVigf1wakyQNUewE5s5AUspK7SDgPoA==
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: aac5681f-715c-4c2d-c715-08d7d1743b27
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 10:55:43.7227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZaVR476BLO8UCM9pmONTKJ96siQ1t+55vM9hL6JQQqnt+LAA4mzL+zQ9ZrT1X0grL6PKE8FkfKH2pbIHRc2dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5339
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.107
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jason Dillaman <dillaman@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 4:12 AM, Maxim Levitsky wrote:
> The recent patches from Max Reitz allowed some block drivers to not
> provide the .bdrv_co_create_opts and still allow qemu-img to
> create/format images as long as the image is already existing
> (that is the case with various block storage drivers like nbd/iscsi/nvme, etc)
>
> However it was found out that some places in the code depend on the
> .bdrv_co_create_opts/.create_opts to be != NULL to decide if to allow
> image creation.
>
> To avoid adding failback code to all these places, just make generic failback
> code be used by the drivers that need it, so that for outside user, there
> is no diffirence if failback was used or not.
>
> Best regards,
> 	Maxim Levitsky
>
> Maxim Levitsky (2):
>   block: pass BlockDriver reference to the .bdrv_co_create
>   block: trickle down the fallback image creation function use to the
>     block drivers
>
>  block.c                   | 38 ++++++++++++++++++++++----------------
>  block/crypto.c            |  3 ++-
>  block/file-posix.c        | 11 +++++++++--
>  block/file-win32.c        |  4 +++-
>  block/gluster.c           |  3 ++-
>  block/iscsi.c             | 16 ++++------------
>  block/nbd.c               |  6 ++++++
>  block/nfs.c               |  4 +++-
>  block/nvme.c              |  3 +++
>  block/parallels.c         |  3 ++-
>  block/qcow.c              |  3 ++-
>  block/qcow2.c             |  4 +++-
>  block/qed.c               |  3 ++-
>  block/raw-format.c        |  4 +++-
>  block/rbd.c               |  3 ++-
>  block/sheepdog.c          |  4 +++-
>  block/ssh.c               |  4 +++-
>  block/vdi.c               |  4 +++-
>  block/vhdx.c              |  3 ++-
>  block/vmdk.c              |  4 +++-
>  block/vpc.c               |  6 ++++--
>  include/block/block.h     |  7 +++++++
>  include/block/block_int.h |  3 ++-
>  23 files changed, 95 insertions(+), 48 deletions(-)
>
Reviewed-by: Denis V. Lunev <den@openvz.org>

