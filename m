Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A37C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D96205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq6+NIkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D96205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibktk-0002Mc-Bh
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ibkrT-0000jv-EW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ibkrS-0002oX-E5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:31:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ibkrS-0002oL-AC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575289889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ic3nJqhdf0tuP/k4oPZml9dPK8NJxkiKAlvTlnMWzg=;
 b=gq6+NIkPhunArLo7z1BdyPlI0xUkeXiuo5+xoirZmPTxlRwUT7e4XLg46fzMWqRzxiKT4O
 HFUdVx0nUz6Vr72D6oZpk4LhHGy+YmmsvXe62BzyxvhwnOnPu9MqUdc1EfoPMzeSxQdRQ7
 3SuIi7wN9rN0KGRgf187LSBnspIXBZg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-SYm24msXMsy-6bBe6Y54jA-1; Mon, 02 Dec 2019 07:31:27 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so1558649wrw.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 04:31:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w5SYgqs2iFKzC0li+V+BKsDheq2A4/lLKctc2SRiMDk=;
 b=TlhYrCBHf/MTVT24p+jZ1S6MRoS9m5IL7YGGs/dFJW0Mn+OnpErpbGem5/IUirUKQc
 K2Y/MDQDkhiXeO+1vPT/kAmTMoXRuxzIcjkUXDeCT+zBKzhpPb7R/kRsQqH8AJ9W+Ez8
 sPSS0wdl7RMC8W4zYmnSF94cMRUfjGgeM3vjtmLERqD+nEwgZF1VHIGKwkP0CZX4Gal5
 NLlsKbnX5BUJrngCh2geHU47+tFDEe7neWbF3BM8brScI5l2k0RJw/n0HJJAzQg+InEx
 j7gaCbnJkA/MCk2AwD4Qf2tr32jLHy/BIWIhcV51ZLw0BOR95WV+p0SzJt5F1XiObJST
 m/hA==
X-Gm-Message-State: APjAAAWcHN9vNGGndkyOnzIXgLNSrDZ6sM5NzMxQEqHUhvb36S6A0TWe
 1lokMb1Q/95IGLxvheoeU+R+mjoOgKoGWtbuK8s1qYOdat36br0RTpNExiY8katOADwrsjdBI2k
 yESflugUFTjWG/3w=
X-Received: by 2002:adf:e78a:: with SMTP id n10mr49531854wrm.62.1575289885958; 
 Mon, 02 Dec 2019 04:31:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjrEMNqTNmapoe3NXzh1gYDKqD96RmQ1RQ2jn6KI1RhZ66WeFLc3DycANp6HKYaIvOMlALsw==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr49531835wrm.62.1575289885777; 
 Mon, 02 Dec 2019 04:31:25 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id v14sm39511558wrm.28.2019.12.02.04.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 04:31:25 -0800 (PST)
Subject: Re: iPXE: update submodule
To: Gerd Hoffmann <kraxel@redhat.com>
References: <d33644db-ec7e-0b51-b6e6-b5fc15f37665@redhat.com>
 <20191202121853.shigtyrko725vmmg@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb8cc032-25bb-75c3-8043-bc1e68ef895a@redhat.com>
Date: Mon, 2 Dec 2019 13:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191202121853.shigtyrko725vmmg@sirius.home.kraxel.org>
Content-Language: en-US
X-MC-Unique: SYm24msXMsy-6bBe6Y54jA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 1:18 PM, Gerd Hoffmann wrote:
> On Mon, Dec 02, 2019 at 12:19:50PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi Gerd,
>>
>> 'make -C roms efirom' is failing on Fedora 30.
>>
>> Can you update the iPXE submodule so we get these buildsys commits:
>>
>> c742c576 [build] Move predefined all-drivers build shortcut to Makefile
>> a4f8c6e3 [build] Do not apply WORKAROUND_CFLAGS for host compiler
>> 1dd56dbd [build] Workaround compilation error with gcc 9.1
>> 412acd78 [build] Fix "'%s' directive argument is null" error
>=20
> Hmm.  Sure, can do that, but the question is for 4.2 or 5.0.  Updating
> ipxe that close to the release makes me nervous, but shipping a ipxe
> version which doesn't build with recent compilers in the release tarball
> isn't great either.
>=20
> I'd tend to go the 5.0 route.

I think 5.0 is OK, because if distributions build it, the are probably=20
already backporting these patches, so they can backport the QEMU patch=20
instead.


