Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB99C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6371720578
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6371720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVjP-0004vd-Fi
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQVhr-0003mm-Jm
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:11:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:48147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQVhp-0003zs-6n
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=JJjv+FONZLgijtpklT4ZZEVzcXMU1dWsgI7fiZPGDMs=; b=OeoYAGXdCRBh4IUofIX6uddJA/
 3TlkUt/txVX7uAlzCq59MGbxxs/8sZWf1zOC9U+9YkujEdFKXH01xeVXU4FsD0cCzSDxRsBGMc8Av
 Z+uCla07DtC/du4O+mZtV3RMzl5b7XIRLrRbvIu0Qm+F1tmGyN0bISJcbMj6oqxmCAdj17SNc/UNy
 G0+ORna2jhg51oZwAjbtRKuXOv8CgG0Ee49uur0oYAlsT5/FdDZfL+tvIr3Fou9xfV3wMwYXX7l1X
 GdmydZfHuf8qDu8/jf6XjK5Qj/3cOXl4ta/U1ApaR0GXuEhrVqmBq1kL8IEBmgEj9EH75p7HB/Spm
 4U5FHkATTjy1ApsPkalEuRzHofebkId01Gkfzc3O6mP5vR5S+WRwC+IpkOIYZW3toBk5J58LQaN+J
 ZGkIawSx+BkKbIH8PEfHKg1BOsvUc+dvY1OtiVoyCX1+PzefG0kWJXqivv8Y1y7ZUax9a8xZIfp8w
 mg3b+VfWhPG581H864tsYg97Vor9yDmg+8aopUs9XcfEVmIyAKrlYaGceTRjYiye8nPW2+iL6LReE
 RjrdrtQDSDQXPwMe0mKNc/AjTdy5zXVj8R7cSLJfxiLrJUyQTZNlcycOqot1zBjtP71i/teMSOUHQ
 1+ndGjou/RZYoLvubxGl8Tqo6wN37p2iWIlKL1dOA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 berrange@redhat.com, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 06/11] tests/qtest/qos-test: dump QEMU command if
 verbose
Date: Thu, 08 Oct 2020 15:11:33 +0200
Message-ID: <11127871.8IYHytKs81@silver>
In-Reply-To: <68eaa9ac-0de6-a426-52bb-8a91f03664de@redhat.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <54781ff3e3231fa1b7e1bea8d16e825c5084a74f.1601655308.git.qemu_oss@crudebyte.com>
 <68eaa9ac-0de6-a426-52bb-8a91f03664de@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 09:11:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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

On Donnerstag, 8. Oktober 2020 14:36:11 CEST Paolo Bonzini wrote:
> On 02/10/20 18:15, Christian Schoenebeck wrote:
> > If qtests are run in verbose mode (i.e. if --verbose CL argument
> > was provided) then print the assembled qemu command line for each
> > test.
> > 
> > Instead of using g_test_message() rather use printf() in combination
> > with g_test_verbose(), to avoid g_test_message() cluttering the
> > output.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  tests/qtest/qos-test.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
> > index fe240b32a7..b9f0942386 100644
> > --- a/tests/qtest/qos-test.c
> > +++ b/tests/qtest/qos-test.c
> > @@ -89,6 +89,9 @@ static void qos_set_machines_devices_available(void)
> > 
> >  static void restart_qemu_or_continue(char *path)
> >  {
> > 
> > +    if (g_test_verbose()) {
> > +        printf("Run QEMU with: '%s'\n", path);
> > +    }
> > 
> >      /* compares the current command line with the
> >      
> >       * one previously executed: if they are the same,
> >       * don't restart QEMU, if they differ, stop previous
> 
> This need not even be made verbose I think.

I actually find that handy in this way. By default I prefer the current output 
where I just see the name of the test currently running. I only need to see 
the actual QEMU command if there is some kind of problem to fix.

Best regards,
Christian Schoenebeck



