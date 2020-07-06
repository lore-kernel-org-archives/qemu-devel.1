Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57DAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9095D20739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSrgfnp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9095D20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsOLk-000074-Qb
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsO8H-0002cZ-Lx
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:13:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsO8F-0005Xq-W9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:13:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so38604653wmh.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9SqWFVrzUfCxpWPdQsQSQdUU0ZuLBS9kb6eOSzr3lFg=;
 b=JSrgfnp+MOSdnvNPllB6emVuPYsFiOMqlR+FHnrrv5rXT+bicgp/lEKab4p/v8sFmP
 yGSrjG+9844nppaHxxfp7RboNYjiZglAPr3X7QKTa8FGlP5IJgGtBSvtjtxfSGMITqW7
 2eu9fjEpry9MFH/WCUla1DoPuUVCCt9lfBIrKkjAvzmPhKOuZLzK/I4ZHcfdy/LhiWh6
 uuV4EOaHo0UqVldhSzcl15scZjcWn2pT0rYiKVWN6rCYT/GcRaBN2bvorDb1+L7ARFTa
 BLyi0Fvp+GfSEZz9URQNG7lFDk1DoVKlkDaxxU1GAy+AmqNvzEzii5OdjkgU07nhHqdT
 J2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9SqWFVrzUfCxpWPdQsQSQdUU0ZuLBS9kb6eOSzr3lFg=;
 b=Z8aoNp3qSCWk4gP3M9wAwYlAw095d/R3xjU4z4bpa4NE9qQm5EOBjGKN478C5QWKz8
 M4zF9Srmjc4pIBn+GnO1Ypbn4Z4HOyfv/ygcYdgnNcjPfyiYsrNlz5dZj3f1la4EjYat
 C229kfK03xEuaXMFiqyW117fCjv5XCv+JuO9/OjnEuyRhYuoC+2Z9cHg+X/Wr2s4jVIz
 Vn0M+eXhYrQmvbtJ41jULEHlhzQ+5Senov07Zhk7Sr+QBdTj7Jc0Xzgt8n5MTbQ4V0dT
 90qtUAKi/DIThMAiRbRGLKbbfZ5rlw4sgNeik8PtEjtYwEq9ntireudFWJCMpfSGzSOm
 6KAg==
X-Gm-Message-State: AOAM533Kc8CNRg6z/mUC1Tz20cMhlOUk3Dqswt+si/Rn3sIxLp0GRW8j
 2qvlign95bRFnkfdT5Xu7AI=
X-Google-Smtp-Source: ABdhPJykzzHeJ2VnqBzYnU0XJnVZrHdQPaUOAEnqDOWE319ijS+hLqBFz0/FGnw6XO+xvqf8hpJySw==
X-Received: by 2002:a7b:ca59:: with SMTP id m25mr51391509wml.151.1594030430053; 
 Mon, 06 Jul 2020 03:13:50 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v11sm60962418wmb.3.2020.07.06.03.13.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 03:13:49 -0700 (PDT)
Subject: Re: [PULL 36/37] qdev: remove QDEV_PROP_PTR
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
 <20200107150442.1727958-37-marcandre.lureau@redhat.com>
 <13c91f97-a7e6-adbd-9c23-2464f2b1b46e@amsat.org>
 <CAMxuvaxx0bM5yhZcmc7LPmpMt-qvuB+zjhRR1mpUiNm=DyasoQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b2cfb05-ce65-7356-fe78-718e39138093@amsat.org>
Date: Mon, 6 Jul 2020 12:13:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxx0bM5yhZcmc7LPmpMt-qvuB+zjhRR1mpUiNm=DyasoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 12:01 PM, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 6, 2020 at 12:44 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 1/7/20 4:04 PM, Marc-André Lureau wrote:
>>> No longer used in the tree. The comment about user_creatable is still
>>> quite relevant, but there is already a similar comment in qdev-core.h.
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  include/hw/qdev-properties.h | 22 ----------------------
>>>  hw/core/qdev-properties.c    | 18 ------------------
>>>  2 files changed, 40 deletions(-)
>>>
>>> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
>>> index 16837ab5dd..a90a9cec80 100644
>>> --- a/include/hw/qdev-properties.h
>>> +++ b/include/hw/qdev-properties.h
>>> @@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_size;
>>>  extern const PropertyInfo qdev_prop_string;
>>>  extern const PropertyInfo qdev_prop_chr;
>>>  extern const PropertyInfo qdev_prop_tpm;
>>> -extern const PropertyInfo qdev_prop_ptr;
>>>  extern const PropertyInfo qdev_prop_macaddr;
>>>  extern const PropertyInfo qdev_prop_on_off_auto;
>>>  extern const PropertyInfo qdev_prop_losttickpolicy;
>>> @@ -171,25 +170,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>>>  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
>>>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
>>>
>>> -/*
>>> - * Please avoid pointer properties.  If you must use them, you must
>>> - * cover them in their device's class init function as follows:
>>> - *
>>> - * - If the property must be set, the device cannot be used with
>>> - *   device_add, so add code like this:
>>> - *   |* Reason: pointer property "NAME-OF-YOUR-PROP" *|
>>> - *   DeviceClass *dc = DEVICE_CLASS(class);
>>> - *   dc->user_creatable = false;
>>> - *
>>> - * - If the property may safely remain null, document it like this:
>>> - *   |*
>>> - *    * Note: pointer property "interrupt_vector" may remain null, thus
>>> - *    * no need for dc->user_creatable = false;
>>> - *    *|
>>> - */
>>> -#define DEFINE_PROP_PTR(_n, _s, _f)             \
>>> -    DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, void*)
>>
>> So the replacement is DEFINE_PROP_LINK()? It is not documented, but
>> it takes a TYPENAME argument, so I assume we can only LINK QOM types.
>> Can the documentation be improved?
> 
> Certainly, although we already have some documentation in
> object_property_add_link(). It's annoying that we have several places
> documenting similar/close API, or API docs in docs/ that quickly
> becomes outdated, or more difficult to find. Root of the issue is that
> there are at least 3 ways to add props: object_{,class}_property &
> QDEV_PROPS ...
> 
>> Yet another sneaky way to force forks to either update to QOM or die...
> 
> You can't blame upstream from doing cleanups and modernization, or
> stagnating. Forks are forks, with all the pain they carry. If they
> want to avoid the maintenance cost, they have to do the extra effort
> to get it upstream. This is also a "sneaky way" to remind them that
> effort is better spent in this direction.

I totally understand, but at the same time we are excluding hobbyist
contributors with mainstream exigency.

This is unfortunate. I'd like to suggest ideas how to keep the QEMU
project open to non-corporate contributors, but I don't have any.

Well, maybe this one: better document API changes, if possible with
examples (example can be as simple as pointing to a particular commit
sha1). At least for each release, because forks usually try to rebase
after releases.

> 
>>> -
>>>  #define DEFINE_PROP_CHR(_n, _s, _f)             \
>>>      DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
>>>  #define DEFINE_PROP_STRING(_n, _s, _f)             \
>>> @@ -262,8 +242,6 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
>>>  void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
>>>                             const uint8_t *value);
>>>  void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
>>> -/* FIXME: Remove opaque pointer properties.  */
>>> -void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
>>>
>>>  void qdev_prop_register_global(GlobalProperty *prop);
>>>  int qdev_prop_check_globals(void);
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index ac28890e5a..6ca7697599 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -501,13 +501,6 @@ const PropertyInfo qdev_prop_string = {
>>>      .set   = set_string,
>>>  };
>>>
>>> -/* --- pointer --- */
>>> -
>>> -/* Not a proper property, just for dirty hacks.  TODO Remove it!  */
>>> -const PropertyInfo qdev_prop_ptr = {
>>> -    .name  = "ptr",
>>> -};
>>> -
>>>  /* --- mac address --- */
>>>
>>>  /*
>>> @@ -1165,17 +1158,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
>>>                              name, &error_abort);
>>>  }
>>>
>>> -void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value)
>>> -{
>>> -    Property *prop;
>>> -    void **ptr;
>>> -
>>> -    prop = qdev_prop_find(dev, name);
>>> -    assert(prop && prop->info == &qdev_prop_ptr);
>>> -    ptr = qdev_get_prop_ptr(dev, prop);
>>> -    *ptr = value;
>>> -}
>>> -
>>>  static GPtrArray *global_props(void)
>>>  {
>>>      static GPtrArray *gp;
>>>
>>
> 
> 

