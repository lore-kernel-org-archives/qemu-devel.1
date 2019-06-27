Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6449FC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2F32084B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2F32084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTaS-0008F4-Ac
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgTYt-0007nM-HF
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgTYs-0003hu-B5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:31:35 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgTYs-0003hN-3P
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:31:34 -0400
Received: by mail-wr1-f42.google.com with SMTP id r16so488528wrl.11
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K3ltNeClTxWSMoXvJArNUMWdDeGxq1iE1RYXRMRzeoY=;
 b=iMZBHNTSC4XAO56LnaAGbvmZN+j2q5LvXd4J+fSaqNpd5LbW1I2+HPiq5VX9D703Ja
 HN31lywt228oRkMs0iEIWbRocPTNssLfT/TYUBVpaPB6J+0ySSTpCrimPr43e1RVeFsr
 kNuQbXHLtWOBI1wyKCVJk2IQyOT3nc2rvsFHWNqsY/OnVt7rzFRB21frvz1u1fEgFlNy
 v4YX/14O39IUX+0GRJgdw5kGJ0gmqvMpzeyCN3N9kzFlhc1iUFkiNps1kz7ENtk5oRLq
 t+PLBn6d3nnXUD6PLjKye0l4+vpLLGdpqXhqIPy4pxjg7jacIQD0mTpNa9M4Joax3Qxj
 6Ftw==
X-Gm-Message-State: APjAAAWA1wCwbb5SD4HNSvK0tg8PRSj8xpakTDbuIabnZkT+nG8t9wU2
 KxSeSOAxBE70060/kvrNXlNUcbSRoMg=
X-Google-Smtp-Source: APXvYqx7FKTKb4zHhPRFKsDB7QSoZ8RJeCRmQvFJhIYr866/jawr7d8xP7vznX8glSt64ZwHtISPQg==
X-Received: by 2002:adf:db12:: with SMTP id s18mr2765289wri.335.1561638692831; 
 Thu, 27 Jun 2019 05:31:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9fc:4658:37f8:2b9c?
 ([2001:b07:6468:f312:9fc:4658:37f8:2b9c])
 by smtp.gmail.com with ESMTPSA id y44sm2287289wrd.13.2019.06.27.05.31.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 05:31:32 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-7-git-send-email-pbonzini@redhat.com>
 <87ef3fgtm3.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <acd3bcd9-36da-9c1b-1853-9d9ddcdd0a17@redhat.com>
Date: Thu, 27 Jun 2019 14:31:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87ef3fgtm3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.42
Subject: Re: [Qemu-devel] [PATCH 6/7] vhost-user-scsi: convert to Meson
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/06/19 13:23, Markus Armbruster wrote:
> Note that there's also glib dependency, which works the same (see
> previous patch).  With Make, we add GLib flags to QEMU_CFLAGS and LIBS,
> so they get used for everything unless overridden.

Having to add glib everywhere is mildly annoying.  We can avoid that
once we convert libqemuutil.a to meson, via

libqemuutil = static_library('qemuutil', ...)
libqemuutil = declare_dependency(link_with: libqemuutil,
                                 dependencies: glib)

>> +libiscsi = declare_dependency(compile_args: config_host['LIBISCSI_CFLAGS'].split(),
>> +                          link_args: config_host['LIBISCSI_LIBS'].split())
> ... we define here.  Less magical.

A couple notes here.  First, later on this declare_dependency() will be
replaced by dependency(), so that meson itself will run pkg-config
rather than our configure script.

Second, some magic will reappear once we start using sourcesets[1],
which allow dependencies will be attached to sources rather than
executables.  However, there will still be no need to track cflags and
ldflags separately.  It will look like this:

# in block/meson.build
block.add(when: libiscsi, if_true: files('iscsi.c'))

# in toplevel meson.build
block_obj = block.apply(config_host)
executable('qemu-img',
           sources: ['qemu-img.c', block_obj.sources()],
           dependencies: [libqemutil, block_obj.dependencies()])

Paolo

[1] https://mesonbuild.com/SourceSet-module.html

