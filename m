Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6109CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267D9205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWoJZqtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267D9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPAx-0007WP-CO
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNP9w-0006Db-0H
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNP9t-0003WV-9K
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:31:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60245
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNP9s-0003Ud-SS
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571869871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ECVZ/JDh1uQ3niNBtcpzb7flDVxLkyBOJo8qKRQafnk=;
 b=HWoJZqtw/CC9S7IkPBWuShCDAwTaMTbaiSEBKFXgrPtcF5z6oRB3r7tesNw5p840eHkN04
 TVSBAJQ4rUkOPbUUbcvSCqj6irH1xCoGezTdOw8Smlg8Z7KXC91ijrmQT80vI6AbjAOtjS
 Agx/d4NtzAv/Oy0aI93Rkq56cZMVric=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-o7qUQfLkNCy-yH6b8Bznvw-1; Wed, 23 Oct 2019 18:31:08 -0400
Received: by mail-wr1-f71.google.com with SMTP id 67so11731804wrm.18
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8/GJhTevpVSL48GXLqGTJhISuPMtzfiyq6zRzaXI90g=;
 b=rxbVkKaV5Wgg+N5Yfo5bGWOewBEnnt5HTDENsJzyTyOhqG9Kr0K4WTpgNaJm0XCbwA
 5ZTt8nxxiPvA5oJqHZbTncKQBpMM0X7me5a1tmPGc3P2di+DLG8BVy12qHtTqbbUwE5p
 3nan1dHzM2XuH0N3YDcQDVXzjGlZDLydVEnEynoZdSwtfbPbgLpUXCocp6853uUBwjwu
 4O2kgFDd82kBbX0tk1s8Wlvr9aNYWB6MyGRUSkYH7koPepN2IzvvHvXBZk6UhU9HziOa
 RnMRp70tVWQ1fQ/xTNbznV3OJbKRrLJ9FOhG47M2ByDCXifWDtx2t21q+aEfVpKCfiW0
 Qcqg==
X-Gm-Message-State: APjAAAVHkIRi7jBZyrvpegiiPL+iS0mq7TdmgscVQLI7683FAo4Geh3l
 QaEPMVrhFPibKCMLen9NpDo/hZsHBSyq+ULj+aOqV0lgojwm9gMbqpEY+q2O3WHyijUnURp0QQR
 WbXkDJqPL5hdKd3g=
X-Received: by 2002:a05:600c:2295:: with SMTP id
 21mr1828741wmf.106.1571869867228; 
 Wed, 23 Oct 2019 15:31:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVxfZHoPAk677d9eZsgjibiAkke8jjMPCY19YoVs9nzQSX0KFw9KgtQfSigiG28RmryR0Yag==
X-Received: by 2002:a05:600c:2295:: with SMTP id
 21mr1828727wmf.106.1571869866974; 
 Wed, 23 Oct 2019 15:31:06 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id e3sm129356wme.36.2019.10.23.15.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 15:31:06 -0700 (PDT)
Subject: Re: LEON3 networking
To: Jiri Gaisler <jiri@gaisler.se>,
 Joshua Shaffer <joshua.shaffer@astrobotic.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>
References: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
 <6bb8abb2-68f0-db85-1557-6e04839b5ea2@redhat.com>
 <32c38984-e745-de6c-792e-09910b68cedd@adacore.com>
 <CAPJW7GLOTyjdMozrb+TSnqpEyoiFh2sxZjYkLXx2pz2_J_dPgA@mail.gmail.com>
 <a6783ce6-eea2-214f-7dbd-7224e830db0b@gaisler.se>
 <2ea63643-5cb2-017e-8889-bb8c77fd75cf@gaisler.se>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6d0ffeda-68c4-3c0e-39bb-e00d544e1b8e@redhat.com>
Date: Thu, 24 Oct 2019 00:31:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2ea63643-5cb2-017e-8889-bb8c77fd75cf@gaisler.se>
Content-Language: en-US
X-MC-Unique: o7qUQfLkNCy-yH6b8Bznvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jiri,

On 10/23/19 9:55 PM, Jiri Gaisler wrote:
> BTW, here is a patch that you might want to apply to qemu if you intend
> to run RTEMS on leon3. The plug&play area must support byte accesses,
> which is used by the RTEMS grlib scanning functions...

Do you mean this one?

http://gaisler.org/qemu/qemu-4.1.0-leon3.patch

-- >8 --
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -228,6 +228,9 @@ static uint64_t grlib_apb_pnp_read(void *opaque,=20
hwaddr offset, unsigned size)
  {
      APBPnp *apb_pnp =3D GRLIB_APB_PNP(opaque);

+    if (size !=3D 4)
+        return apb_pnp->regs[offset >> 2] >> ((~offset & 3) * 8);
+
      return apb_pnp->regs[offset >> 2];
  }

---

But then this is incorrect for 16-bit accesses.

The proper patch might be:

-- >8 --
@@ -234,6 +234,13 @@ static uint64_t grlib_apb_pnp_read(void *opaque,=20
hwaddr offset, unsigned size)
  static const MemoryRegionOps grlib_apb_pnp_ops =3D {
      .read       =3D grlib_apb_pnp_read,
      .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+    },
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+    },
  };

---

(Unrelated note, this device model lacks the MemoryRegionOps::write=20
handler).

> Jiri.
>=20
> On 10/23/19 8:37 PM, Jiri Gaisler wrote:
>> Leon3 uses the GRETH ethernet IP core for networking. You would need to
>> write a qemu emulation model of it to get networking support. The GRETH
>> is fairly well described in the GRLIB IP manual, so it should not be
>> impossible. The core is also available in open-source (VHDL) if you need
>> to look up some finer details ... :-)
>>
>> Jiri.
>>
>> On 10/23/19 6:59 PM, Joshua Shaffer wrote:
>>> Does anyone know what needs implemented to get networking supported?
>>>
>>> Joshua
>>>
>>> On Wed, Oct 16, 2019 at 6:34 AM Fabien Chouteau <chouteau@adacore.com> =
wrote:
>>>> Hello people,
>>>>
>>>> On 15/10/2019 18:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> Hi Joshua,
>>>>>
>>>>> On 10/15/19 3:17 PM, Joshua Shaffer wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I've been using the LEON3 port of qemu, and am wondering if anyone h=
as touched the networking setup for such since the thread here: https://lis=
ts.rtems.org/pipermail/users/2014-September/028224.html
>>>>> Thanks for sharing this!
>>>>>
>>>>> Good news, Jiri keeps rebasing his patch with the latest stable versi=
on.
>>>>> Bad news, he didn't not signed his work with a "Signed-off-by" tag so=
 we can not take this as it into the mainstream repository, see https://wik=
i.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-b=
y:_line
>>>>>
>>>> The Gaisler patches have been rewrote by my colleague Frederic (in CC)=
 and they are now in mainstream.
>>>> (see https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03869.ht=
ml)
>>>>
>>>> But none of them are implementing network support, and I never heard o=
f someone working on network for leon3.
>>>>
>>>> Regards,
>>>>


