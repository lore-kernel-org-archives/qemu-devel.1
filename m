Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77689C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3910E2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3910E2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53087 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZbi-0007oy-EV
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:44:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZZb-0006MG-98
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLZZa-0005vQ-5G
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:41:55 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hLZZW-0005tC-26; Tue, 30 Apr 2019 16:41:51 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MekKJ-1gncKL181l-00apK1; Tue, 30 Apr 2019 22:41:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
	<900dab1c-d200-18fa-530b-43c3d6f017a5@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <5f1c936c-c250-5f64-ccca-1940cc9124d5@vivier.eu>
Date: Tue, 30 Apr 2019 22:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <900dab1c-d200-18fa-530b-43c3d6f017a5@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QeF4mcDtsdUs/aU2n5t4oUomSPgyg231u9cY61avzm1XmqT1I0x
	JK0pYMX4I1UAI4/L4CZxofwNFaGdg28HNzpej6rIpyPbZPypQguyhdpO20tcXq3GZp/1rHg
	W0yUPoky9ev14YSbxTckf15ok5ueO3TUX50nwjZQCKQdkR4gJu19+REjbLdJUcGMACIc+9M
	zYN978U0vuOxXcu5lTEjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8f/VyoJRmoo=:SO9rzexhiGMSwQnVVYJo0o
	Obq0Lc/Z13YYtwb3Y+TpPmZIRoIfpa0G4b2RwSqBvx62bozEQb+O0XQgf5/oTr9kstKzgLAuB
	F+qCH9ZrbJ8sXIAXIGAAiaI1WVqQxG/8GIFQcgrF5/2GwI1vOZ68h7HWgStUOY3dDQGrVibDO
	WJxWK51/t8/VZQxDT9KO+2DEk/3oN6gIsCRNYfJdPc9kRG2Q2yADG5SdFLIaMBn2mcERFC887
	tM9AhPt/ip9U1fM/NrgScuFsWW2ZAeVuvfmFBOr5Q3bLMtQc42fUqnozIrsilkcezD2Iv5AX1
	n9Ep7928tDaLBIpZ1fnJ65wf3VOW0jO7RPqYD6YuIuAwmfJsiFMsTlvYHfH9Y0zNPzXK0tQLf
	FkO6knv4YikyApwKKseUhN8KrZs9oQelliCqtMtCBWp8zNe5t25CFDbHDA7GWji01cxrRT3oT
	KTPmUaOK6vZKjzrFpi1j6zPuUcEOsGvuCmohNBsHI7byH/bkAVpdK8YaDLetTiTMnVyCF7Klp
	V8wBelU4q5mK6mKI3EDtijkCq82n/wfRVNxThxSzzY0unMOdDKGJqFCJTPV2SUl+dRqtwqIKb
	G69dVVZDq5UxPkt9Pfnmc1fDa4gi0QMBenh74KgnWhX4CLr4Yea9Jv3hiuWe8v76YabQEvRuT
	yReIgONeV4VWkNP2mxtuzppkm3OwtE8aY5DpCAIDhjyX6v5Y/olgbR2yCncD1ehTzLlAHcEXP
	gGQ7rUGwBpmhz89RGfce2dDKHrO616WdMDWZNGjdUQsKxxO0SZmRvGFWOIM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build
 warning
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430204126.iMj0WXvWaNTPwua2wWai92rxFXuwBNGxUMSf9t1BrMk@z>

Le 30/04/2019 à 22:28, Laurent Vivier a écrit :
> Le 30/04/2019 à 22:09, Alistair Francis a écrit :
>> Fix this warning with GCC 9 on Fedora 30:
>> hw/usb/dev-mtp.c:1715:36: error: taking address of packed member of ‘struct <anonymous>’ may result in an unaligned pointer value [-Werror=address-of-packed-member]
>>  1715 |                             dataset->filename);
>>       |                             ~~~~~~~^~~~~~~~~~
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  hw/usb/dev-mtp.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index 99548b012d..6de85d99e6 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1711,9 +1711,22 @@ static void usb_mtp_write_metadata(MTPState *s, uint64_t dlen)
>>      assert(!s->write_pending);
>>      assert(p != NULL);
>>  
>> +/*
>> + * We are about to access a packed struct. We are confident that the pointer
>> + * address won't be unalligned, so we ignore GCC warnings.
>> + */
>> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
>> +#endif
>> +
>>      filename = utf16_to_str(MIN(dataset->length, filename_chars),
>>                              dataset->filename);
>>  
>> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9, 0)
>> +#pragma GCC diagnostic pop
>> +#endif
>> +
>>      if (strchr(filename, '/')) {
>>          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
>>                               0, 0, 0, 0);
>>
> 
> You should move and use PRAGMA_DISABLE_PACKED_WARNING and
> PRAGMA_REENABLE_PACKED_WARNING from linux-user/qemu.h.
> 
> It has laready been very well tested :)


Oh, they are for clang and a false positive, so forget my comment (and
the following one)

Thanks,
Laurent


