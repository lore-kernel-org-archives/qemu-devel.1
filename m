Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F4C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8A42100A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="U/LelioM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8A42100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMs1W-0004CH-CM
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMrzs-0003MP-AD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:11:12 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMrzo-0002Xa-9c
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=e0z9rv5gbYij0z9J8/MHDWTuOQc80W2Ze144d1h63a4=; b=U/LelioMj/FPq4whOGUI4JFMqk
 Qftr/Unom/njdhvmvV3z1TEhHdiz2X6McaS8/tT/W4l0hztUO1z5DaMlSw9DYIkrCyJtCrX7Lrjm0
 16uIUsF3jj0hx9wHui3HUYIVEeouWqRCyeyCnj9iCmUslAYUQpp5nGe6iPSd0ggwPhbfaGtwFHhFY
 fl1jzszHiajhEM/7TaIURxqIDemcAKWjGl/iirhsvjnambCuFqDVm49iUNGR8XakNKTz9A/fDaB8e
 +OUS+2P92/kP9dn/+z64Ri2Jwb8zRmL03B3KEaNwwzn0yEEe+3g3dFI5r3CQRh/5Ae73jywGR1rxX
 v3oTznkQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 06/12] tests/qtest/qos-test: add environment variable
 QTEST_DEBUG
Date: Mon, 28 Sep 2020 14:11:04 +0200
Message-ID: <5803564.MLecxQVrnj@silver>
In-Reply-To: <2c5db347-4d17-c735-a153-3043566d7c21@redhat.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <cc6109fcc03d47a68d01ceac5ade71fe8467a3f7.1601203436.git.qemu_oss@crudebyte.com>
 <2c5db347-4d17-c735-a153-3043566d7c21@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 07:56:16
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

On Montag, 28. September 2020 10:31:21 CEST Paolo Bonzini wrote:
> On 27/09/20 12:40, Christian Schoenebeck wrote:
> > For now this new environment variable QTEST_DEBUG will cause the
> > assembled qemu command line to be printed before running each test.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  tests/qtest/qos-test.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
> > index 4b1a1922fc..571d1e140a 100644
> > --- a/tests/qtest/qos-test.c
> > +++ b/tests/qtest/qos-test.c
> > @@ -89,6 +89,9 @@ static void qos_set_machines_devices_available(void)
> > 
> >  static void restart_qemu_or_continue(char *path)
> >  {
> > 
> > +    if (getenv("QTEST_DEBUG") != NULL) {
> > +        printf("run QEMU with: '%s'\n", path);
> > +    }
> > 
> >      /* compares the current command line with the
> >      
> >       * one previously executed: if they are the same,
> >       * don't restart QEMU, if they differ, stop previous
> 
> You can just use g_test_message for this and do it unconditionally.

I actually had to read the glib sources to understand how g_test_message()'s 
output is turned on:  by appending '--verbose' to the CL.

Okay then.

Best regards,
Christian Schoenebeck



