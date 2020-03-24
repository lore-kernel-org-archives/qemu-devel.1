Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB7C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5852D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mk0MzPEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5852D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiF0-0002CC-5A
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGiDs-0001Cy-9v
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGiDq-0007Vo-D6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:59:56 -0400
Received: from mail-eopbgr10108.outbound.protection.outlook.com
 ([40.107.1.108]:6862 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGiDk-0007U2-0J; Tue, 24 Mar 2020 07:59:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfe1/tp3xBRXDPZAUAo6ZtdO8PH+G8fQlmJctITEymEkf2+g4aR7Gm7eygIbwb0LCYwE/FHETXYjoUh8baKK4sJIfh7ONIERqmijn2IXgmk1lzN1Z6PeGd1FHCUitXYrsqd3L5FD+ZhIyiQD45XYCcquYdQtvL97u/9d1Xhm7Gsf3hERcpShwOijEtloyyYd5UG503TkIL5HJgDcXKBwLqdXaH/6sYlU76Dk97/xGjHxSaIFzGce/7tA3upRmW7s/vUqSsQPFLT+WYzgaZkdc3Pdp53YOJMFFuCSfo7WYx3NuX10+ks/6IBQnkfEi+q9pSKeXtnw00nj0pYG0LwDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfIEnYlQ3fUxVR7J49IktVO/gd02+6aDfqlHFUqkBEk=;
 b=YYyHhJd8Toz1f1RQkhalWQBFEcZ5Wi7wYfaXSwQ+8HkVPIICQ94u4klgS0zbq4XDky0qIN179psIgxNAH4EFcHwlss2awOIafv6/m/cGqolUSkzTVKJE9E8bCkcVXMsqdJpSjNVzosRk7Ow1ok+B+kji1xkjcB8Gq6aaM3IZmVeOpJlulLZ8EQROW2ojNgSKYgARssAhSLGxvyYXgWL/MqffWbl4UtaWiJglmTKqOqF0dGcb+gRESb6kZkbT8yL33w7vd+nIS7D9smA4Xf5hhCgHouPGwgOXuJfvCBQR9+zzK5EzDOOKC/9C3L2SRy4sQDzszbvxKC4pT2Opnuuyfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfIEnYlQ3fUxVR7J49IktVO/gd02+6aDfqlHFUqkBEk=;
 b=mk0MzPEHIfaeMPerCy2mkwYdjm85TANQlV8vB7hvWdBuT7iirF4sLrbGs6fun5I5qWNwl35OTV/x3eeNQCBXa3HxbUeP5hWWAMPWOZ/Lc1M7jhVrneuI+TkM0qiaSQ5yzvGIfyYCiGQvF1K4IAmjdrBbLBghklgBsFynF6wYLKA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5333.eurprd08.prod.outlook.com (10.141.172.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 11:59:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 11:59:45 +0000
Subject: Re: Potential Null dereference
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <CAGT9xrCJSy6yQ48p3hCRuwgV7t8vPS7eo+83_pOiPp0gDOfvvQ@mail.gmail.com>
 <336bbdf8-140a-e884-d5d1-0610a9b1c6a6@redhat.com>
 <20200324095056.GD5417@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200324145942498
Message-ID: <b432626a-49c9-255e-5e26-b296490a52cd@virtuozzo.com>
Date: Tue, 24 Mar 2020 14:59:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200324095056.GD5417@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0342.eurprd05.prod.outlook.com
 (2603:10a6:7:92::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.15) by
 HE1PR05CA0342.eurprd05.prod.outlook.com (2603:10a6:7:92::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 11:59:44 +0000
X-Tagtoolbar-Keys: D20200324145942498
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96d7ebf6-a995-4fa6-8e04-08d7cfead801
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5333B6C776D208B5B2746144C1F10@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(396003)(39850400004)(376002)(136003)(6486002)(66946007)(8676002)(3480700007)(2616005)(81166006)(966005)(8936002)(956004)(81156014)(52116002)(316002)(16576012)(186003)(26005)(16526019)(2906002)(54906003)(53546011)(7116003)(31696002)(110136005)(66556008)(66476007)(36756003)(4326008)(5660300002)(31686004)(86362001)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5333;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2MIR0XVkit7E3iRvNjte5elvWja0ItxO1c/rQ1RQkodHSRjqp2i8pxUEd+So3JgzfrF72VPFXM5+laOfxq5vQec65cHJFKOO9ZjDUnpPUAGTu15E0QC0scWhb83LpYw7NKlYwE0aYeBWtCVnBsuG4dAL0YGFKzi/a/HXEMzdaOdp2PEbozZXp5h8iBjZ34fsnypYmI3OQkIkd2huV3lb/Hk463ABtpAhX979xT5YPmqElGP7Bqy3MfL870DByURpK7UBlN+52dBFUyiJs3f87iC/leQlqVKal/V7F6Ok0hPyPyhSWN/hk0Qp+ppFLqdmTgxSG7+gQBbW7VPI/ozAZcD21oP7ImRQ9JWpxsAeDiFz3Xxi2Tz6lM+I1WvelJ2pQ81/bbxsVGQNuMtPyz/AuH34+6siSPo/H0piHcffU4Z9N18rnAge0R6e8GyJTuB9X5CbMDT2kgiA9CsrhTw5PCK38ObRrFp1Y/ZpX3q27JIixoKXv57Tka8psVZ2cS/ZvIQyqHIuffloX3a/2goWQ==
X-MS-Exchange-AntiSpam-MessageData: SUSbgD0IiB1RQI26asigDkRez46gn9239v9NpnkGntOp9c6BojPW8g6coSUAxmNYMcD20l/1ZSHqzscs8iwYZXxdvsOYmVAQisleuUiju//os29AKYx78sTdrXV5LbBCxo0vu0wZnwXInkk4c93oNw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d7ebf6-a995-4fa6-8e04-08d7cfead801
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 11:59:45.1065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3JwefVshKREHWxwox9C0JiLY49lN+RNIn5HSuZi3PLK8Q2ysK6ygEPn7+O/qwKoEjif8F1Kvs6olYbZeh5sBWqBFqnFWl3FegFvD4W3rlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.108
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
Cc: Mansour Ahmadi <ManSoSec@gmail.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.03.2020 12:50, Kevin Wolf wrote:
> Am 24.03.2020 um 08:14 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> On 3/24/20 4:05 AM, Mansour Ahmadi wrote:
>>> Hi,
>>>
>>> Nullness of=C2=A0 needs to be checked here:
>>> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4d=
f76/block/commit.c#L221
>>>
>>> pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),...
>=20
> Do you have a reproducer? It's not obvious to me how bs->backing could
> be NULL here.
>=20
>>>
>>> While it is done at 2 other locations:
>>> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4d=
f76/block/backup-top.c#L113
>>> https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4d=
f76/block/mirror.c#L1477
>=20
> Commit 18775ff3269 made the change for mirror, however its commit
> message is terse and doesn't say anything about the scenario where it
> would happen. We also didn't add a test case for it. I would have
> expected that failure to add the backing file would immediately error
> out and not try to refresh the filename first.
>=20
> backup-top.c has the check from the beginning. I assume it just copied
> it from mirror.
>=20
> Vladimir, do you remember the details?
>=20

No :(
But I believe that "Backing may be zero after failed bdrv_attach_child in b=
drv_set_backing_hd, which leads to SIGSEGV." means real problem, probably r=
eproduced on some experiment branch, not on master.

Let's try most simple check:

apply the following:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
diff --git a/include/block/block.h b/include/block/block.h
index e569a4d747..dc20b55075 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -298,6 +298,8 @@ BdrvChild *bdrv_open_child(const char *filename,
                             const BdrvChildRole *child_role,
                             bool allow_none, Error **errp);
  BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
+void bdrv_set_backing_hd_ex(BlockDriverState *bs, BlockDriverState *backin=
g_hd,
+                            bool bdrv_attach_child_fail, Error **errp);
  void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_=
hd,
                           Error **errp);
  int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
diff --git a/block.c b/block.c
index a2542c977b..21b6124d73 100644
--- a/block.c
+++ b/block.c
@@ -2743,8 +2743,8 @@ static bool bdrv_inherits_from_recursive(BlockDriverS=
tate *child,
   * Sets the backing file link of a BDS. A new reference is created; calle=
rs
   * which don't need their own reference any more must call bdrv_unref().
   */
-void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_h=
d,
-                         Error **errp)
+void bdrv_set_backing_hd_ex(BlockDriverState *bs, BlockDriverState *backin=
g_hd,
+                            bool bdrv_attach_child_fail, Error **errp)
  {
      bool update_inherits_from =3D bdrv_chain_contains(bs, backing_hd) &&
          bdrv_inherits_from_recursive(backing_hd, bs);
@@ -2766,8 +2766,14 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Block=
DriverState *backing_hd,
          goto out;
      }

-    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child_ba=
cking,
-                                    errp);
+    if (bdrv_attach_child_fail) {
+        bs->backing =3D NULL;
+        error_setg(errp, "Unpredicted failure :)");
+    } else {
+        bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &chil=
d_backing,
+                                        errp);
+    }
+
      /* If backing_hd was already part of bs's backing chain, and
       * inherits_from pointed recursively to bs then let's update it to
       * point directly to bs (else it will become NULL). */
@@ -2779,6 +2785,12 @@ out:
      bdrv_refresh_limits(bs, NULL);
  }

+void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_h=
d,
+                         Error **errp)
+{
+    bdrv_set_backing_hd_ex(bs, backing_hd, false, errp);
+}
  /*
   * Opens the backing file for a BlockDriverState if not yet open
   *
diff --git a/block/mirror.c b/block/mirror.c
index 447051dbc6..907bb2b718 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -675,7 +675,7 @@ static int mirror_exit_common(Job *job)
      if (!abort && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
          BlockDriverState *backing =3D s->is_none_mode ? src : s->base;
          if (backing_bs(target_bs) !=3D backing) {
-            bdrv_set_backing_hd(target_bs, backing, &local_err);
+            bdrv_set_backing_hd_ex(target_bs, backing, true, &local_err);
              if (local_err) {
                  error_report_err(local_err);
                  ret =3D -EPERM;
@@ -1477,6 +1477,7 @@ static void bdrv_mirror_top_refresh_filename(BlockDri=
verState *bs)
      if (bs->backing =3D=3D NULL) {
          /* we can be here after failed bdrv_attach_child in
           * bdrv_set_backing_hd */
+        abort();
          return;
      }
      pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[root@kvm qemu-iotests]# git grep -il mirror ??? | xargs
030 041 044 094 109 127 129 132 139 141 151 152 155 156 185 194 218 219 229=
 235 248 255 257 281

check -qcow2 030 041 044 094 109 127 129 132 139 141 151 152 155 156 185 19=
4 218 219 229 235 248 255 257 281
...
Failures: 041 141 155


Have several core dumps, look at one:


Wow! These crashes are due to another bug: use after free!

Fix it:

diff --git a/block/mirror.c b/block/mirror.c
index 907bb2b718..22cf48e46a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -678,6 +678,7 @@ static int mirror_exit_common(Job *job)
              bdrv_set_backing_hd_ex(target_bs, backing, true, &local_err);
              if (local_err) {
                  error_report_err(local_err);
+                local_err =3D NULL;
                  ret =3D -EPERM;
              }
          }
@@ -716,6 +717,7 @@ static int mirror_exit_common(Job *job)
          bdrv_drained_end(target_bs);
          if (local_err) {
              error_report_err(local_err);
+            local_err =3D NULL;
              ret =3D -EPERM;
          }
      }


Roll:


make -j9 && check -qcow2 030 041 044 094 109 127 129 132 139 141 151 152 15=
5 156 185 194 218 219 229 235 248 255 257 281

Aha, new crashes! Let's look at them.

41 and 155 failed with crash, 141 without but I see "+{"error": {"class": "=
GenericError", "desc": "Block device drv0 is in use"}}" in its output.

Hmm, but all crashes are because of assert(QTAILQ_EMPTY(&all_bdrv_states));=
 in bdrv_close_all..

So, we have a problem, but another one..

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hm, looking through our downstream branches, I found that originally the co=
mmit
"block/mirror: check backing in bdrv_mirror_top_refresh_filename" was to fi=
x crash in our internal test.

I'll provide all my investigation from our jira below, it was 28 Sep 2017


#0 bdrv_mirror_top_refresh_filename (bs=3D0x5616df9a7400, opts=3D0x5616df26=
8400) at block/mirror.c:1203
#1 0x00005616ddc3d35f in bdrv_refresh_filename (bs=3D0x5616df9a7400) at blo=
ck.c:4739
#2 0x00005616ddc3d672 in bdrv_set_backing_hd (bs=3Dbs@entry=3D0x5616df9a740=
0, backing_hd=3Dbacking_hd@entry=3D0x5616df25c000, errp=3Derrp@entry=3D0x7f=
fff7896a20) at block.c:2035
#3 0x00005616ddc3dee3 in bdrv_append (bs_new=3Dbs_new@entry=3D0x5616df9a740=
0, bs_top=3Dbs_top@entry=3D0x5616df25c000, errp=3Derrp@entry=3D0x7ffff7896a=
d8) at block.c:3168
#4 0x00005616ddc84e5f in mirror_start_job (job_id=3Djob_id@entry=3D0x5616dd=
d16a31 "commit", bs=3Dbs@entry=3D0x5616df25c000, creation_flags=3Dcreation_=
flags@entry=3D0, target=3Dtarget@entry=3D0x5616df262800,
replaces=3Dreplaces@entry=3D0x0, speed=3Dspeed@entry=3D0, granularity=3D655=
36, granularity@entry=3D0, buf_size=3D16777216, buf_size@entry=3D0, backing=
_mode=3Dbacking_mode@entry=3DMIRROR_LEAVE_BACKING_CHAIN,
on_source_error=3Don_source_error@entry=3DBLOCKDEV_ON_ERROR_REPORT, on_targ=
et_error=3Don_target_error@entry=3DBLOCKDEV_ON_ERROR_REPORT, unmap=3Dunmap@=
entry=3Dtrue, cb=3Dcb@entry=3D0x5616ddc35470 <common_block_job_cb>,
opaque=3Dopaque@entry=3D0x7ffff7896c80, errp=3Derrp@entry=3D0x7ffff7896bd0,=
 driver=3Ddriver@entry=3D0x5616ddf8d100 <commit_active_job_driver>, is_none=
_mode=3Dis_none_mode@entry=3Dfalse, base=3Dbase@entry=3D0x5616df262800,
auto_complete=3Dauto_complete@entry=3Dfalse, filter_node_name=3Dfilter_node=
_name@entry=3D0x0) at block/mirror.c:1314
#5 0x00005616ddc87580 in commit_active_start (job_id=3Djob_id@entry=3D0x561=
6ddd16a31 "commit", bs=3Dbs@entry=3D0x5616df25c000, base=3Dbase@entry=3D0x5=
616df262800, creation_flags=3Dcreation_flags@entry=3D0,
speed=3Dspeed@entry=3D0, on_error=3Don_error@entry=3DBLOCKDEV_ON_ERROR_REPO=
RT, filter_node_name=3Dfilter_node_name@entry=3D0x0, cb=3Dcb@entry=3D0x5616=
ddc35470 <common_block_job_cb>, opaque=3Dopaque@entry=3D0x7ffff7896c80,
errp=3Derrp@entry=3D0x7ffff7896c78, auto_complete=3Dauto_complete@entry=3Df=
alse) at block/mirror.c:1463
#6 0x00005616ddc33a68 in img_commit (argc=3D<optimized out>, argv=3D<optimi=
zed out>) at qemu-img.c:1013
#7 0x00005616ddc2fa79 in main (argc=3D4, argv=3D0x7ffff7896e00) at qemu-img=
.c:4548

--

static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *o=
pts)
{ bdrv_refresh_filename(bs->backing->bs); pstrcpy(bs->exact_filename, sizeo=
f(bs->exact_filename), bs->backing->bs->filename); }

(gdb) p bs->backing
$2 =3D (BdrvChild *) 0x0


--


(gdb) p errp
$3 =3D (Error **) 0x7ffff7896a20
(gdb) p *errp
$4 =3D (Error *) 0x5616df1c2660
(gdb) p **errp
$5 =3D
{msg =3D 0x5616df2554e0 "Failed to get \"write\" lock", err_class =3D ERROR=
_CLASS_GENERIC_ERROR, src =3D 0x5616ddd267fe "block/file-posix.c", func =3D=
 0x5616ddd26fe0 <__func__.27999> "raw_check_lock_bytes", line =3D 682, hint=
 =3D 0x5616df1fe520}

void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd=
,
Error **errp)
{
if (backing_hd)
{ bdrv_ref(backing_hd); }

if (bs->backing)
{ bdrv_unref_child(bs, bs->backing); }

if (!backing_hd)
{ bs->backing =3D NULL; goto out; }

bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child_backing=
,
errp);
if (!bs->backing)
{ bdrv_unref(backing_hd); }

bdrv_refresh_filename(bs);

(and we call refresh, when backing is zero because of an error)

out:
bdrv_refresh_limits(bs, NULL);
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


So, we can see, that bdrv_refresh_filename() that led to crash is gone in c=
ommit f30c66ba6e417a0 "block: Use bdrv_refresh_filename() to pull", since 4=
.0...

Do we have the bug now? I can't say. Any thoughts?

--=20
Best regards,
Vladimir

