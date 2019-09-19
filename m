Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7209FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF5D21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF5D21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxxF-0004IL-9V
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAxpR-0005X7-MR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAxpQ-0005kF-Cr
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:54:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAxpQ-0005ja-1B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:54:40 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A83FC059B7C
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:54:39 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z205so1930844wmb.7
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3fPP3NZHGpg/rjOVTXE8/c07++9RN5o90E5GM+1Yv30=;
 b=PIXKdnDvBgsE4Xad+rPoPB7CR/Zn95o4kCgmIu+HokuOEWeoqi/E2tmpqyP9C5ANfm
 z7SZaiiKzGr2vZewemq7fpqu20my+hBtbAxV7MX98g3ce1EUWq6qRIzIDH7SesyNnUzm
 oIAin1z1dT9Hk+UI/yfDG/nNXEYB07PZRoyikIrBkxvyYlex2Uty6biYjoyuT/rEFqVA
 TBBgaxg/F4TkMNAIl8dEeGwRkkETPLCelbn3xAPdDcfsYqs78RJzWpqpini890Hz82uP
 63/ahpC65s3vKf0UU9fw/6XKJ4XztW8ufmOrNEq3NYts0sHXbOx0HHVd7KC4rHx9wlK6
 tpmw==
X-Gm-Message-State: APjAAAWGI+jzx2coj37l1cfWNdjEjtargUpv24+G02CjIDQRRqLvkOPu
 iF1Qz9iWRm1rMeVrdLDoJ0ayUYVBG/A7WD25EsJVEbpJ3rAyhrGPQxoipBx8ro4wmNye5QSYaw8
 SD0KA/jViHzRSxLY=
X-Received: by 2002:a7b:cb0e:: with SMTP id u14mr3570751wmj.115.1568904877737; 
 Thu, 19 Sep 2019 07:54:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1jCq05KcOy5mFXFh6dCQIc5rXAFzdNvgeTq3PIpa5K/HCpGEo6XYuR/3SfwhZLyiysJsQPA==
X-Received: by 2002:a7b:cb0e:: with SMTP id u14mr3570723wmj.115.1568904877450; 
 Thu, 19 Sep 2019 07:54:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id v6sm14485867wma.24.2019.09.19.07.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 07:54:36 -0700 (PDT)
Subject: Re: [PATCH 6/7] target/i386: add VMX features
To: Liran Alon <liran.alon@oracle.com>
References: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
 <1568716480-9973-7-git-send-email-pbonzini@redhat.com>
 <A0C3DD36-966F-46CC-8705-903112BECBC2@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <60820b32-42df-dbc0-9fc7-81821b2e42cb@redhat.com>
Date: Thu, 19 Sep 2019 16:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A0C3DD36-966F-46CC-8705-903112BECBC2@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 16:32, Liran Alon wrote:
>=20
>=20
>> On 17 Sep 2019, at 13:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Add code to convert the VMX feature words back into MSR values,
>> allowing the user to enable/disable VMX features as they wish.  The sa=
me
>> infrastructure enables support for limiting VMX features in named
>> CPU models.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> +static uint64_t make_vmx_msr_value(uint32_t index, uint32_t features)
>> +{
>> +    uint32_t default1, can_be_one, can_be_zero;
>> +    uint32_t must_be_one;
>> +
>> +    switch (index) {
>> +    case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
>> +        default1 =3D 0x00000016;
>> +        break;
>> +    case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
>> +        default1 =3D 0x0401e172;
>> +        break;
>> +    case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
>> +        default1 =3D 0x000011ff;
>> +        break;
>> +    case MSR_IA32_VMX_TRUE_EXIT_CTLS:
>> +        default1 =3D 0x00036dff;
>> +        break;
>> +    case MSR_IA32_VMX_PROCBASED_CTLS2:
>> +        default1 =3D 0;
>> +        break;
>> +    default:
>> +        abort();
>> +    }
>> +
>=20
> See below.
>=20
>> +    /*
>> +     * Bits 0-30, 32-44 and 50-53 come from the host.  KVM should
>> +     * not change them for backwards compatibility.
>> +     */
>> +    uint64_t fixed_vmx_basic =3D kvm_vmx_basic & 0x003c1fff7fffffffUL=
L;
>> +
>> +    /*
>> +     * Same for bits 0-4 and 25-27.  Bits 16-24 (CR3 target count) ca=
n
>> +     * change in the future but are always zero for now, clear them t=
o be
>> +     * future proof.  Bits 32-63 in theory could change, though KVM d=
oes
>> +     * not support dual-monitor treatment and probably never will; ma=
sk
>> +     * them out as well.
>> +     */
>> +    uint64_t fixed_vmx_misc =3D kvm_vmx_misc & 0x0e00001f;
>=20
> I haven=E2=80=99t yet read deeply entire patch-series but I=E2=80=99m d=
efinitely against having
> these hard-coded values in code instead of explicitly building proper b=
itmap
> with well-defined bit names. This is error-prone and less readable.
> (E.g. Am I suppose as a reader to convert 0x0401e172 to which processor=
-based controls it represents?)

No, you're not. :)  In fact, most of the bits that are set in these
constants have no definition.  Most "default1" reserved bits have
remained reserved since forever, the only exceptions are DEBUGCTL and
CR3 load/store controls.

The hex constants here correspond simply to the bits that are listed in
appendix A of the SDM:

  Default settings partition the various controls into the following
  classes:
  [...]
  * Default1. They are (or have been) reserved with a default
    setting of 1.
  [...]
  The default1 class of pin-based VM-execution controls contains bits 1,
  2, and 4
  [...]
  The default1 class of processor-based VM-execution controls contains
  bits 1, 4=E2=80=936, 8, 13=E2=80=9316, and 26
  [...]
  The default1 class of VM-exit controls contains bits 0=E2=80=938, 10, 1=
1, 13,
  14, 16, and 17
  [...]
  The default1 class of VM-entry controls contains bits 0=E2=80=938 and 1=
2

I could add four #defines for these values, but they are used only here
and shouldn't be used elsewhere since make_vmx_msr_value is there
exactly to hide the existence of default1 reserved bits.

I will add defines for fixed_vmx_basic, fixed_vmx_misc and
fixed_vmx_ept_mask, though.

Paolo

