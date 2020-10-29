Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD7BC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308252076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNs+D5+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308252076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBoB-0001pQ-UX
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYBkT-0006fv-Ta
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kYBkR-00055q-PU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603992603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIogMw27uL+eK/rQNIgij8JIjyISPlYbWo5+mZ6X9bI=;
 b=HNs+D5+AXyGRfKup/q6hsS5by+bH4vPg5eebMixG/XG17TVcm6u5r6BhoUdei89bPK1xrE
 h56SeLtHOwDUJzkVKL4EUzWNcJZGD43r5odhOSVI3Ly8m9JMXJ+EHY074sMx7jSPVFHN90
 8expIZECW4YAEJc+xx6TX65ZSLiatpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-BX7fBBHcN2KLnKwk-4qo2A-1; Thu, 29 Oct 2020 13:29:55 -0400
X-MC-Unique: BX7fBBHcN2KLnKwk-4qo2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01DFE1018F7A;
 Thu, 29 Oct 2020 17:29:54 +0000 (UTC)
Received: from redhat.com (ovpn-115-62.ams2.redhat.com [10.36.115.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5EDA5DA60;
 Thu, 29 Oct 2020 17:29:52 +0000 (UTC)
Date: Thu, 29 Oct 2020 17:29:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
Message-ID: <20201029172949.GJ27369@redhat.com>
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <CAFEAcA9KYtb7tFp5tnPGMiYg0gpurao7GbcU_ND934tvFiU-aw@mail.gmail.com>
 <20201029150403.GF27369@redhat.com> <2309245.eTJEYpyWRi@silver>
MIME-Version: 1.0
In-Reply-To: <2309245.eTJEYpyWRi@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 06:27:21PM +0100, Christian Schoenebeck wrote:
> On Donnerstag, 29. Oktober 2020 16:04:03 CET Daniel P. Berrangé wrote:
> > On Thu, Oct 29, 2020 at 02:52:16PM +0000, Peter Maydell wrote:
> > > On Thu, 29 Oct 2020 at 14:31, Christian Schoenebeck
> > > 
> > > <qemu_oss@crudebyte.com> wrote:
> > > > On Donnerstag, 29. Oktober 2020 15:15:19 CET Peter Maydell wrote:
> > > > > On Thu, 29 Oct 2020 at 14:06, Christian Schoenebeck
> > > > > 
> > > > > <qemu_oss@crudebyte.com> wrote:
> > > > > > Ok, I'll use mkdtemp() instead, that avoids other potential parallel
> > > > > > config
> > > > > > colissions that I may not have considered yet.
> > > > > > 
> > > > > > The original motivation against mkdtemp() was that /tmp is isually a
> > > > > > ramfs,
> > > > > > hence very limited regarding large file tests. But that's not an
> > > > > > issue
> > > > > > right now.

snip

> @@ -278,3 +278,14 @@ static void virtio_9p_register_nodes(void)
>  }
>  
>  libqos_init(virtio_9p_register_nodes);
> +
> +static void __attribute__((constructor)) construct_virtio_9p(void) {
> +    /* make sure test dir for the 'local' tests exists */
> +    init_local_test_path();
> +    create_local_test_dir();
> +}
> +
> +static void __attribute__((destructor)) destruct_virtio_9p(void) {
> +    /* remove previously created test dir when test suite completed */
> +    remove_local_test_dir();
> +}
> 
> So it would still use the current directory instead of /tmp/ and would
> create and remove the test dir on process start/end. I wanted to avoid
> using constructor/destructor atttributes, as some compilers don't
> support them, but it seems it's already used in the code base and there
> are currently no setup/teardown callbacks in libqos.

QEMU explicitly only supports CLang and GCC, and our code assumes
constructors/destructors work.

IOW, you should ignore the portability concern. We don't care about
other vendor compilers with poor feature sets.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


