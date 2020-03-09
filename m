Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70F4C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A066820578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReOk1uck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A066820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKW8-0003Mn-PN
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jBK7G-0007us-Sg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jBK7F-0001cO-HX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:14:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jBK7F-0001bv-93
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:14:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id v11so11643802wrm.9
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lqpgCIJAa53wjMOChqCdeNGb6iakq3HluBlJugDn9cQ=;
 b=ReOk1uckgQlWL7pykCUUXLDWTJN6PWGwzFl2M4XlQ6emGbwMAa/DMG3eAVx54F44lo
 5d6I6fve6kHJmNrIHVSueiJXWbwqqsvUu/wmBrXtHfcU11K+Z7TqxtgN3KqV7hgzZ/1a
 T7KKeADq2L9ruC2cml9LX3yViSp5RRo6aK2x4+Q6fu/LjKEwlrKmkZeZ5D25uOHdZg8N
 0QukyaKpyFMdAybw0B8TbmzMGAXG113+1kLA+QCkVbvitfiQrePvqETNq5BT5hddLiPE
 T1szjGS4hMibcD8uHNbpicB6SBFb0zUDWSsUtJlP1mOb6uBkvc267zOCoj37sSgNHw+K
 /RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lqpgCIJAa53wjMOChqCdeNGb6iakq3HluBlJugDn9cQ=;
 b=bJ2eFgCpqhVZpGAeuU3okazdiGdRD0RO047TuwXRfuBTsjkJ3iHshwSgF9GgFDHiqn
 bu3A30I9hS+q/aUoc56Od7mANQQZHb5AzFrNTxNcA0enuckzVKbNIT3G8dON4gPPXJh0
 WPgVSaMAPTzSubkXyPDsEU/i8RCWAL8vTyVOodkRJz/BwwKuFTjb92LyLxNxtN5V1Huf
 TCABM1INYzk1cgS5T9B5xv+CoiUeb6ol6+lQ1woyVR2+iSzBTYPv91RgME3EYs4Ix3xF
 LBROb8ZkEJKI/47Ro0e3oHx5cAAVoA/QIiSugN+oIksiUp2sF9Bzv+1BFwG7dXEheS8H
 nsgw==
X-Gm-Message-State: ANhLgQ1JA/yU3H2MC86i4GxCQ4xrtJ0NoyrNLJJYbC5DaOisZnLbdRhK
 IZlIBYqZTFZp3w7dIX2Cxju0Y+ElPvEysiggSBU=
X-Google-Smtp-Source: ADFU+vtkteEmwWLN5H9tv1m5nUl1rcXMVJ/Z+wkBW68l8fpPzS0X+7dedG84bkvTabi4II6Ug4noihJ1KXf2+fV85+M=
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr20823129wrf.32.1583766887384; 
 Mon, 09 Mar 2020 08:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200304172748.15338-1-imammedo@redhat.com>
In-Reply-To: <20200304172748.15338-1-imammedo@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Mar 2020 16:14:35 +0100
Message-ID: <CAJ+F1CLNRn7UaS2Z4jSsorFnVfeTDzBmjJkuTURz1B4ni8SU0Q@mail.gmail.com>
Subject: Re: [PATCH for-5.0] vl.c: fix migration failure for 3.1 and older
 machine types
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: ldoktor@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Mar 4, 2020 at 6:28 PM Igor Mammedov <imammedo@redhat.com> wrote:
>
> Migration from QEMU(v4.0) fails when using 3.1 or older machine
> type. For example if one attempts to migrate
> QEMU-2.12 started as
>   qemu-system-ppc64 -nodefaults -M pseries-2.12 -m 4096 -mem-path /tmp/
> to current master, it will fail with
>   qemu-system-ppc64: Unknown ramblock "ppc_spapr.ram", cannot accept migr=
ation
>   qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'ram'
>   qemu-system-ppc64: load of migration failed: Invalid argument
>
> Caused by 900c0ba373 commit which switches main RAM allocation to
> memory backends and the fact in 3.1 and older QEMU, backends used
> full[***] QOM path as memory region name instead of backend's name.
> That was changed after 3.1 to use prefix-less names by default
> (fa0cb34d22) for new machine types.
> *** effectively makes main RAM memory region names defined by
> MachineClass::default_ram_id being altered with '/objects/' prefix
> and therefore migration fails as old QEMU sends prefix-less
> name while new QEMU expects name with prefix when using 3.1 and
> older machine types.
>
> Fix it by forcing implicit[1] memory backend to always use
> prefix-less names for its memory region by setting
>   'x-use-canonical-path-for-ramblock-id'
> property to false.

ahah, ok. If main RAM allocation was always using prefix-less name,
then that should be good enough:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> 1) i.e. memory backend created by compat glue which maps
> -m/-mem-path/-mem-prealloc/default RAM size into
> appropriate backend type/options to match old CLI format.
>
> Fixes: 900c0ba373
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
> CC: ldoktor@redhat.com
> CC: marcandre.lureau@redhat.com
> CC: dgilbert@redhat.com
> ---
>  softmmu/vl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 5549f4b619..1101b1cb41 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2800,6 +2800,9 @@ static void create_default_memdev(MachineState *ms,=
 const char *path)
>      object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
>      object_property_add_child(object_get_objects_root(), mc->default_ram=
_id,
>                                obj, &error_fatal);
> +    /* Ensure backend's memory region name is equal to mc->default_ram_i=
d */
> +    object_property_set_bool(obj, false, "x-use-canonical-path-for-rambl=
ock-id",
> +                             &error_fatal);
>      user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
>      object_unref(obj);
>      object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-back=
end",
> --
> 2.18.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

