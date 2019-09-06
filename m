Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8885CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECC7206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECC7206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6EF8-0004Ad-EE
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6EEQ-0003by-Lt
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6EEO-0001wp-Tx
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:24:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42764)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6EEO-0001u6-M8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:24:52 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6FFC7E42C
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 13:24:50 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b15so2538478wrp.21
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 06:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iVDo4UeFGppDMRYJTVwOBn1Aw0egw1llJNRss/jmaJQ=;
 b=Rbr68tjFPy6FNPneURljSH99HPero+rCDqc3VJNq2fhwBDuNIUgFb40aXnsEut4n3q
 +1u2eVaawd58Pti6LOTY1bBMKtRxCGXZULrNO9PTyk0/HKdxcXsFeHzpBF4V8K5eBFRV
 VcV+HFYZAGgBo0OJR085SnPHXUc81G+G07/3lOTR6BJUjA/ECjneku/KnOiGIOqJIVyz
 mhKH8Xynh5v8FCLReDVFvO0JmBNiUWxrS5awA/ULvbCn5on/ZOQoujiwEzcRiToiVfqF
 TD2kZbYLKVDBonDhPzAF4abnHlAl4IGSuOIgI+hHx9Rx32LN9uRs+vppqL2uerApNO8k
 v+3g==
X-Gm-Message-State: APjAAAVplxMWkAzCWSrDZrSMHU1PSjCbwsTaj2cqR7toxtsIXicPfKvo
 0EuHI9uPE4/9rUaTrr6j0W8JbjsCtsEBuEQXzz4V+yPtoMhzkYQgr/FgeTEf85aJ/Zv3M2xUvfO
 O4tA4yFQ4MpBkeiY=
X-Received: by 2002:adf:f482:: with SMTP id l2mr7255606wro.103.1567776289651; 
 Fri, 06 Sep 2019 06:24:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzSLmzWy2q5pFnlTpWy7qsSUEgkdvlqkMbpIbW0CcuRBjpWrNmZTX/AJaS6PrId4ULdHJXX3Q==
X-Received: by 2002:adf:f482:: with SMTP id l2mr7255578wro.103.1567776289339; 
 Fri, 06 Sep 2019 06:24:49 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id n7sm6047069wrx.42.2019.09.06.06.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 06:24:48 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, Tony Nguyen <tony.nguyen@bt.com>,
 qemu-devel@nongnu.org
References: <20190902012647.1761-1-tony.nguyen@bt.com>
 <41e61c1c-15b0-d028-fc23-52e2c59319d2@redhat.com>
 <93172f42-7506-65d0-5754-248c3fc31aa1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <867bdb4b-3eef-0660-6db2-a2e6a0ab5a0e@redhat.com>
Date: Fri, 6 Sep 2019 15:24:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <93172f42-7506-65d0-5754-248c3fc31aa1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] memory: Set notdirty_mem_ops validator
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:08 PM, Eric Blake wrote:
> On 9/6/19 3:28 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 9/2/19 3:26 AM, Tony Nguyen wrote:
>>> Existing read rejecting validator was mistakenly cleared.
>>>
>>> Reads dispatched to io_mem_notdirty then segfaults as there is no rea=
d
>>> handler.
>>>
>>> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
>>> ---
>>>  exec.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/exec.c b/exec.c
>>> index 1df966d17a..05d664541f 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -2796,12 +2796,12 @@ static bool notdirty_mem_accepts(void *opaque=
, hwaddr addr,
>>> =20
>>>  static const MemoryRegionOps notdirty_mem_ops =3D {
>>>      .write =3D notdirty_mem_write,
>>> -    .valid.accepts =3D notdirty_mem_accepts,
>>>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>>>      .valid =3D {
>>>          .min_access_size =3D 1,
>>>          .max_access_size =3D 8,
>>>          .unaligned =3D false,
>>> +        .accepts =3D notdirty_mem_accepts,
>>
>> I'm surprised the compiler doesn't emit any warning...
>=20
> Same here.
>=20
> But reading
> https://en.cppreference.com/w/c/language/struct_initialization, this is
> compliant behavior:
>=20
> "However, when an initializer begins with a left open brace, its curren=
t
> object is fully re-initialized and any prior explicit initializers for
> any of its subobjects are ignored:"
>=20
> so it is worth filing a gcc bug asking for a QoI improvement in adding =
a
> warning (since the code does not violate the C standard, but does cause
> surprises in the reinitialization of omitted members in the later {} to
> go back to 0 in spite of the earlier initialization by nested name).

Just remembered another case of (correct) reinitialization in
hw/arm/palm.c:101:

static struct {
    int row;
    int column;
} palmte_keymap[0x80] =3D {
    [0 ... 0x7f] =3D { -1, -1 },
    [0x3b] =3D { 0, 0 },	/* F1	-> Calendar */
    [0x3c] =3D { 1, 0 },	/* F2	-> Contacts */
    [0x3d] =3D { 2, 0 },	/* F3	-> Tasks List */
    [0x3e] =3D { 3, 0 },	/* F4	-> Note Pad */
    [0x01] =3D { 4, 0 },	/* Esc	-> Power */
    [0x4b] =3D { 0, 1 },	/* 	   Left */
    [0x50] =3D { 1, 1 },	/* 	   Down */
    [0x48] =3D { 2, 1 },	/*	   Up */
    [0x4d] =3D { 3, 1 },	/*	   Right */
    [0x4c] =3D { 4, 1 },	/* 	   Centre */
    [0x39] =3D { 4, 1 },	/* Spc	-> Centre */
};

