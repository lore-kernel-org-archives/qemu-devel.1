Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2AF20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d45dVowB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2AF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv4u2-0003D2-0q
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 14:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv4t1-00023L-VY
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv4sz-0005T4-Ti
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:44:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv4sy-0005NK-7f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:44:57 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so601664wmf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IfNvriD/kjnho4+fsxK+u26kR73SYIOdRcnJHAOBq60=;
 b=d45dVowBvjr5+HjedBiPHJm0mb1eQuZDVGzwLHddmPGCpPd+w5xEYiFWqL20BQExWP
 Pnxc1CxMzYiDPmuZ6v+6EJBAfIQhU3KREK1jtF9dCmUw2KcfZjUDE7wnOVF023kwlaK0
 fPubVTq7F2Kw1+L6YJJNi3yIlHJFR1joOrFb9I/yUmzOOrkrOVifXDbi6Qj0EDB+lRpm
 aNVtqZ3vA2BW0DqWQvzbFvkFUtSlzn9/e8mxbpzvEBPppFcNjk4+YUQiAWLDQiLefeEr
 aklNk3d7mSDYIjJv/9/JvfDf4VZzq+Cr7hKsqgZ9iZadzFuNrzF2qGyA2c95PYYMuwPB
 vdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IfNvriD/kjnho4+fsxK+u26kR73SYIOdRcnJHAOBq60=;
 b=D72O88JQsuXhxyO7VL6omdj0VDCUtMwGS7mq2dAE17DMn9tpyXIpg8l7kgaIfr4pvu
 gIcM0gkG8fY9fUdqMXNT54XKspukoeYcUjVIOh/s+hPDhb3SH8TGtX4qkiRs74o6wqsd
 WZCXbky3kiIYkkNHHv/hhkEJ7q9ZztbE14ujw46A6CNLPGWUFSIowOEJX7nCdofD0ynz
 afv6iHuh4WuErj8rFl/DFhF3zbgjwQh7rHNLad0OCehY/x4kZF2K9DMNfWwRKMJUL8cz
 MShdjepuDVWwFGDYU/1QwwKCC+1qkSdqnZ+nN6c1w0LoFNm5HSll5vLcBfVv70iaVfuF
 lPYg==
X-Gm-Message-State: APjAAAVBliUpQj6xdyxX/GsMMAAET/iN9ES5M7uSrbBMFgvoqm+EIMxy
 rGDpGmTW4pNuX8SSvyjlNMrT9A==
X-Google-Smtp-Source: APXvYqxRZMWzO3iw/MzNLJba2PLT5Nmn2/Os82s3STfigILxUsTZoxxv3C83+xt5qCMFKbI5VoLziA==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr640811wml.173.1579895092181; 
 Fri, 24 Jan 2020 11:44:52 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm8875535wro.85.2020.01.24.11.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 11:44:51 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 795021FF87;
 Fri, 24 Jan 2020 19:44:50 +0000 (GMT)
References: <BL0PR2101MB1026C24DACAFB1771DE47706D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
 <87eevoak12.fsf@linaro.org>
 <BL0PR2101MB10265432576D6FF63AFA2282D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Henry <robhenry@microsoft.com>
Subject: Re: [EXTERNAL] Re: QEMU for aarch64 with plugins seems to fail
 basic consistency checks
In-reply-to: <BL0PR2101MB10265432576D6FF63AFA2282D60E0@BL0PR2101MB1026.namprd21.prod.outlook.com>
Date: Fri, 24 Jan 2020 19:44:50 +0000
Message-ID: <8736c4abbh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Henry <robhenry@microsoft.com> writes:

> I found at least one problem with my plugin.
>
> I was assuming that the insn data from
>       struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
> could be passed into qemu_plugin_register_vcpu_insn_exec_cb both as the 1=
st argument AND as the user data last argument.  This assumed that insn wou=
ld persist and be unique from when qemu_plugin_register_vcpu_insn_exec_cb w=
as called to when the execution-time callback (vcpu_insn_exec_before) was c=
alled.
>
> This assumption is not true.
>
> I now capture pieces of *insn into my own persistent data structure, and =
pass that in as void *udata, my problems went away.
>
> I think this lack of persistence of insn should be documented, or
> treated as a bug to be fixed.

I thought I had done this but it turns out I only mentioned it for
hwaddr:

  /*
   * qemu_plugin_get_hwaddr():
   * @vaddr: the virtual address of the memory operation
   *
   * For system emulation returns a qemu_plugin_hwaddr handle to query
   * details about the actual physical address backing the virtual
   * address. For linux-user guests it just returns NULL.
   *
   * This handle is *only* valid for the duration of the callback. Any
   * information about the handle should be recovered before the
   * callback returns.
   */

But the concept of handle lifetime is true for all the handles. I
propose something like this for the docs:


--8<---------------cut here---------------start------------->8---
docs/devel: document query handle lifetimes

I forgot to document the lifetime of handles in the developer
documentation. Do so now.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

1 file changed, 11 insertions(+), 2 deletions(-)
docs/devel/tcg-plugins.rst | 13 +++++++++++--

modified   docs/devel/tcg-plugins.rst
@@ -51,8 +51,17 @@ about how QEMU's translation works to the plugins. While=
 there are
 conceptions such as translation time and translation blocks the
 details are opaque to plugins. The plugin is able to query select
 details of instructions and system configuration only through the
-exported *qemu_plugin* functions. The types used to describe
-instructions and events are opaque to the plugins themselves.
+exported *qemu_plugin* functions.
+
+Query Handle Lifetime
+---------------------
+
+Each callback provides an opaque anonymous information handle which
+can usually be further queried to find out information about a
+translation, instruction or operation. The handles themselves are only
+valid during the lifetime of the callback so it is important that any
+information that is needed is extracted during the callback and saved
+by the plugin.
=20
 Usage
 =3D=3D=3D=3D=3D

--8<---------------cut here---------------end--------------->8---

--=20
Alex Benn=C3=A9e

