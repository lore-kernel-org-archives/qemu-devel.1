Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EABC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3889206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=argosnet.com header.i=@argosnet.com header.b="b9n+72+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3889206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=argosnet.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPcE-0006vp-M0
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYPbT-0005ig-H5; Tue, 12 May 2020 03:45:27 -0400
Received: from mx.argosnet.com ([51.255.124.196]:51703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <B3r3n@argosnet.com>)
 id 1jYPbR-0002Uo-QB; Tue, 12 May 2020 03:45:26 -0400
Received: from mx.argosnet.com (Argosnet [51.255.124.196])
 by mx.argosnet.com (Postfix) with ESMTP id E4B5C4F438;
 Tue, 12 May 2020 09:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=argosnet.com; h=date:to
 :from:subject:cc:in-reply-to:references:mime-version
 :content-type; s=mx; bh=wyYNcn0YvQ9aU+5vls1lVMdmbng=; b=b9n+72+j
 V++WrTfgvIK30/RHw3KK38LS6L7nssqrO/VGrt9fh0La7IaZW5cVqX5ATCj2SCiU
 GSpBYIUwvm8OGVyYAjg4D/UIk3mn9QYKNAhy5Lo9WL/Mk5HaSHJgg3fsHoueTqbL
 S1pDgRdGE3EkLUZsMACxZj/cSRQ/S7S7euQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=argosnet.com; h=date:to:from
 :subject:cc:in-reply-to:references:mime-version:content-type; q=
 dns; s=mx; b=XKJo23DTo2FGCUO0biVyDlohhFGhGiwEe4mEXhl3eYORXJeyLvC
 J0gIMzgpu+4zc5AHnagk7f6QnF6jJLRsWhDaEOLF0zjZc/HU6pmpwlnMlU9AsYGd
 HEwe63C0SyQ+sx52QNQcC2hQ+wuzCiIhxyybjdBQyo2gAXNO9h6pVEqs=
Received: from Osgiliath.argosnet.com
 (lfbn-nic-1-419-246.w90-116.abo.wanadoo.fr [90.116.244.246])
 (Authenticated sender: llevier@pop.argosnet.com)
 by mx.argosnet.com (Postfix) with ESMTPSA id 2DAF14F437;
 Tue, 12 May 2020 09:45:20 +0200 (CEST)
X-Mailer: QUALCOMM Windows Eudora Version 7.1.0.9
Date: Tue, 12 May 2020 09:45:20 +0200
To: Daniel P. =?iso-8859-1?Q?Berrang=C3=A9?= <berrange@redhat.com>
From: B3r3n <B3r3n@argosnet.com>
Subject: Re: Qemu, VNC and non-US keymaps
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-discuss@nongnu.org
In-Reply-To: <20200511171930.GS1135885@redhat.com>
References: <E1jY9FF-0000Po-2c@lists.gnu.org>
 <af732fbf-fd70-97bc-3ea8-25d66f5895de@redhat.com>
 <20200511151155.GO1135885@redhat.com>
 <20200511152957.6CFA8D1826@zmta04.collab.prod.int.phx2.redhat.com>
 <20200511171930.GS1135885@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Received-SPF: pass client-ip=51.255.124.196; envelope-from=B3r3n@argosnet.com;
 helo=mx.argosnet.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:45:23
X-ACL-Warn: Detected OS   = FreeBSD  [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_MUA_EUDORA=0.001, MISSING_MID=0.497, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
Message-Id: <E1jYPbT-0005ig-H5@lists.gnu.org>
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

Hello Daniel, all,

I am a bit confused.

Ok, RFB protocol should be the solution that solves all, sending 
scancodes rather than doing keysyms stuff. No pb for me.
So I removed my '-k fr' to my Qemu VM start as it was before.

However, reading TightVNC & noVNC docs, both are able to perform RFB.

Since these explanations, I replayed a bit:

Under my testing Debian 10, I redefined keyboard to French + No 
compose key + AltGr as CTRL_R

Under noVNC: Ctrl_R works well as alternative but when using AltGr, I 
received 29+100+7 (AltGr + 6) and keep displaying a minus as with 
AltGr was not pressed.

Under TightVNC (2.7.10) : Ctrl_R displays characters, I am still in 
QWERTY for letters, weird mapping for other characters, did not 
checked if compliant with whatever definition.
Under TightVNC (last 2.8.27, supposed to be able to RFB): Ctrl_R 
displays nothing, keys are QWERTY. Seems the same as TightVNC 2.7.10.

With the keyboard defining AltGr as AltGr, no change.

I realize that AltGr is sending 29+100 (seen via showkey), when 
CTRL_R only sends 97.
When using a remote console (iLo and iDRAC), AltGr only sends 100.

I wonder if the issue would not also be the fact AltGr sends 2 codes, 
still another one to select the character key (6 for example).

Is that normal Qemu is transforming AltGr (100) in 29+100 ?

Thanks

Brgrds


