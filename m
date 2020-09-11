Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2D6C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 21:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D5E2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 21:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VshFCGLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D5E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGqcM-0002X3-Ht
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 17:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kGqbX-0001hf-Ue
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 17:29:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kGqbU-0000Ka-5O
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599859746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oC83DjMXhWLtqgLMTxxdjy05yrV9Jj5KiZ6ovzmJOLE=;
 b=VshFCGLyfbJRwuQ5EL2pmSVaiDSEb6yMclScyvOjxqhQ7QxoUry4USw53xBDIjkzz7hs6Z
 lDag+TAMhnSDYyeXox1FBCfMABzIgsrhvuqwnkQXvGsog7N+NV3fFZRa3yMV3q6/h7d8NY
 RM6du9ykgkaadissAdx83rH9E44/tNE=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-Mug9r1M1PpmYYUGIXAXjew-1; Fri, 11 Sep 2020 17:29:03 -0400
X-MC-Unique: Mug9r1M1PpmYYUGIXAXjew-1
Received: by mail-vk1-f199.google.com with SMTP id d128so493052vke.23
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 14:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oC83DjMXhWLtqgLMTxxdjy05yrV9Jj5KiZ6ovzmJOLE=;
 b=eQfV9+4NPTjY2HD62H0nmaryobXQcQgWVED1GQ7RIZHY+V2OCrf9zf8btEC0ega1JX
 h6e5gS6h59jtLYSXrXHtCSuTCwffaQni8XbwNXTjuSraSdNSB742+e6PX84RpGDbtMSp
 GUVbW4eYQRSko+Kb3Z2CNvwgY1GH/NThzTMSuXT3aN2CWrocp2JChDgJoH+9WaW41IQk
 qo/dgwJxxHW6lVVi4P+14F0ARATCR4EBvn2sK/nDPmokehidpMRK7EVq6mLEoJJ32NgV
 hXhgfixA7arvmsQpxM7BFmxNVUUWW1+EI+8P6zZDK8VVeyu2lBwjABWcKRQQEAYRQtBm
 3uew==
X-Gm-Message-State: AOAM531GGaMrz1TocXdWgaeh+LJsiF4ThTpgUPygZka4LILwjHSSrCJh
 n1f/mZGVl80xQtw+N8mXyJ1lQXi5kBQkS4H90yZ5+HthmBFiffC2bVvYU7HRofTnBlblOCX3KOA
 9fF01o+Ok1VcEEmXuUBStWfqpaOVllYs=
X-Received: by 2002:ab0:4387:: with SMTP id l7mr2313533ual.133.1599859742743; 
 Fri, 11 Sep 2020 14:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrNsIHcD5fMvOc5iy4f8AuQkeEP0PFzNdLNy5cHNwF2Xq20YLRjQVGb9lcJjIyzO/hOrsIUoFaJBEaKpocN98=
X-Received: by 2002:ab0:4387:: with SMTP id l7mr2313521ual.133.1599859742424; 
 Fri, 11 Sep 2020 14:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200909184028.262297-1-mreitz@redhat.com>
 <20200909184028.262297-8-mreitz@redhat.com>
In-Reply-To: <20200909184028.262297-8-mreitz@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Fri, 11 Sep 2020 18:28:51 -0300
Message-ID: <CAKJDGDZO2BMv_bMCPHcjYRWLqYBCzZPLfM0dCL-o+LC-3EWB0g@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests/acceptance/boot_linux: Accept SSH pubkey
To: Max Reitz <mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 17:29:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 9, 2020 at 3:46 PM Max Reitz <mreitz@redhat.com> wrote:
>
> Let download_cloudinit() take an optional pubkey, which subclasses of
> BootLinux can pass through setUp().
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/acceptance/boot_linux.py | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
> index 0055dc7cee..ad997c3f2e 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -57,7 +57,7 @@ class BootLinuxBase(Test):
>              self.cancel('Failed to download/prepare boot image')
>          return boot.path
>
> -    def download_cloudinit(self):
> +    def download_cloudinit(self, ssh_pubkey=None):
>          self.log.info('Preparing cloudinit image')
>          try:
>              cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
> @@ -67,7 +67,8 @@ class BootLinuxBase(Test):
>                            password='password',
>                            # QEMU's hard coded usermode router address
>                            phone_home_host='10.0.2.2',
> -                          phone_home_port=self.phone_home_port)
> +                          phone_home_port=self.phone_home_port,
> +                          authorized_key=ssh_pubkey)
>          except Exception:
>              self.cancel('Failed to prepared cloudinit image')
>          return cloudinit_iso
> @@ -80,19 +81,19 @@ class BootLinux(BootLinuxBase):
>      timeout = 900
>      chksum = None
>
> -    def setUp(self):
> +    def setUp(self, ssh_pubkey=None):
>          super(BootLinux, self).setUp()
>          self.vm.add_args('-smp', '2')
>          self.vm.add_args('-m', '1024')
>          self.prepare_boot()
> -        self.prepare_cloudinit()
> +        self.prepare_cloudinit(ssh_pubkey)
>
>      def prepare_boot(self):
>          path = self.download_boot()
>          self.vm.add_args('-drive', 'file=%s' % path)
>
> -    def prepare_cloudinit(self):
> -        cloudinit_iso = self.download_cloudinit()
> +    def prepare_cloudinit(self, ssh_pubkey=None):
> +        cloudinit_iso = self.download_cloudinit(ssh_pubkey)
>          self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
>
>      def launch_and_wait(self):
> --
> 2.26.2
>
>

Reviewed-by: WIllian Rampazzo <willianr@redhat.com>


