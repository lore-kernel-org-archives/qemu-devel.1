Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A8C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E51020830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E51020830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8idd-0001Qf-GX
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i8ic0-0000UX-LD
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i8ibz-0000Gv-5B
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:15:32 -0400
Received: from kerio.kamp.de ([195.62.97.192]:42252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1i8iby-0000Dw-VB
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 06:15:31 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:15:19 +0200
Received: (qmail 61689 invoked from network); 13 Sep 2019 10:15:21 -0000
Received: from ac4.vpn.kamp-intra.net (HELO ?172.20.250.4?)
 (pl@kamp.de@::ffff:172.20.250.4)
 by submission.kamp.de with ESMTPS (AES128-SHA encrypted) ESMTPA;
 13 Sep 2019 10:15:21 -0000
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190910154110.6905-1-pl@kamp.de>
 <20190910154110.6905-2-pl@kamp.de>
 <ede55319-ca74-ab1c-6b3e-8558d9e6bdd8@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <237b736e-31ef-c09f-9332-73b0705ef1ca@kamp.de>
Date: Fri, 13 Sep 2019 12:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ede55319-ca74-ab1c-6b3e-8558d9e6bdd8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: Re: [Qemu-devel] [PATCH V2 1/2] block/nfs: tear down aio before
 nfs_close
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, ronniesahlberg@gmail.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.09.19 um 11:51 schrieb Max Reitz:
> On 10.09.19 17:41, Peter Lieven wrote:
>> nfs_close is a sync call from libnfs and has its own event
>> handler polling on the nfs FD. Avoid that both QEMU and libnfs
>> are intefering here.
>>
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  block/nfs.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
> I’ve just seen that Kevin has already included the second patch (in its
> v1) in his pull request.
>
> So all that I can do is take this patch, which sounds good to me,
> especially since Ronnie has agreed that we should remove our FD handler
> there.
>
> (So I’ve rebased the patch on top of Kevin’s pull request, and I’ve
> taken it to my block branch.)


Thank you. After I discovered that we had this bug also before I added the nfs_umount call I thought

it would be good to have this patch first and the add the umount call because the fix should also go into

stable because in theory we could also run into trouble with just the *sync* nfs_clsoe call.


Peter



