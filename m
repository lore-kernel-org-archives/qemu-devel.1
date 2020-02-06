Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5026D206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jt1yvIML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5026D206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcWQ-0000ai-Iv
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1izcVG-0007ry-Db
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1izcVF-0000m5-4z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:27:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1izcVF-0000ls-13
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSROafs//sIPQXClco388sWodIQoa9c5rcy/RC5H3n0=;
 b=Jt1yvIMLkTTMogoLK2P8sa8+SI8iE5CDzrPlCy4sa/6icjOXHYsqfs5ePHuin1G7lVguHD
 jSZOpVC6Y9j1DsxTxqfYY0H9ZQdf4TWpVbaH+QQFKWzFLQToxV5nN0sukuJEwnSbAfNrC2
 y5FB7Vgy8kyte5jQZqgHnAhmxICN11U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-f0YYa0DuPxmxAfvik6vKDg-1; Thu, 06 Feb 2020 03:27:06 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so2953963wrs.22
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 00:27:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OSROafs//sIPQXClco388sWodIQoa9c5rcy/RC5H3n0=;
 b=EeVL2e5RwBGdFCANVYM+iiwuaYyjUDeyg58VqO0bciAc4GmJHv5oySX6z+nKfofCgl
 Ts9Gr+9uxoaDsUp/cuXT0pB2rcaxsw16T+IUlyjSUvwCA3AjO0aHwOB+drWk9fvxJiM6
 hDqhxMoPUfDIyZUGy7sFeqALpqIf3Yl6x15rO8AZUDfaccaRASZ0wtNIy49TrX8jABWO
 D4SZ10B/TmpH4e4AMs3wdZvVRY0IPXLa3m9ZIK2Sx2d11ZYv4r7cZzQyrVCaN/+TQalg
 IO87JnV1dmKt/oegP27o9NhArV4gAzTJfwKvzRmRwSUBkiX+TZd0aII2yw9rXCJW6wkF
 7alw==
X-Gm-Message-State: APjAAAWF8CQP2hwER3RVTaPNFUeiX5gNrP3Mx+cGHCkQkgNRLJARYNxl
 59uhXyVSUbpGDw2j0CrpGI38ZMrXIaxgdET4zQIHnYhgY45l9dYaeWQTW3+mpsv6upQW5CUFguZ
 WhL9NjfJ/V9OOUfM=
X-Received: by 2002:a1c:bb82:: with SMTP id l124mr3024257wmf.176.1580977624844; 
 Thu, 06 Feb 2020 00:27:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3918OfgYSmWh97q0b7XwWjYHNNQPZr6n4294LwgBSiF5kyBaLzPnwApLMwiJsfaWZ0FjdKQ==
X-Received: by 2002:a1c:bb82:: with SMTP id l124mr3024207wmf.176.1580977624452; 
 Thu, 06 Feb 2020 00:27:04 -0800 (PST)
Received: from [192.168.43.81] (93-36-100-117.ip59.fastwebnet.it.
 [93.36.100.117])
 by smtp.gmail.com with ESMTPSA id b10sm3175641wrw.61.2020.02.06.00.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 00:27:03 -0800 (PST)
Subject: Re: VW ELF loader
To: David Gibson <david@gibson.dropbear.id.au>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62d62fab-46a4-240b-037b-409ba859b93d@redhat.com>
Date: Thu, 6 Feb 2020 09:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200205060634.GI60221@umbus.fritz.box>
Content-Language: en-US
X-MC-Unique: f0YYa0DuPxmxAfvik6vKDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/02/20 07:06, David Gibson wrote:
> On Tue, Feb 04, 2020 at 12:26:32AM +0100, Paolo Bonzini wrote:
>> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru> ha scritto:
>>> Speaking seriously, what would I put into the guest?
>>
>> Only things that would be considered drivers. Ignore the partitions issue
>> for now so that you can just pass the device tree services to QEMU with
>> hypercalls.
> 
> Urgh... first, I don't really see how you'd do that.  OF's whole
> device model is based around the device tree.  So implementing OF
> driver interactions would require the firmware to do a bunch of
> internal hypercalls to do all the DT stuff, which brings us back to a
> much more complex and active interface between firmware and hypervisor
> than we really want.

I'm really sorry if what I am saying is stupid; but I was thinking of a
firmware entrypoint like

	if (op == "read" || op == "write")
		do_driver_stuff(op);
	else
		hypercall();

This is not even close to pseudocode, but hopefully enough to give the
idea.  Perhaps what I don't understand is why you can't start the
firmware with r3 pointing to the device tree, and stash it for when you
leave control to GRUB.  Or to put it another way, what petitboot does
that you cannot do in your own firmware.

> Second, drivers are kind of where we'd get the most benefit by putting
> them in qemu: from qemu we can just talk to the device backends
> directly so we don't need to re-abstract the differences between
> different device models of the same type.

Of course, but drivers are easy to write.  Not as easy as s390 probably
because you'd have to link in libfdt and so on, but between
kvm-unit-tests and s390-ccw there's quite a bit of code can be reused.

>> You can generalize and reuse the s390 code. All you have to write is the
>> PCI scan and virtio-pci setup.
> 
> If we assume virtio only.

Do you actually need something else?  The TTY can use the simple
getchar/putchar hypercalls, and sPAPR-vSCSI clients can keep using SLOF.

Paolo


