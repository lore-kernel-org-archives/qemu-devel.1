Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9E0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4302065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm3psvMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4302065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDnG-0008UN-5T
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqDla-00072z-2t; Tue, 30 Jun 2020 06:45:30 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqDlY-0003WD-8k; Tue, 30 Jun 2020 06:45:29 -0400
Received: by mail-ej1-x641.google.com with SMTP id rk21so20036687ejb.2;
 Tue, 30 Jun 2020 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xWW3S9JbFqbF/WDaHtuTcZJtixpKk+BO6FbGx3kUnLI=;
 b=bm3psvMNTmSW0Z7/1cNLpn0EuURvc/8NPcxoCdaUGoXNP10ktMucUNEqt3B3y6kz3C
 qjBa+dpAaRCIAW4JFA+93MxzpuAdfS07sVUKSCu00oT738sXXiRVFcnal/jt+TT/y6cK
 J+P7XiW5LdwH91zydtHNTp2Gji065P0UaheiDG9/lSdhsxmaUrPHJ4xtwtdOehjVEgP5
 cQe0dJ7GscTjtANEneCFD+v3tT4uOarMU8ITomH8BkLTn6Rp14/P6EGNHFe/afRDs2gn
 7gMY8VYR29jVHpZoIHV1MAEm0nk/Vs/MOar22lTiZ0VUjq5L5IOL2P7jrW2fuNPzHqs0
 WXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xWW3S9JbFqbF/WDaHtuTcZJtixpKk+BO6FbGx3kUnLI=;
 b=uapuoc4chheN8dIoEWKXxM32DXaomHrXkex0ToCzcxujPAjKWhs5G+R5al1/YHhLHm
 o0MADJ6xfhmAw5mh+lSLCxbg7Vj9hW2YeDgj5HqjLlxf8+iIVzfkNGUtTZG522ad236b
 rDzPKInRMAohO6mAIQPZclDEwwGRhV7PYeaoqTSWphPlccFKLNeOza+5IBcFodLyPL5l
 LrI/5MbuInRMHAUVIuZj8Dt6oauIX2ukyY2OKnXW3mY9anVPfTzod/CK0BuSuVCsROuk
 iO81I24PN4osiMT7rkJbkT1napb5jfvLwmneDNPseEYU1+36InEjrK+61fg3jjFDxku/
 bZwA==
X-Gm-Message-State: AOAM530hLQLaAfLtXCjvypfIund6WhO3siTYGcuY3+UrolJWxhVcwDK5
 M6kGUV61gh7xRfksGQ28RVA=
X-Google-Smtp-Source: ABdhPJxqLQCqK4RSP2fo8IdzSeQNHc7fKOrj/EWa6d2YJm136DHU3+K0KaK16FgOmO0kSCg6MhNRWg==
X-Received: by 2002:a17:906:538a:: with SMTP id
 g10mr18685060ejo.354.1593513925420; 
 Tue, 30 Jun 2020 03:45:25 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r19sm2388690edp.79.2020.06.30.03.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 03:45:24 -0700 (PDT)
Subject: Re: [PATCH 5/5] hw/i2c: Document the I2C qdev helpers
To: Markus Armbruster <armbru@redhat.com>
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-6-f4bug@amsat.org> <87zh8kg8qu.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f3eff51-57b0-f1c9-9d1d-f7d6eddcec80@amsat.org>
Date: Tue, 30 Jun 2020 12:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zh8kg8qu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 12:15 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> In commit d88c42ff2c we added new prototype but neglected to
>> add their documentation. Fix that.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/i2c/i2c.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
>> index c533058998..fcc61e509b 100644
>> --- a/include/hw/i2c/i2c.h
>> +++ b/include/hw/i2c/i2c.h
>> @@ -79,8 +79,56 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
>>  int i2c_send(I2CBus *bus, uint8_t data);
>>  uint8_t i2c_recv(I2CBus *bus);
>>  
>> +/**
>> + * Create an I2C slave device on the heap.
>> + * @name: a device type name
>> + * @addr: I2C address of the slave when put on a bus
>> + *
>> + * This only initializes the device state structure and allows
>> + * properties to be set. Type @name must exist. The device still
>> + * needs to be realized. See qdev-core.h.
>> + */
>>  I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
>> +
>> +/**
>> + * Create an I2C slave device on the heap.
> 
> Suggest "Create and realize ..."
> 
>> + * @bus: I2C bus to put it on
>> + * @name: I2C slave device type name
>> + * @addr: I2C address of the slave when put on a bus
>> + *
>> + * Create the device state structure, initialize it, put it on the
>> + * specified @bus, and drop the reference to it (the device is realized).
>> + * Any error aborts the process.
> 
> Stick to imperative mood: Abort on error.
> 
> Do we need the sentence?  Doc comments of object_new(), qdev_new() and
> i2c_slave_new() don't have it, they document *preconditions* instead,
> using "must", and rely on the tacit understanding that a function may
> abort or crash when its documented preconditions aren't met.  Matter of
> taste, I guess.
> 
>> + */
>>  I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
>> +
>> +/**
>> + * i2c_slave_realize_and_unref: realize and unref an I2C slave device
> 
> Either consistently waste space for repeating the function name at the
> beginning of its doc comment, or consistently don't :)
> 
> qdev_realize_and_unref()'s doc comment says "and drop a reference"
> instead of "unref", because "unref" is not a word.
> 
>> + * @dev: I2C slave device to realize
>> + * @bus: I2C bus to put it on
>> + * @addr: I2C address of the slave on the bus
>> + * @errp: error pointer
> 
> $ git-grep -h "@errp:" | sort -u
>  *  @errp: pointer to Error*, to store an error if it happens
>  * @errp:   error object
>  * @errp: Error object
>  * @errp: Error object which may be set by job_complete(); this is not
>  * @errp: Error object.
>  * @errp: If an error occurs, a pointer to an area to store the error
>  * @errp: Output pointer for error information. Can be NULL.
>  * @errp: Pointer for reporting an #Error.
>  * @errp: Populated with an error in failure cases
>  * @errp: a pointer to an Error that is filled if getting/setting fails.
>  * @errp: a pointer to return the #Error object if an error occurs.
>  * @errp: an error indicator
>  * @errp: error
>  * @errp: error object
>  * @errp: error object handle
>  * @errp: handle to an error object
>  * @errp: if an error occurs, a pointer to an area to store the error
>  * @errp: indirect pointer to Error to be set
>  * @errp: location to store error
>  * @errp: location to store error information
>  * @errp: location to store error information.
>  * @errp: location to store error, will be set only for exception
>  * @errp: pointer to Error*, to store an error if it happens.
>  * @errp: pointer to NULL initialized error object
>  * @errp: pointer to a NULL initialized error object
>  * @errp: pointer to a NULL-initialized error object
>  * @errp: pointer to an error
>  * @errp: pointer to error object
>  * @errp: pointer to initialized error object
>  * @errp: pointer to uninitialized error object
> 
> Aside: gotta love these two.
> 
>  * @errp: returns an error if this function fails
>  * @errp: set *errp if the check failed, with reason
>  * @errp: set in case of an error
>  * @errp: set on error
>  * @errp: unused
>  * @errp: where to put errors
> 
> Plenty of choice, recommend not to invent another one :)
> 
>> + *
>> + * Call 'realize' on @dev, put it on the specified @bus, and drop the
>> + * reference to it. Errors are reported via @errp and by returning
>> + * false.
> 
> Recommend to use a separate paragraph for the return value.  Since your
> comment style resembles GTK-Doc style[*], you may just as well use it
> for the return value, like this:
> 
>       Returns: %true on success, %false on failure.
> 
> By convention, it goes after the function description.

OK, I'll use whatever you prefer. Maybe the shorter the easier.

I will see if I can find to spend more time on this during the
week-end, but I can't promise anything. Anyway since it is
documentation it can be integrated during soft freeze.

Thanks for your detailed review.

> 
>> + *
>> + * This function is useful if you have created @dev via qdev_new(),
>> + * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
>> + * the device it returns to you), so that you can set properties on it
>> + * before realizing it. If you don't need to set properties then
>> + * i2c_slave_create_simple() is probably better (as it does the create,
>> + * init and realize in one step).
>> + *
>> + * If you are embedding the I2C slave into another QOM device and
>> + * initialized it via some variant on object_initialize_child() then
>> + * do not use this function, because that family of functions arrange
>> + * for the only reference to the child device to be held by the parent
>> + * via the child<> property, and so the reference-count-drop done here
>> + * would be incorrect.  (Instead you would want i2c_slave_realize(),
>> + * which doesn't currently exist but would be trivial to create if we
>> + * had any code that wanted it.)
>> + */
> 
> The advice on use is more elaborate qdev_realize_and_unref()'s.  That
> one simply shows intended use.  I doubt we need more.  But as the person
> who wrote qdev_realize_and_unref(), I'm singularly unqualified judging
> the need ;)
> 
>>  bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp);
>>  
>>  /* lm832x.c */
> 
> 
> [*] A style I dislike, but it's common in QEMU, so you're certainly
> entitled to use it.
> 
> 

