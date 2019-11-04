Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC504CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C6E20848
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C6E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iReVG-0003mj-LA
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iReUb-0003DQ-AS
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iReUZ-0007qB-B4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:42:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iReUZ-0007px-3I
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:42:07 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6287368FF
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 15:42:05 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 2so3988741wmd.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 07:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vmb5S7csguWiNdq1Hf8Wvz+n2BriON2c3MvOkyrzm+k=;
 b=eD9XoWrwjDsPLbyDIRaDChspCpRRzsFguibHkFr3V3575Ky15nXfbFP84mgKR4f12G
 Zi3EPquERpmeeuu+Q25a3QgdsCYXiI2L99llwrNb6qcozlSosXEhvWw3Xzla75qUNrho
 N/Wbb/7k4MrVJqc11UtUfyqcCqsusOFeWFm+AolS/+BfMl3Xq6Vgl28yBVdQeH9jIQdG
 +hD9T2YW8mPxdeIcRAjDMNtoRM3nDTPJLruPjWs8AXNmyvHT+mkMUEvN79yn4e3wNhHi
 DmvVSfKIhNB48tIFoweXeU4WMCLwiX+H9rzKnPgPAlSR0dC9vNJBuqiktVBND0SttNjK
 6+nw==
X-Gm-Message-State: APjAAAX56iQOmUiVqUkD+CanKXCyG15xV4chHDfDUkN/IaA2Pa8OWUdX
 NFfwLvUrbwZQ9W6X8s9GSzhCp6rqCTWJwu+znj/j7ahEYtd5Vq/nsDBfMqD1n13gB72+cFM9Qv0
 A5BhVqitLKGag3yk=
X-Received: by 2002:a1c:23c1:: with SMTP id j184mr22483092wmj.83.1572882124655; 
 Mon, 04 Nov 2019 07:42:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyt12kJfZOouSmsQTvFrScglyJWEq9+lYQrLuG0yFQ4TO94/cYp++u//CTPceUUruRMqrKwyA==
X-Received: by 2002:a1c:23c1:: with SMTP id j184mr22483073wmj.83.1572882124416; 
 Mon, 04 Nov 2019 07:42:04 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id w22sm16429112wmc.16.2019.11.04.07.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 07:42:03 -0800 (PST)
Subject: Re: [PATCH v5 08/13] hw/core: deprecate old reset functions and
 introduce new ones
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-9-damien.hedde@greensocs.com>
 <41ee0633-c8c8-10ce-1372-4804f25273d0@redhat.com>
 <b434efd9-490a-85f4-9f22-c40bb0a9ed77@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7347207f-9f9e-a86f-ca18-ebca4d9ae0f9@redhat.com>
Date: Mon, 4 Nov 2019 16:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b434efd9-490a-85f4-9f22-c40bb0a9ed77@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 edgari@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 1:01 PM, Damien Hedde wrote:
> On 11/1/19 12:35 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/18/19 5:06 PM, Damien Hedde wrote:
>>> Deprecate device_legacy_reset(), qdev_reset_all() and
>>> qbus_reset_all() to be replaced by new functions
>>> device_cold_reset() and bus_cold_reset() which uses resettable API.
>>>
>>> Also introduce resettable_cold_reset_fn() which may be used as a
>>> replacement for qdev_reset_all_fn and qbus_reset_all_fn().
>>>
>>> Following patches will be needed to look at legacy reset call sites
>>> and switch to resettable api. The legacy functions will be removed
>>> when unused.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> ---
>>> [...]>> =C2=A0 +void resettable_cold_reset_fn(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 resettable_reset((Object *) opaque, RESET_TYPE_CO=
LD);
>>
>> Why not take a Object* argument?
>=20
> This function is used to register a reset callback with
> qemu_register_reset() (path 10 and 11), so we need void* to match the
> prototype.

Alright.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

