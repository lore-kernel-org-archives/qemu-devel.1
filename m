Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0976CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 02:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6313E21789
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 02:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vc4XyksZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6313E21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMMK3-00068r-1u
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 22:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kMMJO-0005ex-BW
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 22:21:14 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kMMJK-0002Nk-Mo
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 22:21:14 -0400
Received: by mail-qk1-x744.google.com with SMTP id 16so7076099qkf.4
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version;
 bh=orwuIxhcAzfxvrYdPq15IL46wXoZXSVTBAmQieB+P2I=;
 b=vc4XyksZHYo+IWDFs522eKIz6ybQGpCUHMi7NHKsZCZFiGUJdmSH2/iOqeQJBisr1y
 3Iwy+ufWMUDSyWoevQ/CUcle/JbDQgoKschKRg5lx2UXPJ0hAjkQdxaKyI0eh9F+3bvw
 W2Szjy8UEB5k+gYEYCFOAM//RZK+5qqDnN46sOYLUPDHmssCPddB7J1r43P9zsDo0UUq
 OuDBEtYiAA5I0VFsT1rrj05HU+S/sOx4SZ7x0AhhkkJeCQEKSbfXxCaakZthX47BPhgd
 d6u0q47IxscrGIFdqBXt2hc2GKG0JzDa3201jP6Q3goYG0lrBniHY8bZ5ZWzeRgbQrGn
 vc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
 :message-id:user-agent:mime-version;
 bh=orwuIxhcAzfxvrYdPq15IL46wXoZXSVTBAmQieB+P2I=;
 b=ksJT3xqSCCmvRkIeg45DCrVNzgCvyHKUprqF6yIbAPKS75AkEqRRq5pxJcOH9l1hnW
 lK6IC7VZ8dIE/8mhgQcUr4EbtlT4dRcTVQPUZlEAPHiqL5sAnzBo20S+JWFW63ligYZA
 p0nVLQ/n6uc2WM4YapL4aHJv7qzs0fwevMUVR6doG+iIG6KmpJlMCa1TuNvnRHcwgxn+
 WTVfnRFYsD0HkrVxehREL07W4lRo4bC2Pxb9KcLWWW2OeC6mOqKw32X//QDmZ+PDcHES
 cbmIGXRV6xWdD0sSLzpDX/Dca7P2g9lFVha/h0t2pq19pHS/Qy/SKqMbLjSSdoB2Bbkq
 e1Fg==
X-Gm-Message-State: AOAM531t7QLEM52gr8l7eNICxqyQeII02K/m082B6xxXFnITphoPMGAO
 YhJu+eLEahVhLwIXkOZS9dmrTMUdTysC+A==
X-Google-Smtp-Source: ABdhPJw3TIbzxozScAe9Ke9i2CqM3yBEUt8XHXrX7lRnQicXBEjP+mFxotddlwLKmr9aEjJeuPsjMg==
X-Received: by 2002:ae9:c015:: with SMTP id u21mr6840325qkk.268.1601173269208; 
 Sat, 26 Sep 2020 19:21:09 -0700 (PDT)
Received: from hurd (dsl-10-132-92.b2b2c.ca. [72.10.132.92])
 by smtp.gmail.com with ESMTPSA id p28sm6076362qta.88.2020.09.26.19.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 19:21:08 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] build: Build and install the info manual.
References: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
 <CAFEAcA_wU73U6eaHU0mwccr-E0EHSKzFJ1yiR++YEKv=1LneJQ@mail.gmail.com>
 <87mu1dtao6.fsf@gmail.com>
 <CAFEAcA_4wXqGeOgsY2GbY1mk==DCz--j-jhs+OdGQnOHEf+D_A@mail.gmail.com>
Date: Sat, 26 Sep 2020 22:22:33 -0400
In-Reply-To: <CAFEAcA_4wXqGeOgsY2GbY1mk==DCz--j-jhs+OdGQnOHEf+D_A@mail.gmail.com>
 (Peter Maydell's message of "Sat, 26 Sep 2020 22:34:22 +0100")
Message-ID: <87wo0grmae.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Peter,

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sat, 26 Sep 2020 at 05:36, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>> > This isn't the right thing. You should be pointing sphinx-build
>> > at each of the individual manuals (system, interop, etc) and
>> > generating one info file for each. This is because we generate
>> > manuals for each of these including the 'devel' manual, but
>> > we don't want to install 'devel', because it's developer-facing
>> > and not needed by end-users of QEMU.
>>
>> Is this the only reason individual manuals are being generated?  It
>> makes sense for the manpages (which have their own macros), but
>> otherwise (for HTML and info) introduces a lot of complexity for not
>> much gain, in my opinion.  Users not wanting to know about devel
>> internals can simply skip that section; no harm done.
>
> It is the best way we found for getting Sphinx to do what we wanted.
> I agree that it would be nicer to have one manual with all the user
> facing parts in it, but it is apparently not possible to do that without
> shipping the devel docs to users, which we didn't want to do.

I personally don't understand the rationale of hiding the devel section
from users, especially given the kind of users QEMU is likely to attract
(e.g, teksavvy people, perhaps themselves developers that could be
curious peeking into that section to deepen their understanding of
QEMU's architecture and internals).

But if you feel strongly about it, I'd suggest the following, which
excludes the devel section from being built when calling Sphinx from the
top level:

--8<---------------cut here---------------start------------->8---
7 files changed, 13 insertions(+), 4 deletions(-)
docs/conf.py                 | 5 ++++-
docs/cpu-hotplug.rst         | 2 ++
docs/index.rst               | 3 ---
docs/microvm.rst             | 2 ++
docs/pr-manager.rst          | 2 ++
docs/virtio-net-failover.rst | 2 ++
docs/virtio-pmem.rst         | 1 +

modified   docs/conf.py
@@ -116,7 +116,10 @@ language = None
 # List of patterns, relative to source directory, that match files and
 # directories to ignore when looking for source files.
 # This patterns also effect to html_static_path and html_extra_path
-exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
+exclude_patterns = ['_build',
+                    'Thumbs.db',
+                    '.DS_Store',
+                    'devel/*']

 # The name of the Pygments (syntax highlighting) style to use.
 pygments_style = 'sphinx'
modified   docs/cpu-hotplug.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ===================
 Virtual CPU hotplug
 ===================
modified   docs/index.rst
@@ -9,12 +9,9 @@ Welcome to QEMU's documentation!
 .. toctree::
    :maxdepth: 2
    :caption: Contents:
-   :glob:

    system/index
    user/index
    tools/index
    interop/index
    specs/index
-   devel/index
-   *
modified   docs/microvm.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ====================
 microvm Machine Type
 ====================
modified   docs/pr-manager.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ======================================
 Persistent reservation managers
 ======================================
modified   docs/virtio-net-failover.rst
@@ -1,3 +1,5 @@
+:orphan:
+
 ======================================
 QEMU virtio-net standby (net_failover)
 ======================================
modified   docs/virtio-pmem.rst
@@ -1,3 +1,4 @@
+:orphan:

 ========================
 QEMU virtio pmem
--8<---------------cut here---------------end--------------->8---

With this change, the top level node of "info qemu" reads as:

--8<---------------cut here---------------start------------->8---
QEMU Documentation
******************

     QEMU , Sep 26, 2020

     The QEMU Project Developers

     Copyright (C) 2020, The QEMU Project Developers

* Menu:

* QEMU System Emulation User's Guide::
* QEMU User Mode Emulation User's Guide::
* QEMU Tools Guide::
* QEMU System Emulation Management and Interoperability Guide::
* QEMU System Emulation Guest Hardware Specifications::
* Index::
--8<---------------cut here---------------end--------------->8---

I'd still prefer to include the developer's manual as the last section
of the info manual, if you don't mind, for the reason explained above.

The scheme used above to exclude the devel section could also be used to
simplify building the HTML manual (e.g., build it by calling sphinx on
the top level with a correctly defined index.rst instead of individually
for each of its constituting sections before stitching them back
together with a custom index.html).

What do you think?

Thanks again,

Maxim

