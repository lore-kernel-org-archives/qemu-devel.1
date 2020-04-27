Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915EAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F96206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGgE9pRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F96206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT030-0005k0-AG
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT01k-0004Ad-CA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT01j-0000BG-Qr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:26:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT01j-0000Ah-Di
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587979570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epUTa2MIRGdX/uvZ0IaFVVPsfxco/ySJO/z0SKYTNgs=;
 b=RGgE9pRkeDBDKl3P6OEirha2m+9Q6DYguOOfnMyStInAq2PJahlp43MEQJ3EMtj1NMkN1t
 b3Zx/CAlZk5uHtnn0rshYg06s3sBtp8CmfuryuM0d+NWjIo+oiV77j+nT6nq4eOpUV991S
 gfiWfDTwbs7FhSHj9DggDKpcAh8mfF8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-oSekIaODMn-zEGOl3OiUtg-1; Mon, 27 Apr 2020 05:26:08 -0400
X-MC-Unique: oSekIaODMn-zEGOl3OiUtg-1
Received: by mail-wr1-f71.google.com with SMTP id t8so10160801wrq.22
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=07A1UyANoB0u87LLRsgkeyZU3XBlx4tklbutM7v/vm8=;
 b=Wqbq3g1OruZB0GBTxFKvPwwYEDK2b/5Exb8iajglhu4nGnJBk3u963D61nG7bd7lWj
 t85IAL0Gv50BhWe/7udvSPVaG+StBmlX14S8sWWS6+zEknBtpDOrqlwWbJl168W+bwRp
 WVkrX12C0e8mvDNz0tZf5ziSQ7xR3v42Gexxq6QbWxDHQ35AJTXYUK7T5oHLrz3s18wQ
 fllxg9lil2BLp8AMlWXi9Ma6/8NOVZU/3rQ38+mXbhZddozIiJ5kZs3NJEHdJqzubNBv
 YRM9o+orjgoNXAnfIlXN1qtngnEFvugvoIfPW5j6aQCxTOUmECPNDdksh32SDvjk+v0u
 o8gA==
X-Gm-Message-State: AGi0PuYf7z5SE2iQeBpEulXTnjg/3uAJ+rkDtvNl5tq0Tw4zhRtwGXmM
 sOv8havONgXoBu3CigMPInsbbbonB84Oqo2RVFNvLO1sRWmsowtR+YL90p6iB3cZo5oLxpwYKsE
 T3OZT2vf0eoo5awc=
X-Received: by 2002:adf:94a6:: with SMTP id 35mr25788594wrr.420.1587979567078; 
 Mon, 27 Apr 2020 02:26:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypI+xgqfXlEZQNDSrLUp/2xs3Ij7GTD3DLivz5zrMDhiFOzPG2wOJMyFT/1tY+OxJAudZkm2zA==
X-Received: by 2002:adf:94a6:: with SMTP id 35mr25788574wrr.420.1587979566871; 
 Mon, 27 Apr 2020 02:26:06 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id n25sm9855897wmk.9.2020.04.27.02.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:26:06 -0700 (PDT)
Subject: Re: [PATCH 06/11] error: Use error_reportf_err() where appropriate
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-7-armbru@redhat.com>
 <44cf6721-88fa-acd3-b051-43e81b37506a@redhat.com>
 <87o8rdia2o.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3b9745bf-56df-7e83-3ecb-13eeef56306f@redhat.com>
Date: Mon, 27 Apr 2020 11:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87o8rdia2o.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:33:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 10:53 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 4/24/20 2:20 PM, Markus Armbruster wrote:
>>> Replace
>>>
>>>       error_report("...: %s", ..., error_get_pretty(err));
>>>
>>> by
>>>
>>>       error_reportf_err(err, "...: ", ...);
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    chardev/char-socket.c | 5 +++--
>>>    hw/sd/pxa2xx_mmci.c   | 4 ++--
>>>    hw/sd/sd.c            | 4 ++--
>>>    hw/usb/dev-mtp.c      | 9 +++++----
>>>    qemu-nbd.c            | 7 +++----
>>>    scsi/qemu-pr-helper.c | 4 ++--
>>>    6 files changed, 17 insertions(+), 16 deletions(-)
>>
>> Although it touches NBD, I'm happy for this to go through your tree
>> with the larger series.
>>
>>> +++ b/qemu-nbd.c
>>> @@ -856,8 +856,7 @@ int main(int argc, char **argv)
>>>            }
>>>            tlscreds =3D nbd_get_tls_creds(tlscredsid, list, &local_err)=
;
>>>            if (local_err) {
>>> -            error_report("Failed to get TLS creds %s",
>>> -                         error_get_pretty(local_err));
>>> +            error_reportf_err(local_err, "Failed to get TLS creds ");
>>
>> Odd one out for not using ':' in the message, but that's independent
>> of this patch.
>=20
> The patch is short enough to deviate from "purely mechanical" and stick
> in ':' here.  Your choice.

Let's deviate, else we might forget about it.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


