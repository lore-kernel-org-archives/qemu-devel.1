Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C257FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C554B20729
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CO0gsqot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C554B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYT6C-0007Mh-Fa
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 08:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYT4V-0006Gl-KW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:59:55 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYT4T-0001Iv-Ms
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=z1yPrLM1PcxKWC7rpCS9k3euSTAhC56KQxM40HG7/gs=; b=CO0gsqotQTJJppKD0wcl1fIdWv
 EiQQVkUSU82HkelXKgc42E6Va19WYyWwMYqiDJWTguiZXI4k9ts1CwvMkswKhJEH8JpXZt8PQOhj3
 us1L7+0qOTJTNKF4GvxAWay6bdhNKtKNA71lP43Jy8faHQ/D78L5KuCmKrOPbI2CK4UAKR3QsLbvF
 pmrRrDem/hvDVuTgc6G39DIyoHalhpzGk2ZLYpxkCZ1pTLk15Sf0lRRDmj9ocZldtYCqDj+DRD0Lp
 UsQ3Bvwt4rCAE+4eF8786sApSPXuiypPC2+L1sgoARx4hBQser2M40rvPW561v4dOwvKrrgmIw/qG
 xY1fT9KQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] tests/9pfs: fix coverity error in
 create_local_test_dir()
Date: Fri, 30 Oct 2020 12:59:48 +0100
Message-ID: <3565953.R2qxJ1zP7r@silver>
In-Reply-To: <20201030124418.1a20fb9f@bahia.lan>
References: <cover.1604046404.git.qemu_oss@crudebyte.com>
 <b111895492f8fb79bcca1c3e9586c0615f46cc97.1604046404.git.qemu_oss@crudebyte.com>
 <20201030124418.1a20fb9f@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Freitag, 30. Oktober 2020 12:44:18 CET Greg Kurz wrote:
> On Fri, 30 Oct 2020 09:19:46 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > Coverity wants the return value of mkdir() to be checked, so let's
> > pretend to do that. We're actually just making a dummy check and
> > ignore the result, because we actually only care if the required
> > directory exists and we have an existence check for that in place
> > already.
> 
> I see that sometimes changelog shows a copy of the original
> coverity report (e.g. commit df1a312fea58).

Ok, I'll add that.

> > Reported-by: Greg Kurz <groug@kaod.org>
> 
> Please give credits to coverity, not me :-)
> 
> And most importantly, we want to mention the CID in the changelog.
> 
> e.g.
> 
> Reported-by: Coverity (CID 1435963)

Ok.

It's not clear to me where this coverity report is accessible online. A quick 
search only brought me to statistics about its latest check, but not the 
details of the report you quoted.

And more importantly: is there coverity CI support that one could enable on 
github, so that pending patches were checked before upstream merge?

> 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  tests/qtest/libqos/virtio-9p.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/qtest/libqos/virtio-9p.c
> > b/tests/qtest/libqos/virtio-9p.c index 6b22fa0e9a..0a7c0ee5d8 100644
> > --- a/tests/qtest/libqos/virtio-9p.c
> > +++ b/tests/qtest/libqos/virtio-9p.c
> > @@ -48,9 +48,13 @@ static void init_local_test_path(void)
> > 
> >  static void create_local_test_dir(void)
> >  {
> >  
> >      struct stat st;
> > 
> > +    int res;
> > 
> >      g_assert(local_test_path != NULL);
> > 
> > -    mkdir(local_test_path, 0777);
> > +    res = mkdir(local_test_path, 0777);
> > +    if (res < 0) {
> > +        /* ignore error, dummy check to prevent error by coverity */
> 
> Why not printing an error message with errno there like you did in
> the previous patch ?

Yeah, originally I didn't want to trigger false positives on automated CIs if 
mkdir() failed just because the directory already exists. But OTOH 
g_test_message() is just an info-level message, so it is Ok to bark silently 
and I will add it.

> 
> > +    }
> > 
> >      /* ensure test directory exists now ... */
> >      g_assert(stat(local_test_path, &st) == 0);

Thanks!

Best regards,
Christian Schoenebeck



