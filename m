Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B56C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 602492073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5bhvRys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602492073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPhU-0002BX-J1
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isPgQ-0001EZ-W6
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isPgM-0004ve-Pg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:20:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isPgM-0004u7-MJ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579260053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S8HYxyTaHNmJ7tlat8zD3fa2C4NSzbVkeYnDgLV5lw=;
 b=b5bhvRysNuHhaaB953h3V2/W1Ai/vXocrRGp3+q/9dUbXuZixN0i1HM+AR5Zu4UFJJ6oTo
 BXsyqne/0AdOLI82vjVph/avQbtqHM9k6Kg4q9zlh7YskxfyZ+2gEYfawEWYac8yJdFXdi
 hTZGxSCr1jX9tgnI/ohftsf/kEn43KU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-z1kX666BPkSD-3jOj8XoSg-1; Fri, 17 Jan 2020 06:20:52 -0500
Received: by mail-wm1-f69.google.com with SMTP id q26so1108799wmq.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 03:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VJ0nYIT6yhxd6M+kh3bKnXFh5D4k4gQhd0i0eGOHsl8=;
 b=s0k0PN0fIF/sLQ+gLgyD0jM7etNvBOmhkb2ohfcG78G/ttTdIeatGwl8wzuJnkXpE+
 WYB5sAa6Y1HndmPBpIurL1TUT5/rjvYDc8oC54rgP7neAy1yXiM9ZbafVpQF78D5neEN
 v/fJsUQUQFT4nbOQwj96RjkZO3tEDdc6VicqiIA03Qyq3LkP9+NuBz2rk1Ppypzg5snJ
 1Uwy45sqPWc09L6ekvwfD3j//3ZbmBgbNY4ca15jtnmRSye4tFFxURFtpG+94F7tD4Tz
 cOqawXbzuinmjJsO7hzIVcePGvr7L0twqDxfbQUvJSE5PXCUXT+5mCRJW4CWYfoAEfpC
 WloQ==
X-Gm-Message-State: APjAAAURmLUnuUPUrLWZ5a/+StvlWMJwCTvcT0SsQ5XL6yYqu449iQfL
 FHyxDTmcOEUHbYubVwChAUCQ87KqdvvKJq0KWC1sOhPAqoMTlV9pHlhV7dDxgIiFOpOYYVIPPRg
 PRJCqC1nKLpChzy8=
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr2497914wra.36.1579260051119;
 Fri, 17 Jan 2020 03:20:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPtoRLTxRLbjJbwIsWYdE5olFrOaGUCCU7lOaYXQKHPrY66Xj8i1zfubM2IJckPew0SxOfZw==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr2497874wra.36.1579260050752;
 Fri, 17 Jan 2020 03:20:50 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u16sm7059167wmj.41.2020.01.17.03.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 03:20:50 -0800 (PST)
Subject: Re: [PATCH v22 5/9] ACPI: Record the Generic Error Status Block
 address
To: gengdongjiu <gengdongjiu@huawei.com>, pbonzini@redhat.com,
 mst@redhat.com, imammedo@redhat.com, shannon.zhaosl@gmail.com,
 peter.maydell@linaro.org, fam@euphon.net, rth@twiddle.net,
 ehabkost@redhat.com, mtosatti@redhat.com, xuwei5@huawei.com,
 jonathan.cameron@huawei.com, james.morse@arm.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-arm@nongnu.org
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
 <11c62b51-7a94-5e34-39c6-60c5e989a63b@redhat.com>
 <de0dbaaa-01aa-aba7-df9a-ddfb9a2164b0@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <86db126c-cfec-6057-3724-a52eecb6c681@redhat.com>
Date: Fri, 17 Jan 2020 12:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <de0dbaaa-01aa-aba7-df9a-ddfb9a2164b0@huawei.com>
Content-Language: en-US
X-MC-Unique: z1kX666BPkSD-3jOj8XoSg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: zhengxiang9@huawei.com, linuxarm@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 11:47 AM, gengdongjiu wrote:
> On 2020/1/17 15:39, Philippe Mathieu-Daud=E9 wrote:
>>>  =A0 =A0=A0=A0=A0=A0 table_offsets =3D g_array_new(false, true /* clear=
 */,
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(uint32_t));
>>> @@ -831,7 +832,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBui=
ldTables *tables)
>>>  =A0=A0=A0=A0=A0 acpi_add_table(table_offsets, tables_blob);
>>>  =A0=A0=A0=A0=A0 build_spcr(tables_blob, tables->linker, vms);
>>>  =A0 -=A0=A0=A0 if (vms->ras) {
>>> +=A0=A0=A0 acpi_ged_state =3D ACPI_GED(object_resolve_path_type("", TYP=
E_ACPI_GED,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 NULL));
>>
>> Testing vms->ras first is cheaper than calling object_resolve_path_type(=
). Since some people are spending lot of time to reduce VM boot time, it mi=
ght be worth considering.
> Thanks Philippe's comments.
>=20
> Do you think it should be written to below[1]? right?
>=20
> [1]:
> if (vms->ras && acpi_ged_state)

No, as:

   if (vms->ras) {
     AcpiGedState *acpi_ged_state;

     acpi_ged_state =3D ACPI_GED(object_resolve_path_type("",=20
TYPE_ACPI_GED, NULL));
     if (acpi_ged_state) {
       acpi_add_table(table_offsets, tables_blob);
       ...

Maybe I'm wrong and there is not much impact in VM boot time here,=20
reviews welcomed :)

>>
>>> +=A0=A0=A0 if (acpi_ged_state &&=A0 vms->ras) {
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 acpi_add_table(table_offsets, tables_blob)=
;
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 build_ghes_error_table(tables->hardware_er=
rors, tables->linker);
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 acpi_build_hest(tables_blob, tables->hardw=
are_errors,
>>> @@ -925,6 +928,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>>>  =A0 {
>=20


