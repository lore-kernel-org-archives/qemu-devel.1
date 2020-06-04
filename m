Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1A0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A82206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 10:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VACQIMn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A82206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmmN-00036l-Lv
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 06:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgmlR-0002PL-6M
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:06:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgmlQ-00017d-9F
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 06:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591265179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=mFo/T+rA1vQJVNmKMxcCi1+sXrz7Vt3b4atlrrfunOU=;
 b=VACQIMn7+Bc3TzAjnuXEzMeKBGnvSxtQ37O5aDXaBiJObBaAUHMseuIR6V/AfjS48d5mtK
 46m0tIVuCp2OXN/4Cm65e7jP29Tz8BzShuJst/cTMDiKBkqX0+itWxXpOgi+yvUfJZK8KS
 CoME/d4Nc1awHF87DjTL6eClzdT2JZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-CebjqwlIMPu20Dat1ofb4Q-1; Thu, 04 Jun 2020 06:06:15 -0400
X-MC-Unique: CebjqwlIMPu20Dat1ofb4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B15C7441;
 Thu,  4 Jun 2020 10:06:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79D9C5D9D3;
 Thu,  4 Jun 2020 10:06:08 +0000 (UTC)
Subject: Re: [PATCH] iotests: 194: wait migration completion on target too
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200604083341.26978-1-vsementsov@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3afa4d09-521c-2c3a-cfe4-d1440521f3ef@redhat.com>
Date: Thu, 4 Jun 2020 12:06:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200604083341.26978-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, quintela@redhat.com,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/2020 10.33, Vladimir Sementsov-Ogievskiy wrote:
> It is possible, that shutdown on target occurs earlier than migration
> finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
> on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
> busy bitmap, as bitmap migration is ongoing.
> 
> We'll fix bitmap migration to gracefully cancel on early shutdown soon.
> Now let's fix iotest 194 to wait migration completion before shutdown.
> 
> Note that in this test dest_vm.shutdown() is called implicitly, as vms
> used as context-providers, see __exit__() method of QEMUMachine class.
> 
> Actually, not waiting migration finish is a wrong thing, but the test
> started to crash after commit ae00aa239847682
> "iotests: 194: test also migration of dirty bitmap", which added dirty
> bitmaps here. So, Fixes: tag won't hurt.
> 
> Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/194     | 10 ++++++++++
>  tests/qemu-iotests/194.out |  5 +++++
>  2 files changed, 15 insertions(+)

Thanks, this fixes the issue in the gitlab CI:

 https://gitlab.com/huth/qemu/-/jobs/580902477#L3780

Tested-by: Thomas Huth <thuth@redhat.com>


