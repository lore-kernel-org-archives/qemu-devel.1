Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DE1C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867CE207FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867CE207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7J8P-0000K2-Kj
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 08:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7J7T-0008FB-4w
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7J7R-0005Sg-1D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:50:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7J7Q-0005SI-Ie
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:50:08 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 631BFC05AA71
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 12:50:07 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id f11so7293580wrt.18
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 05:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=edt0cQYoJ9uYncySHWxY8aB60dEI1PXCuhN3ufA9kkw=;
 b=JOx6TcJsORp/TxET2FsdXRICaPw1PPcY5XhEF0n1As1SVCFguVqxVQjHVdicuzJAn/
 xNvdLgwxkHY2MHkst/40gW/+P/0vdUkCncDF9hU36RXD+gkyJaDZxgibwcRw5bvabN7p
 mGEX54r4CIV8NiNrflTjLK5lyZfcxbXxt4H0X2vEp9ujDLY2YGR3AisjHBfHT1fwdOQU
 +/UW2jiS0tcBknWNSgy+mBzKbTXEUYJuOtmHHdlbf1hnp9BpgIF+JPZF5aQ/I+Jigvq6
 CU+1IsA/zLw+xnoc6ajO34YNyuq94tRiB3hXbIvh/JzT1WC28EgPmGnV5STj5tjczFJ0
 tyIg==
X-Gm-Message-State: APjAAAU16eOXjyyVkOMDV2E/q8dN/BKTIHBxS+1GwVG0rXdBjjVGdcod
 iVYKKtICUaBa1zCJVfZJRxhjGBqA1kHikQS1jBB1wwPARfrEcsjdCuvB9yakfC0fOq68J+Y424h
 Dh7mti5gkaRqiyDU=
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr19769021wmk.94.1568033406063; 
 Mon, 09 Sep 2019 05:50:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz0k4w8JcsFhgJylR4rxqkMxFhUtYJw+nJIzIQoSwarAlLYoGH5h+JMsu34zdZD7K5dkryxxw==
X-Received: by 2002:a7b:c4d0:: with SMTP id g16mr19769004wmk.94.1568033405772; 
 Mon, 09 Sep 2019 05:50:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8dc1:ce1e:4b83:3ab7?
 ([2001:b07:6468:f312:8dc1:ce1e:4b83:3ab7])
 by smtp.gmail.com with ESMTPSA id j26sm30884968wrd.2.2019.09.09.05.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 05:50:05 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20190906110649.9561-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <601f8c37-354e-6b91-584a-a04e8b3f8438@redhat.com>
Date: Mon, 9 Sep 2019 14:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906110649.9561-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] action required for qemu-web committers (was Re:
 [qemu-web RFC PATCH] Update to Jekyll 4.0)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/09/19 13:06, Thomas Huth wrote:
> - Update versions in Gemfile
> - "has_key?" has to be renamed to "key?" in category_archive_plugin.rb
> - Add .jekyll-cache to .gitignore file
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

The software collections Ruby 2.5 was trivial to setup (patch to the hook
after my sig), so I went ahead and pushed this patch.  However, I encountered
a small snag for which I also had to add the "[PATCH qemu-web] use precompiled
sassc" that I have just sent.

Peter/Michael/Thomas, please ssh to qemu.org and do "rm -rf ~/bin ~/.gem"
(assuming you don't have any other binary in ~/bin :)).  In theory this
should not be needed, since bundler is now an RPM and the hook does not
add $HOME/bin to the PATH anymore.  However, it would be confusing for you
to have references to a Ruby installation that does not exist anymore on
the machine.

Note that the first time you push to qemu-web.git, you should expect a 
couple minutes of wait to install the updated gems to your home 
directory.

Paolo


--- update.old	2019-09-09 08:48:05.947586644 -0400
+++ update	2019-09-09 08:31:05.940274361 -0400
@@ -5,6 +5,8 @@
 #
 # Author: Paolo Bonzini
 
+source scl_source enable rh-ruby25
+
 # -----------------------------------------------------------------------------
 # $DEPLOY_ROOT is the path to the work area for this script.  All users
 # that can push to the repository must have write access to $DEPLOY_ROOT as
@@ -52,8 +54,7 @@
 # $DEPLOY_ROOT/root if successful.
 cd $DEPLOY_ROOT/source
 
-export PATH=$HOME/bin:$PATH
-bundle install
+bundle install --path $HOME/.gem
 if bundle exec jekyll build -d $DEPLOY_ROOT/new; then
   rm -rf $DEPLOY_ROOT/old
   if test -d $DEPLOY_ROOT/root; then

