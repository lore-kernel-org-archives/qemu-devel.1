Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8674C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D722217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D722217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40731 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5zK-0007AU-Sd
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:17:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH5yQ-0006qz-GJ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH5yP-0007E4-3s
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:17:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH5yO-0007Ch-At
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:17:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so2673964wrw.13
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bGcaV/y71HjXSM/AxwPMJE2jAJNT1XpYU4iBxIManOg=;
	b=f4Ill+fll6SM9U8pyVVLrivsU5P6wWS+yky+eeDC4fxU0w5qLVSL8WGNS4P+/hgYJG
	/jucY7HgyPY0WG3/4RBms9DKyQAzK90RSjSRMYCM3DLHnTxjBFD6Xkwio/iORvDsQZ+M
	ec7BRq85+B/yfX5av/xKniLqZSs6ipd1dTAfzvvHdjYzjHAfD6tmPmKULaP91S0hX0yl
	eNRkUn6b4AzD5CxUn2Zv5el4KJYaB/6RHnkYdqDE/x1y/9EBFD23Hgyt2VnWMX8b/+Xq
	nKL4GsqvyBCbQM+kvLjKLaeSJFcZmpD7bColqLu7B3Mr/MWSQIxc/U0+DZlmiL6dcB0M
	GnYw==
X-Gm-Message-State: APjAAAWUoj121Lgg+iZKb/xyBRZwM+rAXE9hRG2pfruqdC4MKfm5dH6V
	9/1URMWJ77DZQEYpKZUjvTza05fuDno=
X-Google-Smtp-Source: APXvYqxfvOzmnU1MXY5Xq+8a69s76FibRUIN+1gk+R2yPDaLEbe10Qvfz4FzNeKhCiKoBBe7Sq+bYA==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr59816035wrj.8.1555589818437;
	Thu, 18 Apr 2019 05:16:58 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id j2sm2160561wrq.30.2019.04.18.05.16.57
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 05:16:57 -0700 (PDT)
To: Ratnaraj Mirgal <ratnaraj.mirgal@gmail.com>, qemu-devel@nongnu.org
References: <CAAxVKALOPZiBG3u6Co6vXuA5_WWJrOdDUsk=3n4gTOhkuV23rw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a5b19003-6c63-df5d-ce44-2d681103d447@redhat.com>
Date: Thu, 18 Apr 2019 14:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAxVKALOPZiBG3u6Co6vXuA5_WWJrOdDUsk=3n4gTOhkuV23rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] Virtio based IEEE 802.11 device support
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
Message-ID: <20190418121652.vSzh6zjab4UySEKLg5BPeDrnnUIkx0I-w9OffoJUdV0@z>

On 4/17/19 12:00 PM, Ratnaraj Mirgal wrote:
> Hi All,
> 
> At the outset, I do understand there is no mainstream requirement for
> having virtual wireless NIC, if et all there is any, mac80211_hwsim (part
> of Linux) is more than sufficient.
> 
> So this is purely an academic attempt.
> 
> In order to support following topology,
> 
> [image: qemu-wifi-topology.png]

I never thought of sending a picture of an ASCII schema =)

> I am implementing IEEE 802.11 softmac device based on virtio driver. I
> wanted to use existing netdev trasport like socket, however due to lack of
> better understanding of internals I have added new netdev (airport), which
> is very similar to VDE transport implementation. On frontend side, I have
> combined virtio-net and mac80211_hwsim to form frontend wireless driver.
> 
> As of now all driver are loading, and further working on correcting queue
> implementation.
> 
> 00:03.0 Network controller [0280]: Red Hat, Inc Device [1af4:100a]
> 	Subsystem: Red Hat, Inc Device [1af4:000a]
> 	Kernel driver in use: virtio-pci
> 
> # lsmod
> Module                  Size  Used by    Tainted: G
> arc4                   16384  2
> virtio_mac80211        24576  0
> mac80211              356352  1 virtio_mac80211
> sha256_generic         24576  0
> cfg80211              221184  1 mac80211
> 
> 4: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
> default qlen 1000
>     link/ether 52:55:00:d1:55:01 brd ff:ff:ff:ff:ff:ff
> 
> 
> I have kept the repository at,
> https://github.com/ra7narajm/virtio-mac80211
> 
> So if possible, do go through and let me know any mistakes.
> 
> Thank You.
> 
> -
> Ratnaraj
> 

