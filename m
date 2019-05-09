Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9683D2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vaff4Au1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9683D2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnPD-0004Jl-UE
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:04:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hOnNp-0003fv-9n
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1hOnNn-0003Xm-To
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:03:05 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1hOnNn-0003XP-PE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:03:03 -0400
Received: by mail-qk1-x743.google.com with SMTP id z128so2026467qkb.6
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=m243rfOjeyIA5hOPIw6UJaka+gkSAp+WOE/ge0IPy10=;
	b=Vaff4Au1x9XoQbzxcza0RKI7jZx60fwHGmJyo1VHoyXBkhwFvOaYqYLiC7SYgKP3wB
	H+1NToF7NVRbsm3guGUa0uHjTVdVp6ZSiryndOXwG2Zd030BxwsI/shyw0nTX+fQu+A6
	m/osCKQyuIZWEw2T0HvT5nsU/nRKvSj60mZe07ybnfDEmjwwIIllKvAEBFMdaqrINKOK
	WATDVbJ0XmxCSbklT9LfP8ruIrnsygv36uGovlKBXNe1CCK3kA4pKAXoHOuR6PhNRTzX
	xxZ23aXJkB74hBf3wUeSVrmhGtnpQvJfB481vREcAPKjuWcTICPcSrfcRgWdrXfPCPf5
	hDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=m243rfOjeyIA5hOPIw6UJaka+gkSAp+WOE/ge0IPy10=;
	b=bfnKjGD8Et/PDh9fkF5xt60pnOs/vvvOkLr6LhuMw0SoRQrMwd7HVRF0lSCiXwmHSD
	lqExCmIDaF2rx3sdAvJiwMdsWKI2cm9ZRDJaPitbrdedzgS2ritNtaS92uyv0L6aMYZq
	zoJAAgET1AJBRW6SlE2g2/yqbT08c6G7wUIGSUqH9mv+FkmssQS3e3RThweWLng/3wFM
	qInnS1lTJoeZQfQu8a6WgpSbj1tl69HP03ElcryuBIbsa1LaBVenTfQdFoBRb4CSRAJD
	kZn82UGCbKb+7rP/D2ItMCAQklBC+Uwd4fcBK7Os8ck0cSUlM9tqanHr4ISSGHzydZkL
	zO9w==
X-Gm-Message-State: APjAAAUZ/EsGEM5CZY3OkXJBq/OcwJe0EPZ2487SKTtKNyuIAT+FV1Oz
	w89Qi3dbJpdFlmwnTcqjF2o=
X-Google-Smtp-Source: APXvYqzvJRrd8aFSssC1KkrNMzTBA/yNcHVkLfnVh/y8SlUbsShbN+n6bCGUzPC7w7I9KX93MJHi3A==
X-Received: by 2002:a05:620a:1224:: with SMTP id
	v4mr4679654qkj.170.1557424982413; 
	Thu, 09 May 2019 11:03:02 -0700 (PDT)
Received: from ?IPv6:2804:431:f700:9dd7:697c:e24a:8ab6:9cbb?
	([2804:431:f700:9dd7:697c:e24a:8ab6:9cbb])
	by smtp.gmail.com with ESMTPSA id
	g15sm1587325qta.31.2019.05.09.11.03.00
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 11:03:01 -0700 (PDT)
To: Mario <ml@kernelobjects.org>, qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
References: <8C02D03E-96CD-414F-BC2C-C59972B26F94@kernelobjects.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <2fb7615e-0899-665c-e7e9-71aa5f9b6648@gmail.com>
Date: Thu, 9 May 2019 15:02:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8C02D03E-96CD-414F-BC2C-C59972B26F94@kernelobjects.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] Request for comment - dynamic VNC keyboard mapping
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Mario,

Sorry for the delayed answer.  As Daniel already said, any solution based
on how "-k <keymap>" works are too daunting to be maintained - there
are a lot of known keymaps to be aware of.

There's also the case of changing keymaps during the same session.
Speaking from experience: my laptop has a regular en-us keyboard, but
I also use it with an external Brazilian keyboard (which has the "Ç" key and
other punctuation keys). I happen to use some VMs in this hardware too.
It is not uncommon in my usage, in the same VNC session, a change in the
current keyboard layout en_us -> pt_br back and forth.

This is only possible because gtk-vnc does not care about my layout, but for
the keycodes being pressed. In my case, instead of sending the "Ç" symbol,
it would send the keycode of the 11th keyboard key located at the forth 
line.
The translation of keycode to keysym happens up to the OS layer.

gtk-vnc implements the RFB scancode extension that allows for the keycode to
be sent to VNC. This implementation isn't complicated to pull it off, as 
Daniel
also mentioned in his reply. Many VNC clients already supports it. If 
you want
something to start from, I've implemented this extension in a browser VNC
client called noVNC a few years ago and I talked about it here:

https://danielhb.github.io/article/2019/05/06/noVNC-QEMU-RFB.html

You may also want to check Daniel's article about all this scancode/keycode/
keysym theory here:

https://www.berrange.com/tags/rfb/



Thanks,


DHB

On 5/3/19 8:47 AM, Mario wrote:
> Hi all,
>
> I have a question related to the VNC server keyboard settings. Currently the user of qemu has to decide before VM startup which language is used for VNC keyboard mapping. If no keyboard is configured, the en-us keyboard will be loaded for keysym to scancode conversion. A later reconfiguration of the keyboard is not possible at present.
>
> So here is my idea:
>
> The VNC Display context stores a list of loaded keyboards (like vs->vd->kbds). If no keyboard was specified, at least the default will be added to the list ("en-us"?). If a client connects, a copy of the (latest configured) pointer will be stored within the VncState structure. For any keys sent by this client the own keyboard reference will be used.
>
> As (in theory) every VNC client may have a differen keyboard layout, in my point of view it makes sense to attach the keyboard used for keysym2scancode() to the client context rather to the VNC server context. However as (most likely) all clients do have the same keyboard mapping it would be an overhead to parse and store the mapping list each time the client connects.
>
> Now in my idea two mechanisms may change the behavior of the client keyboard.
>
> 1.) a qmp command was sent, that sets /configures for a particular/default keyboard.
> 2.) within the VNC protocol a "VNC_MSG_CLIENT_QEMU/VNC_MSG_CLIENT_QEMU_EXT_KEYBOARD_LAYOUT" message arrives
>
> If the new keyboard was not already loaded and stored inside vs->vd->kbds , qemu initializes the new mapping. The affected VNC client (VncState) again stores the reference only.
>
> This enables switching the keyboard layout during runtime as well as using multiple different keyboard layouts at atime.
>
> Together with a corresponding patch I would also add a patch for libvncclient to have a reference implmentation for the integrated keyboard layout switching.
>
> What are your thoughts about this kind of improvement?
>
> Thanks,
> Mario


