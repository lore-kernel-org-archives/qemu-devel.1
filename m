Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EE9C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD1720578
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ef6VPpn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD1720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVkB-0005jW-SS
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQVfY-0000zD-8y
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:09:16 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:57077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kQVfV-0003cr-W7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=wLjjOB7SPox5da0izpNeAC0Gn7cQCvOmKVxCljbxKQ8=; b=ef6VPpn84q3LgZqO4wQ1xXUopS
 tppiT7KXsK3MRQuC4ao9eTJ52L6TfHgcsFaIrds6lvQrUyX9reu9ksCnZ4ecMWRj9bPEQeOxaqESG
 CW42q5tgptSvL2gLDTqHbNQ2ydhvovPuhOZPU7JSE7nP8fZE3nvtjiqCZqTvA3/MiZpcZdVYGavTX
 4PhP6l7uTFmC3c5JUAv7MB2Mrl4ZLHDPWSJU7Z3jXoDDdji/XYCkw5ABdUu9TNJmLanSVjEgep8Pi
 DMVdO6DCG/666sdWUHgRl7pDgLJNXl3IOAYXFeb3au3PvbVZvxD/sAGZyVrXo4Rdcj/HZP7wg5Za8
 ug0wb2CA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 berrange@redhat.com, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 05/11] tests/qtest/qos-test: dump environment variables
 if verbose
Date: Thu, 08 Oct 2020 15:09:10 +0200
Message-ID: <1836979.gfKjIU19vi@silver>
In-Reply-To: <ff76657f-4da1-5131-f981-02ea975cf1a3@redhat.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <8d8b242f38caccd81c27125167862f4457e8a22f.1601655308.git.qemu_oss@crudebyte.com>
 <ff76657f-4da1-5131-f981-02ea975cf1a3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 08:26:30
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

On Donnerstag, 8. Oktober 2020 14:37:00 CEST Paolo Bonzini wrote:
> On 02/10/20 18:15, Christian Schoenebeck wrote:
> > -int main(int argc, char **argv)
> > +int main(int argc, char **argv, char** envp)
> > 
> >  {
> >  
> >      g_test_init(&argc, &argv, NULL);
> > 
> > +    if (g_test_verbose()) {
> > +        printf("ENVIRONMENT VARIABLES: {\n");
> > +        for (char **env = envp; *env != 0; env++) {
> > +            printf("\t%s\n", *env);
> > +        }
> > +        printf("}\n");
> > +    }
> 
> But doesn't this (and patch 6 as well) break TAP output?  Using
> g_test_message + g_test_verbose would be the best of both worlds.

If there was TAP output then yes, patches 4, 5, 6 would probably break it.

How/when is TAP output enabled? I don't see any TAP output by default.

> In fact using printf in tests should be forbidden, since glib 2.62 and
> newer _always_ emit TAP.
> 
> Paolo

The reason why I used printf() was because g_test_message() clutters the 
output tremendously, as it always wraps the text of each g_test_message() call 
into:

	"(MSG: %s)\n"

which is inappropriate for multi-line messages as these proposed patches do.

Is that actually a real-life problem? I mean these patches only output 
anything if --verbose CL switch is used, and I don't see any TAP output 
enabled by default. And the --verbose CL switch is usually just used by 
developers for debugging test case issues, isn't it?

Best regards,
Christian Schoenebeck



